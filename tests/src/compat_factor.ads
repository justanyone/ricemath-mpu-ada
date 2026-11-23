with AUnit.Test_Suites;

package Compat_Factor is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the factoring fixture suite, including ECM boundaries.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;

   --  ECM fixture and boundary routines for the acceptance runner.
   function Ecm_Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Ecm_Suite'Result /= null;
   --  The nine factor count/predicate fixture routines only.
   function Counts_Suite (Only_Test : Natural := 0)
      return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Counts_Suite'Result /= null;
end Compat_Factor;
