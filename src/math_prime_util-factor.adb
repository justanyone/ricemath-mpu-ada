with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Factor with SPARK_Mode => On is
   use type U128;
   use type Primality.Prime_Result;

   function Difference (A, B : U64) return U64 is
     (if A >= B then A - B else B - A);

   function Step (X, A, N : U64) return U64 is
     (U64 ((U128 (X) * U128 (X) + U128 (A)) mod U128 (N)));

   procedure Sort (Values : in out Factor_List) is
      V : U64;
      J : Natural;
   begin
      for I in Values'First + 1 .. Values'Last loop
         V := Values (I);
         J := I;
         while J > Values'First and then Values (J - 1) > V loop
            Values (J) := Values (J - 1);
            J := J - 1;
         end loop;
         Values (J) := V;
      end loop;
   end Sort;

   function Trial_Factor (N : U64; Max_Factor : U64 := 0)
      return Factor_List
   is
      Values : Factor_List (1 .. 64);
      Count : Natural := 0;
      Rest : U64 := N;
      D : U64 := 7;
   begin
      if N < 2 then
         return (if N = 0 then [1 => 0] else []);
      end if;
      --  XS.xs removes these primes before applying the trial limit.
      for P of Factor_List'[2, 3, 5] loop
         while Rest mod P = 0 loop
            Count := Count + 1;
            Values (Count) := P;
            Rest := Rest / P;
         end loop;
      end loop;
      if Rest > 1 and then Primality.Is_Prime (Rest) /= 0 then
         Count := Count + 1;
         Values (Count) := Rest;
         return Values (1 .. Count);
      end if;
      while D <= Rest / D and then
        (Max_Factor = 0 or else D <= Max_Factor)
      loop
         while Rest mod D = 0 loop
            Count := Count + 1;
            Values (Count) := D;
            Rest := Rest / D;
         end loop;
         D := D + 2;
      end loop;
      if Rest > 1 then
         Count := Count + 1;
         Values (Count) := Rest;
      end if;
      return Values (1 .. Count);
   end Trial_Factor;

   --  factor.c: pbrent_factor (USE_MONTMATH on x86-64).
   function Brent (N, Rounds, A : U64) return U64 is
      Radix : constant U128 := 2 ** 64;
      Mask : constant U128 := Radix - 1;
      function Bit_Length (Value : U64) return Natural is
         X : U64 := Value;
         Bits : Natural := 0;
      begin
         while X > 0 loop
            Bits := Bits + 1;
            X := X / 2;
         end loop;
         return Bits;
      end Bit_Length;
      Bits : constant Natural := Bit_Length (N);
      Inner : constant Natural :=
        (if Bits <= 31 then 32
         elsif Bits <= 35 then 64
         elsif Bits <= 40 then 160
         elsif Bits <= 52 then 256
         else 320);
      Inverse : U64 := (3 * N) xor 2;
      Mont1 : constant U64 := U64 (Radix mod U128 (N));
      function Add_Mod (Left, Right : U64) return U64 is
        (U64 ((U128 (Left) + U128 (Right)) mod U128 (N)));
      function To_Mont (Value : U64) return U64 is
        (U64 ((U128 (Value) * U128 (Mont1)) mod U128 (N)));
      function Mont_Mul (Left, Right : U64) return U64 is
         Product : constant U128 := U128 (Left) * U128 (Right);
         M : constant U64 := U64 (Product and Mask) * Inverse;
         MN : constant U128 := U128 (M) * U128 (N);
         Low : constant U128 := (Product and Mask) + (MN and Mask);
         High : constant U128 :=
           Product / Radix + MN / Radix + Low / Radix;
         T : constant U64 := U64 (High and Mask);
      begin
         --  factor.c _mulredc64 keeps a wrapped difference when the
         --  128-bit accumulation overflows. Smaller n subtract once.
         if N >= 2 ** 63 and then High >= Radix then
            return T - N;
         elsif T >= N then
            return T - N;
         else
            return T;
         end if;
      end Mont_Mul;
      function Poly (X : U64; C : U64) return U64 is
      begin
         if N < 2 ** 63 or else C = Mont1 then
            return Mont_Mul (X, X + C);
         end if;
         return Add_Mod (Mont_Mul (X, X), C);
      end Poly;
      Left : U64 := Rounds;
      R : U64 := 1;
      X : U64 := Mont1;
      Y : U64 := Mont1;
      C : U64 := To_Mont (A);
      Saved, M, D : U64;
      Batch : Natural;
      Remaining : U64;
      Fails : Integer := 6;
   begin
      for I in 1 .. 4 loop
         Inverse := Inverse * (2 - N * Inverse);
      end loop;
      Inverse := 0 - Inverse;
      while Left > 0 loop
         Remaining := U64'Min (R, Left);
         Y := X;
         D := 1;
         while Remaining > 0 loop
            Batch := Natural (U64'Min (Remaining, U64 (Inner)));
            Saved := X;
            Remaining := Remaining - U64 (Batch);
            Left := Left - U64 (Batch);
            X := Poly (X, C);
            M := Difference (X, Y);
            for I in 1 .. Batch - 1 loop
               X := Poly (X, C);
               M := Mont_Mul (M, Difference (X, Y));
            end loop;
            D := Int.Gcd (M, N);
            exit when D /= 1;
         end loop;
         if D = 1 then
            R := R * 2;
         else
            if D = N then
               X := Saved;
               while D = 1 and then R /= 0 loop
                  R := R - 1;
                  X := Poly (X, C);
                  D := Int.Gcd (Difference (X, Y), N);
               end loop;
            end if;
            if D = 0 or else D = N then
               exit when Fails <= 0;
               Fails := Fails - 1;
               X := Mont1;
               Y := Mont1;
               C := Add_Mod (C, To_Mont (11));
            else
               return D;
            end if;
         end if;
      end loop;
      return N;
   end Brent;

   --  factor.c: prho_factor, including batch rollback and retries.
   function Rho (N, Rounds : U64) return U64 is
      X, Y : U64 := 7 mod N;
      C : U64 := 1;
      Old_X, Old_Y, Product, D : U64;
      Failures : Natural := 0;
      Blocks : constant U64 := Rounds / 64 +
        (if Rounds mod 64 = 0 then 0 else 1);
   begin
      for B in 1 .. Blocks loop
         Product := 1;
         Old_X := X;
         Old_Y := Y;
         for I in 1 .. 64 loop
            X := Step (X, C, N);
            Y := Step (Step (Y, C, N), C, N);
            Product := U64
              (U128 (Product) * U128 (Difference (X, Y)) mod U128 (N));
         end loop;
         D := Int.Gcd (Product, N);
         if D = N then
            X := Old_X;
            Y := Old_Y;
            for I in 1 .. 65 loop
               X := Step (X, C, N);
               Y := Step (Step (Y, C, N), C, N);
               D := Int.Gcd (Difference (X, Y), N);
               exit when D /= 1;
            end loop;
         end if;
         if D > 1 and D < N then
            return D;
         elsif D = N then
            exit when Failures = 3;
            Failures := Failures + 1;
            X := U64 ((U128 (X) + 2) mod U128 (N));
            Y := X;
            C := C + 2;
         end if;
      end loop;
      return N;
   end Rho;

   --  factor.c: fermat_factor; wide squares avoid signed overflow.
   function Fermat (N, Rounds : U64) return U64 is
      Root : U64 := Int.Sqrtint (N);
      Square_Gap : U128;
      B : U64;
   begin
      for I in 0 .. Rounds loop
         Square_Gap := U128 (Root) ** 2;
         if Square_Gap >= U128 (N) then
            Square_Gap := Square_Gap - U128 (N);
            if Square_Gap <= U128 (U64'Last) then
               B := Int.Sqrtint (U64 (Square_Gap));
               if U128 (B) ** 2 = Square_Gap then
                  return Root - B;
               end if;
            end if;
         end if;
         exit when Root = U64'Last;
         Root := Root + 1;
      end loop;
      return N;
   end Fermat;

   type Method is (Brent_Method, Rho_Method, Fermat_Method);

   --  XS.xs: common small-factor preprocessing for named methods.
   function Split (N, Rounds, A : U64; Kind : Method)
      return Factor_List
   is
      Small : constant Factor_List := Trial_Factor (N, 5);
      Values : Factor_List (1 .. 64);
      Count : Natural := Small'Length;
      Rest, D : U64;
   begin
      Values (1 .. Count) := Small;
      if Count = 0 then
         return [];
      end if;
      Rest := Values (Count);
      if Rest < 7 or else Primality.Is_Prime (Rest) /= 0 then
         return Small;
      end if;
      D := (case Kind is
         when Brent_Method => Brent (Rest, Rounds, A),
         when Rho_Method => Rho (Rest, Rounds),
         when Fermat_Method => Fermat (Rest, Rounds));
      if D > 1 and D < Rest then
         Values (Count) := D;
         Count := Count + 1;
         Values (Count) := Rest / D;
         Sort (Values (1 .. Count));
      end if;
      return Values (1 .. Count);
   end Split;

   function Pbrent_Factor
     (N : U64; Rounds : U64 := 1_000_000; A : U64 := 1)
      return Factor_List is (Split (N, Rounds, A, Brent_Method));

   function Prho_Factor (N : U64; Rounds : U64 := 1_000_000)
      return Factor_List is (Split (N, Rounds, 1, Rho_Method));

   function Fermat_Factor (N : U64; Rounds : U64 := 1_000_000)
      return Factor_List is (Split (N, Rounds, 1, Fermat_Method));

   --  factor.c: factor, iterative splitting and sorted prime output.
   function Factor (N : U64) return Factor_List is
      Values, Pending : Factor_List (1 .. 64);
      Count : Natural := 0;
      Top : Natural := 1;
      Rest, D : U64;
   begin
      if N < 2 then
         return (if N = 0 then [1 => 0] else []);
      end if;
      Pending (1) := N;
      while Top > 0 loop
         Rest := Pending (Top);
         Top := Top - 1;
         if Primality.Is_Prime (Rest) /= 0 then
            Count := Count + 1;
            Values (Count) := Rest;
         else
            D := Rest;
            for P of Factor_List'[2, 3, 5] loop
               if Rest mod P = 0 then
                  D := P;
                  exit;
               end if;
            end loop;
            if D = Rest then
               for A in U64 range 1 .. 16 loop
                  D := Brent (Rest, 1_000_000, A);
                  exit when D > 1 and D < Rest;
               end loop;
            end if;
            if D <= 1 or D = Rest then
               raise Constraint_Error with "factor split exhausted";
            end if;
            Top := Top + 1;
            Pending (Top) := D;
            Top := Top + 1;
            Pending (Top) := Rest / D;
         end if;
      end loop;
      Sort (Values (1 .. Count));
      return Values (1 .. Count);
   end Factor;

   --  factor.c: divisor_list, expand prime powers then sort.
   function Divisors (N : U64; Max_Divisor : U64 := U64'Last)
      return Factor_List
   is
      Factors : constant Factor_List := Factor (N);
      Capacity : Positive := 1;
      I : Positive := 1;
      Exponent : Natural;
   begin
      if N = 0 or Max_Divisor = 0 then
         return [];
      end if;
      while I <= Factors'Last loop
         Exponent := 1;
         while I < Factors'Last and then Factors (I) = Factors (I + 1)
         loop
            Exponent := Exponent + 1;
            I := I + 1;
         end loop;
         Capacity := Capacity * (Exponent + 1);
         I := I + 1;
      end loop;
      declare
         Values : Factor_List (1 .. Capacity);
         Count : Positive := 1;
         Base_Count : Positive;
         Power, P : U64;
      begin
         Values (1) := 1;
         I := 1;
         while I <= Factors'Last loop
            P := Factors (I);
            Power := 1;
            Base_Count := Count;
            loop
               Power := Power * P;
               for J in 1 .. Base_Count loop
                  if Values (J) <= Max_Divisor / Power then
                     Count := Count + 1;
                     Values (Count) := Values (J) * Power;
                  end if;
               end loop;
               I := I + 1;
               exit when I > Factors'Last or else Factors (I) /= P;
            end loop;
         end loop;
         Sort (Values (1 .. Count));
         return Values (1 .. Count);
      end;
   end Divisors;
end Math_Prime_Util.Factor;
