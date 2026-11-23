with Ada.Containers.Vectors;

--  Native factoring from Math::Prime::Util 0.75 factor.c and the XS
--  wrappers in XS.xs. Lists use multiplicity. An empty list is the MPU
--  undef result (factor of 1, divisors of 0).
package Math_Prime_Util.Factor is
   use type U64;
   package Factor_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => U64);

   --  factor.c: factor. Ascending prime factors with multiplicity.
   --  Factor (0) is 0. Factor (1) is empty. No other errors.
   function Factor (N : U64) return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Factor'Result.Length = 1
                   elsif N = 1 then Factor'Result.Is_Empty);

   --  factor.c: trial_factor, after the XS strip of 2, 3 and 5.
   --  Last 0 trials through the square root. The cofactor is kept when
   --  the limit stops early. N = 0 yields 0; N = 1 is empty.
   function Trial_Factor (N : U64; Last : U64 := 0)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Trial_Factor'Result.Length = 1
                   elsif N = 1 then Trial_Factor'Result.Is_Empty);

   --  factor.c: fermat_factor. Rounds is the Fermat search bound.
   --  Default 64000000 matches XS.xs. One split; cofactors may be
   --  composite. N = 0 yields 0; N = 1 is empty.
   function Fermat_Factor (N : U64; Rounds : U64 := 64_000_000)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Fermat_Factor'Result.Length = 1
                   elsif N = 1 then Fermat_Factor'Result.Is_Empty);

   --  factor.c: holf_factor. Rounds limits both HOLF passes.
   --  Default 8000000 matches XS.xs. N = 0 yields 0; N = 1 is empty.
   function Holf_Factor (N : U64; Rounds : U64 := 8_000_000)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Holf_Factor'Result.Length = 1
                   elsif N = 1 then Holf_Factor'Result.Is_Empty);

   --  factor.c: squfof_factor. Rounds is the shared race budget.
   --  Default 4000000 matches XS.xs. Inputs above 2^62-1 are not split.
   --  N = 0 yields 0; N = 1 is empty.
   function Squfof_Factor (N : U64; Rounds : U64 := 4_000_000)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Squfof_Factor'Result.Length = 1
                   elsif N = 1 then Squfof_Factor'Result.Is_Empty);

   --  factor.c: lehman_factor. Trial is the C do_trial flag: zero skips
   --  the trial passes. Default 1 matches XS.xs. N = 0 yields 0; N = 1
   --  is empty.
   function Lehman_Factor (N : U64; Trial : U64 := 1)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Lehman_Factor'Result.Length = 1
                   elsif N = 1 then Lehman_Factor'Result.Is_Empty);

   --  factor.c: prho_factor. Rounds is the iteration budget.
   --  Default 4000000 matches XS.xs. A third XS argument is ignored.
   --  N = 0 yields 0; N = 1 is empty.
   function Prho_Factor (N : U64; Rounds : U64 := 4_000_000)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Prho_Factor'Result.Length = 1
                   elsif N = 1 then Prho_Factor'Result.Is_Empty);

   --  factor.c: pbrent_factor, portable arithmetic path.
   --  Rounds and the polynomial constant A match XS.xs (A defaults to 1,
   --  rounds to 4000000). N = 0 yields 0; N = 1 is empty.
   function Pbrent_Factor
     (N : U64; Rounds : U64 := 4_000_000; A : U64 := 1)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Pbrent_Factor'Result.Length = 1
                   elsif N = 1 then Pbrent_Factor'Result.Is_Empty);

   --  factor.c: pminus1_factor. B2 = 0 means 10*B1, the XS default when
   --  the third argument is omitted. B1 defaults to 1000000.
   --  N = 0 yields 0; N = 1 is empty.
   function Pminus1_Factor
     (N : U64; B1 : U64 := 1_000_000; B2 : U64 := 0)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Pminus1_Factor'Result.Length = 1
                   elsif N = 1 then Pminus1_Factor'Result.Is_Empty);

   --  factor.c: pplus1_factor. B1 is the smoothness bound.
   --  Default 200 matches XS.xs. N = 0 yields 0; N = 1 is empty.
   function Pplus1_Factor (N : U64; B1 : U64 := 200)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 then Pplus1_Factor'Result.Length = 1
                   elsif N = 1 then Pplus1_Factor'Result.Is_Empty);

   --  factor.c: divisor_list. Divisors of N that are at most Max_D, in
   --  ascending order. Max_D above N is clamped to N. N = 0 or Max_D = 0
   --  is empty. N = 1 is the list 1.
   function Divisors (N : U64; Max_D : U64 := U64'Last)
      return Factor_Vectors.Vector
     with Pre => True,
          Post => (if N = 0 or else Max_D = 0
                   then Divisors'Result.Is_Empty
                   elsif N = 1 then Divisors'Result.Length = 1);
end Math_Prime_Util.Factor;
