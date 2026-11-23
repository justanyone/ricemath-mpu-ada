with Math_Prime_Util.Primality;

package body Math_Prime_Util.Modular with SPARK_Mode => On is
   use type U128;
   use type Primality.Prime_Result;

   function Mul (A, B, M : U64) return U64
     is (U64 ((U128 (A) * U128 (B)) mod U128 (M)))
     with Pre => M > 0, Post => Mul'Result < M;

   function Add (A, B, M : U64) return U64
     is (U64 ((U128 (A) + U128 (B)) mod U128 (M)))
     with Pre => M > 0, Post => Add'Result < M;

   function Power (A, E, M : U64) return U64
     is (Powmod (A, E, M).Value)
     with Pre => M > 0, Post => Power'Result < M;

   subtype Factor_Count is Natural range 0 .. 64;
   type Factor_Array is array (Positive range 1 .. 64) of U64;
   type Factors is record
      Count : Factor_Count := 0;
      Values : Factor_Array := [others => 0];
   end record;

   --  Local factorization support until the factor package is available.
   --  Deterministic rho restarts have no shared random or mutable state.
   function Split (N : U64) return U64
     with Pre => N > 1
   is
      X, Y, D, C : U64;
   begin
      if N mod 2 = 0 then
         return 2;
      end if;
      C := 1;
      loop
         X := 2;
         Y := 2;
         D := 1;
         for Iteration in 1 .. 200_000 loop
            X := Add (Mul (X, X, N), C, N);
            Y := Add (Mul (Y, Y, N), C, N);
            Y := Add (Mul (Y, Y, N), C, N);
            D := Gcd ((if X > Y then X - Y else Y - X), N);
            exit when D /= 1;
         end loop;
         if D > 1 and D < N then
            return D;
         end if;
         C := (if C = N - 1 then 1 else C + 1);
      end loop;
   end Split;

   procedure Factor_Into (N : U64; F : in out Factors)
     with Pre => N > 0
   is
      D : U64;
   begin
      if N = 1 then
         return;
      elsif Primality.Is_Prime (N) /= 0 then
         F.Count := F.Count + 1;
         F.Values (F.Count) := N;
      else
         D := Split (N);
         Factor_Into (D, F);
         Factor_Into (N / D, F);
      end if;
   end Factor_Into;

   function Factorize (N : U64) return Factors
     with Pre => N > 0
   is
      F : Factors;
      V : U64;
      J : Natural;
   begin
      Factor_Into (N, F);
      for I in 2 .. F.Count loop
         V := F.Values (I);
         J := I;
         while J > 1 and then F.Values (J - 1) > V loop
            F.Values (J) := F.Values (J - 1);
            J := J - 1;
         end loop;
         F.Values (J) := V;
      end loop;
      return F;
   end Factorize;

   function Factorialmod (N, M : U64) return Optional_U64 is
      D : U64 := N;
      R : U64 := 1;
      Backwards : Boolean := False;
   begin
      if M = 0 then
         return (Defined => False);
      elsif M = 1 or N >= M then
         return (True, 0);
      elsif N <= 1 then
         return (True, 1);
      end if;
      --  factmod.c: Wilson's theorem shortens products near a prime M.
      if N > M / 2 and then Primality.Is_Prime (M) /= 0 then
         D := M - N - 1;
         Backwards := True;
      end if;
      for I in U64 range 2 .. D loop
         R := Mul (R, I, M);
         exit when R = 0;
      end loop;
      if Backwards then
         if D mod 2 = 0 then
            R := M - R;
         end if;
         return Invmod (R, M);
      end if;
      return (True, R);
   end Factorialmod;

   --  factmod.c: _factorial_valuation, _factorialmod_without_prime,
   --  _factorialmod_without_prime_powers. N may be a transformed signed
   --  binomial input with 65 bits; residues remain native.
   function Valuation (N : U128; P : U64) return U128
     with Pre => P >= 2
   is
      T : U128 := N;
      R : U128 := 0;
   begin
      while T >= U128 (P) loop
         T := T / U128 (P);
         R := R + T;
      end loop;
      return R;
   end Valuation;

   function Unit_Factorial (N : U128; P, M : U64) return U64
     with Pre => P >= 2 and M >= P
   is
      T : U128 := N;
      R : U64 := 1;
      Tail : U64;
   begin
      while T > 1 loop
         if (T / U128 (M)) mod 2 = 1 and (P > 2 or M = 4) then
            R := M - R;
         end if;
         Tail := U64 (T mod U128 (M));
         for I in U64 range 2 .. Tail loop
            if I mod P /= 0 then
               R := Mul (R, I, M);
            end if;
         end loop;
         T := T / U128 (P);
      end loop;
      return R;
   end Unit_Factorial;

   function Binomial_Prime_Power
     (N, K : U128; P, M : U64; E : Positive) return U64
     with Pre => K <= N and P >= 2 and M >= P
   is
      B : constant U128 := Valuation (N, P) - Valuation (K, P)
        - Valuation (N - K, P);
      L : constant U128 := U128'Min (K, N - K);
      Num : U64 := 1;
      Den : U64 := 1;
      T, S : U128;
   begin
      if B >= U128 (E) then
         return 0;
      end if;
      --  Avoid traversing a huge prime modulus for small K.
      if L < U128 (M) then
         for I in U64 range 1 .. U64 (L) loop
            T := N - L + U128 (I);
            S := U128 (I);
            while T mod U128 (P) = 0 loop
               T := T / U128 (P);
            end loop;
            while S mod U128 (P) = 0 loop
               S := S / U128 (P);
            end loop;
            Num := Mul (Num, U64 (T mod U128 (M)), M);
            Den := Mul (Den, U64 (S mod U128 (M)), M);
         end loop;
      else
         Num := Unit_Factorial (N, P, M);
         Den := Mul (Unit_Factorial (K, P, M),
                     Unit_Factorial (N - K, P, M), M);
      end if;
      return Mul (Mul (Num, Invmod (Den, M).Value, M),
                  Power (P, U64 (B), M), M);
   end Binomial_Prime_Power;

   function Binomialmod (N, K : I128; M : U64) return Optional_U64 is
      NN : I128 := N;
      KK : I128 := K;
      Negative : Boolean := False;
      F : Factors;
      I : Positive := 1;
      E : Positive;
      P, Q, R, Difference, X : U64;
      Product : U64 := 1;
      Result : U64 := 0;
   begin
      if M = 0 then
         return (Defined => False);
      elsif M = 1 then
         return (True, 0);
      end if;
      --  MPU's signed binomial convention reflects negative K first.
      if KK < 0 then
         if NN >= 0 or KK > NN then
            return (True, 0);
         end if;
         KK := NN - KK;
      end if;
      if NN < 0 then
         Negative := KK mod 2 /= 0;
         NN := -NN + KK - 1;
      end if;
      if KK > NN then
         return (True, 0);
      elsif KK = 0 or KK = NN then
         return (True, 1);
      end if;
      F := Factorize (M);
      while I <= F.Count loop
         P := F.Values (I);
         Q := P;
         E := 1;
         I := I + 1;
         while I <= F.Count and then F.Values (I) = P loop
            Q := Q * P;
            E := E + 1;
            I := I + 1;
         end loop;
         R := Binomial_Prime_Power (U128 (NN), U128 (KK), P, Q, E);
         --  Incremental CRT, with exact 128-bit intermediates.
         Difference := Submod (R, Result mod Q, Q).Value;
         X := Mul (Difference, Invmod (Product mod Q, Q).Value, Q);
         Result := U64 (U128 (Result) + U128 (Product) * U128 (X));
         Product := Product * Q;
      end loop;
      if Negative and Result /= 0 then
         Result := M - Result;
      end if;
      return (True, Result);
   end Binomialmod;

   --  znlog.c: baby-step/giant-step search, with a bounded local table.
   --  Capping the width bounds memory, not the exponent search space.
   function Baby_Giant (A, G, M, Order : U64) return Optional_U64
     with Pre => M > 1 and Order > 0
   is
      Table_Size : constant := 131_071;
      subtype Slot is Natural range 0 .. Table_Size - 1;
      type Table_Entry is record
         Key, Exponent : U64 := 0;
         Used : Boolean := False;
      end record;
      type Table_Array is array (Slot) of Table_Entry;
      Table : Table_Array := [others => (0, 0, False)];
      Width : constant U64 := U64'Min (Sqrtint (Order) + 1, 65_536);
      V : U64 := 1;
      H : Slot;
      Step : U64;
      Inverse : Optional_U64;
      Candidate : U128;
   begin
      for J in U64 range 0 .. Width - 1 loop
         H := Slot (V mod Table_Size);
         while Table (H).Used and then Table (H).Key /= V loop
            H := (if H = Slot'Last then 0 else H + 1);
         end loop;
         if not Table (H).Used then
            Table (H) := (V, J, True);
         end if;
         V := Mul (V, G, M);
      end loop;
      Inverse := Invmod (V, M);
      if not Inverse.Defined then
         return (Defined => False);
      end if;
      Step := Inverse.Value;
      V := A;
      for I in U64 range 0 .. (Order - 1) / Width loop
         H := Slot (V mod Table_Size);
         while Table (H).Used loop
            if Table (H).Key = V then
               Candidate := U128 (I) * U128 (Width)
                 + U128 (Table (H).Exponent);
               if Candidate < U128 (Order) then
                  return (True, U64 (Candidate));
               end if;
            end if;
            H := (if H = Slot'Last then 0 else H + 1);
         end loop;
         V := Mul (V, Step, M);
      end loop;
      return (Defined => False);
   end Baby_Giant;

   function Group_Order (G, M : U64) return U64
     with Pre => M > 1 and Gcd (G, M) = 1
   is
      F : Factors := Factorize (M);
      Phi : U64 := M;
      Previous : U64 := 0;
   begin
      for I in 1 .. F.Count loop
         if F.Values (I) /= Previous then
            Phi := (Phi / F.Values (I)) * (F.Values (I) - 1);
            Previous := F.Values (I);
         end if;
      end loop;
      F := Factorize (Phi);
      for I in 1 .. F.Count loop
         if Power (G, Phi / F.Values (I), M) = 1 then
            Phi := Phi / F.Values (I);
         end if;
      end loop;
      return Phi;
   end Group_Order;

   --  znlog.c: znlog_ph, znlog_prime_power (Pohlig-Hellman digits).
   function Pohlig_Hellman (A, G, M, Order : U64) return Optional_U64
     with Pre => M > 1 and Order > 0 and Gcd (G, M) = 1
   is
      F : constant Factors := Factorize (Order);
      I : Positive := 1;
      Q, QE, Base, X, Digit_Power, H, Difference, T : U64;
      R : U64 := 0;
      Product : U64 := 1;
      Digit : Optional_U64;
      Inverse_G : constant U64 := Invmod (G, M).Value;
   begin
      while I <= F.Count loop
         Q := F.Values (I);
         QE := 1;
         X := 0;
         Base := Power (G, Order / Q, M);
         while I <= F.Count and then F.Values (I) = Q loop
            Digit_Power := QE;
            QE := QE * Q;
            H := Power (Mul (A, Power (Inverse_G, X, M), M),
                        Order / QE, M);
            Digit := Baby_Giant (H, Base, M, Q);
            if not Digit.Defined then
               return (Defined => False);
            end if;
            X := X + Digit.Value * Digit_Power;
            I := I + 1;
         end loop;
         Difference := Submod (X, R mod QE, QE).Value;
         T := Mul (Difference, Invmod (Product mod QE, QE).Value, QE);
         R := U64 (U128 (R) + U128 (Product) * U128 (T));
         Product := Product * QE;
      end loop;
      if Power (G, R, M) /= A then
         return (Defined => False);
      end if;
      return (True, R);
   end Pohlig_Hellman;

   function Znlog (A, G, M : U64) return Optional_U64 is
      Target, Base, Modulus, D, Accumulator, Offset, V, Order : U64;
      R : Optional_U64;
   begin
      if M = 0 then
         return (Defined => False);
      elsif M = 1 then
         return (True, 0);
      end if;
      Target := A mod M;
      Base := G mod M;
      --  Short exponents also avoid expensive order computations.
      V := 1;
      for I in U64 range 0 .. U64'Min (65_535, M) loop
         if V = Target then
            return (True, I);
         end if;
         V := Mul (V, Base, M);
      end loop;
      Modulus := M;
      Accumulator := 1;
      Offset := 0;
      D := Gcd (Base, Modulus);
      --  znlog.c: znlog_non_coprime strips common factors first.
      while D > 1 loop
         if Target = Accumulator then
            return (True, Offset);
         elsif Target mod D /= 0 then
            return (Defined => False);
         end if;
         Target := Target / D;
         Modulus := Modulus / D;
         Offset := Offset + 1;
         if Modulus = 1 then
            return (True, Offset);
         end if;
         Accumulator := Mul (Accumulator, Base / D, Modulus);
         D := Gcd (Base, Modulus);
      end loop;
      Target := Mul (Target, Invmod (Accumulator, Modulus).Value, Modulus);
      Base := Base mod Modulus;
      Order := Group_Order (Base, Modulus);
      R := Pohlig_Hellman (Target, Base, Modulus, Order);
      if R.Defined then
         if R.Value > U64'Last - Offset then
            return (Defined => False);
         end if;
         R.Value := R.Value + Offset;
      end if;
      return R;
   end Znlog;

   --  Fast doubling returns F(K), F(K+1), including 65-bit candidates.
   procedure Fibonacci (K : U128; M : U64; A, B : out U64)
     with Pre => M > 0
   is
      X : U64 := 0;
      Y : U64 := 1 mod M;
      C, D, Twice : U64;
      Mask : U128 := 2 ** 127;
   begin
      while Mask > 0 loop
         Twice := Submod (Add (Y, Y, M), X, M).Value;
         C := Mul (X, Twice, M);
         D := Add (Mul (X, X, M), Mul (Y, Y, M), M);
         if (K and Mask) = 0 then
            X := C;
            Y := D;
         else
            X := D;
            Y := Add (C, D, M);
         end if;
         Mask := Mask / 2;
      end loop;
      A := X;
      B := Y;
   end Fibonacci;

   function Is_Period (K : U128; M : U64) return Boolean
     with Pre => M > 1
   is
      A, B : U64;
   begin
      Fibonacci (K, M, A, B);
      return A = 0 and B = 1;
   end Is_Period;

   function Prime_Period (P : U64) return U128
     with Pre => P >= 2
   is
      Candidate : U128;
      F : Factors;
      Bound : U64;
   begin
      if P = 2 then
         return 3;
      elsif P = 5 then
         return 20;
      end if;
      --  util.c: _pisano_prime_power. The period divides P-1 for
      --  quadratic residues of 5, and 2*(P+1) otherwise.
      if P mod 5 = 1 or P mod 5 = 4 then
         Bound := P - 1;
         Candidate := U128 (Bound);
      else
         Bound := P + 1;
         Candidate := 2 * U128 (Bound);
      end if;
      F := Factorize (Bound);
      if Candidate > U128 (Bound) then
         F.Count := F.Count + 1;
         F.Values (F.Count) := 2;
      end if;
      for I in 1 .. F.Count loop
         if Is_Period (Candidate / U128 (F.Values (I)), P) then
            Candidate := Candidate / U128 (F.Values (I));
         end if;
      end loop;
      return Candidate;
   end Prime_Period;

   function Pisano_Period (N : U64) return Optional_U64 is
      F : Factors;
      I : Positive := 1;
      P : U64;
      Period : U128;
      Result : U64 := 1;
      Combined : U128;
   begin
      if N <= 1 then
         return (True, N);
      end if;
      F := Factorize (N);
      while I <= F.Count loop
         P := F.Values (I);
         Period := Prime_Period (P);
         I := I + 1;
         while I <= F.Count and then F.Values (I) = P loop
            Period := Period * U128 (P);
            I := I + 1;
         end loop;
         if Period > U128 (U64'Last) then
            return (Defined => False);
         end if;
         Combined := U128 (Result / Gcd (Result, U64 (Period))) * Period;
         if Combined > U128 (U64'Last) then
            return (Defined => False);
         end if;
         Result := U64 (Combined);
      end loop;
      return (True, Result);
   end Pisano_Period;
end Math_Prime_Util.Modular;
