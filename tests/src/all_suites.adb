with Version_Suite;
with Test_Fixture_Support;
with Compat_Int;
with Prop_Int;
with Compat_Rational;
with Prop_Rational;
with Compat_Lucas;
with Prop_Lucas;

with Compat_Real;
with Prop_Real;

package body All_Suites is
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        Version_Suite.Suite;
   begin
      Result.Add_Test (Test_Fixture_Support.Suite);
      Result.Add_Test (Compat_Int.Suite);
      Result.Add_Test (Prop_Int.Suite);
      Result.Add_Test (Compat_Rational.Suite);
      Result.Add_Test (Prop_Rational.Suite);
      Result.Add_Test (Compat_Lucas.Suite);
      Result.Add_Test (Prop_Lucas.Suite);
      Result.Add_Test (Compat_Real.Suite);
      Result.Add_Test (Prop_Real.Suite);
      return Result;
   end Suite;
end All_Suites;
