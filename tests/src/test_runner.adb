with Ada.Command_Line;
with Compat_Vec;
with Prop_Vec;
with AUnit.Test_Suites;
with AUnit.Reporter.Text;
with AUnit.Run;
with All_Suites;

procedure Test_Runner is
   procedure Run is new AUnit.Run.Test_Runner (All_Suites.Suite);
   function Vec_Suite return AUnit.Test_Suites.Access_Test_Suite is
      R : constant AUnit.Test_Suites.Access_Test_Suite := Compat_Vec.Suite;
   begin
      R.Add_Test (Prop_Vec.Suite);
      return R;
   end Vec_Suite;
   procedure Run_Vec is new AUnit.Run.Test_Runner (Vec_Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   if Ada.Command_Line.Argument_Count = 1
     and then Ada.Command_Line.Argument (1) = "--vec"
   then
      Run_Vec (Reporter);
   else
      Run (Reporter);
   end if;
end Test_Runner;
