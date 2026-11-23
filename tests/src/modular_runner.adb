with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Modular;

--  Run the modular fixture family independently within its time budget.
procedure Modular_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Compat_Modular.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Modular_Runner;
