with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Assertions;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Combinat;

package body Compat_Combinat is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Combinat;
   use type U64;

   type Combinat_Case is new Test_Case with null record;
   overriding function Name
     (T : Combinat_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Combinat_Case);

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("combinat"), Func);
      A, B, Expected : U64 := 0;
      R : Optional_U64;
      Signed_R : Optional_I128;
      Signed_A, Signed_Expected : I128;
      Signed_Input : Boolean;
      Fits, Inputs_Fit : Boolean;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         Signed_Input := Func = "falling_factorial"
           or Func = "rising_factorial";
         Inputs_Fit := Parse_U64 (To_String (C.Args (1)), A);
         B := 0;
         if Natural (C.Args.Length) > 1 then
            Inputs_Fit :=
              Parse_U64 (To_String (C.Args (2)), B) and Inputs_Fit;
         end if;
         if Signed_Input then
            Signed_A := I128'Value (To_String (C.Args (1)));
            Inputs_Fit := Signed_A in
              -I128 (U64'Last) .. I128 (U64'Last);
         end if;
         --  Bigint inputs are outside this native API.
         --  Their fixture rows remain for the later signed/bigint port.
         if Inputs_Fit then
            if C.Error then
               if Func = "multifactorial" and B = 0 then
                  declare
                     Raised : Boolean := False;
                  begin
                     begin
                        R := Multifactorial (A, B);
                     exception
                        when Ada.Assertions.Assertion_Error =>
                           Raised := True;
                     end;
                     AUnit.Assertions.Assert (Raised, "zero step");
                  end;
               else
                  AUnit.Assertions.Assert (False, "unexpected error row");
               end if;
            else
               if Signed_Input then
                  Signed_R := (if Func = "falling_factorial" then
                    Falling_Factorial (Signed_A, B)
                    else Rising_Factorial (Signed_A, B));
                  Fits := not C.Undef;
                  if Fits then
                     Signed_Expected := I128'Value (To_String (C.Result));
                     Fits := Signed_Expected in
                       -I128 (U64'Last) .. I128 (U64'Last);
                  end if;
                  AUnit.Assertions.Assert
                    (Signed_R.Defined = Fits and then
                     (not Fits or else Signed_R.Value = Signed_Expected),
                     Func & Positive'Image (C.Line_Number));
               else
               if Func = "factorial" then
                  R := Factorial (A);
               elsif Func = "subfactorial" then
                  R := Subfactorial (A);
               elsif Func = "multifactorial" then
                  R := Multifactorial (A, B);
               elsif Func = "binomial" then
                  R := Binomial (A, B);
               elsif Func = "catalan_number" then
                  R := Catalan_Number (A);
               elsif Func = "bell_number" then
                  R := Bell_Number (A);
               elsif Func = "primorial" then
                  R := Primorial (A);
               elsif Func = "fubini" then
                  R := Fubini (A);
               elsif Func = "powersum" then
                  R := Powersum (A, B);
               elsif Func = "consecutive_integer_lcm" then
                  R := Consecutive_Integer_Lcm (A);
               elsif Func = "pn_primorial" then
                  R := Pn_Primorial (A);
               end if;
               Fits := not C.Undef and then
                 Parse_U64 (To_String (C.Result), Expected);
               AUnit.Assertions.Assert
                 (R.Defined = Fits and then
                  (not Fits or else R.Value = Expected),
                  Func & Positive'Image (C.Line_Number));
               end if;
            end if;
         end if;
      end loop;
   end Replay;

   procedure Check_Factorial (T : in out Test_Case'Class) is
   begin
      Replay ("factorial");
   end Check_Factorial;

   procedure Check_Subfactorial (T : in out Test_Case'Class) is
   begin
      Replay ("subfactorial");
   end Check_Subfactorial;

   procedure Check_Multifactorial (T : in out Test_Case'Class) is
   begin
      Replay ("multifactorial");
   end Check_Multifactorial;

   procedure Check_Binomial (T : in out Test_Case'Class) is
   begin
      Replay ("binomial");
   end Check_Binomial;

   procedure Check_Catalan_Number (T : in out Test_Case'Class) is
   begin
      Replay ("catalan_number");
   end Check_Catalan_Number;

   procedure Check_Bell_Number (T : in out Test_Case'Class) is
   begin
      Replay ("bell_number");
   end Check_Bell_Number;

   procedure Check_Primorial (T : in out Test_Case'Class) is
   begin
      Replay ("primorial");
   end Check_Primorial;

   procedure Check_Pn_Primorial (T : in out Test_Case'Class) is
   begin
      Replay ("pn_primorial");
   end Check_Pn_Primorial;

   procedure Check_Falling_Factorial (T : in out Test_Case'Class) is
   begin
      Replay ("falling_factorial");
   end Check_Falling_Factorial;

   procedure Check_Rising_Factorial (T : in out Test_Case'Class) is
   begin
      Replay ("rising_factorial");
   end Check_Rising_Factorial;

   procedure Check_Consecutive_Integer_Lcm (T : in out Test_Case'Class) is
   begin
      Replay ("consecutive_integer_lcm");
   end Check_Consecutive_Integer_Lcm;

   procedure Check_Fubini (T : in out Test_Case'Class) is
   begin
      Replay ("fubini");
   end Check_Fubini;

   procedure Check_Powersum (T : in out Test_Case'Class) is
   begin
      Replay ("powersum");
   end Check_Powersum;

   overriding function Name
     (T : Combinat_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Combinat");
   end Name;

   overriding procedure Register_Tests (T : in out Combinat_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine
        (T, Check_Falling_Factorial'Access, "falling_factorial");
      Register_Routine
        (T, Check_Rising_Factorial'Access, "rising_factorial");
      Register_Routine
        (T, Check_Consecutive_Integer_Lcm'Access, "consecutive_integer_lcm");
      Register_Routine
        (T, Check_Fubini'Access, "fubini");
      Register_Routine
        (T, Check_Powersum'Access, "powersum");
      Register_Routine (T, Check_Factorial'Access, "factorial");
      Register_Routine (T, Check_Subfactorial'Access, "subfactorial");
      Register_Routine (T, Check_Multifactorial'Access, "multifactorial");
      Register_Routine (T, Check_Binomial'Access, "binomial");
      Register_Routine (T, Check_Catalan_Number'Access, "catalan_number");
      Register_Routine (T, Check_Bell_Number'Access, "bell_number");
      Register_Routine (T, Check_Primorial'Access, "primorial");
      Register_Routine (T, Check_Pn_Primorial'Access, "pn_primorial");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Combinat_Case);
      return Result;
   end Suite;
end Compat_Combinat;
