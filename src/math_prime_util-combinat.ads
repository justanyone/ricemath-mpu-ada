with Math_Prime_Util.Int;

--  Native combinatorics from MPU 0.75.
package Math_Prime_Util.Combinat with SPARK_Mode => On is
   use type U64;
   subtype Optional_U64 is Math_Prime_Util.Int.Optional_U64;

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

end Math_Prime_Util.Combinat;
