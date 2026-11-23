with AUnit.Test_Suites;

package Compat_Arith is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Replay totient, Moebius, divisor, and inverse divisor-count fixtures;
   --  check arithmetic identities and boundaries.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Arith;
