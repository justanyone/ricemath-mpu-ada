--  Native filtered ranges from MPU 0.75 XS.xs. Inclusive bounds, ascending
--  callbacks, independent contexts. Lastfor stops after the callback returns.
--  Callback exceptions and allocation Storage_Error propagate to the caller.
package Math_Prime_Util.Iter.Ranges with SPARK_Mode => On is
   --  XS.xs: foroddcomposites. Visit odd composites >= 9. No domain errors.
   procedure Foroddcomposites
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: foroddcomposites, default lower bound 9. Same errors as above.
   procedure Foroddcomposites
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forsemiprimes. Visit products of two primes, with multiplicity.
   --  Reversed ranges are empty. No domain errors.
   procedure Forsemiprimes
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forsemiprimes, default lower bound 4. Same errors as above.
   procedure Forsemiprimes
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: foralmostprimes. Visit integers with K prime factors counted
   --  with multiplicity. K = 0 or K >= 64 gives no visits (XS semantics).
   --  Reversed ranges are empty. No domain errors.
   procedure Foralmostprimes
     (K : Natural; Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: foralmostprimes, default lower bound 1. Same errors as above.
   procedure Foralmostprimes
     (K : Natural; High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forsquarefree; factor.c: factor_range_next. Visit square-free
   --  positive integers with sorted prime factors; one has no factors.
   --  Zero is omitted and reversed ranges are empty. No domain errors.
   procedure Forsquarefree
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forsquarefree, default lower bound 1. Same errors as above.
   procedure Forsquarefree
     (High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forsquarefreeint; util.c: range_issquarefree. Visit square-free
   --  positive integers without factors. Zero and reversed ranges are empty.
   --  No domain errors.
   procedure Forsquarefreeint
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forsquarefreeint, default lower bound 1. Same errors as above.
   procedure Forsquarefreeint
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: fordivisors; factor.c: divisor_list. Visit divisors of N in
   --  ascending order. N = 0 gives no visits. No domain errors.
   procedure Fordivisors
     (N : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;
end Math_Prime_Util.Iter.Ranges;
