with Ada.Numerics.Big_Numbers.Big_Integers;

--  Unbounded tier uses the Ada 2022 runtime, with no crate dependency.
--  Big_Integers supplies the b9 arithmetic backend used by strops.c;
--  this child keeps its signed wrappers and quotient conventions.
--  This checkout carries strint equivalents in strops.c, not strint.c.
package Math_Prime_Util.Digit_Operations.Bigints with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;
   type Digit_Array is array (Positive range <>) of Big_Integer;
   type Division_Result is record
      Quotient, Remainder : Big_Integer;
   end record;

   --  strops.c: strint_abs; exact signed arithmetic.
   function Absint
     (A : Big_Integer) return Big_Integer
     with Pre => True, Post => Absint'Result = abs A;

   --  strops.c: strint_neg; exact signed arithmetic.
   function Negint
     (A : Big_Integer) return Big_Integer
     with Pre => True, Post => Negint'Result = -A;

   --  strops.c: strint_cmp; exact signed arithmetic.
   function Signint
     (A : Big_Integer) return Integer
     with Pre => True, Post => Signint'Result in -1 .. 1;

   --  strops.c: strint_add_s; exact signed arithmetic.
   function Add1int
     (A : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_add_s; exact signed arithmetic.
   function Sub1int
     (A : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_muladd_s; exact signed arithmetic.
   function Muladdint
     (A, B, C : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_muladd_s; exact signed arithmetic.
   function Mulsubint
     (A, B, C : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_cmp; exact signed arithmetic.
   function Cmpint
     (A, B : Big_Integer) return Integer
     with Pre => True, Post => Cmpint'Result in -1 .. 1;

   --  strops.c: strint_add_s; exact signed arithmetic.
   function Addint
     (A, B : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_add_s; exact signed arithmetic.
   function Subint
     (A, B : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_mul; exact signed arithmetic.
   function Mulint
     (A, B : Big_Integer) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_divint; exact signed arithmetic.
   function Divint
     (A, B : Big_Integer) return Big_Integer
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_modint; exact signed arithmetic.
   function Modint
     (A, B : Big_Integer) return Big_Integer
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_cdivint; exact signed arithmetic.
   function Cdivint
     (A, B : Big_Integer) return Big_Integer
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_fdivrem; exact signed arithmetic.
   function Divrem
     (A, B : Big_Integer) return Division_Result
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_fdivrem; exact signed arithmetic.
   function Tdivrem
     (A, B : Big_Integer) return Division_Result
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_fdivrem; exact signed arithmetic.
   function Fdivrem
     (A, B : Big_Integer) return Division_Result
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_fdivrem; exact signed arithmetic.
   function Cdivrem
     (A, B : Big_Integer) return Division_Result
     with Pre => B /= 0, Post => True;

   --  strops.c: strint_lshiftint; signed power-of-two shift.
   function Lshiftint
     (A : Big_Integer; Bits : Integer := 1) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_rshiftint; signed power-of-two shift.
   function Rshiftint
     (A : Big_Integer; Bits : Integer := 1) return Big_Integer
     with Pre => True, Post => True;

   --  strops.c: strint_rashiftint; signed power-of-two shift.
   function Rashiftint
     (A : Big_Integer; Bits : Integer := 1) return Big_Integer
     with Pre => True, Post => True;

   --  XS.xs: toint; parse and truncate; invalid text raises Constraint_Error.
   function Toint
     (Text : String) return Big_Integer
     with Pre => True, Post => True;

   --  XS.xs: is_odd; test parity.
   function Is_Odd
     (A : Big_Integer) return Boolean
     with Pre => True, Post => Is_Odd'Result = (A rem 2 /= 0);

   --  XS.xs: is_even; test parity.
   function Is_Even
     (A : Big_Integer) return Boolean
     with Pre => True, Post => Is_Even'Result = (A rem 2 = 0);

   --  XS.xs: is_divisible; only zero is divisible by zero.
   function Is_Divisible
     (A, B : Big_Integer) return Boolean
     with Pre => True, Post => True;

   --  XS.xs: is_congruent; zero modulus tests equality.
   function Is_Congruent
     (A, B, Modulus : Big_Integer) return Boolean
     with Pre => True, Post => True;

   --  util.c: to_digit_array; most significant digit first.
   function Todigits
     (N : Big_Integer; Base : Big_Integer := 10;
      Length : Integer := -1) return Digit_Array
     with Pre => Base >= 2 and Length in -1 .. 128, Post => True;

   --  util.c: to_digit_string; lowercase, padded or truncated.
   function Todigitstring
     (N : Big_Integer; Base : Big_Integer := 10;
      Length : Integer := -1) return String
     with Pre => Base >= 2 and Base <= 36 and Length in -1 .. 128,
          Post => True;

   --  strops.c: strint_fromdigitstring, b9_from_little_digits.
   --  Invalid digits raise Constraint_Error; bases above 36 are permitted.
   function Fromdigits
     (Text : String; Base : Big_Integer := 10) return Big_Integer
     with Pre => Base >= 2, Post => True;

   --  XS.xs: sumdigits; base digit operation.
   function Sumdigits
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
     with Pre => Base >= 2, Post => True;

   --  strops.c: strint_reverse_digits; base digit operation.
   function Reverse_Digits
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
     with Pre => Base >= 2, Post => True;

   --  XS.xs: is_palindrome; base digit operation.
   function Is_Palindrome
     (N : Big_Integer; Base : Big_Integer := 10) return Boolean
     with Pre => N >= 0 and Base >= 2, Post => True;

   --  XS.xs: is_harshad; base digit operation.
   function Is_Harshad
     (N : Big_Integer; Base : Big_Integer := 10) return Boolean
     with Pre => Base >= 2, Post => True;

   --  XS.xs: digital_root; base digit operation.
   function Digital_Root
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
     with Pre => N >= 0 and Base >= 2, Post => True;

   --  XS.xs: mult_digital_root; base digit operation.
   function Mult_Digital_Root
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
     with Pre => N >= 0 and Base >= 2, Post => True;

   --  util.h: popcnt; count bits of the magnitude.
   function Hammingweight
     (N : Big_Integer) return Natural
     with Pre => True, Post => True;

   --  util.c: to_zeckendorf; greedy Fibonacci representation.
   function Tozeckendorf
     (N : Big_Integer) return String
     with Pre => N >= 0, Post => True;

   --  util.c: from_zeckendorf; invalid representation raises Constraint_Error.
   function Fromzeckendorf
     (Text : String) return Big_Integer
     with Pre => True, Post => True;
end Math_Prime_Util.Digit_Operations.Bigints;
