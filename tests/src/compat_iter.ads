with AUnit.Test_Suites;
package Compat_Iter is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Replay native iterator fixtures and check callback isolation.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Iter;
