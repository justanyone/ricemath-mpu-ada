--  lmo.c: LMO_prime_count, the Lagarias-Miller-Odlyzko count.
private package Math_Prime_Util.Count.Lmo
  with SPARK_Mode => Off
is
   use Math_Prime_Util;

   --  Primes <= N. Every native N is accepted, as in prime_counts.c.
   function Prime_Count (N : U64) return U64;
end Math_Prime_Util.Count.Lmo;
