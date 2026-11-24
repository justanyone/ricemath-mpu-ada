with AUnit.Reporter.Text;
with AUnit.Run;
with Random_Suite;
--  Focused random-family runner for deterministic offline tests.
procedure Random_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Random_Suite.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Random_Runner;
