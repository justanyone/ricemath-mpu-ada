--  Native 64-bit logic for the proposed names in reference/mpu/TODO.
--  MPU 0.75 has no C or Perl implementation of these operations.
package Math_Prime_Util.Bits with SPARK_Mode => On is
   pragma Pure;
   use type U64;

   --  reference/mpu/TODO: bitand(x,y). Native Ada bitwise intersection
   --  of two dimensionless U64 values; all inputs are valid, no errors.
   function Bitand (A, B : U64) return U64
     with Pre => True, Post => Bitand'Result = (A and B);

   --  reference/mpu/TODO: bitor(x,y). Native Ada bitwise union of two
   --  dimensionless U64 values; all inputs are valid, no errors.
   function Bitor (A, B : U64) return U64
     with Pre => True, Post => Bitor'Result = (A or B);

   --  reference/mpu/TODO: bitxor(x,y). Native Ada exclusive union of two
   --  dimensionless U64 values; all inputs are valid, no errors.
   function Bitxor (A, B : U64) return U64
     with Pre => True, Post => Bitxor'Result = (A xor B);

   --  reference/mpu/TODO: bitnot(x,width). Native Ada complement over
   --  all 64 bits of a dimensionless U64; all inputs valid, no errors.
   function Bitnot (N : U64) return U64
     with Pre => True, Post => Bitnot'Result = (not N);

   --  reference/mpu/TODO: bitandnot(x,y). Native Ada intersection of A
   --  with B's 64-bit complement. Dimensionless; all inputs valid, no errors.
   function Bitandnot (A, B : U64) return U64
     with Pre => True, Post => Bitandnot'Result = (A and not B);
end Math_Prime_Util.Bits;
