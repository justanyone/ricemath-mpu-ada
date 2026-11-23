--  Internal extended LMO prime counter, translated from MPU 0.75 lmo.c.
private package Math_Prime_Util.Count.Lmo with SPARK_Mode => On is
   --  Return pi (N). Scratch storage is local to each invocation.
   --  Storage_Error may propagate when the factor table cannot fit.
   function Count (N : U64) return U64
     with Pre => True, Post => Count'Result <= N;
end Math_Prime_Util.Count.Lmo;
