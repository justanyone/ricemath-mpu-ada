with AUnit.Test_Suites;

package Compat_Modular is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Fixture replay and exhaustive small-modulus root checks.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Post => Suite'Result /= null;
end Compat_Modular;
