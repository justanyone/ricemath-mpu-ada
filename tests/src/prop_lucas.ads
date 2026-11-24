with AUnit.Test_Suites;

package Prop_Lucas is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the Lucas test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Prop_Lucas;
