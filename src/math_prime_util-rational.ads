with Math_Prime_Util.Int;

--  Native rational arithmetic translated from MPU 0.75 rational.c.
package Math_Prime_Util.Rational with SPARK_Mode => On is
   use type U64;
   subtype I128 is Math_Prime_Util.Int.I128;
   use type I128;
   type Coefficients is array (Positive range <>) of I128;
   type Fraction is record
      Num : I128 := 0;
      Den : U64 := 1;
      Defined : Boolean := True;
   end record;
   type Fraction_Array is array (Positive range <>) of Fraction;

   --  rational.c: contfrac. Euclidean quotients; Den must be positive.
   function Contfrac (Num : I128; Den : U64) return Coefficients
     with Pre => Den > 0 and Num in -I128 (U64'Last) .. I128 (U64'Last),
          Post => Contfrac'Result'Length in 1 .. 128;

   --  rational.c: convergents. Empty input denotes zero; overflow undefined.
   function Convergents (Terms : Coefficients) return Fraction_Array
     with Pre => Terms'Length <= 128,
          Post => Convergents'Result'Length = Terms'Length;

   --  rational.c: convergents (last pair). Zero tail terms are undefined.
   function From_Contfrac (Terms : Coefficients) return Fraction
     with Pre => Terms'Length <= 128,
          Post => (if From_Contfrac'Result.Defined then
                     From_Contfrac'Result.Den > 0);

   --  rational.c: bestrational. Magnitude approximation, bound in units.
   --  A negative input gives a negative numerator; failure is undefined.
   function Bestrational (X : Long_Long_Float; Bound : U64) return Fraction
     with Pre => True,
          Post => (if Bestrational'Result.Defined then
                     Bestrational'Result.Den in 1 .. Bound);

   --  rational.c: next_calkin_wilf. Reduced positive input.
   --  Native overflow returns undefined.
   function Next_Calkin_Wilf (Num, Den : U64) return Fraction
     with Pre => True,
          Post => (if Next_Calkin_Wilf'Result.Defined then
                     Next_Calkin_Wilf'Result.Den > 0);

   --  rational.c: next_stern_brocot. Reduced positive input.
   --  Native overflow returns undefined.
   function Next_Stern_Brocot (Num, Den : U64) return Fraction
     with Pre => True,
          Post => (if Next_Stern_Brocot'Result.Defined then
                     Next_Stern_Brocot'Result.Den > 0);

   --  rational.c: calkin_wilf_n. Zero denotes native index overflow.
   function Calkin_Wilf_N (Num, Den : U64) return U64
     with Pre => Num > 0 and then Den > 0
       and then Math_Prime_Util.Int.Gcd (Num, Den) = 1,
          Post => (if Num = Den then Calkin_Wilf_N'Result = 1);

   --  rational.c: stern_brocot_n. Zero denotes native index overflow.
   function Stern_Brocot_N (Num, Den : U64) return U64
     with Pre => Num > 0 and then Den > 0
       and then Math_Prime_Util.Int.Gcd (Num, Den) = 1,
          Post => (if Num = Den then Stern_Brocot_N'Result = 1);

   --  rational.c: nth_calkin_wilf. One-based breadth-first tree index.
   function Nth_Calkin_Wilf (N : U64) return Fraction
     with Pre => N > 0,
          Post => Nth_Calkin_Wilf'Result.Defined
       and Nth_Calkin_Wilf'Result.Den > 0;

   --  rational.c: nth_stern_brocot. One-based breadth-first tree index.
   function Nth_Stern_Brocot (N : U64) return Fraction
     with Pre => N > 0,
          Post => Nth_Stern_Brocot'Result.Defined
       and Nth_Stern_Brocot'Result.Den > 0;

   --  rational.c: nth_stern_diatomic. Stern sequence at zero-based index.
   function Nth_Stern_Diatomic (N : U64) return U64
     with Pre => True, Post => Nth_Stern_Diatomic'Result <= N;

   --  rational.c: farey_array. Ordered fractions in [0,1], order N.
   function Farey (N : Positive) return Fraction_Array
     with Pre => N <= 1_000_000,
          Post => Farey'Result'Length >= 2;

   --  rational.c: next_farey. Undefined at or beyond one, or outside F_N.
   function Next_Farey (N, Num, Den : U64) return Fraction
     with Pre => N <= 2 ** 32 - 1 and Num <= 2 ** 32 - 1
       and Den <= 2 ** 32 - 1,
          Post => (if Next_Farey'Result.Defined then
                     Next_Farey'Result.Den in 1 .. N);

   --  rational.c: farey_rank. Number of members strictly below Num/Den.
   function Farey_Rank (N : Natural; Num, Den : U64) return U64
     with Pre => N <= 1_000_000 and Num <= 2 ** 32 - 1
       and Den <= 2 ** 32 - 1,
          Post => (if Num = 0 or Den = 0 then Farey_Rank'Result = 0);
end Math_Prime_Util.Rational;
