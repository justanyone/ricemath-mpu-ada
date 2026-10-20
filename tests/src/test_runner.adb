with AUnit.Reporter.Text;
with AUnit.Run;
with Version_Suite;
with Test_Fixture_Support;
with AUnit.Test_Suites;

procedure Test_Runner is
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        Version_Suite.Suite;
   begin
      Result.Add_Test (Test_Fixture_Support.Suite);
      return Result;
   end Suite;

   procedure Run is new AUnit.Run.Test_Runner (Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Test_Runner;
