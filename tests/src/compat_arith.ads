with AUnit.Test_Suites;

package Compat_Arith is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Replay arithmetic oracle rows and check native boundaries.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Arith;
