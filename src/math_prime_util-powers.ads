with Ada.Containers.Vectors;
with Math_Prime_Util.Count;
with Math_Prime_Util.Int;

--  Prime powers and perfect powers from MPU 0.75
--  (prime_powers.c, perfect_powers.c, and the signed XS/PP wrappers).
package Math_Prime_Util.Powers with SPARK_Mode => Off is
   use type U64;
   use type Int.I128;

   package Power_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  Signed or one-past-2^64 results. Undefined is the Perl undef value.
   type Optional_Wide (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Int.I128;
         when False => null;
      end case;
   end record;

   --  prime_powers.c: prime_power. Exponent and prime root; both zero
   --  when N is not a prime power. Units are dimensionless. No errors.
   type Prime_Power_Root is record
      Exponent : U64 := 0;
      Root : U64 := 0;
   end record;

   --  prime_powers.c: prime_power. Returns the exponent (0 when none).
   function Prime_Power_Root (N : U64) return Prime_Power_Root
     with Pre => True,
          Post => (if N < 2 then Prime_Power_Root'Result.Exponent = 0);

   --  XS is_prime_power. Same exponent as Prime_Power_Root.
   function Is_Prime_Power (N : U64) return U64
     with Pre => True,
          Post => Is_Prime_Power'Result =
            Prime_Power_Root (N).Exponent;

   --  prime_powers.c: next_prime_power. Strict successor. The successor
   --  of the largest native prime power is 2**64. No errors.
   function Next_Prime_Power (N : U64) return Optional_Wide
     with Pre => True,
          Post => Next_Prime_Power'Result.Defined
            and then Next_Prime_Power'Result.Value > Int.I128 (N);

   --  prime_powers.c: prev_prime_power. Undefined for N <= 2.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N <= 2 then not Prev_Prime_Power'Result.Defined
                   elsif Prev_Prime_Power'Result.Defined then
                     Prev_Prime_Power'Result.Value < N);

   --  prime_powers.c: prime_power_sieve. Inclusive. Empty when reversed
   --  or when High < 2. Storage_Error may propagate from the sieve.
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P >= Low and then P <= High);

   --  prime_powers through High, including 2 when High >= 2.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result => P <= High);

   --  prime_powers.c: prime_power_count. Dies above the prime-count
   --  limit (Pre). The value counts prime powers through High.
   function Prime_Power_Count (High : U64) return U64
     with Pre => High <= Count.Prime_Count_Limit,
          Post => Prime_Power_Count'Result <= High;

   --  prime_powers.c: prime_power_count_range. Reversed bounds are 0.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => Low > High or else High <= Count.Prime_Count_Limit,
          Post => (if Low > High then Prime_Power_Count'Result = 0);

   --  prime_powers.c: prime_power_count_lower. Native bound.
   function Prime_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Lower'Result <= High + 1
            or else High = U64'Last;

   --  prime_powers.c: prime_power_count_upper. Native bound.
   function Prime_Power_Count_Upper (High : U64) return U64
     with Pre => True;

   --  prime_powers.c: prime_power_count_approx. Native estimate.
   function Prime_Power_Count_Approx (High : U64) return U64
     with Pre => True;

   --  prime_powers.c: nth_prime_power. One-based; zero is undefined.
   --  Past the native prime index, the result is the largest prime.
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_lower. Zero is undefined.
   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power_Lower'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_upper. Zero is undefined.
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power_Upper'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_approx. Zero is undefined.
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power_Approx'Result.Defined = (N /= 0);

   --  perfect_powers.c: is_perfect_power and is_perfect_power_neg.
   --  0, 1, and -1 are perfect powers. No errors.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => True,
          Post => (if N >= -1 and then N <= 1 then
                     Is_Perfect_Power'Result);

   --  perfect_powers.c: next_perfect_power, next_perfect_power_neg.
   --  The value may exceed 2**64. No errors.
   function Next_Perfect_Power (N : Int.I128) return Optional_Wide
     with Pre => True,
          Post => Next_Perfect_Power'Result.Defined
            and then Next_Perfect_Power'Result.Value > N;

   --  perfect_powers.c: prev_perfect_power, prev_perfect_power_neg.
   --  Prev (0) is -1. No errors.
   function Prev_Perfect_Power (N : Int.I128) return Optional_Wide
     with Pre => True,
          Post => Prev_Perfect_Power'Result.Defined
            and then Prev_Perfect_Power'Result.Value < N;

   --  perfect_powers.c: perfect_power_count. Through High, counting 1.
   function Perfect_Power_Count (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count'Result <= High + 1
            or else High = U64'Last;

   --  perfect_powers.c: perfect_power_count_range. Reversed is zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High then Perfect_Power_Count'Result = 0);

   --  perfect_powers.c: perfect_power_count_lower. Exact on this domain.
   function Perfect_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: perfect_power_count_upper. Exact on this domain.
   function Perfect_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: perfect_power_count_approx. Exact on this domain.
   function Perfect_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: nth_perfect_power. Zero is undefined. The
   --  value may be 2**64 when the index is one past the native limit.
   function Nth_Perfect_Power (N : U64) return Optional_Wide
     with Pre => True,
          Post => Nth_Perfect_Power'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   function Nth_Perfect_Power_Lower (N : U64) return Optional_Wide
     with Pre => True,
          Post => Nth_Perfect_Power_Lower'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_upper. Zero is undefined.
   function Nth_Perfect_Power_Upper (N : U64) return Optional_Wide
     with Pre => True,
          Post => Nth_Perfect_Power_Upper'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_approx. Zero is undefined.
   function Nth_Perfect_Power_Approx (N : U64) return Optional_Wide
     with Pre => True,
          Post => Nth_Perfect_Power_Approx'Result.Defined = (N /= 0);
end Math_Prime_Util.Powers;
