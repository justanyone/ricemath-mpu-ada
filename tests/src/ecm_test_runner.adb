with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Factor;

--  Dedicated acceptance runner: the general runner ignores CLI filters.
procedure Ecm_Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Compat_Factor.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Ecm_Test_Runner;
