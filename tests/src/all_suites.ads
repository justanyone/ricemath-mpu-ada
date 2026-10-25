with AUnit.Test_Suites;

package All_Suites is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the integer test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end All_Suites;
