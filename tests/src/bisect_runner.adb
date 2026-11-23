with Ada.Text_IO;
with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Suites;
with Compat_Combinat;
with Compat_Count;
with Compat_Digits;
with Compat_Families;
with Compat_Goldbach;
with Compat_Int;
with Compat_Lucas;
with Compat_Primality;
with Compat_Rational;
with Compat_Real;
with Compat_Sieve;
with Prop_Combinat;
with Prop_Count;
with Prop_Digits;
with Prop_Families;
with Prop_Int;
with Prop_Lucas;
with Prop_Primality;
with Prop_Rational;
with Prop_Real;
with Prop_Sieve;
with Test_Fixture_Support;
with Version_Suite;

procedure Bisect_Runner is
   procedure Run_One
     (Name : String; S : AUnit.Test_Suites.Access_Test_Suite)
   is
      function Suite return AUnit.Test_Suites.Access_Test_Suite is (S);
      procedure Run is new AUnit.Run.Test_Runner (Suite);
      Reporter : AUnit.Reporter.Text.Text_Reporter;
   begin
      Ada.Text_IO.Put_Line ("BEGIN " & Name);
      Ada.Text_IO.Flush;
      Run (Reporter);
      Ada.Text_IO.Put_Line ("END " & Name);
      Ada.Text_IO.Flush;
   end Run_One;
begin
   Run_One ("version", Version_Suite.Suite);
   Run_One ("fixture", Test_Fixture_Support.Suite);
   Run_One ("compat_int", Compat_Int.Suite);
   Run_One ("prop_int", Prop_Int.Suite);
   Run_One ("compat_combinat", Compat_Combinat.Suite);
   Run_One ("prop_combinat", Prop_Combinat.Suite);
   Run_One ("compat_sieve", Compat_Sieve.Suite);
   Run_One ("prop_sieve", Prop_Sieve.Suite);
   Run_One ("compat_digits", Compat_Digits.Suite);
   Run_One ("prop_digits", Prop_Digits.Suite);
   Run_One ("compat_rational", Compat_Rational.Suite);
   Run_One ("prop_rational", Prop_Rational.Suite);
   Run_One ("compat_lucas", Compat_Lucas.Suite);
   Run_One ("prop_lucas", Prop_Lucas.Suite);
   Run_One ("compat_real", Compat_Real.Suite);
   Run_One ("prop_real", Prop_Real.Suite);
   Run_One ("compat_count", Compat_Count.Suite);
   Run_One ("prop_count", Prop_Count.Suite);
   Run_One ("compat_primality", Compat_Primality.Suite);
   Run_One ("prop_primality", Prop_Primality.Suite);
   Run_One ("compat_families", Compat_Families.Suite);
   Run_One ("compat_goldbach", Compat_Goldbach.Suite);
   Run_One ("prop_families", Prop_Families.Suite);
end Bisect_Runner;
