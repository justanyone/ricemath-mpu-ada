with AUnit.Test_Suites;

package Compat_Factor is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build ECM fixture and boundary tests.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Factor;
