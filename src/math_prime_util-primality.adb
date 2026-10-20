with Math_Prime_Util.Sieve;
with Math_Prime_Util.Int;
with Math_Prime_Util.Intmont;
with Math_Prime_Util.Lucas;

package body Math_Prime_Util.Primality is
   use type Int.I128;
   use type Lucas.I64;
   Bases : constant array (U64 range 0 .. 255) of U64 :=
     (4816, 6332, 958, 6124, 1001, 1431, 9644, 3700, 9251, 20069,
      7085, 2484, 3255, 218, 4660, 732, 1863, 3716, 2480, 2120,
      2464, 38264, 3070, 2621, 1592, 17862, 15223, 2926, 9119, 2181,
      24932, 4407, 10915, 13832, 1965, 3646, 2470, 62, 8548, 449,
      4440, 7656, 1065, 10100, 6497, 1868, 33282, 4277, 805, 636,
      11536, 34, 2065, 406, 6435, 1043, 27985, 7134, 1357, 3056,
      6077, 4704, 6174, 865, 15190, 14419, 38, 6161, 18774, 3990,
      976, 1267, 3251, 233, 7387, 241, 3871, 4331, 8780, 2233,
      30331, 1656, 462, 5585, 194, 10300, 1072, 1197, 1573, 1144,
      1273, 19439, 696, 1477, 15858, 2684, 6022, 80, 9726, 6731,
      1132, 774, 2202, 3668, 19479, 10837, 183, 71, 403, 5245,
      1995, 2019, 5209, 174, 503, 13830, 21013, 3284, 7164, 2607,
      10769, 473, 119, 8227, 1216, 3550, 1450, 1399, 45822, 609,
      721, 47, 9665, 4242, 767, 4880, 16037, 844, 333, 8560,
      1907, 2532, 13468, 302, 2589, 5546, 14312, 1548, 18013, 8452,
      12427, 4431, 10248, 4022, 5545, 1399, 41507, 1160, 1865, 219,
      1254, 3330, 13627, 1070, 3304, 5537, 6085, 26999, 10279, 5369,
      4992, 38919, 2191, 1663, 46961, 6570, 11876, 21689, 2804, 1202,
      5764, 275, 2862, 2139, 7799, 4646, 1696, 4964, 19016, 12891,
      4282, 4741, 7274, 174, 541, 26596, 7524, 2777, 1819, 339,
      1399, 2636, 668, 291, 559, 4992, 520, 7874, 2544, 4618,
      4122, 1128, 326, 275, 13080, 156, 236, 7015, 6349, 11673,
      2632, 475, 4560, 1543, 78, 3611, 34, 3811, 137, 737,
      31269, 2522, 13354, 2033, 8577, 3597, 9269, 3815, 2511, 8088,
      903, 109, 12454, 1985, 8065, 17637, 1645, 1404, 6106, 3661,
      328, 6160, 1602, 6601, 1491, 8657);

   function Jacobi (Input : Int.I128; Modulus : U64) return Integer is
      A : U64 := U64 (abs Input);
      N : U64 := Modulus;
      J : Integer := 1;
      Temp : U64;
   begin
      if N = 0 or else N mod 2 = 0 then
         return 0;
      end if;
      if Input < 0 and then N mod 4 = 3 then
         J := -J;
      end if;
      while A /= 0 loop
         while A mod 2 = 0 loop
            A := A / 2;
            if N mod 8 in 3 | 5 then
               J := -J;
            end if;
         end loop;
         Temp := A;
         A := N;
         N := Temp;
         if A mod 4 = 3 and N mod 4 = 3 then
            J := -J;
         end if;
         A := A mod N;
      end loop;
      return (if N = 1 then J else 0);
   end Jacobi;

   function Power (A, K, N : U64) return U64 is
     (if N mod 2 = 1 then Intmont.Powmod (A, K, N)
      else Int.Powmod (A, K, N).Value);

   function Is_Pseudoprime (N, A : U64) return Boolean is
      B : U64 := A;
   begin
      if N < 3 then
         return N = 2;
      end if;
      if N mod 2 = 0 and A mod 2 = 0 then
         return False;
      end if;
      if B >= N then
         B := B mod N;
         if B <= 1 then
            return B = 1;
         elsif B = N - 1 then
            return B mod 2 = 0;
         end if;
      end if;
      return Power (B, N - 1, N) = 1;
   end Is_Pseudoprime;

   function Is_Euler_Pseudoprime (N, A : U64) return Boolean is
      B : U64 := A;
      X : U64;
   begin
      if N < 3 then
         return N = 2;
      elsif N mod 2 = 0 then
         return False;
      end if;
      if B >= N then
         B := B mod N;
         if B <= 1 then
            return B = 1;
         elsif B = N - 1 then
            return B mod 2 = 0;
         end if;
      end if;
      if N mod B = 0 then
         return False;
      end if;
      X := Power (B, (N - 1) / 2, N);
      return X = (if Jacobi (Int.I128 (B), N) >= 0 then 1 else N - 1);
   end Is_Euler_Pseudoprime;

   function Is_Strong_Pseudoprime (N, A : U64) return Boolean is
      D : U64;
      S : Natural := 0;
      B, X : U64;
   begin
      if N < 3 then
         return N = 2;
      elsif N mod 2 = 0 then
         return False;
      end if;
      B := A mod N;
      if B <= 1 or else B = N - 1 then
         return True;
      end if;
      D := N - 1;
      while D mod 2 = 0 loop
         D := D / 2;
         S := S + 1;
      end loop;
      X := Power (B, D, N);
      if X = 1 or X = N - 1 then
         return True;
      end if;
      for I in 1 .. S - 1 loop
         X := Int.Sqrmod (X, N).Value;
         if X = N - 1 then
            return True;
         elsif X = 1 then
            return False;
         end if;
      end loop;
      return False;
   end Is_Strong_Pseudoprime;

   function Is_Euler_Plumb_Pseudoprime (N : U64) return Boolean is
      X : U64;
      R : constant U64 := N mod 8;
   begin
      if N < 5 then
         return N = 2 or N = 3;
      elsif N mod 2 = 0 then
         return False;
      end if;
      X := Power (2, (N - 1) / (if R = 1 then 4 else 2), N);
      return (X = 1 and R in 1 | 7) or
        (X = N - 1 and R in 1 | 3 | 5);
   end Is_Euler_Plumb_Pseudoprime;

   function Extra_Parameter (N, Increment : U64) return Lucas.I64 is
      P : U64 := 3;
      D, G : U64;
      J : Integer;
   begin
      loop
         D := P * P - 4;
         J := Jacobi (Int.I128 (D), N);
         if J = 0 then
            G := Int.Gcd (D, N);
            if G /= 1 and G /= N then
               return 0;
            end if;
         end if;
         exit when J = -1;
         if P = 3 + 20 * Increment and then Int.Is_Square (N) then
            return 0;
         end if;
         P := P + Increment;
         if P > 65_535 then
            raise Constraint_Error with "Lucas P exceeded 65535";
         end if;
      end loop;
      return Lucas.I64 (P mod N);
   end Extra_Parameter;

   function Lucas_Test (N : U64; Strength : Natural) return Boolean is
      D : Lucas.I64 := 5;
      P : Lucas.I64 := 1;
      Q : Lucas.I64;
      K, Qu : U64;
      S : Natural := 0;
      J : Integer;
      R : Lucas.Sequence_Result;
   begin
      if N < 5 then
         return N in 2 | 3;
      elsif N mod 2 = 0 or N = U64'Last then
         return False;
      end if;
      if Strength = 3 then
         P := Extra_Parameter (N, 1);
         if P = 0 then
            return False;
         end if;
         Q := 1;
      else
         loop
            J := Jacobi (Int.I128 (D), N);
            exit when J /= 1 and U64 (abs D) /= N;
            if abs D = 21 and then Int.Is_Square (N) then
               return False;
            end if;
            D := (if D > 0 then -(D + 2) else -D + 2);
            if abs D > 1_000_000 then
               raise Constraint_Error with "Lucas D exceeded 1e6";
            end if;
         end loop;
         if J /= -1 then
            return False;
         end if;
         Q := (1 - D) / 4;
         Qu := U64 (Int.I128 (Q) mod Int.I128 (N));
         if Int.Gcd (Qu, N) /= 1 then
            return False;
         end if;
      end if;
      K := N + 1;
      if Strength > 0 then
         while K mod 2 = 0 loop
            K := K / 2;
            S := S + 1;
         end loop;
      end if;
      R := Lucas.Lucas_Sequence (N, P, Q, K);
      if Strength = 0 then
         return R.U = 0;
      elsif Strength = 1 then
         if R.U = 0 then
            return True;
         end if;
         for I in 1 .. S loop
            if R.V = 0 then
               return True;
            end if;
            R.V := Int.Mulsubmod
              (R.V, R.V, Int.Addmod (R.Qk, R.Qk, N).Value, N).Value;
            R.Qk := Int.Sqrmod (R.Qk, N).Value;
         end loop;
      else
         if R.U = 0 and (R.V = 2 or R.V = N - 2) then
            return True;
         end if;
         for I in 1 .. S - 1 loop
            if R.V = 0 then
               return True;
            end if;
            R.V := Int.Mulsubmod (R.V, R.V, 2, N).Value;
         end loop;
      end if;
      return False;
   end Lucas_Test;

   function Is_Lucas_Pseudoprime (N : U64) return Boolean is
     (Lucas_Test (N, 0));
   function Is_Strong_Lucas_Pseudoprime (N : U64) return Boolean is
     (Lucas_Test (N, 1));
   function Is_Extra_Strong_Lucas_Pseudoprime (N : U64) return Boolean is
     (Lucas_Test (N, 3));

   function Is_Almost_Extra_Strong_Lucas_Pseudoprime
     (N : U64; Increment : U64 := 1) return Boolean
   is
      P : Lucas.I64;
      K, V : U64;
      S : Natural := 0;
   begin
      if N < 13 then
         return N in 2 | 3 | 5 | 7 | 11;
      elsif N mod 2 = 0 or N = U64'Last then
         return False;
      end if;
      if ((Increment >= 16 and N <= 331) or
          (Increment > 148 and N <= 631)) and then Is_Prob_Prime (N) /= 0
      then
         return True;
      end if;
      P := Extra_Parameter (N, Increment);
      if P = 0 then
         return False;
      end if;
      K := N + 1;
      while K mod 2 = 0 loop
         K := K / 2;
         S := S + 1;
      end loop;
      V := Lucas.Lucasvmod (P, 1, K, N);
      if V = 2 or V = N - 2 then
         return True;
      end if;
      for I in 1 .. S - 1 loop
         if V = 0 then
            return True;
         end if;
         V := Int.Mulsubmod (V, V, 2, N).Value;
      end loop;
      return False;
   end Is_Almost_Extra_Strong_Lucas_Pseudoprime;

   function Is_Bpsw_Prime (N : U64) return Boolean is
     (Is_Strong_Pseudoprime (N, 2) and then
        Is_Almost_Extra_Strong_Lucas_Pseudoprime (N));

   function Is_Prob_Prime (N : U64) return Prime_Result is
      Small : constant array (Positive range <>) of U64 :=
        (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53);
      Large : constant array (Positive range <>) of U64 :=
        (59, 61, 67, 71, 73, 79, 83, 89);
   begin
      if N < 2 then
         return 0;
      end if;
      for P of Small loop
         if N = P then
            return 2;
         elsif N mod P = 0 then
            return 0;
         end if;
      end loop;
      if N < 3_481 then
         return 2;
      elsif N <= 4_294_967_295 then
         return (if Is_Strong_Pseudoprime
           (N, Bases (N / 256 mod 256)) then 2 else 0);
      end if;
      for P of Large loop
         if N mod P = 0 then
            return 0;
         end if;
      end loop;
      return (if Is_Bpsw_Prime (N) then 2 else 0);
   end Is_Prob_Prime;

   function Is_Prime (N : U64) return Prime_Result is
     (Is_Prob_Prime (N));

   function Is_Safe_Prime (N : U64) return Boolean is
   begin
      if N < 23 then
         return N in 5 | 7 | 11;
      elsif N mod 6 /= 5 or N mod 5 = 0 or N mod 7 = 0 or
        N mod 10 = 1 or N mod 14 = 1
      then
         return False;
      end if;
      return Is_Prime (N / 2) /= 0 and then Is_Prime (N) /= 0;
   end Is_Safe_Prime;

   function Is_Mersenne_Prime (N : U64) return Mersenne_Result is
      Known : constant array (Positive range <>) of U64 :=
        (2, 3, 5, 7, 13, 17,
         19, 31, 61, 89, 107, 127,
         521, 607, 1279, 2203, 2281, 3217,
         4253, 4423, 9689, 9941, 11213, 19937,
         21701, 23209, 44497, 86243, 110503, 132049,
         216091, 756839, 859433, 1257787, 1398269, 2976221,
         3021377, 6972593, 13466917, 20996011, 24036583, 25964951,
         30402457, 32582657, 37156667, 42643801, 43112609, 57885161,
         74207281, 77232917, 82589933, 136279841);
   begin
      for P of Known loop
         if N = P then
            return (Defined => True, Value => True);
         end if;
      end loop;
      return (if N < 81_307_409 then (True, False)
              else (Defined => False));
   end Is_Mersenne_Prime;
   function Add (A, B, N : U64) return U64 is
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
      V := N;
      while V mod 2 = 0 loop
         V := V / 2;
      end loop;
      J := Jacobi (-23, V);
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
      elsif (N mod 2 = 0 or N = U64'Last) or else Int.Is_Square (N) then
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

   function Is_Catalan_Pseudoprime (N : U64) return Boolean is
      A : constant U64 := N / 2;
      M : U64 := 1;
      Rest : U64 := N;
      D : U64 := 3;
      Factors, First, Last, Exponent, V : U64 := 0;
      Squarefree : Boolean := True;
   begin
      if N < 2 or (N mod 2 = 0 and N /= 2) then
         return False;
      elsif Is_Prob_Prime (N) /= 0 then
         return True;
      end if;
      while D <= Rest / D loop
         if Rest mod D = 0 then
            Factors := Factors + 1;
            if First = 0 then
               First := D;
            end if;
            Last := D;
            Exponent := 0;
            while Rest mod D = 0 loop
               Rest := Rest / D;
               Exponent := Exponent + 1;
            end loop;
            Squarefree := Squarefree and Exponent = 1;
            V := 2 * A / D;
            while V > 0 loop
               if V mod 2 = 1 then
                  return False;
               end if;
               V := V / D;
            end loop;
         end if;
         D := D + 2;
      end loop;
      if Rest > 1 then
         Factors := Factors + 1;
         Last := Rest;
         V := 2 * A / Rest;
         while V > 0 loop
            if V mod 2 = 1 then
               return False;
            end if;
            V := V / Rest;
         end loop;
      end if;
      if (Factors = 2 and Squarefree) and then
        (N < 10_000_000_000 or else 2 * First + 1 >= Last)
      then
         return False;
      end if;
      for P of Sieve.Primes (N) loop
         Exponent := 0;
         V := 2 * A;
         while V >= P loop
            V := V / P;
            Exponent := Exponent + V mod 2;
         end loop;
         M := Mul (M, Power (P, Exponent, N), N);
      end loop;
      return M = (if A mod 2 = 1 then N - 1 else 1);
   end Is_Catalan_Pseudoprime;

   function Is_Chen_Prime (N : U64) return Boolean is
      V, D, Xi, Xm, Xs, Product, G, R, Left, Count : U64;
      C : U64 := 1;
   begin
      if (N < 2 or N > U64'Last - 2) or else Is_Prime (N) = 0 then
         return False;
      end if;
      V := N + 2;
      if Is_Prime (V) /= 0 then
         return True;
      end if;
      D := 2;
      while D <= 1_000 and D <= V / D loop
         if V mod D = 0 then
            return Is_Prime (D) /= 0 and then Is_Prime (V / D) /= 0;
         end if;
         D := (if D = 2 then 3 else D + 2);
      end loop;
      --  factor.c: pbrent_factor, portable modular arithmetic path.
      loop
         Xi := 1;
         Xm := 1;
         Xs := 1;
         R := 1;
         G := 1;
         while G = 1 loop
            Xm := Xi;
            Left := R;
            while Left > 0 and G = 1 loop
               Count := U64'Min (Left, 320);
               Left := Left - Count;
               Xs := Xi;
               Product := 1;
               for I in 1 .. Count loop
                  Xi := Add (Mul (Xi, Xi, V), C, V);
                  D := (if Xi > Xm then Xi - Xm else Xm - Xi);
                  Product := Mul (Product, D, V);
               end loop;
               G := Int.Gcd (Product, V);
            end loop;
            R := R * 2;
         end loop;
         if G = V then
            loop
               Xs := Add (Mul (Xs, Xs, V), C, V);
               D := (if Xs > Xm then Xs - Xm else Xm - Xs);
               G := Int.Gcd (D, V);
               exit when G /= 1;
            end loop;
         end if;
         exit when G /= V;
         C := C + 11;
      end loop;
      return Is_Prime (G) /= 0 and then Is_Prime (V / G) /= 0;
   end Is_Chen_Prime;

   function Is_Delicate_Prime
     (N : U64; Base : U64 := 10) return Mersenne_Result
   is
      Place : U64 := 1;
      Old, Candidate, Digit : U64;
   begin
      if Base = 10 and N < 100 then
         return (True, False);
      elsif Base = 3 and N = 2 then
         return (True, True);
      elsif Is_Prime (N) = 0 then
         return (True, False);
      end if;
      if Base = 2 then
         if N < 127 then
            return (True, False);
         end if;
         Place := 2;
         while Place <= N loop
            if Is_Prime (N xor Place) /= 0 then
               return (True, False);
            end if;
            exit when Place > U64'Last / 2;
            Place := Place * 2;
         end loop;
         return (True, True);
      end if;
      if Base = 10 and N >= 10 ** 19 then
         return (Defined => False);
      end if;
      while Place <= N loop
         Old := N / Place mod Base;
         if Base /= 10 and then
           (Place > U64'Last / Base or else
              N > U64'Last - Place * Base)
         then
            return (Defined => False);
         end if;
         Candidate := N - Old * Place;
         Digit := 0;
         while Digit < Base loop
            if Digit /= Old and then Is_Prime (Candidate) /= 0 then
               return (True, False);
            end if;
            Digit := Digit + 1;
            exit when Digit = Base;
            Candidate := Candidate + Place;
         end loop;
         exit when Place > U64'Last / Base;
         Place := Place * Base;
      end loop;
      return (True, True);
   end Is_Delicate_Prime;

end Math_Prime_Util.Primality;
