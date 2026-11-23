with AUnit.Test_Suites;

package Compat_Random is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the deterministic ChaCha compatibility and contract suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Post => Suite'Result /= null;
end Compat_Random;
