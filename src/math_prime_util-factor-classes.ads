--  Factor classes from Math::Prime::Util 0.75 util.c.
package Math_Prime_Util.Factor.Classes with SPARK_Mode => On is

   --  util.c: is_carmichael, Korselt's criterion. No errors.
   function Is_Carmichael (N : U64) return Boolean
     with Pre => True,
          Post => (if Is_Carmichael'Result then N >= 561 and then N mod 2 = 1);

   --  util.c: is_quasi_carmichael. Number of qualifying bases, including
   --  negative bases; zero for primes or non-square-free N. No errors.
   function Is_Quasi_Carmichael (N : U64) return U64
     with Pre => True,
          Post => (if N < 35 then Is_Quasi_Carmichael'Result = 0);

   --  util.c: is_cyclic. True when gcd (N, phi (N)) = 1. No errors.
   function Is_Cyclic (N : U64) return Boolean
     with Pre => True,
          Post => (if N = 0 then not Is_Cyclic'Result);

   --  util.c: is_perfect_number. Sum of proper divisors equals N.
   --  No odd perfect number fits the native range. No errors.
   function Is_Perfect_Number (N : U64) return Boolean
     with Pre => True,
          Post => (if Is_Perfect_Number'Result then
                     N > 0 and then N mod 2 = 0);

   --  util.c: is_practical. Every integer <= N is a sum of distinct
   --  divisors of N. Includes one, excludes zero. No errors.
   function Is_Practical (N : U64) return Boolean
     with Pre => True,
          Post => (if Is_Practical'Result then N = 1 or else N mod 2 = 0);

   --  util.c: is_smooth. No prime factor exceeds K; 0 and 1 always
   --  qualify, including K = 0. No errors.
   function Is_Smooth (N, K : U64) return Boolean
     with Pre => True,
          Post => (if N <= 1 then Is_Smooth'Result);

   --  util.c: is_rough. No prime factor is below K. One always qualifies;
   --  zero qualifies only for K = 0. No errors.
   function Is_Rough (N, K : U64) return Boolean
     with Pre => True,
          Post => (if N = 0 then Is_Rough'Result = (K = 0)
                   elsif N = 1 then Is_Rough'Result);

   --  util.c: debruijn_psi. Count K-smooth integers in 1 .. N.
   --  Storage_Error may propagate from prime enumeration.
   function Smooth_Count (N, K : U64) return U64
     with Pre => True,
          Post => Smooth_Count'Result <= N;

   --  util.c: buchstab_phi, legendre_phi.c: legendre_phi.
   --  Count K-rough integers in 1 .. N (factors >= K).
   --  Storage_Error may propagate from prime enumeration.
   function Rough_Count (N, K : U64) return U64
     with Pre => True,
          Post => Rough_Count'Result <= N;
end Math_Prime_Util.Factor.Classes;
