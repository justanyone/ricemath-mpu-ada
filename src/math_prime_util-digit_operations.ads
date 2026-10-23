with Math_Prime_Util.Int;

--  Digit conversion and checked integer operations from MPU 0.75.
package Math_Prime_Util.Digit_Operations with SPARK_Mode => On is
   use type U128;
   subtype I128 is Math_Prime_Util.Int.I128;
   use type I128;
   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : I128;
         when False => null;
      end case;
   end record;
   type Digit_Array is array (Positive range <>) of U128;
   type Division_Result is record
      Defined : Boolean := False;
      Quotient, Remainder : I128 := 0;
   end record;

   --  util.c: to_digit_array. Most significant digit first; zero is empty.
   function Todigits
     (N : U128; Base : U128 := 10; Length : Integer := -1) return Digit_Array
     with Pre => Base >= 2 and Length in -1 .. 128,
          Post => Todigits'Result'Length <= 128;

   --  util.c: to_digit_string. Lowercase digits, padded or truncated.
   function Todigitstring
     (N : U128; Base : U128 := 10; Length : Integer := -1) return String
     with Pre => Base in 2 .. 36 and Length in -1 .. 128,
          Post => Todigitstring'Result'Length <= 128;

   --  util.c: from_digit_to_UV. Invalid digits or overflow raise
   --  Constraint_Error.
   function Fromdigits
     (Text : String; Base : U128 := 10) return U128
     with Pre => Base >= 2,
          Post => True;

   --  XS.xs: sumdigits. Sum the base digits.
   function Sumdigits
     (N : U128; Base : U128 := 10) return U128
     with Pre => Base >= 2,
          Post => Sumdigits'Result <= N;

   --  XS.xs: sumdigits. Sum valid text digits; ignore signs and punctuation.
   function Sumdigits (Text : String; Base : U128 := 10) return U128
     with Pre => Base in 2 .. 36, Post => True;

   --  XS.xs: reverse_digits. Reverse base digits; overflow raises
   --  Constraint_Error.
   function Reverse_Digits
     (N : U128; Base : U128 := 10) return U128
     with Pre => Base >= 2,
          Post => True;

   --  XS.xs: is_palindrome. Test digit symmetry.
   function Is_Palindrome
     (N : U128; Base : U128 := 10) return Boolean
     with Pre => Base >= 2,
          Post => True;

   --  XS.xs: is_harshad. Test divisibility by the digit sum; zero is false.
   function Is_Harshad
     (N : U128; Base : U128 := 10) return Boolean
     with Pre => Base >= 2,
          Post => (if N = 0 then not Is_Harshad'Result);

   --  XS.xs: digital_root. Iterate digit sums.
   function Digital_Root
     (N : U128; Base : U128 := 10) return U128
     with Pre => Base >= 2,
          Post => Digital_Root'Result < Base;

   --  XS.xs: mult_digital_root. Iterate digit products.
   function Mult_Digital_Root
     (N : U128; Base : U128 := 10) return U128
     with Pre => Base >= 2,
          Post => Mult_Digital_Root'Result < Base;

   --  util.c: to_zeckendorf. Greedy Fibonacci representation.
   function Tozeckendorf
     (N : U64) return String
     with Pre => True,
          Post => Tozeckendorf'Result'Length in 1 .. 92;

   --  util.c: validate_zeckendorf, from_zeckendorf. Invalid text raises
   --  Constraint_Error.
   function Fromzeckendorf
     (Text : String) return U64
     with Pre => Text'Length in 1 .. 92,
          Post => True;

   --  util.h: popcnt. Count the set bits.
   function Hammingweight
     (N : U128) return Natural
     with Pre => True,
          Post => Hammingweight'Result <= 128;

   --  strops.c: strint_abs.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Absint (A : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_neg.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Negint (A : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_add_s.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Add1int (A : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_add_s.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Sub1int (A : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_add_s.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Addint (A, B : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_add_s.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Subint (A, B : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_mul.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Mulint (A, B : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_muladd_s.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Muladdint (A, B, C : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_muladd_s.
   --  Exact signed arithmetic; undefined on signed 128-bit overflow.
   function Mulsubint (A, B, C : I128) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_cmp. Return the sign.
   function Signint
     (A : I128) return Integer
     with Pre => True, Post => Signint'Result in -1 .. 1;

   --  strops.c: strint_cmp. Compare two integers.
   function Cmpint
     (A, B : I128) return Integer
     with Pre => True, Post => Cmpint'Result in -1 .. 1;

   --  strops.c: strint_fdivrem. Quotient and remainder; undefined
   --  for zero divisor or overflow.
   function Divrem
     (A, B : I128) return Division_Result
     with Pre => True, Post => (if B = 0 then not Divrem'Result.Defined);

   --  strops.c: strint_fdivrem. Quotient and remainder; undefined
   --  for zero divisor or overflow.
   function Tdivrem
     (A, B : I128) return Division_Result
     with Pre => True, Post => (if B = 0 then not Tdivrem'Result.Defined);

   --  strops.c: strint_fdivrem. Quotient and remainder; undefined
   --  for zero divisor or overflow.
   function Fdivrem
     (A, B : I128) return Division_Result
     with Pre => True, Post => (if B = 0 then not Fdivrem'Result.Defined);

   --  strops.c: strint_fdivrem. Quotient and remainder; undefined
   --  for zero divisor or overflow.
   function Cdivrem
     (A, B : I128) return Division_Result
     with Pre => True, Post => (if B = 0 then not Cdivrem'Result.Defined);

   --  strops.c: strint_divint. Checked division; undefined for
   --  zero divisor or overflow.
   function Divint
     (A, B : I128) return Optional_I128
     with Pre => True, Post => (if B = 0 then not Divint'Result.Defined);

   --  strops.c: strint_modint. Checked division; undefined for
   --  zero divisor or overflow.
   function Modint
     (A, B : I128) return Optional_I128
     with Pre => True, Post => (if B = 0 then not Modint'Result.Defined);

   --  strops.c: strint_cdivint. Checked division; undefined for
   --  zero divisor or overflow.
   function Cdivint
     (A, B : I128) return Optional_I128
     with Pre => True, Post => (if B = 0 then not Cdivint'Result.Defined);

   --  strops.c: strint_lshiftint. Shift magnitude; undefined on
   --  overflow.
   function Lshiftint
     (A : I128; Bits : Integer := 1) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_rshiftint. Shift magnitude; undefined on
   --  overflow.
   function Rshiftint
     (A : I128; Bits : Integer := 1) return Optional_I128
     with Pre => True, Post => True;

   --  strops.c: strint_rashiftint. Shift magnitude; undefined on
   --  overflow.
   function Rashiftint
     (A : I128; Bits : Integer := 1) return Optional_I128
     with Pre => True, Post => True;

   --  XS.xs: toint. Parse numeric text; truncate
   --  fractions; undefined on overflow.
   function Toint
     (Text : String) return Optional_I128
     with Pre => True, Post => True;

   --  XS.xs: is_odd. Test odd parity.
   function Is_Odd
     (A : I128) return Boolean
     with Pre => True, Post => Is_Odd'Result = (A rem 2 /= 0);

   --  XS.xs: is_even. Test even parity.
   function Is_Even
     (A : I128) return Boolean
     with Pre => True, Post => Is_Even'Result = (A rem 2 = 0);

   --  XS.xs: is_divisible. Test exact division; only
   --  zero is divisible by zero.
   function Is_Divisible
     (A, B : I128) return Boolean
     with Pre => True, Post => True;

   --  XS.xs: is_congruent. Test equal residues; modulus
   --  zero tests equality.
   function Is_Congruent
     (A, B, Modulus : I128) return Boolean
     with Pre => True, Post => True;

end Math_Prime_Util.Digit_Operations;
