with Interfaces;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Arith is
   use type U128;
   use type Int.I128;
   use type Primality.Prime_Result;
   use type Interfaces.Integer_8;

   subtype Factor_Count is Natural range 0 .. 64;
   type Factor_Array is array (Positive range 1 .. 64) of U64;
   type Factorization is record
      Values : Factor_Array := [others => 0];
      Count : Factor_Count := 0;
   end record;

   --  factor.c: prho_factor, with deterministic polynomial restarts.
   --  Private until the separate factor package dependency is available.
   function Split (N : U64) return U64
     with Pre => N > 1, Post => Split'Result in 2 .. N
   is
      C : U64 := 1;
      X, Y, D : U64;
      function Step (V : U64) return U64 is
        (U64 ((U128 (V) * U128 (V) + U128 (C)) mod U128 (N)));
   begin
      if N mod 2 = 0 then
         return 2;
      elsif Primality.Is_Prime (N) /= 0 then
         return N;
      end if;
      loop
         X := 2;
         Y := 2;
         D := 1;
         for Iteration in 1 .. 200_000 loop
            X := Step (X);
            Y := Step (Step (Y));
            D := Int.Gcd ((if X > Y then X - Y else Y - X), N);
            exit when D /= 1;
         end loop;
         if D > 1 and D < N then
            return D;
         end if;
         C := (if C = N - 1 then 1 else C + 1);
      end loop;
   end Split;

   function Factors (N : U64) return Factorization is
      Result : Factorization;
      procedure Visit (V : U64) with Pre => V > 0 is
         D : U64;
      begin
         if V = 1 then
            return;
         end if;
         D := Split (V);
         if D = V then
            Result.Count := Result.Count + 1;
            Result.Values (Result.Count) := V;
         else
            Visit (D);
            Visit (V / D);
         end if;
      end Visit;
      Key : U64;
      J : Natural;
   begin
      if N > 1 then
         Visit (N);
      end if;
      for I in 2 .. Result.Count loop
         Key := Result.Values (I);
         J := I;
         while J > 1 and then Result.Values (J - 1) > Key loop
            Result.Values (J) := Result.Values (J - 1);
            J := J - 1;
         end loop;
         Result.Values (J) := Key;
      end loop;
      return Result;
   end Factors;

   function Euler_Phi (N : Signed_Input) return U64 is
      Result : U64;
      Last : U64 := 0;
   begin
      if N <= 0 then
         return 0;
      end if;
      Result := U64 (N);
      for P of Factors (U64 (N)).Values loop
         if P /= 0 and P /= Last then
            Result := Result / P * (P - 1);
            Last := P;
         end if;
      end loop;
      return Result;
   end Euler_Phi;

   function Jordan_Totient (K, N : U64) return Int.Optional_U64 is
      Result : U128 := 1;
      Last : U64 := 0;
      Power : Int.Optional_U64;
      Term : U64;
   begin
      if N <= 1 or K = 0 then
         return (Defined => True, Value => (if N = 1 then 1 else 0));
      end if;
      for P of Factors (N).Values loop
         if P /= 0 then
            Power := Int.Powint (P, K);
            if not Power.Defined then
               --  2**64 - 1 still fits when a prime power is exactly 2**64.
               if P = 2 and K = 64 and Last = 0 then
                  Term := U64'Last;
               else
                  return (Defined => False);
               end if;
            else
               Term := Power.Value - (if P = Last then 0 else 1);
            end if;
            Result := Result * U128 (Term);
            if Result > U128 (U64'Last) then
               return (Defined => False);
            end if;
            Last := P;
         end if;
      end loop;
      return (Defined => True, Value => U64 (Result));
   end Jordan_Totient;

   function Moebius (N : Signed_Input) return Sign_Value is
      Result : Sign_Value := 1;
      Last : U64 := 0;
   begin
      if N = 0 then
         return 0;
      end if;
      for P of Factors (U64 (abs N)).Values loop
         if P /= 0 then
            if P = Last then
               return 0;
            end if;
            Result := -Result;
            Last := P;
         end if;
      end loop;
      return Result;
   end Moebius;

   function Liouville (N : U64) return Liouville_Value is
   begin
      if N = 0 then
         return -1;
      end if;
      return (if Factors (N).Count mod 2 = 0 then 1 else -1);
   end Liouville;

   function Exp_Mangoldt (N : U64) return U64 is
      F : constant Factorization := Factors (N);
   begin
      if F.Count = 0 then
         return 1;
      end if;
      for I in 2 .. F.Count loop
         if F.Values (I) /= F.Values (1) then
            return 1;
         end if;
      end loop;
      return F.Values (1);
   end Exp_Mangoldt;

   function Mertens (N : U64) return Int.I128 is
      --  moebius.c: mertens_array and _rmertens. Group equal quotients
      --  in M(x) = 1 - sum_{i=2..x} M(floor(x/i)). The cache is per call.
      Limit : constant U64 := U64'Min (N, 1_000_000);
      type Mu_Array is array (U64 range <>) of Interfaces.Integer_8;
      type Prefix_Array is array (U64 range <>) of Integer;
      type Cache_Array is array (U64 range <>) of Int.I128;
      type Known_Array is array (U64 range <>) of Boolean;
      Mu : Mu_Array (0 .. Limit) := [others => 1];
      Prefix : Prefix_Array (0 .. Limit) := [others => 0];
      Slots : constant U64 := N / (Limit + 1);
      Cache : Cache_Array (1 .. Slots) := [others => 0];
      Known : Known_Array (1 .. Slots) := [others => False];
      J : U64;
      function Evaluate (X : U64) return Int.I128 is
         Sum : Int.I128 := 1;
         Low : U64 := 2;
         High, Q, Slot : U64;
      begin
         if X <= Limit then
            return Int.I128 (Prefix (X));
         end if;
         Slot := N / X;
         if Known (Slot) then
            return Cache (Slot);
         end if;
         while Low <= X loop
            Q := X / Low;
            High := X / Q;
            Sum := Sum - Int.I128 (High - Low + 1) * Evaluate (Q);
            exit when High = X;
            Low := High + 1;
         end loop;
         Cache (Slot) := Sum;
         Known (Slot) := True;
         return Sum;
      end Evaluate;
   begin
      Mu (0) := 0;
      for P in U64 range 2 .. Limit loop
         --  Prefix doubles as a composite marker until summation below.
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
         Prefix (I) := Prefix (I - 1) + Integer (Mu (I));
      end loop;
      return Evaluate (N);
   end Mertens;

   function Mertens (Lo, Hi : U64) return Int.I128 is
      Sum : Int.I128 := 0;
      I : U64 := U64'Max (1, Lo);
   begin
      if Lo > Hi then
         return 0;
      elsif Lo = 0 or Lo = 1 then
         return Mertens (Hi);
      elsif Hi - Lo <= 100 then
         while I <= Hi loop
            Sum := Sum + Int.I128 (Moebius (Int.I128 (I)));
            exit when I = Hi;
            I := I + 1;
         end loop;
         return Sum;
      end if;
      return Mertens (Hi) - Mertens (Lo - 1);
   end Mertens;
end Math_Prime_Util.Arith;
