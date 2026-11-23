with Ada.Containers.Vectors;
with Math_Prime_Util.Count;
with Math_Prime_Util.Int;

--  Prime powers and perfect powers from MPU 0.75.
package Math_Prime_Util.Powers with SPARK_Mode => On is
   use type U64;
   use type U128;
   use type Int.I128;

   package Power_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  Signed results cover prev(0) = -1 and powers past 2^64 - 1.
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Int.I128;
         when False => null;
      end case;
   end record;

   --  prime_powers.c: prime_power. Exponent and prime root, or none.
   type Prime_Factor (Found : Boolean := False) is record
      case Found is
         when True =>
            Exponent : Natural;
            Prime : U64;
         when False => null;
      end case;
   end record;

   --  prime_powers.c: prime_power. Zero means not a prime power.
   --  The exponent is a count of prime factors, all equal to Prime.
   function Prime_Power (N : U64) return Prime_Factor
     with Pre => True,
          Post => (if N < 2 then not Prime_Power'Result.Found);

   --  prime_powers.c: prime_power, Perl is_prime_power.
   --  Returns the exponent, or zero when N is not a prime power.
   function Is_Prime_Power (N : U64) return Natural
     with Pre => True,
          Post => (if N < 2 then Is_Prime_Power'Result = 0);

   --  prime_powers.c: next_prime_power. Strict successor.
   --  The result is 2**64 when that power does not fit in U64.
   function Next_Prime_Power (N : U64) return U128
     with Pre => True,
          Post => Next_Prime_Power'Result > U128 (N)
            and then Next_Prime_Power'Result <= 2 ** 64;

   --  prime_powers.c: prev_prime_power. Undefined for N <= 2.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N <= 2 then not Prev_Prime_Power'Result.Defined
                   elsif Prev_Prime_Power'Result.Defined then
                     Prev_Prime_Power'Result.Value < N);

   --  prime_powers.c: prime_power_sieve. Inclusive; empty when none.
   --  Storage_Error may propagate from the prime sieve.
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P >= Low and then P <= High and then P >= 2);

   --  Prime powers from 2 through High, inclusive.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P <= High and then P >= 2);

   --  prime_powers.c: prime_power_count. Dies above the prime-count limit.
   function Prime_Power_Count (High : U64) return U64
     with Pre => High <= Count.Prime_Count_Limit,
          Post => Prime_Power_Count'Result <= High;

   --  prime_powers.c: prime_power_count_range. Reversed bounds are zero.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => Low > High or else High <= Count.Prime_Count_Limit,
          Post => (if Low > High or else High < 2 then
                     Prime_Power_Count'Result = 0);

   --  prime_powers.c: prime_power_count_lower. Bound through High.
   function Prime_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Lower'Result <= High;

   --  prime_powers.c: prime_power_count_upper. Bound through High.
   function Prime_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Upper'Result <= High;

   --  prime_powers.c: prime_power_count_approx. Estimate through High.
   function Prime_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Approx'Result <= High;

   --  prime_powers.c: nth_prime_power. One-based; zero is undefined.
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

   --  perfect_powers.c: is_perfect_power and is_perfect_power_iv.
   --  Negative bases count only when the max exponent is not a power of two.
   --  Inputs are signed integers in the stated range; no errors.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => N >= -(2 ** 120) and then N <= 2 ** 120,
          Post => (if N in -1 .. 1 then Is_Perfect_Power'Result);

   --  perfect_powers.c: next_perfect_power and next_perfect_power_neg.
   --  Strict successor, including negative odd powers. No errors in range.
   function Next_Perfect_Power (N : Int.I128) return Optional_I128
     with Pre => N >= -(2 ** 120) and then N <= 2 ** 120,
          Post => Next_Perfect_Power'Result.Defined
            and then Next_Perfect_Power'Result.Value > N;

   --  perfect_powers.c: prev_perfect_power and prev_perfect_power_neg.
   --  Strict predecessor. Zero yields -1. No errors in range.
   function Prev_Perfect_Power (N : Int.I128) return Optional_I128
     with Pre => N >= -(2 ** 120) and then N <= 2 ** 120,
          Post => Prev_Perfect_Power'Result.Defined
            and then Prev_Perfect_Power'Result.Value < N;

   --  perfect_powers.c: perfect_power_count. Count through High.
   function Perfect_Power_Count (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count'Result <= High;

   --  perfect_powers.c: perfect_power_count_range. Reversed is zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High or else High < 1 then
                     Perfect_Power_Count'Result = 0);

   --  perfect_powers.c: perfect_power_count_lower. Equals the exact count.
   function Perfect_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result <= High;

   --  perfect_powers.c: perfect_power_count_upper. Equals the exact count.
   function Perfect_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result <= High;

   --  perfect_powers.c: perfect_power_count_approx. Equals the exact count.
   function Perfect_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result <= High;

   --  perfect_powers.c: nth_perfect_power. One-based; zero is undefined.
   --  At and above the native index limit the value is the last native power.
   function Nth_Perfect_Power (N : U64) return Optional_I128
     with Pre => True,
          Post => Nth_Perfect_Power'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   function Nth_Perfect_Power_Lower (N : U64) return Optional_I128
     with Pre => True,
          Post => Nth_Perfect_Power_Lower'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_upper. Zero is undefined.
   function Nth_Perfect_Power_Upper (N : U64) return Optional_I128
     with Pre => True,
          Post => Nth_Perfect_Power_Upper'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_approx. Zero is undefined.
   function Nth_Perfect_Power_Approx (N : U64) return Optional_I128
     with Pre => True,
          Post => Nth_Perfect_Power_Approx'Result.Defined = (N /= 0);
end Math_Prime_Util.Powers;
