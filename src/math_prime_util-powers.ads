with Ada.Containers.Vectors;
with Math_Prime_Util.Count;
with Math_Prime_Util.Int;

--  Prime powers and perfect powers from MPU 0.75 prime_powers.c and
--  perfect_powers.c. Results are dimensionless integers.
package Math_Prime_Util.Powers is
   package Count renames Math_Prime_Util.Count;
   use type U64;
   use type Int.I128;

   package Power_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  Undefined when the index is zero or the value does not fit.
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Int.I128;
         when False => null;
      end case;
   end record;

   --  Largest native prime. The next prime power is 2**64.
   Max_Prime : constant U64 := 18_446_744_073_709_551_557;
   --  Last perfect power that fits in a native unsigned integer.
   Max_Perfect_Power : constant U64 := 18_446_744_065_119_617_025;
   --  One-based index of Max_Perfect_Power. Larger indexes are PP-only.
   Max_Perfect_Index : constant U64 := 4_297_615_581;
   --  Largest N for which the exact nth prime power calls Prime_Count.
   Nth_Prime_Power_Limit : constant U64 := 250_000_000;

   --  prime_powers.c: prime_power. Exponent of p**k, else zero.
   --  Native unsigned input. No errors.
   function Is_Prime_Power (N : U64) return U64
     with Pre => True, Post => Is_Prime_Power'Result <= 63;

   --  prime_powers.c: prime_power, also writing the prime root.
   --  Root is zero when the exponent is zero. No errors.
   function Is_Prime_Power (N : U64; Root : out U64) return U64
     with Pre => True,
          Post => Is_Prime_Power'Result <= 63
            and then (if Is_Prime_Power'Result = 0 then Root = 0);

   --  prime_powers.c: next_prime_power. Strict successor.
   --  Undefined at and above Max_Prime, where the successor is 2**64.
   function Next_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N >= Max_Prime then not Next_Prime_Power'Result.Defined
                   elsif Next_Prime_Power'Result.Defined then
                     Next_Prime_Power'Result.Value > N);

   --  prime_powers.c: prev_prime_power. Strict predecessor.
   --  Undefined for N below 3.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N <= 2 then not Prev_Prime_Power'Result.Defined
                   elsif Prev_Prime_Power'Result.Defined then
                     Prev_Prime_Power'Result.Value < N);

   --  prime_powers.c: prime_power_sieve. Inclusive; one argument starts at 0.
   --  Reversed bounds are empty. Storage_Error may propagate.
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all V of Prime_Powers'Result =>
                     V >= U64'Max (Low, 2) and then V <= High);

   --  prime_powers.c: prime_power_sieve through High. Storage_Error may
   --  propagate from the prime sieve.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all V of Prime_Powers'Result =>
                     V >= 2 and then V <= High);

   --  prime_powers.c: prime_power_count. Count of p**k <= High, k >= 1.
   --  Dies above the prime-count limit (Pre).
   function Prime_Power_Count (High : U64) return U64
     with Pre => High <= Count.Prime_Count_Limit,
          Post => Prime_Power_Count'Result <= High;

   --  prime_powers.c: prime_power_count_range. Inclusive; reversed is zero.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => Low > High or else High <= Count.Prime_Count_Limit,
          Post => (if Low > High then Prime_Power_Count'Result = 0);

   --  prime_powers.c: prime_power_count_lower. Sum of prime lower bounds.
   function Prime_Power_Count_Lower (High : U64) return U64
     with Pre => True, Post => Prime_Power_Count_Lower'Result <= High;

   --  prime_powers.c: prime_power_count_upper. Sum of prime upper bounds.
   function Prime_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Upper'Result <= U64'Last;

   --  prime_powers.c: prime_power_count_approx. Sum of prime estimates.
   function Prime_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Approx'Result <= U64'Last;

   --  prime_powers.c: nth_prime_power. One-based; zero is undefined.
   --  Dies above Nth_Prime_Power_Limit (Pre).
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => N <= Nth_Prime_Power_Limit,
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

   --  perfect_powers.c: is_perfect_power, including negatives.
   --  -1, 0, and 1 are perfect powers. No errors.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => True,
          Post => (if N >= -1 and then N <= 1 then Is_Perfect_Power'Result);

   --  perfect_powers.c / PP.pm: next_perfect_power. Strict successor.
   --  Constraint_Error when the successor does not fit in I128.
   function Next_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N < Int.I128'Last,
          Post => Next_Perfect_Power'Result > N;

   --  perfect_powers.c / PP.pm: prev_perfect_power. Strict predecessor.
   --  Constraint_Error when the predecessor does not fit in I128.
   function Prev_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N > Int.I128'First,
          Post => Prev_Perfect_Power'Result < N;

   --  perfect_powers.c: perfect_power_count. Numbers in 1 .. High.
   function Perfect_Power_Count (High : U64) return U64
     with Pre => True, Post => Perfect_Power_Count'Result <= High;

   --  perfect_powers.c: perfect_power_count_range. Inclusive.
   --  Reversed bounds and a zero high return zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High or else High = 0 then
                     Perfect_Power_Count'Result = 0);

   --  perfect_powers.c: perfect_power_count_lower. Exact on this port.
   function Perfect_Power_Count_Lower (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: perfect_power_count_upper. Exact on this port.
   function Perfect_Power_Count_Upper (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: perfect_power_count_approx. Exact on this port.
   function Perfect_Power_Count_Approx (High : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result =
            Perfect_Power_Count (High);

   --  perfect_powers.c: nth_perfect_power. One-based; zero is undefined.
   --  N above Max_Perfect_Index is outside the native C function.
   function Nth_Perfect_Power (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Index,
          Post => Nth_Perfect_Power'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   function Nth_Perfect_Power_Lower (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Index,
          Post => Nth_Perfect_Power_Lower'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_upper. Zero is undefined.
   function Nth_Perfect_Power_Upper (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Index,
          Post => Nth_Perfect_Power_Upper'Result.Defined = (N /= 0);

   --  perfect_powers.c: nth_perfect_power_approx. Zero is undefined.
   function Nth_Perfect_Power_Approx (N : U64) return Optional_I128
     with Pre => N <= Max_Perfect_Index,
          Post => Nth_Perfect_Power_Approx'Result.Defined = (N /= 0);
end Math_Prime_Util.Powers;
