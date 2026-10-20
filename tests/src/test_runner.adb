with AUnit.Reporter.Text;
with AUnit.Run;
with Version_Suite;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Version_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Test_Runner;
