with AUnit.Test_Suites;

package Compat_Powers is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Regression tests for native prime and perfect powers; no errors.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Powers;
