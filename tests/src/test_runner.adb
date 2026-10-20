with AUnit.Reporter.Text;
with AUnit.Run;
with All_Suites;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (All_Suites.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Test_Runner;
