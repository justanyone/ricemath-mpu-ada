with AUnit.Test_Suites;

package Prop_Digits is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the digit test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Prop_Digits;
