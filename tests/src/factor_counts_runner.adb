with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Suites;
with Compat_Factor;
with Prop_Factor;

procedure Factor_Counts_Runner is
   function Suite return AUnit.Test_Suites.Access_Test_Suite;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        Compat_Factor.Counts_Suite;
   begin
      Result.Add_Test (Prop_Factor.Suite);
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
