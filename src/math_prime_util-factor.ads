with Ada.Containers.Vectors;

--  Factoring from MPU 0.75 factor.c and the XS wrappers in XS.xs.
--  Native unsigned inputs. Non-numeric Perl arguments are not representable.
package Math_Prime_Util.Factor is
   use type U64;

   --  At most one slot per bit of a native integer.
   Max_Factors : constant := 64;
   type Factor_Values is array (1 .. Max_Factors) of U64;
   type Factor_List is record
      Count : Natural := 0;
      Value : Factor_Values := [others => 0];
   end record;

   package U64_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => U64);

   --  factor.c: factor. Prime factors, ascending, with multiplicity.
   --  Factor (0) is (0). Factor (1) is empty. No errors.
   function Factor (N : U64) return Factor_List
     with Pre => True,
          Post => (if N = 0 then Factor'Result.Count = 1
                   elsif N = 1 then Factor'Result.Count = 0
                   else Factor'Result.Count >= 1);

   --  factor.c: trial_factor, after the XS.xs strip of 2, 3 and 5.
   --  Last = 0 trials through Sqrt (N). The cofactor is kept. No errors.
   function Trial_Factor (N : U64; Last : U64 := 0) return Factor_List
     with Pre => True,
          Post => (if N = 0 then Trial_Factor'Result.Count = 1
                   elsif N = 1 then Trial_Factor'Result.Count = 0
                   else Trial_Factor'Result.Count >= 1);

   --  factor.c: fermat_factor. Rounds is the step budget.
   --  One split, or N when the budget runs out. No errors.
   function Fermat_Factor
     (N : U64; Rounds : U64 := 64_000_000) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Fermat_Factor'Result.Count <= 1
                   else Fermat_Factor'Result.Count >= 1);

   --  factor.c: holf_factor. Rounds is the step budget.
   --  One split, or N when the budget runs out. No errors.
   function Holf_Factor
     (N : U64; Rounds : U64 := 8_000_000) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Holf_Factor'Result.Count <= 1
                   else Holf_Factor'Result.Count >= 1);

   --  factor.c: lehman_factor. Do_Trial is the XS boolean.
   --  One split, or N when Lehman does not apply. No errors.
   function Lehman_Factor
     (N : U64; Do_Trial : Boolean := True) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Lehman_Factor'Result.Count <= 1
                   else Lehman_Factor'Result.Count >= 1);

   --  factor.c: squfof_factor. Rounds is the step budget.
   --  Inputs above 2**62 - 1 return N. No errors.
   function Squfof_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Squfof_Factor'Result.Count <= 1
                   else Squfof_Factor'Result.Count >= 1);

   --  factor.c: prho_factor. Rounds is the step budget.
   --  One split, or N when the budget runs out. No errors.
   function Prho_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Prho_Factor'Result.Count <= 1
                   else Prho_Factor'Result.Count >= 1);

   --  factor.c: pbrent_factor, Montgomery form on x86-64.
   --  A defaults to 1, as in XS.xs when the third argument is omitted.
   --  One split, or N when the budget runs out. No errors.
   function Pbrent_Factor
     (N : U64; Rounds : U64 := 4_000_000; A : U64 := 1)
      return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Pbrent_Factor'Result.Count <= 1
                   else Pbrent_Factor'Result.Count >= 1);

   --  factor.c: pminus1_factor. B2 defaults to 10 * B1 (XS.xs).
   --  One split, or N when no factor is found. No errors.
   function Pminus1_Factor
     (N : U64; B1 : U64 := 1_000_000) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Pminus1_Factor'Result.Count <= 1
                   else Pminus1_Factor'Result.Count >= 1);

   --  factor.c: pminus1_factor with an explicit stage-2 bound.
   --  One split, or N when no factor is found. No errors.
   function Pminus1_Factor (N, B1, B2 : U64) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Pminus1_Factor'Result.Count <= 1
                   else Pminus1_Factor'Result.Count >= 1);

   --  factor.c: pplus1_factor. B1 is the smoothness bound.
   --  One split, or N when no factor is found. No errors.
   function Pplus1_Factor (N : U64; B1 : U64 := 200) return Factor_List
     with Pre => True,
          Post => (if N <= 1 then Pplus1_Factor'Result.Count <= 1
                   else Pplus1_Factor'Result.Count >= 1);

   --  factor.c: divisor_list. Ascending divisors in 1 .. Limit.
   --  Empty when N = 0 or Limit = 0. No errors.
   function Divisors (N, Limit : U64) return U64_Vectors.Vector
     with Pre => True,
          Post => (for all D of Divisors'Result =>
                     D >= 1 and then D <= N);

   --  factor.c: divisor_list with the upper bound equal to N.
   --  Empty when N = 0. Divisors (1) is (1). No errors.
   function Divisors (N : U64) return U64_Vectors.Vector
     with Pre => True,
          Post => (for all D of Divisors'Result =>
                     D >= 1 and then D <= N);

   --  factor.c: tinyecm64_factor; XS.xs: ecm_factor wrapper.
   --  Strip 2, 3, 5, then attempt one ECM split (not full factorization).
   --  Bounds B1/B2 are inclusive prime limits; B2 = 0 means saturated
   --  20 * B1. Curves is capped at the 400 fixed Suyama curves.
   --  Return sorted factors, (0) for zero, an empty list for one, or the
   --  unsplit cofactor on failure. Storage_Error may propagate for bounds
   --  too large to allocate stage-two tables. No randomness or shared state.
   function Ecm_Factor
     (N : U64; B1 : U64 := 4_000; B2 : U64 := 0;
      Curves : U64 := 100) return Factor_List
     with Pre => True,
          Post => Ecm_Factor'Result.Count <= Max_Factors
            and then (if N = 1 then Ecm_Factor'Result.Count = 0
              elsif N = 0 then Ecm_Factor'Result.Count = 1
                and then Ecm_Factor'Result.Value (1) = 0
              else Ecm_Factor'Result.Count > 0
                and then (for all I in 1 .. Ecm_Factor'Result.Count =>
                  Ecm_Factor'Result.Value (I) > 1
                    and then N mod Ecm_Factor'Result.Value (I) = 0));
end Math_Prime_Util.Factor;
