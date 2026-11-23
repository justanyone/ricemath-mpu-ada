with Ada.Containers.Vectors;

--  Factoring from MPU 0.75 factor.c (trial, rho, Brent, p-1, p+1,
--  SQUFOF, HOLF, Lehman, Fermat, factor, and divisors).
--  Arguments are native unsigned values. A list is empty when MPU
--  returns no values. Algorithm routines peel every factor 2, 3 and 5
--  before the named method, matching the Perl wrapper in XS.xs.
package Math_Prime_Util.Factor is
   use type U64;
   package Factor_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => U64);
   subtype Factor_Vector is Factor_Vectors.Vector;

   --  factor.c: factor. Prime factors with multiplicity, ascending.
   --  Units are the integer N. N = 0 yields 0; N = 1 yields empty.
   --  No error cases on the native range.
   function Factor (N : U64) return Factor_Vector
     with Pre => True,
          Post => (if N = 1 then Factor'Result.Is_Empty
                   else not Factor'Result.Is_Empty);

   --  factor.c: trial_factor. Limit 0 runs to completion.
   --  Factors 2, 3 and 5 are removed even below a tight Limit.
   --  A cofactor above Limit is left whole. No error cases.
   function Trial_Factor
     (N : U64; Limit : U64 := 0) return Factor_Vector
     with Pre => True, Post => not Trial_Factor'Result.Is_Empty;

   --  factor.c: fermat_factor. Rounds is the iteration budget.
   --  The default matches XS.xs. No split returns N. No error cases.
   function Fermat_Factor
     (N : U64; Rounds : U64 := 64_000_000) return Factor_Vector
     with Pre => True, Post => not Fermat_Factor'Result.Is_Empty;

   --  factor.c: holf_factor. Rounds is the iteration budget.
   --  The default matches XS.xs. No split returns N. No error cases.
   function Holf_Factor
     (N : U64; Rounds : U64 := 8_000_000) return Factor_Vector
     with Pre => True, Post => not Holf_Factor'Result.Is_Empty;

   --  factor.c: squfof_factor. Rounds is the iteration budget.
   --  The default matches XS.xs. No split returns N. No error cases.
   function Squfof_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_Vector
     with Pre => True, Post => not Squfof_Factor'Result.Is_Empty;

   --  factor.c: lehman_factor. A non-zero flag trials small primes.
   --  The default matches XS.xs (trial on). No split returns N.
   function Lehman_Factor
     (N : U64; Do_Trial : U64 := 1) return Factor_Vector
     with Pre => True, Post => not Lehman_Factor'Result.Is_Empty;

   --  factor.c: prho_factor. Rounds is the iteration budget.
   --  The default matches XS.xs. No split returns N. No error cases.
   function Prho_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_Vector
     with Pre => True, Post => not Prho_Factor'Result.Is_Empty;

   --  factor.c: pbrent_factor. Rounds is the budget and A is the
   --  polynomial constant. Omitted A is 1, matching XS.xs.
   function Pbrent_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_Vector
     with Pre => True, Post => not Pbrent_Factor'Result.Is_Empty;

   --  factor.c: pbrent_factor with an explicit polynomial constant.
   function Pbrent_Factor (N, Rounds, A : U64) return Factor_Vector
     with Pre => True, Post => not Pbrent_Factor'Result.Is_Empty;

   --  factor.c: pminus1_factor. B2 defaults to 10*B1, matching XS.xs.
   function Pminus1_Factor
     (N : U64; B1 : U64 := 1_000_000) return Factor_Vector
     with Pre => True, Post => not Pminus1_Factor'Result.Is_Empty;

   --  factor.c: pminus1_factor with an explicit stage-2 bound.
   function Pminus1_Factor (N, B1, B2 : U64) return Factor_Vector
     with Pre => True, Post => not Pminus1_Factor'Result.Is_Empty;

   --  factor.c: pplus1_factor. B is the smoothness bound.
   --  The default matches XS.xs. No split returns N. No error cases.
   function Pplus1_Factor
     (N : U64; B : U64 := 200) return Factor_Vector
     with Pre => True, Post => not Pplus1_Factor'Result.Is_Empty;

   --  factor.c: divisor_list. Divisors of N that are <= Limit,
   --  ascending. Limit above N lists every divisor. N = 0 or
   --  Limit = 0 yields an empty list. No error cases.
   function Divisors
     (N : U64; Limit : U64 := U64'Last) return Factor_Vector
     with Pre => True,
          Post => (for all D of Divisors'Result => D <= N);
end Math_Prime_Util.Factor;
