with AUnit.Test_Suites;

package Compat_Combinat is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the combinatorics test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Combinat;
