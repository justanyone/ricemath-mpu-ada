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

   --  factor.c pbrent_factor, USE_MONTMATH (the x86_64 fixture path).
   function Bit_Length (Value : U64) return Natural is
      Rest : U64 := Value;
      Bits : Natural := 0;
   begin
      while Rest > 0 loop
         Bits := Bits + 1;
         Rest := Rest / 2;
      end loop;
      return Bits;
   end Bit_Length;

   function Mont_One (Modulus : U64) return U64 is
     (U64 (U128'(2) ** 64 mod U128 (Modulus)));

   function Mont_Inverse (Modulus : U64) return U64 is
      Ret : U64 := (3 * Modulus) xor 2;
   begin
      for Unused in 1 .. 4 loop
         Ret := Ret * (2 - Modulus * Ret);
      end loop;
      return 0 - Ret;
   end Mont_Inverse;

   function Mont_Mul
     (Left, Right, Modulus, Inverse : U64) return U64
   is
      Product : constant U128 := U128 (Left) * U128 (Right);
      Low : constant U64 := U64 (Product mod 2 ** 64);
      Scaled : constant U128 := U128 (Low * Inverse) * U128 (Modulus);
      Sum : constant U128 := Product + Scaled;
      Carry : constant U128 := (if Sum < Product then 1 else 0);
      High : U128 := Sum / 2 ** 64 + Carry * 2 ** 64;
   begin
      while High >= U128 (Modulus) loop
         High := High - U128 (Modulus);
      end loop;
      return U64 (High);
   end Mont_Mul;

   function Add_Mod (Left, Right, Modulus : U64) return U64 is
      Sum : constant U128 := U128 (Left) + U128 (Right);
   begin
      if Sum >= U128 (Modulus) then
         return U64 (Sum - U128 (Modulus));
      end if;
      return U64 (Sum);
   end Add_Mod;

   function Brent (N, Rounds, A : U64) return U64 is
      Left : U64 := Rounds;
      Width : constant U64 :=
        (if Bit_Length (N) <= 31 then 32
         elsif Bit_Length (N) <= 35 then 64
         elsif Bit_Length (N) <= 40 then 160
         elsif Bit_Length (N) <= 52 then 256
         else 320);
      Inverse : constant U64 := Mont_Inverse (N);
      One : constant U64 := Mont_One (N);
      R : U64 := 1;
      X : U64 := One;
      Anchor : U64 := One;
      Saved : U64 := One;
      C : U64 := U64 ((U128 (A) * U128 (One)) mod U128 (N));
      Remaining, Batch, Product, D : U64 := 1;
      Failures : Integer := 6;

      procedure Advance (Value : in out U64) is
      begin
         if N < 2 ** 63 or else C = One then
            Value := Mont_Mul (Value, Value + C, N, Inverse);
         else
            Value := Add_Mod
              (Mont_Mul (Value, Value, N, Inverse), C, N);
         end if;
      end Advance;
   begin
      while Left > 0 loop
         Remaining := U64'Min (R, Left);
         Anchor := X;
         D := 1;
         while Remaining > 0 loop
            Batch := U64'Min (Remaining, Width);
            Remaining := Remaining - Batch;
            Left := Left - Batch;
            Saved := X;
            Advance (X);
            Product := Difference (X, Anchor);
            Batch := Batch - 1;
            while Batch > 0 loop
               Advance (X);
               Product := Mont_Mul
                 (Product, Difference (X, Anchor), N, Inverse);
               Batch := Batch - 1;
            end loop;
            D := Int.Gcd (Product, N);
            exit when D /= 1;
         end loop;
         if D = 1 then
            R := R * 2;
         else
            if D = N then
               X := Saved;
               loop
                  Advance (X);
                  D := Int.Gcd (Difference (X, Anchor), N);
                  exit when D /= 1;
                  exit when R = 0;
                  R := R - 1;
               end loop;
               if D = 1 then
                  R := U64'Last;
               end if;
            end if;
            if D = 0 or else D = N then
               exit when Failures <= 0;
               Failures := Failures - 1;
               X := One;
               Anchor := One;
               C := Add_Mod (C, U64 ((U128 (11) * U128 (One)) mod U128 (N)), N);
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
