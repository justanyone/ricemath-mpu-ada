--  Portable Montgomery arithmetic from MPU 0.75 montmath.h.
private package Math_Prime_Util.Intmont with SPARK_Mode => On is
   use type U64;
   --  mont_inverse, mont_geta, _powredc, mont_recover; no assembly.
   --  Compute A**K modulo odd N. Invalid N fails the precondition.
   function Powmod (A, K, N : U64) return U64
     with Pre => N > 1 and N mod 2 = 1, Post => Powmod'Result < N;
end Math_Prime_Util.Intmont;
