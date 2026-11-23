with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Prime powers and perfect powers from MPU 0.75 prime_powers.c and
--  perfect_powers.c. Counts are dimensionless. A zero index is undefined.
package Math_Prime_Util.Powers with SPARK_Mode => On is
   use type U64;
   use type Int.I128;

   --  constants.h: MPU_MAX_PRIME. Largest prime representable as U64.
   Max_Prime : constant U64 := 18_446_744_073_709_551_557;
   --  constants.h: MPU_MAX_PRIME_IDX. Largest index with an nth value.
   Max_Prime_Index : constant U64 := 425_656_284_035_217_743;
   --  constants.h: MPU_MAX_PERFECT_POW. Largest perfect power in U64.
   Max_Perfect_Power : constant U64 := 18_446_744_065_119_617_025;
   --  constants.h: MPU_MAX_PERFECT_POW_IDX.
   Max_Perfect_Power_Index : constant U64 := 4_297_615_581;

   --  Signed domain covering the native range and one step past 2**64.
   subtype Power_Domain is Int.I128 range -(2 ** 66) .. 2 ** 66;

   --  Exact nth perfect power, including 2**64. Undefined for a zero index
   --  and for an index past Max_Perfect_Power_Index + 1.
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Int.I128;
         when False => null;
      end case;
   end record;

   package Power_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  prime_powers.c: prime_power. Exponent of the prime base, or 0 when
   --  N is not a prime power. No errors for a native argument.
   function Is_Prime_Power (N : U64) return Natural
     with Pre => True,
          Post => Is_Prime_Power'Result <= 63;

   --  prime_powers.c: prime_power root output. Zero when N is not a
   --  prime power. No errors for a native argument.
   function Prime_Power_Root (N : U64) return U64
     with Pre => True,
          Post => (if Is_Prime_Power (N) = 0 then Prime_Power_Root'Result = 0
                   else Prime_Power_Root'Result >= 2);

   --  prime_powers.c: next_prime_power. Strict successor. Undefined at
   --  and above Max_Prime, where the successor is 2**64.
   function Next_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Next_Prime_Power'Result.Defined then
                     Next_Prime_Power'Result.Value > N);

   --  prime_powers.c: prev_prime_power. Strict predecessor. Undefined
   --  for N <= 2.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Prev_Prime_Power'Result.Defined then
                     Prev_Prime_Power'Result.Value < N);

   --  prime_powers.c: prime_power_sieve. Inclusive range. Empty when
   --  reversed or High < 2. Storage_Error may propagate from the sieve.
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all V of Prime_Powers'Result =>
                     V >= Low and then V <= High);

   --  Prime powers from 2 through High. Storage_Error may propagate.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all V of Prime_Powers'Result => V <= High);

   --  prime_powers.c: prime_power_count. Prime powers through N.
   function Prime_Power_Count (N : U64) return U64
     with Pre => True, Post => Prime_Power_Count'Result <= N;

   --  prime_powers.c: prime_power_count_range. Inclusive. Reversed or
   --  High < 2 yields zero.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High or else High < 2 then
                     Prime_Power_Count'Result = 0);

   --  prime_powers.c: prime_power_count_lower. Bound through N.
   function Prime_Power_Count_Lower (N : U64) return U64
     with Pre => True, Post => Prime_Power_Count_Lower'Result <= N;

   --  prime_powers.c: prime_power_count_upper. Bound through N.
   function Prime_Power_Count_Upper (N : U64) return U64
     with Pre => True, Post => Prime_Power_Count_Upper'Result <= N;

   --  prime_powers.c: prime_power_count_approx. Estimate through N.
   function Prime_Power_Count_Approx (N : U64) return U64
     with Pre => True, Post => Prime_Power_Count_Approx'Result <= N;

   --  prime_powers.c: nth_prime_power. One-based. Zero is undefined.
   --  An index above Max_Prime_Index saturates at Max_Prime.
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_lower. Zero is undefined.
   --  An index above Max_Prime_Index saturates at Max_Prime.
   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power_Lower'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_upper. Zero is undefined.
   --  An index above Max_Prime_Index saturates at Max_Prime.
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power_Upper'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_approx. Zero is undefined.
   --  An index above Max_Prime_Index saturates at Max_Prime.
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Prime_Power_Approx'Result.Defined = (N /= 0);

   --  perfect_powers.c: is_perfect_power and is_perfect_power_neg.
   --  True for -1, 0, 1 and for every higher perfect power. A negative
   --  value is a perfect power only for an odd exponent. No errors inside
   --  Power_Domain.
   function Is_Perfect_Power (N : Power_Domain) return Boolean
     with Pre => True,
          Post => (if N in -1 .. 1 then Is_Perfect_Power'Result);

   --  perfect_powers.c: next_perfect_power, including the odd-power
   --  walk used for a negative argument. The result may be 2**64.
   function Next_Perfect_Power (N : Power_Domain) return Int.I128
     with Pre => True, Post => Next_Perfect_Power'Result > N;

   --  perfect_powers.c: prev_perfect_power. Zero yields -1.
   function Prev_Perfect_Power (N : Power_Domain) return Int.I128
     with Pre => True, Post => Prev_Perfect_Power'Result < N;

   --  perfect_powers.c: perfect_power_count. Perfect powers through N,
   --  counting 1.
   function Perfect_Power_Count (N : U64) return U64
     with Pre => True, Post => Perfect_Power_Count'Result <= N;

   --  perfect_powers.c: perfect_power_count_range. Inclusive. Reversed
   --  or High = 0 yields zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High or else High = 0 then
                     Perfect_Power_Count'Result = 0);

   --  perfect_powers.c: perfect_power_count_lower. Equal to the exact count.
   function Perfect_Power_Count_Lower (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result = Perfect_Power_Count (N);

   --  perfect_powers.c: perfect_power_count_upper. Equal to the exact count.
   function Perfect_Power_Count_Upper (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result = Perfect_Power_Count (N);

   --  perfect_powers.c: perfect_power_count_approx. Equal to the exact count.
   function Perfect_Power_Count_Approx (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result =
            Perfect_Power_Count (N);

   --  perfect_powers.c: nth_perfect_power. One-based, with the value 1
   --  at index 1. The index Max_Perfect_Power_Index + 1 is 2**64.
   function Nth_Perfect_Power (N : U64) return Optional_I128
     with Pre => True,
          Post => (if N = 0 or else N > Max_Perfect_Power_Index + 1 then
                     not Nth_Perfect_Power'Result.Defined
                   elsif N = Max_Perfect_Power_Index + 1 then
                     Nth_Perfect_Power'Result.Defined
                     and then Nth_Perfect_Power'Result.Value = 2 ** 64
                   else Nth_Perfect_Power'Result.Defined);

   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   --  At and above Max_Perfect_Power_Index the bound is Max_Perfect_Power.
   --  A larger PP BigFloat value is outside this native saturation.
   function Nth_Perfect_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power_Lower'Result.Defined
                   elsif N >= Max_Perfect_Power_Index then
                     Nth_Perfect_Power_Lower'Result.Defined
                     and then Nth_Perfect_Power_Lower'Result.Value =
                       Max_Perfect_Power
                   else Nth_Perfect_Power_Lower'Result.Defined);

   --  perfect_powers.c: nth_perfect_power_upper. Same saturation as lower.
   function Nth_Perfect_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power_Upper'Result.Defined
                   elsif N >= Max_Perfect_Power_Index then
                     Nth_Perfect_Power_Upper'Result.Defined
                     and then Nth_Perfect_Power_Upper'Result.Value =
                       Max_Perfect_Power
                   else Nth_Perfect_Power_Upper'Result.Defined);

   --  perfect_powers.c: nth_perfect_power_approx. Same saturation as lower.
   function Nth_Perfect_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power_Approx'Result.Defined
                   elsif N >= Max_Perfect_Power_Index then
                     Nth_Perfect_Power_Approx'Result.Defined
                     and then Nth_Perfect_Power_Approx'Result.Value =
                       Max_Perfect_Power
                   else Nth_Perfect_Power_Approx'Result.Defined);
end Math_Prime_Util.Powers;
