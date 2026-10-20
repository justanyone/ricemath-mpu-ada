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
         74207281, 77232917, 82589933, 136279841 );
   begin
      for P of Known loop
         if N = P then
            return 1;
         end if;
      end loop;
      return (if N < 81_307_409 then 0 else -1);
   end Is_Mersenne_Prime;
end Math_Prime_Util.Primality;
