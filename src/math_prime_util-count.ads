with Math_Prime_Util.Int;

--  Prime counting and summation from Math::Prime::Util 0.75.
package Math_Prime_Util.Count with SPARK_Mode => On is
   use type U64;

   --  Largest High that Prime_Count accepts. The Lucy table holds
   --  two arrays of Sqrt (High) entries on the stack.
   Prime_Count_Limit : constant U64 := 10_000_000_000;

   --  Largest N that Nth_Prime accepts.
   Nth_Prime_Limit : constant U64 := 1_000_000;

   --  Largest index that Legendre_Phi accepts.
   Legendre_Index_Limit : constant Natural := 40;

   --  prime_sums.c: _sum_primes128 and sum_primes128. Sum primes <= High.
   --  Undefined on U64 overflow. Storage_Error may propagate.
   function Sum_Primes (High : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if High < 2 then Sum_Primes'Result.Defined
                   and then Sum_Primes'Result.Value = 0
                   elsif Sum_Primes'Result.Defined then
                     Sum_Primes'Result.Value >= 2);

   --  prime_sums.c: sum_primes128, _sum_primes_range128. Inclusive range.
   --  Empty ranges return zero. Storage_Error may propagate.
   function Sum_Primes (Low, High : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Low > High or High < 2 then Sum_Primes'Result.Defined
                   and then Sum_Primes'Result.Value = 0);

   --  lmo.c: LMO_count, Lucy_Hedgehog method with the
   --  prime_counts.c entry point. Returns pi (High).
   --  Dies on High above Prime_Count_Limit (Pre).
   function Prime_Count (High : U64) return U64
     with Pre => High <= Prime_Count_Limit,
          Post => (if High < 2 then Prime_Count'Result = 0)
                  and then Prime_Count'Result <= High;

   --  legendre_phi.c: _legendre_phi. Counts n in 1 .. X with no prime
   --  factor among the first A primes. Recursion on A, so A is bounded.
   function Legendre_Phi (X : U64; A : Natural) return U64
     with Pre => X <= Prime_Count_Limit and then A <= Legendre_Index_Limit,
          Post => (if X = 0 or A = 0 then Legendre_Phi'Result = X)
                  and then Legendre_Phi'Result <= X;

   --  prime_counts.c: nth_prime. Returns the N-th prime (N >= 1), found
   --  by bisection on Prime_Count within the bound 20 * N.
   --  Dies on N = 0 or N above Nth_Prime_Limit (Pre).
   function Nth_Prime (N : U64) return U64
     with Pre => N >= 1 and then N <= Nth_Prime_Limit,
          Post => Nth_Prime'Result >= 2
                  and then Prime_Count (Nth_Prime'Result) = N;
end Math_Prime_Util.Count;
