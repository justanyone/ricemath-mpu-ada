with AUnit.Test_Suites;

package Prop_Vec is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the vector test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Prop_Vec;
