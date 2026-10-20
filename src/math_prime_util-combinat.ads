with Math_Prime_Util.Int;

--  Native combinatorics from MPU 0.75.
package Math_Prime_Util.Combinat with SPARK_Mode => On is
   use type U64;
   use type U128;
   type I128 is range -(2 ** 127) .. 2 ** 127 - 1;
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : I128;
         when False => null;
      end case;
   end record;
   subtype Optional_U64 is Math_Prime_Util.Int.Optional_U64;
   use type Optional_U64;

   --  util.c: factorial. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Factorial (N : U64) return Optional_U64
     with Pre => True,
          Post => Factorial'Result.Defined = (N <= 20);

   --  util.c: subfactorial. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Subfactorial (N : U64) return Optional_U64
     with Pre => True,
          Post => Subfactorial'Result.Defined = (N <= 20);

   --  util.c: multifactorial. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Multifactorial (N, K : U64) return Optional_U64
     with Pre => K > 0,
          Post => (if N = 0 then
                     Multifactorial'Result.Defined);

   --  util.c: binomial. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Binomial (N, K : U64) return Optional_U64
     with Pre => True,
          Post => (if N = 0 and K = 0 then
                     Binomial'Result.Defined);

   --  util.c: catalan_number. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Catalan_Number (N : U64) return Optional_U64
     with Pre => True,
          Post => Catalan_Number'Result.Defined = (N <= 36);

   --  util.c: bell_number. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Bell_Number (N : U64) return Optional_U64
     with Pre => True,
          Post => Bell_Number'Result.Defined = (N <= 25);

   --  util.c: primorial. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Primorial (N : U64) return Optional_U64
     with Pre => True,
          Post => Primorial'Result.Defined = (N <= 52);

   --  util.c: pn_primorial. Exact nonnegative result; undefined on
   --  native overflow. Inputs are unsigned integers.
   function Pn_Primorial (N : U64) return Optional_U64
     with Pre => True,
          Post => Pn_Primorial'Result.Defined = (N <= 15);

   type Optional_Fraction (Defined : Boolean := False) is record
      case Defined is
         when True =>
            Num : I128;
            Den : U128;
         when False => null;
      end case;
   end record;

   --  util.c: harmfrac and _harmonic_split. Reduced harmonic sum
   --  1 + 1/2 + ... + 1/N, with H(0) = 0/1. Undefined past I128/U128.
   function Harmfrac (N : U64) return Optional_Fraction
     with Pre => True,
          Post => (if Harmfrac'Result.Defined then
                     Harmfrac'Result.Num >= 0
                     and Harmfrac'Result.Den > 0);

   --  util.c: falling_factorial and falling_factorial_s. Signed product
   --  of M descending terms. Undefined when the magnitude exceeds U64.
   function Falling_Factorial (N : I128; M : U64) return Optional_I128
     with Pre => N in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (if M = 0 then Falling_Factorial'Result = (True, 1));

   --  util.c: rising_factorial and rising_factorial_s. Signed product
   --  of M ascending terms. Undefined when the magnitude exceeds U64.
   function Rising_Factorial (N : I128; M : U64) return Optional_I128
     with Pre => N in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (if M = 0 then Rising_Factorial'Result = (True, 1));

   --  util.c: consecutive_integer_lcm. LCM of 1 through N, with the
   --  empty product equal to one. Undefined on native overflow.
   function Consecutive_Integer_Lcm (N : U64) return Optional_U64
     with Pre => True,
          Post => Consecutive_Integer_Lcm'Result.Defined = (N <= 46);

   --  util.c: fubini, using factorial(k)*stirling2(n,k). Returns the
   --  ordered Bell number, or undefined on native overflow.
   function Fubini (N : U64) return Optional_U64
     with Pre => True,
          Post => (if N = 0 then Fubini'Result = (True, 1));

   --  util.c: powersum. Sum of the K-th powers of 1 through N.
   --  Undefined on native overflow; the zeroth power is one.
   function Powersum (N, K : U64) return Optional_U64
     with Pre => True,
          Post => (if K = 0 then Powersum'Result = (True, N));

   --  util.c: happy_height. Steps for N to reach 1 under the sum of the
   --  Exp-th powers of its base-Base digits (1 for N = 1); 0 when N is
   --  not happy or a sum overflows.
   function Is_Happy
     (N : U64; Base : U64 := 10; Exp : U64 := 2) return U64
     with Pre => Base >= 2 and Base <= 2 ** 32 - 1 and Exp <= 2 ** 32 - 1,
          Post => (if N = 1 then Is_Happy'Result = 1);

   --  util.c: polygonal_root. True when N is a K-gonal number.
   function Is_Polygonal (N, K : U64) return Boolean
     with Pre => K >= 3,
          Post => (if N <= 1 then Is_Polygonal'Result);

   --  util.c: pillai_v. Smallest V with V! = -1 mod N and N mod V /= 1,
   --  else 0.
   function Is_Pillai (N : U64) return U64
     with Pre => True,
          Post => (if N < 23 then Is_Pillai'Result = 0);

   --  Kind of Stirling number for Stirling.
   subtype Stirling_Kind is Positive range 1 .. 3;

   --  util.c: stirling1 (Kind 1, signed), stirling2 (Kind 2) and
   --  stirling3 (Kind 3, Lah numbers). Undefined past a native U64.
   function Stirling (N, K : U64; Kind : Stirling_Kind := 1)
     return Optional_I128
     with Pre => True,
          Post => (if N = K then Stirling'Result = (True, 1));

   --  util.c: partitions. Number of partitions of N; undefined past U64.
   function Partitions (N : U64) return Optional_U64
     with Pre => True,
          Post => (if N <= 1 then Partitions'Result = (True, 1));

   --  util.c: partitions into distinct parts (partitionsq); undefined
   --  past U64.
   function Partitionsq (N : U64) return Optional_U64
     with Pre => True,
          Post => (if N <= 1 then Partitionsq'Result = (True, 1));

end Math_Prime_Util.Combinat;
