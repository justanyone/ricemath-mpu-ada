with AUnit.Test_Suites;

package Compat_Int is
   --  Build the integer test suite.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Int;
