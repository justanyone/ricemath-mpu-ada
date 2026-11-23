with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Iter;

--  Focused runner for the iterator compatibility and control scenarios.
procedure Iter_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Compat_Iter.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Iter_Runner;
