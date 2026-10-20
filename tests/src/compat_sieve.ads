with AUnit.Test_Suites;

package Compat_Sieve is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Build the sieve test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Sieve;
