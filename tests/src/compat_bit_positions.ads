with AUnit.Test_Suites;

package Compat_Bit_Positions is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Native bit-position boundaries and examples; no errors.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Pre => True, Post => Suite'Result /= null;
end Compat_Bit_Positions;
