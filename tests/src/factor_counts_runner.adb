with Ada.Command_Line;
with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Suites;
with Compat_Factor;
with Prop_Factor;

procedure Factor_Counts_Runner is
   use type AUnit.Status;
   function Suite return AUnit.Test_Suites.Access_Test_Suite;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Selected : constant Natural :=
        (if Ada.Command_Line.Argument_Count = 0 then 0
         else Natural'Value (Ada.Command_Line.Argument (1)));
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        Compat_Factor.Counts_Suite (Selected);
   begin
      if Selected = 0 or else Selected = 10 then
         Result.Add_Test (Prop_Factor.Suite);
      end if;
      return Result;
   end Suite;
   function Run is new AUnit.Run.Test_Runner_With_Status (Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
   Status : AUnit.Status;
begin
   Status := Run (Reporter);
   if Status /= AUnit.Success then
      raise Program_Error with "factor counts failed";
   end if;
end Factor_Counts_Runner;
