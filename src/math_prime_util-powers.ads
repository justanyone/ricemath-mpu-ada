with Ada.Containers.Vectors;
with Math_Prime_Util.Count;
with Math_Prime_Util.Int;

--  Prime powers and perfect powers from Math::Prime::Util 0.75.
package Math_Prime_Util.Powers with SPARK_Mode => On is
   use type U64;
   use type U128;
   use type Int.I128;

   --  constants.h: MPU_MAX_PRIME. Largest prime below 2**64.
   Max_Prime : constant U64 := 18_446_744_073_709_551_557;
   --  constants.h: MPU_MAX_PERFECT_POW. Last perfect power that fits U64.
   Max_Perfect_Power : constant U64 := 18_446_744_065_119_617_025;
   --  constants.h: MPU_MAX_PERFECT_POW_IDX. One-based index of that power.
   Max_Perfect_Power_Index : constant U64 := 4_297_615_581;
   --  Largest index whose prime power Prime_Count can still reach.
   Nth_Prime_Power_Limit : constant U64 := 203_280_221;

   --  Wide signed results: undef, negatives, and 2**64.
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Int.I128;
         when False => null;
      end case;
   end record;

   --  prime_powers.c: prime_power. Exponent and prime, or both zero.
   type Prime_Power_Factor is record
      Exponent : U64;
      Prime : U64;
   end record;

   package Power_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  prime_powers.c: prime_power. Exponent is zero when N is not one.
   --  The prime is zero in that same case. No errors.
   function Prime_Power (N : U64) return Prime_Power_Factor
     with Pre => True,
          Post => (if N < 2 then Prime_Power'Result.Exponent = 0)
            and then Prime_Power'Result.Exponent <= 63;

   --  prime_powers.h: is_prime_power. Exponent, or zero when N is not one.
   function Is_Prime_Power (N : U64) return U64
     is (Prime_Power (N).Exponent)
     with Pre => True,
          Post => Is_Prime_Power'Result = Prime_Power (N).Exponent;

   --  prime_powers.c: next_prime_power. Strict successor, in integer units.
   --  Past Max_Prime the successor is 2**64. No errors.
   function Next_Prime_Power (N : U64) return U128
     with Pre => True,
          Post => Next_Prime_Power'Result > U128 (N);

   --  prime_powers.c: prev_prime_power. Undefined for N below 3.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Prev_Prime_Power'Result.Defined = (N > 2);

   --  prime_powers.c: prime_power_sieve. Inclusive; reversed is empty.
   --  Storage_Error may propagate from the prime sieve.
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P >= Low and then P <= High);

   --  prime_powers.c: prime_power_sieve from 0 through High.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     is (Prime_Powers (0, High))
     with Pre => True,
          Post => (for all P of Prime_Powers'Result => P <= High);

   --  prime_powers.c: prime_power_count. Count of p**e <= High, e >= 1.
   --  Above Count.Prime_Count_Limit the precondition fails.
   function Prime_Power_Count (High : U64) return U64
     with Pre => High <= Count.Prime_Count_Limit,
          Post => Prime_Power_Count'Result <= High;

   --  prime_powers.c: prime_power_count_range. Reversed bounds are zero.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => Low > High or else High <= Count.Prime_Count_Limit,
          Post => (if Low > High then Prime_Power_Count'Result = 0);

   --  prime_powers.c: prime_power_count_lower. Native integer bound.
   function Prime_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Lower'Result <= U64'Last;

   --  prime_powers.c: prime_power_count_upper. Native integer bound.
   function Prime_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Upper'Result <= U64'Last;

   --  prime_powers.c: prime_power_count_approx. Native integer estimate.
   function Prime_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Approx'Result <= U64'Last;

   --  prime_powers.c: nth_prime_power. One-based; zero is undefined.
   --  Storage_Error may propagate from the prime counter.
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => N <= Nth_Prime_Power_Limit,
          Post => Nth_Prime_Power'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_lower. Zero is undefined.
   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => N <= Nth_Prime_Power_Limit,
          Post => Nth_Prime_Power_Lower'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_upper. Zero is undefined.
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => N <= Nth_Prime_Power_Limit,
          Post => Nth_Prime_Power_Upper'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_approx. Zero is undefined.
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => N <= Nth_Prime_Power_Limit,
          Post => Nth_Prime_Power_Approx'Result.Defined = (N /= 0);

   --  perfect_powers.c: is_perfect_power and is_perfect_power_neg.
   --  N is an integer unit. Values outside ±2**66 are rejected.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => N >= -(2 ** 66) and then N <= 2 ** 66,
          Post => (if N in 0 .. 1 then Is_Perfect_Power'Result);

   --  perfect_powers.c: next_perfect_power, including the negative form.
   --  The result is the following perfect power, in integer units.
   function Next_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N >= -(2 ** 66) and then N <= 2 ** 66,
          Post => Next_Perfect_Power'Result > N;

   --  perfect_powers.c: prev_perfect_power, including the negative form.
   --  Zero yields -1. The result is strictly smaller than N.
   function Prev_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N >= -(2 ** 66) and then N <= 2 ** 66,
          Post => Prev_Perfect_Power'Result < N;

   --  perfect_powers.c: perfect_power_count. Count of k**e <= High, e >= 2,
   --  plus 1 when High >= 1. No errors.
   function Perfect_Power_Count (High : U64) return U64
     with Pre => True,
          Post => U128 (Perfect_Power_Count'Result) <= U128 (High) + 1;

   --  perfect_powers.c: perfect_power_count_range. Reversed bounds are zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High then Perfect_Power_Count'Result = 0);

   --  perfect_powers.c: perfect_power_count_lower. Equals the exact count.
   function Perfect_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: perfect_power_count_upper. Equals the exact count.
   function Perfect_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: perfect_power_count_approx. Equals the exact count.
   function Perfect_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: nth_perfect_power. One-based; zero is undefined.
   --  Index Max_Perfect_Power_Index + 1 is 2**64.
   function Nth_Perfect_Power (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Power_Index + 1,
          Post => Nth_Perfect_Power'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   function Nth_Perfect_Power_Lower (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Power_Index + 1,
          Post => Nth_Perfect_Power_Lower'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_upper. Zero is undefined.
   function Nth_Perfect_Power_Upper (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Power_Index + 1,
          Post => Nth_Perfect_Power_Upper'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_approx. Zero is undefined.
   function Nth_Perfect_Power_Approx (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Power_Index + 1,
          Post => Nth_Perfect_Power_Approx'Result.Defined = (N /= 0);
end Math_Prime_Util.Powers;
