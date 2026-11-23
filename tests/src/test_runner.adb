with Ada.Command_Line;
with Compat_Random;
with AUnit.Reporter.Text;
with AUnit.Run;
with All_Suites;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (All_Suites.Suite);
   procedure Run_Random is new AUnit.Run.Test_Runner (Compat_Random);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   if Ada.Command_Line.Argument_Count = 1 and then
     Ada.Command_Line.Argument (1) = "random"
   then
      Run_Random (Reporter);
   else
      Run (Reporter);
   end if;
end Test_Runner;
