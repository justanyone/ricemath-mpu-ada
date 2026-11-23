with Ada.Command_Line;
with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Suites;
with Compat_Iter_Ranges;

procedure Iter_Ranges_Runner is
   function Selected return AUnit.Test_Suites.Access_Test_Suite;
   function Selected return AUnit.Test_Suites.Access_Test_Suite is
     (if Ada.Command_Line.Argument_Count = 0 then Compat_Iter_Ranges.Suite
      else Compat_Iter_Ranges.Suite (Ada.Command_Line.Argument (1)));
   procedure Run is new AUnit.Run.Test_Runner (Selected);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Iter_Ranges_Runner;
