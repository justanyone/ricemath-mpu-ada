with Math_Prime_Util.Int;

--  Native modular helpers translated from Math::Prime::Util 0.75.
package Math_Prime_Util.Modular with SPARK_Mode => On is
   use Math_Prime_Util.Int;
   use type U64;
   use type I128;

   --  znlog.c: znlog. Smallest exponent X with G**X = A modulo M.
   --  Undefined for M = 0 or when no exponent exists; M = 1 returns 0.
   function Znlog (A, G, M : U64) return Optional_U64
     with Pre => True,
          Post => (if Znlog'Result.Defined then M > 0 and then
                     Powmod (G, Znlog'Result.Value, M).Value = A mod M);

   --  factmod.c: factorialmod. N! modulo M, in residue units.
   --  Undefined for M = 0; no intermediate factorial is constructed.
   function Factorialmod (N, M : U64) return Optional_U64
     with Pre => True,
          Post => (if Factorialmod'Result.Defined then M > 0 and then
                     Factorialmod'Result.Value < M);

   --  factmod.c: binomialmod. Generalized signed binomial modulo M.
   --  Inputs have at most 64 magnitude bits. Undefined for M = 0.
   function Binomialmod (N, K : I128; M : U64) return Optional_U64
     with Pre => N in -I128 (U64'Last) .. I128 (U64'Last)
       and K in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (if Binomialmod'Result.Defined then M > 0 and then
                     Binomialmod'Result.Value < M);

   --  util.c: pisano_period, _pisano_prime_power. Fibonacci period mod N.
   --  Returns 0 for N = 0; undefined if the period exceeds U64'Last.
   function Pisano_Period (N : U64) return Optional_U64
     with Pre => True,
          Post => (if N <= 1 then Pisano_Period'Result.Defined and then
                     Pisano_Period'Result.Value = N);
end Math_Prime_Util.Modular;
