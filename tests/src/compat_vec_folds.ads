with AUnit.Test_Suites;

package Compat_Vec_Folds is
   use type AUnit.Test_Suites.Access_Test_Suite;
   --  Compatibility suite for the native callback operations.
   function Suite return AUnit.Test_Suites.Access_Test_Suite
     with Post => Suite'Result /= null;
end Compat_Vec_Folds;
