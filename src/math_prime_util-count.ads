--  Prime counting and summation from Math::Prime::Util 0.75.
package Math_Prime_Util.Count with SPARK_Mode => On is
   use type U64;
   use type U128;

   --  prime_sums.c: _sum_primes128 and sum_primes128. Sum primes <= High.
   --  The exact sum fits U128. Storage_Error may propagate on large inputs.
   function Sum_Primes (High : U64) return U128
     with Pre => True,
          Post => (if High < 2 then Sum_Primes'Result = 0
                   else Sum_Primes'Result >= 2);

   --  prime_sums.c: sum_primes128, _sum_primes_range128. Inclusive range.
   --  Empty ranges return zero. Storage_Error may propagate.
   function Sum_Primes (Low, High : U64) return U128
     with Pre => True,
          Post => (if Low > High or High < 2 then Sum_Primes'Result = 0);
end Math_Prime_Util.Count;
