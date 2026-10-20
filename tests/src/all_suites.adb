with Version_Suite;
with Test_Fixture_Support;
with Compat_Int;
with Prop_Int;
with Compat_Sieve;
with Prop_Sieve;
with Compat_Lucas;
with Prop_Lucas;

package body All_Suites is
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        Version_Suite.Suite;
   begin
      Result.Add_Test (Test_Fixture_Support.Suite);
      Result.Add_Test (Compat_Int.Suite);
      Result.Add_Test (Prop_Int.Suite);
      Result.Add_Test (Compat_Sieve.Suite);
      Result.Add_Test (Prop_Sieve.Suite);
      Result.Add_Test (Compat_Lucas.Suite);
      Result.Add_Test (Prop_Lucas.Suite);
      return Result;
   end Suite;
end All_Suites;
