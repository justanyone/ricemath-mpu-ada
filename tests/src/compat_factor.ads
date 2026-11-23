with AUnit.Test_Suites;

package Compat_Factor is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the factoring fixture suite, including ECM boundaries.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;

   --  ECM fixture and boundary routines for the acceptance runner.
   function Ecm_Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Ecm_Suite'Result /= null;
end Compat_Factor;
