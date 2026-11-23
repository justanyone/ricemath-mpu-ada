--  Wide arithmetic used by the factor128.c factoring paths in MPU 0.75.
package Math_Prime_Util.Int.Wide with SPARK_Mode => On is
   --  addmod128: sum of reduced residues modulo N; N must be positive.
   function Addmod (A, B, N : U128) return U128
     with Pre => N > 0 and then A < N and then B < N,
          Post => Addmod'Result < N;

   --  submod128: difference of reduced residues; N must be positive.
   function Submod (A, B, N : U128) return U128
     with Pre => N > 0 and then A < N and then B < N,
          Post => Submod'Result < N;

   --  mulmod128: exact modular product, including unreduced operands.
   --  A zero modulus violates the precondition.
   function Mulmod (A, B, N : U128) return U128
     with Pre => N > 0, Post => Mulmod'Result < N;

   --  gcd128: greatest common divisor in integer units; Gcd (0, 0) = 0.
   function Gcd (A, B : U128) return U128
     with Pre => True,
          Post => (if Gcd'Result = 0 then A = 0 and then B = 0
                   else A mod Gcd'Result = 0 and then B mod Gcd'Result = 0);

   --  isqrt128: floor square root in integer units, with no error cases.
   function Sqrtint (N : U128) return U64
     with Pre => True,
          Post => U128 (Sqrtint'Result) ** 2 <= N
            and then (Sqrtint'Result = U64'Last or else
              (U128 (Sqrtint'Result) + 1) ** 2 > N);

   --  is_perfect_square128_ret: includes zero and one; no error cases.
   function Is_Square (N : U128) return Boolean
     with Pre => True,
          Post => Is_Square'Result = (U128 (Sqrtint (N)) ** 2 = N);
end Math_Prime_Util.Int.Wide;
