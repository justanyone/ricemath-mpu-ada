with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;
with Ada.Containers.Ordered_Maps;

package body Math_Prime_Util.Arith.Totients is
   use type Primality.Prime_Result;

   function Carmichael_Lambda (N : U64) return U64 is
      F : constant Factor.Factor_List := Factor.Factor (N);
      Result, Power, P : U64 := 1;
      I : Natural := 1;
      E : Natural;
   begin
      if N <= 1 then
         return N;
      end if;
      while I <= F.Count loop
         P := F.Value (I);
         Power := P - 1;
         E := 1;
         I := I + 1;
         while I <= F.Count and then F.Value (I) = P loop
            Power := Power * P;
            E := E + 1;
            I := I + 1;
         end loop;
         if P = 2 and then E > 2 then
            Power := Power / 2;
         end if;
         Result := Result / Int.Gcd (Result, Power) * Power;
      end loop;
      return Result;
   end Carmichael_Lambda;

   function Dedekind_Psi (N : Signed_Input) return Optional_U64 is
      Result : U128 := 1;
      Last : U64 := 0;
   begin
      if N <= 1 then
         return (True, (if N <= 0 then 0 else 1));
      end if;
      declare
         F : constant Factor.Factor_List := Factor.Factor (U64 (N));
      begin
         for I in 1 .. F.Count loop
            Result := Result * (if F.Value (I) = Last then
                                  U128 (Last) else U128 (F.Value (I)) + 1);
            if Result > U128 (U64'Last) then
               return (Defined => False);
            end if;
            Last := F.Value (I);
         end loop;
      end;
      return (True, U64 (Result));
   end Dedekind_Psi;

   --  The reference's divisor-keyed sets store intermediate products.
   --  Recursing over the same prime/divisor choices avoids storing them.
   procedure Inverse_Search
     (N : U64; Values : out U64_Vectors.Vector; Count : out U64;
      Count_Only : Boolean)
     with SPARK_Mode => Off
   is
      Divs : constant Factor.U64_Vectors.Vector := Factor.Divisors (N);
      procedure Visit (Remaining, Product, Minimum : U64);
      procedure Visit (Remaining, Product, Minimum : U64) is
         P, R, V : U64;
      begin
         if Remaining = 1 then
            if Count = U64'Last then
               raise Constraint_Error with "inverse totient count overflow";
            end if;
            Count := Count + 1;
            if not Count_Only then
               Values.Append (Product);
            end if;
         end if;
         for Index in Divs.First_Index .. Divs.Last_Index loop
            declare
               D : constant U64 := Divs.Element (Index);
            begin
               exit when D > Remaining;
               if D < U64'Last and then D + 1 >= Minimum
                 and then Remaining mod D = 0
                 and then Primality.Is_Prime (D + 1) /= 0
               then
                  P := D + 1;
                  R := Remaining / D;
                  V := Product;
                  loop
                     if V > U64'Last / P then
                        if not Count_Only then
                           raise Constraint_Error with
                             "inverse totient preimage overflow";
                        end if;
                     else
                        V := V * P;
                     end if;
                     Visit (R, V, P + 1);
                     exit when R mod P /= 0;
                     R := R / P;
                  end loop;
               end if;
            end;
         end loop;
      end Visit;
   begin
      Values.Clear;
      Count := 0;
      if N = 0 or else (N > 1 and then N mod 2 = 1) then
         return;
      end if;
      Visit (N, 1, 2);
   end Inverse_Search;

   function Inverse_Totient (N : U64) return U64_Vectors.Vector is
      package Sorting is new U64_Vectors.Generic_Sorting;
      Values : U64_Vectors.Vector;
      Count : U64;
   begin
      Inverse_Search (N, Values, Count, False);
      Sorting.Sort (Values);
      return Values;
   end Inverse_Totient;

   function Inverse_Totient_Count (N : U64) return U64 is
      Values : U64_Vectors.Vector;
      Count : U64;
   begin
      Inverse_Search (N, Values, Count, True);
      return Count;
   end Inverse_Totient_Count;

   function Is_Totient (N : U64) return Boolean is
      function Predicate (X, Maximum : U64) return Boolean;
      function Predicate (X, Maximum : U64) return Boolean is
         Half : constant U64 := X / 2;
         R, P : U64;
      begin
         if X mod 2 = 1 then
            return False;
         end if;
         if (X and (X - 1)) = 0 then
            return True;
         end if;
         if Half < Maximum and then Primality.Is_Prime (X + 1) /= 0 then
            return True;
         end if;
         declare
            Divs : constant Factor.U64_Vectors.Vector :=
              Factor.Divisors (Half, Maximum);
         begin
            for Index in Divs.First_Index .. Divs.Last_Index loop
               declare
                  D : constant U64 := Divs.Element (Index);
               begin
                  exit when D >= Maximum;
                  P := 2 * D + 1;
                  if Primality.Is_Prime (P) /= 0 then
                     R := Half / D;
                     loop
                        if R = P or else Predicate (R, D) then
                           return True;
                        end if;
                        exit when R mod P /= 0;
                        R := R / P;
                     end loop;
                  end if;
               end;
            end loop;
         end;
         return False;
      end Predicate;
   begin
      return N > 0 and then (N = 1 or else Predicate (N, N));
   end Is_Totient;

   function Ramanujan_Sum (K, N : U64) return I128 is
      G : U64;
      M : Sign_Value;
   begin
      if K = 0 or else N = 0 then
         return 0;
      end if;
      G := K / Int.Gcd (K, N);
      M := Moebius (I128 (G));
      if M = 0 or else K = G then
         return I128 (M);
      end if;
      return I128 (M) * I128 (Euler_Phi (I128 (K)) /
                               Euler_Phi (I128 (G)));
   end Ramanujan_Sum;

   function Sumtotient (N : U64) return U128 is
      Root : constant U64 := Int.Rootint (N, 3);
      Limit : constant U64 := U64'Min
        (N, U64'Max (1, U64'Min (400_000_000, 3 * Root * Root / 5)));
      type Prefix_Array is array (U64 range <>) of U64;
      Prefix : Prefix_Array (0 .. Limit);
      package Caches is new Ada.Containers.Ordered_Maps (U64, U128);
      Cache : Caches.Map;
      J : U64;
      function Evaluate (X : U64) return U128;
      function Evaluate (X : U64) return U128 is
         S : U128;
         R : constant U64 := Int.Sqrtint (X);
         Last : constant U64 := X / (R + 1);
      begin
         if X <= Limit then
            return U128 (Prefix (X));
         elsif Cache.Contains (X) then
            return Cache.Element (X);
         end if;
         S := U128 (X) * (U128 (X) + 1) / 2;
         S := S - U128 (X - X / 2);
         for K in U64 range 2 .. Last loop
            S := S - Evaluate (X / K);
            S := S - U128 (X / K - X / (K + 1)) * Evaluate (K);
         end loop;
         if R > Last then
            S := S - U128 (X / R - X / (R + 1)) * Evaluate (R);
         end if;
         Cache.Insert (X, S);
         return S;
      end Evaluate;
   begin
      for I in U64 range 0 .. Limit loop
         Prefix (I) := I;
      end loop;
      for P in U64 range 2 .. Limit loop
         if Prefix (P) = P then
            J := P;
            loop
               Prefix (J) := Prefix (J) / P * (P - 1);
               exit when J > Limit - P;
               J := J + P;
            end loop;
         end if;
      end loop;
      for I in U64 range 2 .. Limit loop
         Prefix (I) := Prefix (I) + Prefix (I - 1);
      end loop;
      return Evaluate (N);
   end Sumtotient;

   function Sumliouville (N : U64) return I128 is
      Limit : constant U64 := U64'Min (N, 1_000_000);
      type Signed_Array is array (U64 range <>) of Integer;
      Mu : Signed_Array (0 .. Limit) := [others => 1];
      Prefix : Signed_Array (0 .. Limit) := [others => 0];
      package Caches is new Ada.Containers.Ordered_Maps (U64, I128);
      Cache : Caches.Map;
      J : U64;
      Sum : I128 := 0;
      function Evaluate (X : U64) return I128;
      function Evaluate (X : U64) return I128 is
         S : I128 := 1;
         Low : U64 := 2;
         High, Q : U64;
      begin
         if X <= Limit then
            return I128 (Prefix (X));
         elsif Cache.Contains (X) then
            return Cache.Element (X);
         end if;
         while Low <= X loop
            Q := X / Low;
            High := X / Q;
            S := S - I128 (High - Low + 1) * Evaluate (Q);
            exit when High = X;
            Low := High + 1;
         end loop;
         Cache.Insert (X, S);
         return S;
      end Evaluate;
   begin
      Mu (0) := 0;
      for P in U64 range 2 .. Limit loop
         if Prefix (P) = 0 then
            J := P;
            loop
               Mu (J) := -Mu (J);
               Prefix (J) := 1;
               exit when J > Limit - P;
               J := J + P;
            end loop;
            if P <= Limit / P then
               J := P * P;
               loop
                  Mu (J) := 0;
                  exit when J > Limit - P * P;
                  J := J + P * P;
               end loop;
            end if;
         end if;
      end loop;
      for I in U64 range 1 .. Limit loop
         Prefix (I) := Prefix (I - 1) + Mu (I);
      end loop;
      for K in U64 range 1 .. Int.Sqrtint (N) loop
         Sum := Sum + Evaluate (N / (K * K));
      end loop;
      return Sum;
   end Sumliouville;
