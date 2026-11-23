<<<<<<< HEAD
with Ada.Containers.Vectors;

--  Arithmetic functions translated from MPU 0.75.
package Math_Prime_Util.Arith is
   package U64_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  inverse_sigma0.c: inverse_sigma0_list. Inclusive range; reversed ranges
   --  and k = 0 return an empty vector.
   function Inverse_Sigma0 (K, Low, High : U64) return U64_Vectors.Vector
     with Pre => True,
          Post => (for all N of Inverse_Sigma0'Result =>
                     N >= Low and then N <= High);
   --  inverse_sigma0.c: inverse_sigma0_list. Search 1 .. High inclusive.
   function Inverse_Sigma0 (K, High : U64) return U64_Vectors.Vector
     with Pre => True,
          Post => (for all N of Inverse_Sigma0'Result => N <= High);

   --  inverse_sigma0.c: inverse_sigma0_count. Inclusive range; returns zero
   --  for reversed ranges and k = 0.
   function Inverse_Sigma0_Count (K, Low, High : U64) return U64
     with Pre => True, Post => Inverse_Sigma0_Count'Result <= High;
   --  inverse_sigma0.c: inverse_sigma0_count. Search 1 .. High inclusive.
   function Inverse_Sigma0_Count (K, High : U64) return U64
     with Pre => True, Post => Inverse_Sigma0_Count'Result <= High;
=======
with Math_Prime_Util.Int;

--  Divisor arithmetic from MPU 0.75 factor.c and XS.xs.
package Math_Prime_Util.Arith with SPARK_Mode => On is
   use type U64;
   subtype Optional_U64 is Int.Optional_U64;
   subtype I128 is Int.I128;
   use type I128;

   --  factor.c: divisor_sum. Sum of D**K over positive divisors D of N.
   --  K defaults to 1; K = 0 counts divisors. Zero has sum zero.
   --  Undefined if the exact sum exceeds U64'Last. No errors.
   function Divisor_Sum (N : U64; K : U64 := 1) return Optional_U64
     with Pre => True,
          Post => (if N <= 1 then Divisor_Sum'Result.Defined
                   and then Divisor_Sum'Result.Value = N);

   --  factor.c: aliquot_sum. Sum of positive proper divisors, zero at 0/1.
   --  Undefined if the exact sum exceeds U64'Last. No errors.
   function Aliquot_Sum (N : U64) return Optional_U64
     with Pre => True,
          Post => (if N <= 1 then Aliquot_Sum'Result.Defined
                   and then Aliquot_Sum'Result.Value = 0);

   --  XS.xs: abundance. Aliquot sum minus N, in integer units.
   --  Exact signed result, including values below -2**63. No errors.
   function Abundance (N : U64) return I128
     with Pre => True, Post => Abundance'Result >= -I128 (N);

   --  factor.c: sopf. Sum of distinct prime factors; zero at 0/1.
   --  Result is in integer units. No errors.
   function Sopf (N : U64) return U64
     with Pre => True, Post => Sopf'Result <= N;

   --  factor.c: sopfr. Sum of prime factors with multiplicity, zero at 0/1.
   --  Result is in integer units. No errors.
   function Sopfr (N : U64) return U64
     with Pre => True, Post => Sopfr'Result <= N;
>>>>>>> origin/dev-mpuada-001
end Math_Prime_Util.Arith;
