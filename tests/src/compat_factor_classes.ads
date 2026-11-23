with AUnit.Test_Suites;

package Compat_Factor_Classes is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Native factor-class fixtures and deterministic mathematical laws.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Factor_Classes;
