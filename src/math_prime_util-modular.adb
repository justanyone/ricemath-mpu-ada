with Math_Prime_Util.Primality;

package body Math_Prime_Util.Modular with SPARK_Mode => On is
   use type U128;
   use type Primality.Prime_Result;

   function Mul (A, B, M : U64) return U64
     with Pre => M > 0, Post => Mul'Result < M
   is (U64 ((U128 (A) * U128 (B)) mod U128 (M)));

   function Add (A, B, M : U64) return U64
     with Pre => M > 0, Post => Add'Result < M
   is (U64 ((U128 (A) + U128 (B)) mod U128 (M)));

   function Power (A, E, M : U64) return U64
     with Pre => M > 0, Post => Power'Result < M
   is (Powmod (A, E, M).Value);

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
      L : constant U128 := U128' Min (K, N - K);
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
      P, Q, R, Delta, X : U64;
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
         Delta := Submod (R, Result mod Q, Q).Value;
         X := Mul (Delta, Invmod (Product mod Q, Q).Value, Q);
         Result := U64 (U128 (Result) + U128 (Product) * U128 (X));
         Product := Product * Q;
      end loop;
      if Negative and Result /= 0 then
         Result := M - Result;
      end if;
      return (True, Result);
   end Binomialmod;
