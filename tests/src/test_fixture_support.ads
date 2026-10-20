with AUnit.Test_Suites;

package Test_Fixture_Support is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Return the fixture loader and decimal parser tests.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Post => Suite'Result /= null;
end Test_Fixture_Support;
