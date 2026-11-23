with AUnit.Test_Suites;
package Random_Suite is
   --  CSPRNG and native random-prime fixtures, contracts and properties.
   function Suite return AUnit.Test_Suites.Access_Test_Suite;
end Random_Suite;
