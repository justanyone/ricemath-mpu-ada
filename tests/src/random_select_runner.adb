with AUnit.Reporter.Text;
with AUnit.Run;
with Compat_Random_Select;

--  Focused runner for the seeded random selection and certificate family.
procedure Random_Select_Runner is
   procedure Run is new AUnit.Run.Test_Runner (Compat_Random_Select.Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run (Reporter);
end Random_Select_Runner;
