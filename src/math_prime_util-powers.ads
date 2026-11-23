with Math_Prime_Util.Int;
with Math_Prime_Util.Count;

--  Prime and perfect powers from MPU 0.75, in native integer units.
package Math_Prime_Util.Powers with SPARK_Mode => On is
   use type U64;
   use type Int.I128;
   type Prime_Power_Result is record
      Exponent : U64 range 0 .. 63;
      Prime : U64;
   end record;
   --  prime_powers.c: prime_power. Zero fields if N is not a prime power.
   function Prime_Power (N : U64) return Prime_Power_Result
     with Pre => True,
          Post => (Prime_Power'Result.Exponent = 0) =
                    (Prime_Power'Result.Prime = 0);
   --  prime_powers.c: prime_power. Exponent, or zero; primes return one.
   function Is_Prime_Power (N : U64) return U64
     with Pre => True, Post => Is_Prime_Power'Result <= 63;
   --  perfect_powers.c: is_perfect_power. Includes zero and one.
   function Is_Perfect_Power (N : U64) return Boolean
     with Pre => True,
          Post => (if N <= 1 then Is_Perfect_Power'Result);
   --  perfect_powers.c: is_perfect_power_iv. Negative odd powers qualify.
   function Is_Perfect_Power (N : Int.I128) return Boolean
     with Pre => N in -Int.I128 (U64'Last) .. Int.I128 (U64'Last),
          Post => (if N in -1 .. 1 then Is_Perfect_Power'Result);
   --  prime_powers.c: next_prime_power. Strict neighbor.
   --  Undefined when no neighbor is representable in U64.
   function Next_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Next_Prime_Power'Result.Defined then
                     Next_Prime_Power'Result.Value > N);
   --  prime_powers.c: prev_prime_power. Strict neighbor.
   --  Undefined when no neighbor is representable in U64.
   function Prev_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Prev_Prime_Power'Result.Defined then
                     Prev_Prime_Power'Result.Value < N);
   --  perfect_powers.c: next_perfect_power. Strict neighbor.
   --  Undefined when no neighbor is representable in U64.
   function Next_Perfect_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Next_Perfect_Power'Result.Defined then
                     Next_Perfect_Power'Result.Value > N);
   --  perfect_powers.c: prev_perfect_power. Strict neighbor.
   --  Undefined when no neighbor is representable in U64.
   function Prev_Perfect_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Prev_Perfect_Power'Result.Defined then
                     Prev_Perfect_Power'Result.Value < N);
   --  perfect_powers.c: next_perfect_power_neg. Signed strict successor.
   function Next_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N in -Int.I128 (U64'Last) .. -1,
          Post => Next_Perfect_Power'Result > N;
   --  perfect_powers.c: prev_perfect_power_neg. Signed strict predecessor.
   --  Predecessor magnitude must fit U64; otherwise Constraint_Error.
   function Prev_Perfect_Power (N : Int.I128) return Int.I128
     with Pre => N in -18_446_724_184_312_856_124 .. 0,
          Post => Prev_Perfect_Power'Result < N;
   --  prime_powers.c: prime_power_count. Count through N inclusive.
   function Prime_Power_Count (N : U64) return U64
     with Pre => N <= Count.Prime_Count_Limit,
          Post => Prime_Power_Count'Result <= N;
   --  prime_powers.c: prime_power_count_lower. Count through N inclusive.
   function Prime_Power_Count_Lower (N : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Lower'Result <= N;
   --  prime_powers.c: prime_power_count_upper. Count through N inclusive.
   function Prime_Power_Count_Upper (N : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Upper'Result <= N;
   --  prime_powers.c: prime_power_count_approx. Count through N inclusive.
   function Prime_Power_Count_Approx (N : U64) return U64
     with Pre => True,
          Post => Prime_Power_Count_Approx'Result <= N;
   --  prime_powers.c: prime_power_count_range. Inclusive; reversed is zero.
   function Prime_Power_Count (Low, High : U64) return U64
     with Pre => High <= Count.Prime_Count_Limit,
          Post => (if Low > High then Prime_Power_Count'Result = 0);
   --  prime_powers.c: nth_prime_power. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Prime_Power (N : U64) return Int.Optional_U64
     with Pre => N <= Count.Nth_Prime_Limit,
          Post => (if N = 0 then not Nth_Prime_Power'Result.Defined);
   --  prime_powers.c: nth_prime_power_lower. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => N <= Count.Nth_Prime_Limit,
          Post => (if N = 0 then not Nth_Prime_Power_Lower'Result.Defined);
   --  prime_powers.c: nth_prime_power_upper. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => N <= Count.Nth_Prime_Limit,
          Post => (if N = 0 then not Nth_Prime_Power_Upper'Result.Defined);
   --  prime_powers.c: nth_prime_power_approx. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => N <= Count.Nth_Prime_Limit,
          Post => (if N = 0 then not Nth_Prime_Power_Approx'Result.Defined);
   --  perfect_powers.c: perfect_power_count. Count through N inclusive.
   function Perfect_Power_Count (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count'Result <= N;
   --  perfect_powers.c: perfect_power_count_lower. Count through N inclusive.
   function Perfect_Power_Count_Lower (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Lower'Result <= N;
   --  perfect_powers.c: perfect_power_count_upper. Count through N inclusive.
   function Perfect_Power_Count_Upper (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Upper'Result <= N;
   --  perfect_powers.c: perfect_power_count_approx. Count through N inclusive.
   function Perfect_Power_Count_Approx (N : U64) return U64
     with Pre => True,
          Post => Perfect_Power_Count_Approx'Result <= N;
   --  perfect_powers.c: perfect_power_count_range. Reversed is zero.
   function Perfect_Power_Count (Low, High : U64) return U64
     with Pre => True,
          Post => (if Low > High then Perfect_Power_Count'Result = 0);
   --  perfect_powers.c: nth_perfect_power. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Perfect_Power (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power'Result.Defined);
   --  perfect_powers.c: nth_perfect_power_lower. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Perfect_Power_Lower (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power_Lower'Result.Defined);
   --  perfect_powers.c: nth_perfect_power_upper. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Perfect_Power_Upper (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power_Upper'Result.Defined);
   --  perfect_powers.c: nth_perfect_power_approx. One-based index.
   --  Undefined for zero or a result beyond U64; estimates saturate.
   function Nth_Perfect_Power_Approx (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 0 then not Nth_Perfect_Power_Approx'Result.Defined);
end Math_Prime_Util.Powers;
