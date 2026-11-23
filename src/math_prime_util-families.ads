with Ada.Containers.Vectors;
with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

--  Lucky-number sieves and estimates from MPU 0.75.
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
   --  Exact operations are bounded by the prime-count backend.
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
end Math_Prime_Util.Families;
