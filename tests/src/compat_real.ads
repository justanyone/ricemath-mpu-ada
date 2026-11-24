with AUnit.Test_Suites;
package Compat_Real is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the real function test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Real;
