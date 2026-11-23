with AUnit.Reporter.Text;
with AUnit.Run;
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
end Modular_Runner;
