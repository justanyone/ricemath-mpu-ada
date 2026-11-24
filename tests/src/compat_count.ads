with AUnit.Test_Suites;
package Compat_Count is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the count test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Count;
