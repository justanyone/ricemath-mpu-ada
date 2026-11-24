with AUnit.Test_Suites;
package Compat_Primality is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Construct the registered primality tests.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Primality;
