with AUnit.Test_Suites;

package Compat_Goldbach is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build fixture tests for the standalone Goldbach package.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Goldbach;
