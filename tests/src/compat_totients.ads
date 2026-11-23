with AUnit.Test_Suites;

package Compat_Totients is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Replay eight totient-family fixture functions and seeded identities.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Totients;
