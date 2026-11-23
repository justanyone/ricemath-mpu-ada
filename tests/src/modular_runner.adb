with AUnit.Reporter.Text;
with AUnit.Run;
<<<<<<< HEAD
with AUnit;
with Ada.Command_Line;
with Compat_Modular;

--  Focused runner used by the modular-root behavior scenarios.
procedure Modular_Runner is
   function Run is new AUnit.Run.Test_Runner_With_Status (Compat_Modular.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Result : AUnit.Status;
   use type AUnit.Status;
begin
   Result := Run (Reporter);
   if Result /= AUnit.Success then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
=======
with Compat_Modular;

--  Run the modular fixture family independently within its time budget.
procedure Modular_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Compat_Modular.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
>>>>>>> origin/dev-mpuada-001
end Modular_Runner;
