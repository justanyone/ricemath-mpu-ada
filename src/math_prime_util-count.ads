with Math_Prime_Util.Int;

--  Prime counting and summation from Math::Prime::Util 0.75.
package Math_Prime_Util.Count with SPARK_Mode => On is
   use type U64;

   --  Native range supported by MPU's extended LMO counter.
   Prime_Count_Limit : constant U64 := U64'Last;

   --  Number of primes representable in the native unsigned range.
   Nth_Prime_Limit : constant U64 := 425_656_284_035_217_743;

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

   --  lmo.c: LMO_prime_count, extended LMO method. Returns pi (High).
   --  Storage_Error may propagate from local factor and phi tables.
   function Prime_Count (High : U64) return U64
     with Pre => True,
          Post => (if High < 2 then Prime_Count'Result = 0)
                  and then Prime_Count'Result <= High;

   --  prime_counts.c: prime_count_range. Inclusive bounds; reversed
   --  ranges return zero. Narrow intervals use the segmented sieve
   --  directly. Above Prime_Count_Limit, only ranges of at most
   --  100_001 integers are accepted (Assertion_Error with contracts
   --  enabled). Extended LMO sets that limit to the native maximum,
   --  so every native interval is accepted. Storage_Error may
   --  propagate from a wide prefix count.
   function Prime_Count (Low, High : U64) return U64
     with Pre => Low > High or else High <= Prime_Count_Limit
                   or else High - Low <= 100_000,
          Post => (if Low > High or High < 2 then
                     Prime_Count'Result = 0
                   else Prime_Count'Result <= High - U64'Max (Low, 2) + 1);

   --  legendre_phi.c: _legendre_phi. Counts n in 1 .. X with no prime
   --  factor among the first A primes. Recursion on A, so A is bounded.
   function Legendre_Phi (X : U64; A : Natural) return U64
     with Pre => X <= Prime_Count_Limit and then A <= Legendre_Index_Limit,
          Post => (if X = 0 or A = 0 then Legendre_Phi'Result = X)
                  and then Legendre_Phi'Result <= X;

   --  prime_counts.c: nth_prime. Returns the N-th prime (N >= 1), found
   --  from Prime_Count at Nth_Prime_Approx and a segmented sieve walk.
   --  Dies on N = 0 or N above Nth_Prime_Limit (Pre).
   function Nth_Prime (N : U64) return U64
     with Pre => N >= 1 and then N <= Nth_Prime_Limit,
          Post => Nth_Prime'Result >= 2;
   --  prime_counts.c: prime_count_lower. Native integer estimate or bound.
   --  Nth-prime indices must fit the native prime range.
   function Prime_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Prime_Count_Lower'Result <= U64'Last;

   --  prime_counts.c: prime_count_upper. Native integer estimate or bound.
   --  Nth-prime indices must fit the native prime range.
   function Prime_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Prime_Count_Upper'Result <= U64'Last;

   --  prime_counts.c: prime_count_approx. Native integer estimate or bound.
   --  Nth-prime indices must fit the native prime range.
   function Prime_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Prime_Count_Approx'Result <= U64'Last;

   --  prime_counts.c: nth_prime_lower. Native integer estimate or bound.
   --  Nth-prime indices must fit the native prime range.
   function Nth_Prime_Lower (N : U64) return U64
     with Pre => N >= 1 and then N <= 425_656_284_035_217_743,
          Post => Nth_Prime_Lower'Result <= U64'Last;

   --  prime_counts.c: nth_prime_upper. Native integer estimate or bound.
   --  Nth-prime indices must fit the native prime range.
   function Nth_Prime_Upper (N : U64) return U64
     with Pre => N >= 1 and then N <= 425_656_284_035_217_743,
          Post => Nth_Prime_Upper'Result <= U64'Last;

   --  prime_counts.c: nth_prime_approx. Native integer estimate or bound.
   --  Nth-prime indices must fit the native prime range.
   function Nth_Prime_Approx (N : U64) return U64
     with Pre => N >= 1 and then N <= 425_656_284_035_217_743,
          Post => Nth_Prime_Approx'Result <= U64'Last;

   --  real.c: chebyshev_theta. Sum of natural logs, in real units.
   --  Storage_Error may propagate from the segmented sieve.
   function Chebyshev_Theta (N : U64) return Long_Float
     with Pre => N <= Prime_Count_Limit,
          Post => Chebyshev_Theta'Result >= 0.0;

   --  real.c: chebyshev_psi. Sum of natural logs, in real units.
   --  Storage_Error may propagate from the segmented sieve.
   function Chebyshev_Psi (N : U64) return Long_Float
     with Pre => N <= Prime_Count_Limit,
          Post => Chebyshev_Psi'Result >= 0.0;

end Math_Prime_Util.Count;
