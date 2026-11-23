--  prime_count_tables.h. Sparse pi steps for segment_prime_count.
private package Math_Prime_Util.Count.Tables
  with SPARK_Mode => Off
is
   use Math_Prime_Util;

   --  APPLY_TABLES. On entry Low is 7. Added counts primes in 7 .. Low-1
   --  after Low moves to the first integer the table does not cover.
   procedure Advance (High : U64; Low : in out U64; Added : out U64);
end Math_Prime_Util.Count.Tables;
