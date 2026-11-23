with Math_Prime_Util.Int;

--  lmo.c and prime_count_tables.h. Private so the count body is the
--  only caller. SPARK stays off: the phi sieve is a word bitmap.
private package Math_Prime_Util.Count.Lmo
  with SPARK_Mode => Off
is
   use type U64;

   --  lmo.c: LMO_prime_count. pi (High), every native argument.
   function Prime_Count (High : U64) return U64
     with Pre => True,
          Post => (if High < 2 then Prime_Count'Result = 0)
            and then Prime_Count'Result <= High;
end Math_Prime_Util.Count.Lmo;
