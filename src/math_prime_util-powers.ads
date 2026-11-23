with Math_Prime_Util.Count;
with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

--  Prime powers and perfect powers from MPU 0.75 prime_powers.c and
--  perfect_powers.c. Values one step past 2^64 use Int.I128.
package Math_Prime_Util.Powers with SPARK_Mode => On is
   use type U64;
   use type Int.I128;

   --  Native lists share the sieve vector. Storage_Error may propagate.
   package Power_Vectors renames Sieve.Prime_Vectors;

   --  Undefined native results. Wider than Optional_U64 so 2^64 fits.
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Int.I128;
         when False => null;
      end case;
   end record;

   --  prime_powers.c: prime_power. Exponent of a prime power, else zero.
   --  The prime factor is Prime, or zero when Exponent is zero.
   type Prime_Power_Factors is record
      Exponent : U64;
      Prime : U64;
   end record;

   --  Largest native prime. Next prime power at or above it is 2^64.
   Max_Prime : constant U64 := 18_446_744_073_709_551_557;
   --  perfect_powers.c: MPU_MAX_PERFECT_POW and its one-based index.
   Max_Perfect_Pow : constant U64 := 18_446_744_065_119_617_025;
   Max_Perfect_Idx : constant U64 := 4_297_615_581;

   --  prime_powers.c: prime_power. Exponent and prime, or zeros.
   function Prime_Power (N : U64) return Prime_Power_Factors
     with Pre => True,
          Post => (if Prime_Power'Result.Exponent = 0
                   then Prime_Power'Result.Prime = 0
                   else Prime_Power'Result.Prime >= 2);

   --  prime_powers.h: is_prime_power. Exponent, or zero when N is not
   --  a prime power. No errors.
   function Is_Prime_Power (N : U64) return U64
     with Pre => True, Post => Is_Prime_Power'Result <= 63;

   --  XS prime_powers. Inclusive. Reversed and empty ranges are empty.
   --  A window longer than Scan_Limit is sieved. Storage_Error may occur.
   Scan_Limit : constant U64 := 8_192;
   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P >= Low and then P <= High and then P >= 2);
   --  Prime powers from 2 through High, inclusive.
   function Prime_Powers (High : U64) return Power_Vectors.Vector
     with Pre => True,
          Post => (for all P of Prime_Powers'Result =>
                     P <= High and then P >= 2);

   --  prime_powers.c: next_prime_power. Strict successor. The value
   --  2^64 is the successor of the largest native prime.
   function Next_Prime_Power (N : U64) return Optional_I128
     with Pre => True,
          Post => Next_Prime_Power'Result.Defined
            and then Next_Prime_Power'Result.Value >= 2
            and then Next_Prime_Power'Result.Value > Int.I128 (N);

   --  prime_powers.c: prev_prime_power. Undefined for N <= 2.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => Prev_Prime_Power'Result.Defined = (N > 2);

   --  prime_powers.c: prime_power_count. Dies above the prime-count
   --  limit (Pre). Count of prime powers <= N.
   function Prime_Power_Count (N : U64) return U64
     with Pre => N <= Count.Prime_Count_Limit,
          Post => Prime_Power_Count'Result <= N;
   --  prime_powers.c: prime_power_count_range. Inclusive; reversed is 0.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => Low > High or else High <= Count.Prime_Count_Limit,
          Post => (if Low > High then Prime_Power_Count'Result = 0);
   --  prime_powers.c: prime_power_count_lower. Native bound, all N.
   function Prime_Power_Count_Lower (N : U64) return U64
     with Pre => True;
   --  prime_powers.c: prime_power_count_upper. Native bound, all N.
   function Prime_Power_Count_Upper (N : U64) return U64
     with Pre => True;
   --  prime_powers.c: prime_power_count_approx. Native estimate, all N.
   function Prime_Power_Count_Approx (N : U64) return U64
     with Pre => True;

   --  prime_powers.c: nth_prime_power. One-based; zero is undefined.
   --  The search uses the native prime-count range.
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => N = 0 or else N <= 300_000_000,
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

   --  perfect_powers.c: is_perfect_power / is_perfect_power_iv.
   --  Zero, one, and negative one are perfect powers. No errors.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => True,
          Post => (if N in 0 .. 1 or else N = -1
                   then Is_Perfect_Power'Result);

   --  perfect_powers.c: next_perfect_power, including negative arguments
   --  and the step past 2^64. The result is strictly greater than N.
   --  Constraint_Error if the successor does not fit in Int.I128.
   function Next_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N < Int.I128'Last,
          Post => Next_Perfect_Power'Result > N;
   --  perfect_powers.c: prev_perfect_power. Strict predecessor.
   --  Constraint_Error if the predecessor does not fit in Int.I128.
   function Prev_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N > Int.I128'First,
          Post => Prev_Perfect_Power'Result < N;

   --  perfect_powers.c: perfect_power_count. Count through N inclusive.
   --  One is counted; zero is not.
   function Perfect_Power_Count (N : U64) return U64
     with Pre => True,
          Post => (if N = 0 then Perfect_Power_Count'Result = 0
                   elsif N < 4 then Perfect_Power_Count'Result = 1);
   --  perfect_powers.c: perfect_power_count_range. Inclusive.
   --  Reversed ranges and a high bound of zero are zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High or else High = 0
                   then Perfect_Power_Count'Result = 0);
   --  perfect_powers.c: the three estimates are the exact count.
   function Perfect_Power_Count_Lower (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result
            = Perfect_Power_Count (N);
   function Perfect_Power_Count_Upper (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result
            = Perfect_Power_Count (N);
   function Perfect_Power_Count_Approx (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result
            = Perfect_Power_Count (N);

   --  perfect_powers.c: nth_perfect_power. One-based; zero is undefined.
   --  Index Max_Perfect_Idx + 1 is 2^64. Constraint_Error past that
   --  when the value does not fit in Int.I128.
   function Nth_Perfect_Power (N : U64) return Optional_I128
     with Pre => True,
          Post => Nth_Perfect_Power'Result.Defined = (N /= 0);
   --  perfect_powers.c: nth_perfect_power_lower. Zero is undefined.
   --  The first index past Max_Perfect_Idx uses the pure-Perl value.
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
