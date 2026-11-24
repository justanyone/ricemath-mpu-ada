with AUnit.Test_Suites;
package Compat_Random_Select is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Seeded selection fixtures and native proving properties.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Random_Select;
