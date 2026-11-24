with Ada.Command_Line;
with AUnit;
with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Totients;

--  Focused checked suite with a failing process status on test failures.
procedure Totients_Runner is
   use type AUnit.Status;
   function Run is new AUnit.Run.Test_Runner_With_Status
     (Compat_Totients.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Status : AUnit.Status;
begin
   Status := Run (Reporter);
   if Status /= AUnit.Success then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end Totients_Runner;
