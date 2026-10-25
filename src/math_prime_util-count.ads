package Math_Prime_Util.Count is
   use type U64;
   --  MPU 0.75 lehmer.c: lehmer_prime_count; prime_count_tables.h:
   --  APPLY_TABLES. Count primes <= N. Local storage grows as sqrt(N);
   --  Storage_Error may propagate when the sieve cannot fit in memory.
   function Prime_Count (N : U64) return U64
     with Pre => True, Post => Prime_Count'Result <= N;

   --  MPU 0.75 prime_counts.c: nth_prime (inverse exact count).
   --  Return zero for index zero. The largest index fits native U64.
   --  Storage_Error may propagate from Prime_Count.
   function Nth_Prime (N : U64) return U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => (if N = 0 then Nth_Prime'Result = 0
                   else Nth_Prime'Result >= N);
end Math_Prime_Util.Count;
