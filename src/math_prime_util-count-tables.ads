--  Sparse counts translated from MPU 0.75 prime_count_tables.h.
private package Math_Prime_Util.Count.Tables with SPARK_Mode => On is
   --  Return a composite anchor <= N and its exact prime count.
   procedure Lookup (N : U64; Anchor, Value : out U64)
     with Pre => True, Post => Anchor <= N and then Value <= Anchor;
end Math_Prime_Util.Count.Tables;
