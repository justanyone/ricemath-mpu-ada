with AUnit.Reporter.Text;
with AUnit.Run;
with All_Suites;
with Ada.Command_Line;
with AUnit.Options;
with AUnit.Test_Filters;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (All_Suites.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Filter : aliased AUnit.Test_Filters.Name_Filter;
   Options : AUnit.Options.AUnit_Options := AUnit.Options.Default_Options;
begin
   if Ada.Command_Line.Argument_Count = 1 then
      Filter.Set_Name (Ada.Command_Line.Argument (1));
      Options.Filter := Filter'Unchecked_Access;
   end if;
   Run (Reporter, Options);
end Test_Runner;
