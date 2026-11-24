with AUnit.Test_Suites;

package Prop_Families is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the lucky-number test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Prop_Families;
