with AUnit.Test_Suites;

package Compat_Modular is
   use type AUnit.Test_Suites.Access_Test_Suite;
<<<<<<< HEAD
   --  Fixture replay and exhaustive small-modulus root checks.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Post => Suite'Result /= null;
=======
   --  Build the modular test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
>>>>>>> origin/dev-mpuada-001
end Compat_Modular;
