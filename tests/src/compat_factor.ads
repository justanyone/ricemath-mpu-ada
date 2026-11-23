with AUnit.Test_Suites;

package Compat_Factor is
   use type AUnit.Test_Suites.Access_Test_Suite;
<<<<<<< HEAD
   --  Build ECM fixture and boundary tests.
=======
   --  Build the factoring fixture suite.
>>>>>>> origin/dev-mpuada-001
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Factor;
