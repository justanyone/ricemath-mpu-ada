from pathlib import Path
p=Path('src/math_prime_util-primality.ads')
s=p.read_text().replace('--  primality.c: is_prob_prime.','--  util.c: is_prime.',1)
new=''
for name,args,pre,source in [
('Is_Perrin_Pseudoprime','N : U64; Restricted : Natural := 0','Restricted <= 3','primality.c: is_perrin_pseudoprime, calc_perrin_sig'),
('Is_Frobenius_Pseudoprime','N : U64','True','primality.c: is_frobenius_pseudoprime'),
('Is_Frobenius_Pseudoprime','N : U64; P, Q : Interfaces.Integer_64','True','primality.c: is_frobenius_pseudoprime_pq'),
('Is_Frobenius_Khashin_Pseudoprime','N : U64','True','primality.c: is_frobenius_khashin_pseudoprime'),
('Is_Frobenius_Underwood_Pseudoprime','N : U64','True','primality.c: is_frobenius_underwood_pseudoprime'),
('Is_Catalan_Pseudoprime','N : U64','True','util.c: is_catalan_pseudoprime'),
('Is_Chen_Prime','N : U64','True','almost_primes.c: is_chen_prime')]:
 new+=f"   --  {source}.\n   --  Native predicate; invalid parameters raise Constraint_Error.\n   function {name}\n     ({args}) return Boolean\n     with Pre => {pre},\n          Post => (if N < 2 then not {name}'Result);\n\n"
new+='''   --  util.c: is_delicate_prime. Base >= 2; undefined on digit overflow.
   function Is_Delicate_Prime
     (N : U64; Base : U64 := 10) return Mersenne_Result
     with Pre => Base >= 2,
          Post => (if N < 2 then Is_Delicate_Prime'Result.Defined);

'''
p.write_text(s.replace('end Math_Prime_Util.Primality;',new+'end Math_Prime_Util.Primality;'))
p=Path('src/math_prime_util-primality.adb');s=p.read_text();s=s.replace('with Math_Prime_Util.Int;','with Math_Prime_Util.Sieve;\nwith Math_Prime_Util.Int;',1)
new='''   function Add (A, B, N : U64) return U64 is
     (Int.Addmod (A, B, N).Value);
   function Sub (A, B, N : U64) return U64 is
     (Int.Submod (A, B, N).Value);
   function Mul (A, B, N : U64) return U64 is
     (Int.Mulmod (A, B, N).Value);

   function Is_Perrin_Pseudoprime
     (N : U64; Restricted : Natural := 0) return Boolean
   is
      S, T : array (Natural range 0 .. 5) of U64;
      Bits : Natural := 0;
      V : U64 := N;
      T01, T34, T45, B, B2 : U64;
      J : Integer;
   begin
      if N < 3 then
         return N = 2;
      elsif N mod 2 = 0 and Restricted > 2 then
         return False;
      end if;
      S := (1, N - 1, 3 mod N, 3 mod N, 0, 2);
      while V > 0 loop
         Bits := Bits + 1;
         V := V / 2;
      end loop;
      for Bit in reverse 0 .. Bits - 2 loop
         for I in S'Range loop
            T (I) := Sub (Sub (Mul (S (I), S (I), N),
              S (5 - I), N), S (5 - I), N);
         end loop;
         T01 := Sub (T (2), T (1), N);
         T34 := Sub (T (5), T (4), N);
         T45 := Add (T34, T (3), N);
         if N / 2 ** Bit mod 2 = 1 then
            S := (T (0), T01, T (1), T (4), T45, T (5));
         else
            S := (T01, T (1), Add (T01, T (0), N), T34, T (4), T45);
         end if;
      end loop;
      if S (4) /= 0 then
         return False;
      elsif Restricted = 0 then
         return True;
      elsif S (1) /= N - 1 then
         return False;
      elsif Restricted = 1 then
         return True;
      end if;
      J := Jacobi (-23, N);
      if J = -1 then
         B := S (2);
         B2 := Mul (B, B, N);
         return S (0) = Sub (Add (1, Mul (B, 3, N), N), B2, N)
           and S (3) = B and S (5) = Sub (Mul (B2, 3, N), 2, N)
           and B /= 3 and Sub (Mul (B2, B, N), B, N) = 1;
      end if;
      if J = 0 and N /= 23 and Restricted > 2 then
         return False;
      end if;
      return (S (0) = 1 and S (2) = 3 and S (3) = 3 and S (5) = 2)
        or (S (0) = 0 and S (5) = N - 1 and S (2) /= S (3)
          and Add (S (2), S (3), N) = N - 3
          and Mul (Sub (S (2), S (3), N), Sub (S (2), S (3), N), N)
            = N - (23 mod N));
   end Is_Perrin_Pseudoprime;

   function Is_Frobenius_Pseudoprime
     (N : U64; P, Q : Interfaces.Integer_64) return Boolean
   is
      D : constant Int.I128 := Int.I128 (P) ** 2 - 4 * Int.I128 (Q);
      Du, Qu, G, Expected, K : U64;
      J : Integer;
      R : Lucas.Residue_Pair;
   begin
      if N < 4 then
         return N in 2 | 3;
      elsif N mod 2 = 0 or N = U64'Last then
         return False;
      end if;
      if P not in -3_037_000_497 .. 3_037_000_497 or
        Q not in -3_037_000_497 .. 3_037_000_497
      then
         raise Constraint_Error with "Frobenius parameters out of range";
      end if;
      Du := U64 (abs D);
      if D >= 0 and then Int.Is_Square (Du) then
         raise Constraint_Error with "square Frobenius discriminant";
      end if;
      Qu := U64 ((Int.I128 (Q) mod Int.I128 (N)));
      G := Int.Gcd (N, Qu);
      if G /= 1 then
         return G = N and then Is_Prob_Prime (N) /= 0;
      end if;
      G := Int.Gcd (N, Du);
      if G /= 1 then
         return G = N and then Is_Prob_Prime (N) /= 0;
      end if;
      J := Jacobi (D, N);
      if J = 0 then
         return False;
      end if;
      K := (if J = 1 then N - 1 else N + 1);
      Expected := (if J = 1 then 2 else Add (Qu, Qu, N));
      R := Lucas.Lucasuvmod (P, Q, K, N);
      return R.U = 0 and R.V = Expected;
   end Is_Frobenius_Pseudoprime;

   function Is_Frobenius_Pseudoprime (N : U64) return Boolean is
      P : Lucas.I64 := -1;
      J : Integer;
   begin
      if N < 11 then
         return N in 2 | 3 | 5 | 7;
      elsif N mod 2 = 0 or N = U64'Last then
         return False;
      end if;
      loop
         P := P + 2;
         if P = 3 then
            P := 5;
         end if;
         J := Jacobi (Int.I128 (P) ** 2 - 8, N);
         if P = 10_001 and then Int.Is_Square (N) then
            return False;
         end if;
         exit when J /= 1;
      end loop;
      return J /= 0 and then Is_Frobenius_Pseudoprime (N, P, 2);
   end Is_Frobenius_Pseudoprime;

   function Is_Frobenius_Khashin_Pseudoprime (N : U64) return Boolean is
      J : Integer := 2;
      C : U64 := 1;
      A, B, Ra, Rb, Ea, Ta, Tb, T, D : U64;
   begin
      if N < 7 then
         return N in 2 | 3 | 5;
      elsif N mod 2 = 0 or N = U64'Last or else Int.Is_Square (N) then
         return False;
      end if;
      D := N - 1;
      if N mod 4 = 3 then
         C := D;
      elsif N mod 8 = 5 then
         C := 2;
      else
         loop
            C := C + 2;
            if C /= 9 and then
              (C < 15 or else (C mod 3 /= 0 and C mod 5 /= 0
                and C mod 7 /= 0 and C mod 11 /= 0 and C mod 13 /= 0))
            then
               J := Jacobi (Int.I128 (C), N);
               exit when J /= 1;
            end if;
         end loop;
      end if;
      if J = 0 or (J = 2 and N mod 3 = 0) then
         return False;
      end if;
      Ea := (if J = 2 then 2 else 1);
      A := Ea;
      Ra := Ea;
      B := 1;
      Rb := 1;
      while D > 0 loop
         if D mod 2 = 1 then
            Ta := Ra;
            Tb := Rb;
            Ra := Add (Mul (Ta, A, N), Mul (Mul (Tb, B, N), C, N), N);
            Rb := Add (Mul (Tb, A, N), Mul (Ta, B, N), N);
         end if;
         D := D / 2;
         if D > 0 then
            T := Mul (Mul (B, B, N), C, N);
            B := Mul (B, A, N);
            B := Add (B, B, N);
            A := Add (Mul (A, A, N), T, N);
         end if;
      end loop;
      return Ra = Ea and Rb = N - 1;
   end Is_Frobenius_Khashin_Pseudoprime;

   function Is_Frobenius_Underwood_Pseudoprime
     (N : U64) return Boolean
   is
      X : U64 := 0;
      A, B, T, G, V, Expected, Multiplier : U64;
      Bits : Natural := 0;
      J : Integer;
   begin
      if N < 7 then
         return N in 2 | 3 | 5;
      elsif N mod 2 = 0 or N = U64'Last then
         return False;
      end if;
      loop
         if X not in 2 | 4 | 7 | 8 | 10 | 14 | 16 | 18 then
            if X > 999_999 then
               raise Constraint_Error with "Underwood parameter search";
            end if;
            J := Jacobi (Int.I128 (X) ** 2 - 4, N);
            exit when J = -1;
            if J = 0 or else (X = 20 and then Int.Is_Square (N)) then
               return False;
            end if;
         end if;
         X := X + 1;
      end loop;
      G := Int.Gcd (N, Mul (X + 4, 2 * X + 5, N));
      if G /= 1 and G /= N then
         return False;
      end if;
      V := N + 1;
      while V > 0 loop
         Bits := Bits + 1;
         V := V / 2;
      end loop;
      A := 1;
      B := 2;
      Multiplier := Add (X, 2, N);
      Expected := Add (Add (X, X, N), 5, N);
      for Bit in reverse 0 .. Bits - 2 loop
         T := Add (Mul (A, X, N), Add (B, B, N), N);
         B := Mul (Sub (B, A, N), Add (B, A, N), N);
         A := Mul (A, T, N);
         if (N + 1) / 2 ** Bit mod 2 = 1 then
            T := B;
            B := Sub (Add (B, B, N), A, N);
            A := Add (Mul (A, Multiplier, N), T, N);
         end if;
      end loop;
      return A = 0 and B = Expected;
   end Is_Frobenius_Underwood_Pseudoprime;

'''
s=s.replace('end Math_Prime_Util.Primality;',new+'end Math_Prime_Util.Primality;');p.write_text(s)
