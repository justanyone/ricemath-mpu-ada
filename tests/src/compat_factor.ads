with AUnit.Test_Suites;
package Compat_Factor is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Replay native factoring fixtures and check boundary properties.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Factor;
