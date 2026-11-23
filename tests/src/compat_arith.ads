with AUnit.Test_Suites;

package Compat_Arith is
   use type AUnit.Test_Suites.Access_Test_Suite;
<<<<<<< HEAD
   --  Replay arithmetic fixtures and check identities and boundaries.
=======
   --  Replay arithmetic fixtures and inverse divisor-count rows, and check
   --  divisor identities and boundaries.
>>>>>>> origin/dev-mpuada-001
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Arith;
