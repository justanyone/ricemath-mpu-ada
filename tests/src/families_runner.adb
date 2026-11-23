with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Suites;
with Compat_Families;
with Prop_Families;

--  Focused runner for the number-family fixture and property suites.
procedure Families_Runner is
   function Suite return AUnit.Test_Suites.Access_Test_Suite;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (Compat_Families.Suite);
      Result.Add_Test (Prop_Families.Suite);
      return Result;
   end Suite;
   procedure Run is new AUnit.Run.Test_Runner (Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Families_Runner;
