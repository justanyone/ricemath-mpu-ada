with Ada.Command_Line;
with AUnit.Options;
with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Filters;
with All_Suites;

--  Focus a family routine without changing the full gate's suite.
procedure Powers_Runner is
   procedure Run is new AUnit.Run.Test_Runner (All_Suites.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Filter : aliased AUnit.Test_Filters.Name_Filter;
   Options : AUnit.Options.AUnit_Options := AUnit.Options.Default_Options;
begin
   AUnit.Test_Filters.Set_Name
     (Filter, (if Ada.Command_Line.Argument_Count = 0 then "Compat_Families"
               else Ada.Command_Line.Argument (1)));
   Options.Filter := Filter'Unchecked_Access;
   Options.Test_Case_Timer := True;
   Run (Reporter, Options);
end Powers_Runner;
