with Ada.Containers.Vectors;
with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

--  Number-family sieves and estimates from MPU 0.75.
package Math_Prime_Util.Families with SPARK_Mode => On is
   use type U64;
   use type U128;
   use type Int.I128;
   package Lucky_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  almost_primes.c: next_chen_prime. First Chen prime strictly above N;
   --  undefined beyond MAX_CHEN_PRIME (18446744073709551437).
   function Next_Chen_Prime (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Next_Chen_Prime'Result.Defined then
                     Next_Chen_Prime'Result.Value > N);

   --  XS.xs / PP.pm: is_gaussian_prime. Test A+B*i using absolute
   --  native coordinates. No errors; norms beyond U64 use exact trial
   --  division and can be slow when they have no small prime divisor.
   function Is_Gaussian_Prime (A, B : Int.I128) return Boolean
     with Pre => A in -Int.I128 (U64'Last) .. Int.I128 (U64'Last)
       and B in -Int.I128 (U64'Last) .. Int.I128 (U64'Last),
          Post => (if A = 0 and B = 0 then
                     not Is_Gaussian_Prime'Result);

   --  PP.pm: is_sum_of_squares. Represent abs N by K nonnegative squares
   --  (zero terms allowed). Native magnitudes only; no errors.
   function Is_Sum_Of_Squares (N : Int.I128; K : U64 := 2) return Boolean
     with Pre => N in -Int.I128 (U64'Last) .. Int.I128 (U64'Last),
          Post => (if K >= 4 then Is_Sum_Of_Squares'Result);

   --  lucky_numbers.c: lucky_sieve_range. Inclusive; reversed is empty.
   --  Storage_Error propagates when the sieve cannot fit in memory.
   function Lucky_Numbers (Low, High : U64) return Lucky_Vectors.Vector
     with Pre => True,
          Post => (for all V of Lucky_Numbers'Result =>
                     V >= Low and then V <= High and then V mod 2 = 1);
   --  lucky_numbers.c: lucky_sieve64. Lucky numbers through High inclusive.
   function Lucky_Numbers (High : U64) return Lucky_Vectors.Vector
     with Pre => True,
          Post => (for all V of Lucky_Numbers'Result => V <= High);
   --  lucky_numbers.c: is_lucky. Test membership in the lucky sieve.
   function Is_Lucky (N : U64) return Boolean
     with Pre => True,
          Post => (if Is_Lucky'Result then N mod 2 = 1);
   --  lucky_numbers.c: lucky_count. Count lucky numbers through N inclusive.
   function Lucky_Count (N : U64) return U64
     with Pre => True, Post => Lucky_Count'Result <= N;
   --  lucky_numbers.c: lucky_count_range. Inclusive; reversed is empty.
   function Lucky_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High then Lucky_Count'Result = 0);
   --  lucky_numbers.c: lucky_count_approx. Invert the nth estimate.
   function Lucky_Count_Approx (N : U64) return U64
     with Pre => True, Post => Lucky_Count_Approx'Result <= N;
   --  lucky_numbers.c: lucky_count_lower. Empirical lower count bound.
   function Lucky_Count_Lower (N : U64) return U64
     with Pre => True, Post => Lucky_Count_Lower'Result <= N;
   --  lucky_numbers.c: lucky_count_upper. Empirical upper count bound.
   function Lucky_Count_Upper (N : U64) return U64
     with Pre => True, Post => Lucky_Count_Upper'Result <= N;
   --  lucky_numbers.c: nth_lucky. One-based index; zero is undefined.
   --  Storage_Error propagates when the backward sieve cannot fit.
   function Nth_Lucky (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky'Result.Defined = (N /= 0);
   --  lucky_numbers.c: nth_lucky_approx. Saturates at the native maximum.
   function Nth_Lucky_Approx (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky_Approx'Result.Defined = (N /= 0);
   --  lucky_numbers.c: nth_lucky_lower. Empirical lower value bound.
   function Nth_Lucky_Lower (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky_Lower'Result.Defined = (N /= 0);
   --  lucky_numbers.c: nth_lucky_upper. Empirical upper value bound.
   function Nth_Lucky_Upper (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky_Upper'Result.Defined = (N /= 0);

   --  Lists share the native integer vector representation with lucky numbers.
   package Family_Vectors renames Lucky_Vectors;

   --  almost_primes.c: generate_almost_primes.
   --  Integers in the inclusive range with K prime factors with multiplicity.
   --  Reversed ranges are empty; Storage_Error may propagate.
   function Almost_Primes (K : Natural; Low, High : U64)
      return Family_Vectors.Vector
     with Pre => True,
          Post => (for all V of Almost_Primes'Result =>
                     V >= Low and then V <= High);
   --  Prefix list through High inclusive; Storage_Error may propagate.
   function Almost_Primes (K : Natural; High : U64)
      return Family_Vectors.Vector
     with Pre => True,
          Post => (for all V of Almost_Primes'Result => V <= High);
   --  almost_primes.c: almost_prime_count.
   --  Count integers through High, counting prime factors with multiplicity.
   --  Storage_Error may propagate from the prime sieve. Intermediate prime
   --  counts inherit Count.Prime_Count_Limit; exceeding it fails its Pre.
   function Almost_Prime_Count (K : Natural; High : U64) return U64
     with Pre => True, Post => Almost_Prime_Count'Result <= High;
   --  Inclusive range count; reversed ranges return zero. May raise
   --  Storage_Error if the prime sieve cannot fit in memory.
   function Almost_Prime_Count (K : Natural; Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High then Almost_Prime_Count'Result = 0);
   --  almost_primes.c: nth_almost_prime. One-based index; undefined for
   --  zero or a result beyond U64. Storage_Error may propagate. Counting
   --  during selection inherits Count.Prime_Count_Limit and its Pre.
   function Nth_Almost_Prime (K : Natural; N : U64)
      return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Almost_Prime'Result.Defined);

   --  omega_primes.c: range_omega_prime_sieve.
   --  Inclusive range with K distinct prime factors.
   --  Reversed ranges are empty; Storage_Error may propagate.
   function Omega_Primes (K : Natural; Low, High : U64)
      return Family_Vectors.Vector
     with Pre => True,
          Post => (for all V of Omega_Primes'Result =>
                     V >= Low and then V <= High);
   --  Prefix list through High inclusive; Storage_Error may propagate.
   function Omega_Primes (K : Natural; High : U64)
      return Family_Vectors.Vector
     with Pre => True,
          Post => (for all V of Omega_Primes'Result => V <= High);
   --  omega_primes.c: omega_prime_count.
   --  Count integers through High with K distinct prime factors.
   --  Storage_Error may propagate from the prime sieve. Intermediate prime
   --  counts inherit Count.Prime_Count_Limit; exceeding it fails its Pre.
   function Omega_Prime_Count (K : Natural; High : U64) return U64
     with Pre => True, Post => Omega_Prime_Count'Result <= High;
   --  Inclusive range count; reversed ranges return zero. May raise
   --  Storage_Error if the prime sieve cannot fit in memory.
   function Omega_Prime_Count (K : Natural; Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High then Omega_Prime_Count'Result = 0);
   --  omega_primes.c: nth_omega_prime. One-based index; undefined for
   --  zero or a result beyond U64. Storage_Error may propagate. Counting
   --  during selection inherits Count.Prime_Count_Limit and its Pre.
   function Nth_Omega_Prime (K : Natural; N : U64)
      return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Omega_Prime'Result.Defined);

   --   almost_primes.c: almost_prime_count_lower. Native count estimate
   --  or bound.
   --  K counts factors with multiplicity; no errors for native inputs.
   function Almost_Prime_Count_Lower (K : Natural; N : U64) return U64
     with Pre => True, Post => Almost_Prime_Count_Lower'Result <= N;

   --   almost_primes.c: almost_prime_count_upper. Native count estimate
   --  or bound.
   --  K counts factors with multiplicity; no errors for native inputs.
   function Almost_Prime_Count_Upper (K : Natural; N : U64) return U64
     with Pre => True, Post => Almost_Prime_Count_Upper'Result <= N;

   --   almost_primes.c: almost_prime_count_approx. Native count estimate
   --  or bound.
   --  K counts factors with multiplicity; no errors for native inputs.
   function Almost_Prime_Count_Approx (K : Natural; N : U64) return U64
     with Pre => True, Post => Almost_Prime_Count_Approx'Result <= N;

   --  almost_primes.c: nth_almost_prime_lower. Native value estimate
   --  or bound. Undefined for zero index or native overflow; no errors.
   function Nth_Almost_Prime_Lower (K : Natural; N : U64)
      return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then
                     not Nth_Almost_Prime_Lower'Result.Defined);

   --  almost_primes.c: nth_almost_prime_upper. Native value estimate
   --  or bound. Undefined for zero index or native overflow; no errors.
   function Nth_Almost_Prime_Upper (K : Natural; N : U64)
      return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then
                     not Nth_Almost_Prime_Upper'Result.Defined);

   --  almost_primes.c: nth_almost_prime_approx. Native value estimate
   --  or bound. Undefined for zero index or native overflow; no errors.
   function Nth_Almost_Prime_Approx (K : Natural; N : U64)
      return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then
                     not Nth_Almost_Prime_Approx'Result.Defined);
   --  Ramanujan arguments/results are dimensionless; exact operations are
   --  bounded by the prime-count backend. Contract violations raise
   --  Assertion_Error; nth bounds return zero beyond the native prime range.
   Exact_Limit : constant U64 := 10_000_000_000_000;
   Index_Limit : constant U64 := 200_000_000_000;

   --  Inclusive interval; reversed bounds are empty. Storage_Error may occur.
   function Ramanujan_Primes (Low, High : U64)
      return Sieve.Prime_Vectors.Vector
     with Pre => High <= Exact_Limit,
          Post => (for all P of Ramanujan_Primes'Result =>
                     P >= Low and then P <= High);
   --  List Ramanujan primes through High. Storage_Error may occur.
   function Ramanujan_Primes (High : U64) return Sieve.Prime_Vectors.Vector
     with Pre => High <= Exact_Limit,
          Post => (for all P of Ramanujan_Primes'Result => P <= High);
   --  Test membership; Storage_Error may occur in window generation.
   function Is_Ramanujan_Prime (N : U64) return Boolean
     with Pre => N <= Exact_Limit,
          Post => (if N < 2 then not Is_Ramanujan_Prime'Result);
   --  Count Ramanujan primes through N; Storage_Error may occur.
   function Ramanujan_Prime_Count (N : U64) return U64
     with Pre => N <= Exact_Limit,
          Post => Ramanujan_Prime_Count'Result <= N;
   --  Count an inclusive interval; reversed bounds return zero.
   function Ramanujan_Prime_Count (Low, High : U64) return U64
     with Pre => High <= Exact_Limit,
          Post => (if Low > High then Ramanujan_Prime_Count'Result = 0);
   --  Exact one-based value; zero is undefined. Storage_Error may occur.
   function Nth_Ramanujan_Prime (N : U64) return Int.Optional_U64
     with Pre => N <= Index_Limit,
          Post => Nth_Ramanujan_Prime'Result.Defined = (N /= 0);
   --  Lower bound on the one-based value; zero is undefined.
   function Nth_Ramanujan_Prime_Lower (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Ramanujan_Prime_Lower'Result.Defined = (N /= 0);
   --  Upper bound on the one-based value; zero is undefined.
   function Nth_Ramanujan_Prime_Upper (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Ramanujan_Prime_Upper'Result.Defined = (N /= 0);
   --  Estimate of the one-based value; zero is undefined.
   function Nth_Ramanujan_Prime_Approx (N : U64) return Int.Optional_U64
     with Pre => N <= Index_Limit,
          Post => Nth_Ramanujan_Prime_Approx'Result.Defined = (N /= 0);
   --  Lower count bound through N, including the native maximum.
   function Ramanujan_Prime_Count_Lower (N : U64) return U64
     with Pre => True,
          Post => Ramanujan_Prime_Count_Lower'Result <= N;
   --  Upper count bound through N, including the native maximum.
   function Ramanujan_Prime_Count_Upper (N : U64) return U64
     with Pre => True,
          Post => Ramanujan_Prime_Count_Upper'Result <= N;
   --  Count estimate through N, including the native maximum.
   function Ramanujan_Prime_Count_Approx (N : U64) return U64
     with Pre => True,
          Post => Ramanujan_Prime_Count_Approx'Result <= N;

   --  twin_primes.c: range_twin_prime_sieve. Lower members in [Low, High];
   --  the partner may exceed High. Reversed ranges are empty.
   --  Storage_Error may propagate from the sieve or result vector.
   function Twin_Primes (Low, High : U64) return Family_Vectors.Vector
     with Pre => True,
          Post => (for all P of Twin_Primes'Result =>
                     P >= Low and then P <= High and then P <= U64'Last - 2);
   --  Lower members of twin pairs through High, inclusive.
   function Twin_Primes (High : U64) return Family_Vectors.Vector
     with Pre => True,
          Post => (for all P of Twin_Primes'Result => P <= High);
   --  twin_primes.c: twin_prime_count_range. Inclusive; reversed is zero.
   function Twin_Prime_Count (Low, High : U64) return U64
     with SPARK_Mode => On, Pre => True,
          Post => (if Low > High then Twin_Prime_Count'Result = 0);
   --  twin_primes.c: twin_prime_count. Count lower members <= High.
   function Twin_Prime_Count (High : U64) return U64
     with SPARK_Mode => On, Pre => True,
          Post => Twin_Prime_Count'Result <= High;
   --  twin_primes.c: twin_prime_count_approx. Rounded native estimate.
   function Twin_Prime_Count_Approx (N : U64) return U64
     with SPARK_Mode => On, Pre => True,
          Post => Twin_Prime_Count_Approx'Result <= N;
   --  twin_primes.c: nth_twin_prime. One-based; zero or overflow undefined.
   --  Storage_Error may propagate from the sieve.
   function Nth_Twin_Prime (N : U64) return Int.Optional_U64
     with SPARK_Mode => On, Pre => True,
          Post => (if N = 0 then not Nth_Twin_Prime'Result.Defined);
   --  twin_primes.c: nth_twin_prime_approx. Zero undefined; saturates.
   function Nth_Twin_Prime_Approx (N : U64) return Int.Optional_U64
     with SPARK_Mode => On, Pre => True,
          Post => Nth_Twin_Prime_Approx'Result.Defined = (N /= 0);

   --  semi_primes.c: range_semiprime_sieve. Products of two primes,
   --  including squares, in [Low, High]. Reversed ranges are empty.
   --  Storage_Error may propagate from the sieve or result vector.
   function Semi_Primes (Low, High : U64) return Family_Vectors.Vector
     with Pre => True,
          Post => (for all P of Semi_Primes'Result =>
                     P >= U64'Max (Low, 4) and then P <= High);
   --  Products of exactly two primes through High, inclusive.
   function Semi_Primes (High : U64) return Family_Vectors.Vector
     with Pre => True,
          Post => (for all P of Semi_Primes'Result => P <= High);
   --  semi_primes.c: semiprime_count. Uses the prime counter, so High/2
   --  must fit its supported range. Storage_Error may propagate.
   function Semiprime_Count (High : U64) return U64
     with SPARK_Mode => On, Pre => High <= 40_000_000_000_000,
          Post => Semiprime_Count'Result <= High;
   --  semi_primes.c: semiprime_count_range. Inclusive; reversed is zero.
   --  Uses the segmented factor sieve. Storage_Error may propagate.
   function Semiprime_Count (Low, High : U64) return U64
     with SPARK_Mode => On, Pre => True,
          Post => (if Low > High then Semiprime_Count'Result = 0);
   --  semi_primes.c: semiprime_count_approx. Rounded, clamped estimate.
   function Semiprime_Count_Approx (N : U64) return U64
     with SPARK_Mode => On, Pre => True,
          Post => Semiprime_Count_Approx'Result <= N;
   --  semi_primes.c: nth_semiprime. One-based; zero undefined.
   --  The exact search uses the supported native prime-count range.
   function Nth_Semiprime (N : U64) return Int.Optional_U64
     with SPARK_Mode => On, Pre => N <= 1_000_000_000,
          Post => Nth_Semiprime'Result.Defined = (N /= 0);
   --  semi_primes.c: nth_semiprime_approx. Zero or overflow undefined.
   function Nth_Semiprime_Approx (N : U64) return Int.Optional_U64
     with SPARK_Mode => On, Pre => True,
          Post => (if N = 0 then not Nth_Semiprime_Approx'Result.Defined);
   --  powerful.c: is_powerful. Every prime exponent is at least K.
   --  Zero is false; one is true; K <= 1 accepts every positive N.
   function Is_Powerful (N : U64; K : U64 := 2) return Boolean
     with Pre => True,
          Post => (if N = 0 then not Is_Powerful'Result
                   elsif N = 1 then Is_Powerful'Result);
   --  powerful.c: powerful_count. Count positive K-powerful values <= N.
   --  Storage_Error propagates from the squarefree sieve.
   function Powerful_Count (N : U64; K : U64 := 2) return U64
     with Pre => True, Post => Powerful_Count'Result <= N;
   --  powerful.c: nth_powerful. One-based; zero or native overflow undefined.
   --  K <= 1 returns N, following the MPU Perl fallback.
   function Nth_Powerful (N : U64; K : U64 := 2) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Powerful'Result.Defined);
   --  powerful.c: sumpowerful. Exact sum through N, in integer units.
   --  U128 holds every native-input sum; Storage_Error may propagate.
   function Sumpowerful (N : U64; K : U64 := 2) return U128
     with Pre => True,
          Post => (if N = 0 then Sumpowerful'Result = 0);
   --  powerful.c: powerful_numbers_range. Sorted inclusive positive values.
   --  Reversed ranges are empty; Storage_Error may propagate.
   function Powerful_Numbers (Low, High : U64; K : U64 := 2)
      return Family_Vectors.Vector
     with Pre => True,
          Post => (for all V of Powerful_Numbers'Result =>
                     V >= U64'Max (1, Low) and then V <= High);
   --  List positive powerful values through High, with K = 2.
   function Powerful_Numbers (High : U64) return Family_Vectors.Vector
     with Pre => True,
          Post => (for all V of Powerful_Numbers'Result => V <= High);

   --  powerfree.c uses 32-bit exponents. Invalid exponents fail the subtype
   --  constraint with Constraint_Error. All other inputs use native units.
   subtype Powerfree_Exponent is U64 range 0 .. 2 ** 32 - 1;
   --  powerfree.c: is_powerfree. Every prime exponent is less than K.
   --  K < 2 accepts only one; zero is always false. No errors.
   function Is_Powerfree (N : U64; K : Powerfree_Exponent := 2)
      return Boolean
     with Pre => True,
          Post => (if N = 0 then not Is_Powerfree'Result
                   elsif N = 1 then Is_Powerfree'Result);
   --  powerfree.c: powerfree_count. Count positive values through N.
   --  Storage_Error propagates from the Mobius sieve.
   function Powerfree_Count (N : U64; K : Powerfree_Exponent := 2)
      return U64
     with Pre => True, Post => Powerfree_Count'Result <= N;
   --  powerfree.c: powerfree_sum. Exact sum through N. U128 cannot overflow.
   --  Storage_Error propagates from the Mobius sieve.
   function Powerfree_Sum (N : U64; K : Powerfree_Exponent := 2)
      return U128
     with Pre => True,
          Post => (if N = 0 then Powerfree_Sum'Result = 0);
   --  powerfree.c: powerfree_part. Remove K-th powers from N's factors.
   --  Zero gives zero; K < 2 gives one only for N = 1. No errors.
   function Powerfree_Part (N : U64; K : Powerfree_Exponent := 2)
      return U64
     with Pre => True, Post => Powerfree_Part'Result <= N;
   --  powerfree.c: powerfree_part_sum. Sum parts of 1 .. N, exactly in U128.
   --  Storage_Error propagates from the Mobius sieve.
   function Powerfree_Part_Sum (N : U64; K : Powerfree_Exponent := 2)
      return U128
     with Pre => True,
          Post => (if N = 0 then Powerfree_Part_Sum'Result = 0);
   --  powerfree.c: nth_powerfree. One-based; zero, K < 2, or native overflow
   --  is undefined. Storage_Error propagates from the Mobius sieve.
   function Nth_Powerfree (N : U64; K : Powerfree_Exponent := 2)
      return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 or else K < 2 then
                     not Nth_Powerfree'Result.Defined);
   --  powerfree.c: squarefree_kernel. Product of distinct prime factors.
   --  Zero gives zero; one gives one. No errors.
   function Squarefree_Kernel (N : U64) return U64
     with Pre => True, Post => Squarefree_Kernel'Result <= N;
end Math_Prime_Util.Families;
