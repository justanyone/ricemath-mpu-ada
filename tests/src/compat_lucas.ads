with AUnit.Test_Suites;

package Compat_Lucas is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the Lucas test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Lucas;
