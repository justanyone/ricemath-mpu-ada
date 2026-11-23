with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Prime powers and perfect powers from MPU 0.75.
--  prime_powers.c and perfect_powers.c. Values past the native unsigned
--  maximum are returned in U128; signed perfect-power walks use I128.
package Math_Prime_Util.Powers with SPARK_Mode => On is
   use type U64;
   use type U128;
   use type Int.I128;

   package Power_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  prime_powers.c: prime_power. Exponent and prime root; both zero
   --  when N is not a prime power. No errors.
   type Prime_Power_Factor is record
      Exponent : U64;
      Root : U64;
   end record;

   --  Wider than U64 so 2**64, the successor of the last native prime,
   --  remains representable. Undefined results use Defined => False.
   type Optional_U128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : U128;
         when False => null;
      end case;
   end record;

   --  Largest perfect-power index in the native C table.
   Max_Perfect_Index : constant U64 := 4_297_615_581;
   --  perfect_powers.c: MPU_MAX_PERFECT_POW. Last perfect power in U64.
   Max_Perfect_Power : constant U64 := 18_446_744_065_119_617_025;
   --  prime_powers.c: MPU_MAX_PRIME. Last native prime.
   Max_Prime : constant U64 := 18_446_744_073_709_551_557;

   --  prime_powers.c: prime_power. Exponent, or zero when N is not one.
   function Prime_Power (N : U64) return Prime_Power_Factor
     with Pre => True,
          Post => (if Prime_Power'Result.Exponent = 0 then
                     Prime_Power'Result.Root = 0
                   else Prime_Power'Result.Root >= 2);

   --  prime_powers.c: is_prime_power. The exponent, or zero.
   function Is_Prime_Power (N : U64) return U64
     with Pre => True,
          Post => Is_Prime_Power'Result = Prime_Power (N).Exponent;

   --  prime_powers.c: prime_power_sieve. Inclusive. Empty when reversed
   --  or High < 2. Storage_Error may propagate from the prime sieve.
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P >= Low and then P <= High and then P >= 2);

   --  prime_powers.c: prime_powers through High. High < 2 is empty.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P <= High and then P >= 2);

   --  prime_powers.c: next_prime_power. Strict successor. The value 2**64
   --  is returned once N passes the last native prime.
   function Next_Prime_Power (N : U64) return U128
     with Pre => True,
          Post => Next_Prime_Power'Result > U128 (N);

   --  prime_powers.c: prev_prime_power. Undefined for N <= 2.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N <= 2 then not Prev_Prime_Power'Result.Defined
                   elsif Prev_Prime_Power'Result.Defined then
                     Prev_Prime_Power'Result.Value < N);

   --  prime_powers.c: prime_power_count. Needs the prime counter, so N
   --  stays inside Count.Prime_Count_Limit.
   function Prime_Power_Count (N : U64) return U64
     with Pre => N <= 20_000_000_000_000,
          Post => Prime_Power_Count'Result <= N;

   --  prime_powers.c: prime_power_count_range. Inclusive; reversed is 0.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => High <= 20_000_000_000_000,
          Post => (if Low > High or High < 2 then
                     Prime_Power_Count'Result = 0);

   --  prime_powers.c: prime_power_count_lower. Estimate, every native N.
   function Prime_Power_Count_Lower (N : U64) return U64
     with Pre => True, Post => Prime_Power_Count_Lower'Result <= N;

   --  prime_powers.c: prime_power_count_upper. Estimate, every native N.
   function Prime_Power_Count_Upper (N : U64) return U64
     with Pre => True, Post => True;

   --  prime_powers.c: prime_power_count_approx. Estimate, every native N.
   function Prime_Power_Count_Approx (N : U64) return U64
     with Pre => True, Post => Prime_Power_Count_Approx'Result <= N;

   --  prime_powers.c: nth_prime_power. One-based; zero is undefined.
   --  The search uses exact prime counts, so N stays in the tested range.
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => N <= 300_000_000,
          Post => Nth_Prime_Power'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_lower. Zero is undefined.
   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Prime_Power_Lower'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_upper. Zero is undefined.
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Prime_Power_Upper'Result.Defined = (N /= 0);

   --  prime_powers.c: nth_prime_power_approx. Zero is undefined.
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Prime_Power_Approx'Result.Defined = (N /= 0);

   --  perfect_powers.c: is_perfect_power, including the negative form.
   --  N = 0 and N = 1 are perfect powers. No errors.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => True, Post => (if N in 0 .. 1 then Is_Perfect_Power'Result);

   --  perfect_powers.c: next_perfect_power and next_perfect_power_neg.
   function Next_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => True, Post => Next_Perfect_Power'Result > N;

   --  perfect_powers.c: prev_perfect_power and prev_perfect_power_neg.
   --  Prev (0) is -1, matching the XS special case.
   function Prev_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => True, Post => Prev_Perfect_Power'Result < N;

   --  perfect_powers.c: perfect_power_count. Exact for every U128 N.
   function Perfect_Power_Count (N : U128) return U64
     with Pre => True, Post => U128 (Perfect_Power_Count'Result) <= N;

   --  perfect_powers.c: perfect_power_count_range. Inclusive.
   --  Reversed bounds and High = 0 return zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High or High = 0 then
                     Perfect_Power_Count'Result = 0);

   --  perfect_powers.c: perfect_power_count_lower. Identical to the count.
   function Perfect_Power_Count_Lower (N : U128) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result =
                    Perfect_Power_Count (N);

   --  perfect_powers.c: perfect_power_count_upper. Identical to the count.
   function Perfect_Power_Count_Upper (N : U128) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result =
                    Perfect_Power_Count (N);

   --  perfect_powers.c: perfect_power_count_approx. Identical to the count.
   function Perfect_Power_Count_Approx (N : U128) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result =
                    Perfect_Power_Count (N);

   --  perfect_powers.c: nth_perfect_power. One-based; zero is undefined.
   --  Index Max_Perfect_Index + 1 is 2**64, past the native C cap.
   function Nth_Perfect_Power (N : U64) return Optional_U128
     with Pre => N <= Max_Perfect_Index + 1,
          Post => Nth_Perfect_Power'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   --  Indices above Max_Perfect_Index return Max_Perfect_Power.
   function Nth_Perfect_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Perfect_Power_Lower'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_upper. Zero is undefined.
   function Nth_Perfect_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Perfect_Power_Upper'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_approx. Zero is undefined.
   function Nth_Perfect_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Nth_Perfect_Power_Approx'Result.Defined = (N /= 0);
end Math_Prime_Util.Powers;
