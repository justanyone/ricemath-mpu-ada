with Ada.Command_Line;
with AUnit;
with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Arith;

--  Focused runner for the arithmetic behavior scenarios.
procedure Arith_Runner is
   use type AUnit.Status;
   function Run is new AUnit.Run.Test_Runner_With_Status (Compat_Arith.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Status : AUnit.Status;
begin
   Status := Run (Reporter);
   if Status /= AUnit.Success then
      Ada.Command_Line.Set_Exit_Status (Ada.Command_Line.Failure);
   end if;
end Arith_Runner;
