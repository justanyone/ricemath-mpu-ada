--  MPU 0.75 prime_count_tables.h: NSTEP_SEARCH and APPLY_TABLES.
--  Immutable sparse count tables. No shared mutable state.
private package Math_Prime_Util.Count_Tables is
   use type U64;
   --  Largest tabulated boundary <= N and its exact prime count.
   procedure Lookup (N : U64; Base, Total : out U64)
     with Pre => True, Post => Base <= N and then Total <= Base;
end Math_Prime_Util.Count_Tables;
