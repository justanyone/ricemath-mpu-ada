with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;
with Ada.Containers.Ordered_Maps;
with Ada.Numerics.Big_Numbers.Big_Integers;

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

   function Inverse_Totient (N : U64) return U64_Vectors.Vector is
      package Lists is new Ada.Containers.Ordered_Maps
        (U64, U64_Vectors.Vector, "<", U64_Vectors."=");
      package Sorting is new U64_Vectors.Generic_Sorting;
      Set, Added : Lists.Map;
      Divs : Factor.U64_Vectors.Vector;
      Initial, Result : U64_Vectors.Vector;
      D, P, DP, PP, R, Key : U64;
   begin
      if N = 0 or else (N > 1 and then N mod 2 = 1) then
         return Result;
      elsif N = 1 then
         Result.Append (1);
         Result.Append (2);
         return Result;
      end if;
      --  Coleman Remark 3.3 / Proposition 6.2, before the list bound.
      if Primality.Is_Prime (N / 2) /= 0 then
         if Primality.Is_Prime (N + 1) = 0 then
            return Result;
         elsif N >= U64'Last / 2 then
            raise Constraint_Error with "inverse totient preimage overflow";
         elsif N >= 10 then
            Result.Append (N + 1);
            Result.Append (2 * N + 2);
            return Result;
         end if;
      end if;
      --  totients.c refuses the list when products can exceed U64.
      if N >= 2_459_565_884_898_017_280 then
         raise Constraint_Error with "inverse totient list overflow";
      end if;
      Divs := Factor.Divisors (N);
      Initial.Append (1);
      Set.Insert (1, Initial);
      for I in reverse Divs.First_Index .. Divs.Last_Index loop
         D := Divs.Element (I);
         P := D + 1;
         if Primality.Is_Prime (P) /= 0 then
            DP := D;
            PP := P;
            R := N;
            Added.Clear;
            loop
               for J in Divs.First_Index .. Divs.Last_Index loop
                  Key := Divs.Element (J);
                  exit when Key > N / DP;
                  if (N / DP) mod Key = 0
                    and then (D /= 1 or else Key * DP = N)
                    and then Set.Contains (Key)
                  then
                     declare
                        Values : U64_Vectors.Vector;
                        Source : constant U64_Vectors.Vector :=
                          Set.Element (Key);
                     begin
                        if Added.Contains (Key * DP) then
                           Values := Added.Element (Key * DP);
                        end if;
                        for K in Source.First_Index .. Source.Last_Index loop
                           if Source.Element (K) > U64'Last / PP then
                              raise Constraint_Error with
                                "inverse totient preimage overflow";
                           end if;
                           Values.Append (Source.Element (K) * PP);
                        end loop;
                        Added.Include (Key * DP, Values);
                     end;
                  end if;
               end loop;
               exit when R mod P /= 0;
               R := R / P;
               exit when DP > N / P;
               DP := DP * P;
               PP := PP * P;
            end loop;
            for Position in Added.Iterate loop
               Key := Lists.Key (Position);
               if Set.Contains (Key) then
                  declare
                     Values : U64_Vectors.Vector := Set.Element (Key);
                  begin
                     Values.Append (Lists.Element (Position));
                     Set.Replace (Key, Values);
                  end;
               else
                  Set.Insert (Key, Lists.Element (Position));
               end if;
            end loop;
         end if;
      end loop;
      if Set.Contains (N) then
         Result := Set.Element (N);
         Sorting.Sort (Result);
      end if;
      return Result;
   end Inverse_Totient;

   function Inverse_Totient_Count (N : U64) return U64 is
      package Counts is new Ada.Containers.Ordered_Maps (U64, U64);
      Set, Added : Counts.Map;
      Divs : Factor.U64_Vectors.Vector;
      D, P, DP, R, Key, Value : U64;
      procedure Add (Target : in out Counts.Map; K, V : U64);
      procedure Add (Target : in out Counts.Map; K, V : U64) is
      begin
         if Target.Contains (K) then
            if Target.Element (K) > U64'Last - V then
               raise Constraint_Error with "inverse totient count overflow";
            end if;
            Target.Replace (K, Target.Element (K) + V);
         else
            Target.Insert (K, V);
         end if;
      end Add;
   begin
      if N = 1 then
         return 2;
      elsif N = 0 or else N mod 2 = 1 then
         return 0;
      end if;
      if Primality.Is_Prime (N / 2) /= 0 then
         if Primality.Is_Prime (N + 1) = 0 then
            return 0;
         elsif N >= 10 then
            return 2;
         end if;
      end if;
      Divs := Factor.Divisors (N);
      Set.Insert (1, 1);
      for I in Divs.First_Index .. Divs.Last_Index loop
         D := Divs.Element (I);
         P := D + 1;
         if Primality.Is_Prime (P) /= 0 then
            DP := D;
            R := N;
            Added.Clear;
            loop
               if DP = 1 then
                  Add (Added, 1, 1);
               else
                  for J in Divs.First_Index .. Divs.Last_Index loop
                     Key := Divs.Element (J);
                     exit when Key > N / DP;
                     if (N / DP) mod Key = 0 and then Set.Contains (Key) then
                        Value := Set.Element (Key);
                        Add (Added, Key * DP, Value);
                     end if;
                  end loop;
               end if;
               exit when R mod P /= 0;
               R := R / P;
               exit when DP > N / P;
               DP := DP * P;
            end loop;
            for Position in Added.Iterate loop
               Add (Set, Counts.Key (Position), Counts.Element (Position));
            end loop;
         end if;
      end loop;
      return (if Set.Contains (N) then Set.Element (N) else 0);
   end Inverse_Totient_Count;

   function Is_Totient (N : Signed_Input) return Boolean is
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
      return N > 0 and then (N = 1 or else
        Predicate (U64 (N), U64 (N)));
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
      package Prefix_Vectors is new Ada.Containers.Vectors (Natural, U64);
      Prefix : Prefix_Vectors.Vector;
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
            return U128 (Prefix (Natural (X)));
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
      Prefix.Set_Length (Ada.Containers.Count_Type (Limit + 1));
      for I in U64 range 0 .. Limit loop
         Prefix (Natural (I)) := I;
      end loop;
      for P in U64 range 2 .. Limit loop
         if Prefix (Natural (P)) = P then
            J := P;
            loop
               Prefix (Natural (J)) := Prefix (Natural (J)) / P * (P - 1);
               exit when J > Limit - P;
               J := J + P;
            end loop;
         end if;
      end loop;
      for I in U64 range 2 .. Limit loop
         Prefix (Natural (I)) :=
           Prefix (Natural (I)) + Prefix (Natural (I - 1));
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

   function Ramanujan_Tau (N : Signed_Input) return Optional_I128 is
      Native : constant U64 := (if N <= 0 then 0 else U64 (N));
      package Big renames Ada.Numerics.Big_Numbers.Big_Integers;
      use Big;
      package Conversion is new Signed_Conversions (I128);
      function B (X : U64) return Big_Integer is
        (Conversion.To_Big_Integer (I128 (X)));
      Table : constant array (Natural range <>) of I128 :=
        [0,
         1,
         -24,
         252,
         -1472,
         4830,
         -6048,
         -16744,
         84480,
         -113643,
         -115920,
         534612,
         -370944,
         -577738,
         401856,
         1217160,
         987136,
         -6905934,
         2727432,
         10661420,
         -7109760,
         -4219488,
         -12830688,
         18643272,
         21288960,
         -25499225,
         13865712,
         -73279080,
         24647168,
         128406630,
         -29211840,
         -52843168,
         -196706304,
         134722224,
         165742416,
         -80873520,
         167282496,
         -182213314,
         -255874080,
         -145589976,
         408038400,
         308120442,
         101267712,
         -17125708,
         -786948864,
         -548895690,
         -447438528];

      --  util.c: hclassno and _count_class_div; 12 times H(X).
      function Wide_Sqrt (X : U128) return U64;
      function Wide_Sqrt (X : U128) return U64 is
         Low : U64 := 0;
         High : U64 := 2 ** 34;
         Middle : U64;
      begin
         while Low + 1 < High loop
            Middle := Low + (High - Low) / 2;
            if U128 (Middle) ** 2 <= X then
               Low := Middle;
            else
               High := Middle;
            end if;
         end loop;
         return Low;
      end Wide_Sqrt;

      function Class_Number (X : U128) return U64;
      function Class_Number (X : U128) return U64 is
         H, Corr : U64;
         D, B2, Bound : U128;
         Square : Boolean;
         F : Optional_U64;
      begin
         if X mod 4 in 1 | 2 then
            return 0;
         elsif X = 3 then
            return 4;
         end if;
         D := X mod 2;
         B2 := (X + 1) / 4;
         Bound := U128 (Wide_Sqrt (B2));
         Square := Bound * Bound = B2;
         if B2 <= U128 (U64'Last) then
            F := Divisor_Sum (U64 (B2), 0);
            H := F.Value / 2;
         else
            --  Same divisor-pair count beyond the native factor API.
            H := 0;
            for I in U128 range 1 .. Bound loop
               if B2 mod I = 0 then
                  H := H + 1;
               end if;
            end loop;
            if Square then
               H := H - 1;
            end if;
         end if;
         if D = 1 then
            H := 1 + (if Square then 1 else 0) + 2 * (H - 1);
         end if;
         D := D + 2;
         loop
            B2 := (X + D * D) / 4;
            exit when 3 * B2 >= X;
            if B2 mod D = 0 then
               H := H + 1;
            end if;
            if U128 (Wide_Sqrt (B2)) ** 2 = B2 then
               H := H + 1;
            end if;
            Bound := U128 (Wide_Sqrt (B2));
            if Bound * Bound = B2 then
               Bound := Bound - 1;
            end if;
            for I in D + 1 .. Bound loop
               if B2 mod I = 0 then
                  H := H + 2;
               end if;
            end loop;
            D := D + 2;
         end loop;
         Corr := (if 3 * B2 = X then 4
                  elsif Square and then X mod 2 = 0 then 6 else 0);
         return 12 * H + Corr;
      end Class_Number;

      function Tau_Prime (P : U64) return Big_Integer;
      function Tau_Prime (P : U64) return Big_Integer is
         Sum : Big_Integer := To_Big_Integer (0);
         BP : constant Big_Integer := B (P);
         T2, V, T3 : U64;
      begin
         if P < U64 (Table'Length) then
            return Conversion.To_Big_Integer (Table (Natural (P)));
         end if;
         --  PP.pm: _tauprime, with wide class-number arguments.
         for T in U64 range 1 .. Int.Sqrtint (P) loop
            T2 := T * T;
            V := P - T2;
            if V mod 4 = 0 then
               T3 := 2 * Class_Number (U128 (V)) + Class_Number (4 * U128 (V));
            elsif V mod 4 = 3 then
               T3 := (if V mod 8 = 3 then 6 else 4) * Class_Number (U128 (V));
            else
               T3 := Class_Number (4 * U128 (V));
            end if;
            Sum := Sum + B (T2) ** 3 *
              (4 * B (T2) ** 2 - 9 * BP * B (T2) + 7 * BP ** 2) * B (T3);
         end loop;
         return 28 * BP ** 6 - 28 * BP ** 5 - 90 * BP ** 4 -
           35 * BP ** 3 - 1 - 32 * (Sum / 3);
      end Tau_Prime;

      F : constant Factor.Factor_List := Factor.Factor (Native);
      Result : Big_Integer := To_Big_Integer (1);
      Current, Previous, Next, TP, P11 : Big_Integer;
      I : Natural := 1;
      P : U64;
   begin
      if Native < U64 (Table'Length) then
         return (True, Table (Natural (Native)));
      end if;
      while I <= F.Count loop
         P := F.Value (I);
         TP := Tau_Prime (P);
         P11 := B (P) ** 11;
         Previous := To_Big_Integer (1);
         Current := TP;
         I := I + 1;
         while I <= F.Count and then F.Value (I) = P loop
            Next := TP * Current - P11 * Previous;
            Previous := Current;
            Current := Next;
            I := I + 1;
         end loop;
         Result := Result * Current;
      end loop;
      if Result < Conversion.To_Big_Integer (-2 ** 63)
        or else Result > Conversion.To_Big_Integer (2 ** 63 - 1)
      then
         return (Defined => False);
      end if;
      return (True, Conversion.From_Big_Integer (Result));
   end Ramanujan_Tau;
end Math_Prime_Util.Arith.Totients;
