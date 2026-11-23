with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Number-family sieves and estimates from MPU 0.75.
package Math_Prime_Util.Families is
   use type U64;
   package Lucky_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

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
   --  Family lists use the same native integer vector representation.
   package Family_Vectors renames Lucky_Vectors;

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
end Math_Prime_Util.Families;
