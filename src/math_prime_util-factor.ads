--  Native factoring operations translated from MPU 0.75 factor.c.
package Math_Prime_Util.Factor with SPARK_Mode => On is
   use type U64;
   type Factor_List is array (Positive range <>) of U64;

   --  Prime factors in ascending order, with multiplicity; 0 gives [0],
   --  1 gives an empty list. Constraint_Error if splitting is exhausted.
   function Factor (N : U64) return Factor_List
     with Pre => True, Post => Factor'Result'Length <= 64;

   --  Remove 2, 3, 5, then trial through Max_Factor (0 is unlimited), with
   --  the remaining cofactor. Integer units; no invalid inputs.
   function Trial_Factor (N : U64; Max_Factor : U64 := 0)
      return Factor_List
     with Pre => True, Post => Trial_Factor'Result'Length <= 64;

   --  Pollard-Brent splitting after removing 2, 3 and 5. Rounds counts
   --  polynomial evaluations; A is its additive constant. No split leaves
   --  the cofactor unchanged; factors need not be prime. No errors.
   function Pbrent_Factor
     (N : U64; Rounds : U64 := 1_000_000; A : U64 := 1)
      return Factor_List
     with Pre => True, Post => Pbrent_Factor'Result'Length <= 64;

   --  Pollard rho splitting; Rounds counts Floyd iterations, rounded up
   --  to a block of 64. Unsplit cofactors are returned; no errors.
   function Prho_Factor (N : U64; Rounds : U64 := 1_000_000)
      return Factor_List
     with Pre => True, Post => Prho_Factor'Result'Length <= 64;

   --  Fermat difference of squares after removing 2, 3 and 5. Rounds
   --  bounds successive squares; failure returns the cofactor. No errors.
   function Fermat_Factor (N : U64; Rounds : U64 := 1_000_000)
      return Factor_List
     with Pre => True, Post => Fermat_Factor'Result'Length <= 64;

   --  Positive divisors in ascending order, at most Max_Divisor.
   --  Zero N or limit gives an empty list. Factor's errors propagate.
   function Divisors (N : U64; Max_Divisor : U64 := U64'Last)
      return Factor_List
     with Pre => True,
          Post => (for all D of Divisors'Result =>
                     D > 0 and then D <= Max_Divisor and then N mod D = 0);
end Math_Prime_Util.Factor;
