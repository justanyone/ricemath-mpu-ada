package body Math_Prime_Util.Bits with SPARK_Mode => On is
   function Bitand (A, B : U64) return U64 is (A and B);

   function Bitor (A, B : U64) return U64 is (A or B);

   function Bitxor (A, B : U64) return U64 is (A xor B);

   function Bitnot (N : U64) return U64 is (not N);

   function Bitandnot (A, B : U64) return U64 is (A and not B);
end Math_Prime_Util.Bits;
