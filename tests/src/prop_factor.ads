with AUnit.Test_Suites;

package Prop_Factor is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build deterministic native factor property tests.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Prop_Factor;
