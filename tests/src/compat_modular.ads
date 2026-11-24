with AUnit.Test_Suites;

package Compat_Modular is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Fixture replay for roots and modular helpers, plus boundary checks.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Modular;
