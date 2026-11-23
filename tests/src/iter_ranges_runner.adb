with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Iter_Ranges;

procedure Iter_Ranges_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Compat_Iter_Ranges.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Iter_Ranges_Runner;
