with Ada.Containers.Vectors;

--  Factoring from MPU 0.75 factor.c and the XS.xs method wrappers.
--  Results are prime factors or one split, in the order MPU returns.
package Math_Prime_Util.Factor is
   use type U64;
   package Factor_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => U64);

   --  factor.c: factor. Complete factorization in ascending order.
   --  N = 0 yields (0). N = 1 yields an empty list. No errors.
   function Factor (N : U64) return Factor_Vectors.Vector
     with Post => (if N = 1 then Factor'Result.Is_Empty);

   --  factor.c: trial_factor, after the XS.xs 2/3/5 strip.
   --  Last is the largest prime to try. Last = 0 tries every prime.
   --  N = 0 yields (0). N = 1 yields an empty list. No errors.
   function Trial_Factor
     (N : U64; Last : U64 := 0) return Factor_Vectors.Vector
     with Post => (if N = 1 then Trial_Factor'Result.Is_Empty);

   --  factor.c: fermat_factor, after the XS.xs 2/3/5 strip.
   --  Rounds is the search limit. The default is the XS value.
   --  N = 0 yields (0). N = 1 yields an empty list. No errors.
   function Fermat_Factor
     (N : U64; Rounds : U64 := 64_000_000)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Fermat_Factor'Result.Is_Empty);

   --  factor.c: holf_factor, after the XS.xs 2/3/5 strip.
   --  Rounds is the search limit. The default is the XS value.
   --  N = 0 yields (0). N = 1 yields an empty list. No errors.
   function Holf_Factor
     (N : U64; Rounds : U64 := 8_000_000)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Holf_Factor'Result.Is_Empty);

   --  factor.c: squfof_factor, after the XS.xs 2/3/5 strip.
   --  Rounds is the search limit. The default is the XS value.
   --  Inputs above 2^62-1 stay unsplit. N = 1 yields an empty list.
   function Squfof_Factor
     (N : U64; Rounds : U64 := 4_000_000)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Squfof_Factor'Result.Is_Empty);

   --  factor.c: lehman_factor, after the XS.xs 2/3/5 strip.
   --  Do_Trial runs the initial prime scan. The default is the XS value.
   --  N = 0 yields (0). N = 1 yields an empty list. No errors.
   function Lehman_Factor
     (N : U64; Do_Trial : Boolean := True)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Lehman_Factor'Result.Is_Empty);

   --  factor.c: prho_factor, after the XS.xs 2/3/5 strip.
   --  Rounds is the search limit. The default is the XS value.
   --  A later XS argument is ignored, matching XS.xs. No errors.
   function Prho_Factor
     (N : U64; Rounds : U64 := 4_000_000)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Prho_Factor'Result.Is_Empty);

   --  factor.c: pbrent_factor, Montgomery form, after the XS strip.
   --  Rounds is the search limit and A is the polynomial constant.
   --  Defaults match XS.xs. N = 1 yields an empty list. No errors.
   function Pbrent_Factor
     (N : U64; Rounds : U64 := 4_000_000; A : U64 := 1)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Pbrent_Factor'Result.Is_Empty);

   --  factor.c: pminus1_factor, after the XS.xs 2/3/5 strip.
   --  B1 and B2 are the stage bounds. B2 = 0 selects 10 * B1,
   --  which is the XS default when the third argument is omitted.
   --  N = 1 yields an empty list. No errors.
   function Pminus1_Factor
     (N : U64; B1 : U64 := 1_000_000; B2 : U64 := 0)
      return Factor_Vectors.Vector
     with Post => (if N = 1 then Pminus1_Factor'Result.Is_Empty);

   --  factor.c: pplus1_factor, after the XS.xs 2/3/5 strip.
   --  B1 is the prime bound. The default is the XS value.
   --  N = 1 yields an empty list. No errors.
   function Pplus1_Factor
     (N : U64; B1 : U64 := 200) return Factor_Vectors.Vector
     with Post => (if N = 1 then Pplus1_Factor'Result.Is_Empty);

   --  factor.c: divisor_list. Ascending divisors that are <= Max_Divisor.
   --  The default bound is N. N = 0 or Max_Divisor = 0 yields an empty
   --  list, which MPU prints as undef. No errors.
   function Divisors
     (N : U64; Max_Divisor : U64 := U64'Last)
      return Factor_Vectors.Vector
     with Post => (if N = 0 or else Max_Divisor = 0
                   then Divisors'Result.Is_Empty);
end Math_Prime_Util.Factor;
