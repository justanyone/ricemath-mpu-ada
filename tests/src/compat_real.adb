with Ada.Exceptions;
with Ada.Numerics;
with AUnit.Assertions;
with Ada.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Interfaces.C;
with System;
with Fixture_Support;
with Math_Prime_Util.Real;
package body Compat_Real is
   --  MPU accepts IEEE infinities and NaNs as real arguments.
   pragma Validity_Checks (Off);
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util.Real;
   function Strtod
     (Text : Interfaces.C.char_array; Tail : System.Address)
      return Interfaces.C.double
     with Import, Convention => C, External_Name => "strtod";
   function Number (Text : String) return F64 is
     (F64 (Strtod (Interfaces.C.To_C (Text), System.Null_Address)));
   type Real_Case is new Test_Case with null record;
   overriding function Name (T : Real_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Real_Case);
   overriding function Name (T : Real_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Real");
   end Name;
   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("real"), Func);
      Actual, Expected, X : F64;
      Raised : Boolean;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         Raised := False;
         begin
            X := (if C.Args.Is_Empty then 0.0 else
                    Number (To_String (C.Args (1))));
            if Func = "ExponentialIntegral" then
               Actual := Exponentialintegral (X);
            elsif Func = "LogarithmicIntegral" then
               Actual := Logarithmicintegral (X);
            elsif Func = "RiemannZeta" then
               Actual := Riemannzeta (X);
            elsif Func = "RiemannR" then
               Actual := Riemannr (X);
            elsif Func = "LambertW" then
               Actual := Lambertw (X);
            elsif Func = "inverse_li" then
               Actual := Inverse_Li (X);
            elsif Func = "inverse_li_nv" then
               Actual := Inverse_Li_Nv (X);
            elsif Func = "Pi" then
               declare
                  S : constant String := Pi (Natural (X));
               begin
                  --  Perl strips trailing zeroes from its numeric Pi result.
                  if X > 15.0 then
                     declare
                        E : constant String := To_String (C.Result);
                        Last : Natural := S'Last;
                     begin
                        while S (Last) = '0' loop
                           Last := Last - 1;
                        end loop;
                        AUnit.Assertions.Assert
                          (S (1 .. Last) = E, "Pi row" &
                           Positive'Image (C.Line_Number));
                     end;
                  end if;
                  Actual := Number (S);
               end;
            elsif Func = "bernreal" then
               Actual := Bernreal (Natural (X));
            elsif Func = "harmreal" then
               Actual := Harmreal (Natural (X));
            else
               raise Program_Error;
            end if;
            if not C.Error then
               Expected := Number (To_String (C.Result));
               AUnit.Assertions.Assert
                 ((if Expected /= Expected then Actual /= Actual
                   elsif abs Expected > F64'Last then Actual = Expected
                   elsif Expected = 0.0 then Actual = 0.0
                   else abs (Actual - Expected) <=
                     1.0E-12 * abs Expected),
                  Func & " row" & Positive'Image (C.Line_Number) &
                  " got " & F64'Image (Actual));
            end if;
         exception
            when E : Constraint_Error | Ada.Assertions.Assertion_Error |
              Ada.Numerics.Argument_Error =>
               if not C.Error then
                  AUnit.Assertions.Assert (False,
                    Func & " row" & Positive'Image (C.Line_Number) &
                    Ada.Exceptions.Exception_Message (E));
               end if;
               Raised := True;
         end;
         AUnit.Assertions.Assert (Raised = C.Error,
           Func & " error row" & Positive'Image (C.Line_Number));
      end loop;
   end Replay;
   procedure Test_Exponentialintegral (T : in out Test_Case'Class);
   procedure Test_Exponentialintegral (T : in out Test_Case'Class) is
   begin
      Replay ("ExponentialIntegral");
   end Test_Exponentialintegral;
   procedure Test_Logarithmicintegral (T : in out Test_Case'Class);
   procedure Test_Logarithmicintegral (T : in out Test_Case'Class) is
   begin
      Replay ("LogarithmicIntegral");
   end Test_Logarithmicintegral;
   procedure Test_Riemannzeta (T : in out Test_Case'Class);
   procedure Test_Riemannzeta (T : in out Test_Case'Class) is
   begin
      Replay ("RiemannZeta");
   end Test_Riemannzeta;
   procedure Test_Riemannr (T : in out Test_Case'Class);
   procedure Test_Riemannr (T : in out Test_Case'Class) is
   begin
      Replay ("RiemannR");
   end Test_Riemannr;
   procedure Test_Lambertw (T : in out Test_Case'Class);
   procedure Test_Lambertw (T : in out Test_Case'Class) is
   begin
      Replay ("LambertW");
   end Test_Lambertw;
   procedure Test_Inverse_Li (T : in out Test_Case'Class);
   procedure Test_Inverse_Li (T : in out Test_Case'Class) is
   begin
      Replay ("inverse_li");
   end Test_Inverse_Li;
   procedure Test_Inverse_Li_Nv (T : in out Test_Case'Class);
   procedure Test_Inverse_Li_Nv (T : in out Test_Case'Class) is
   begin
      Replay ("inverse_li_nv");
   end Test_Inverse_Li_Nv;
   procedure Test_Pi (T : in out Test_Case'Class);
   procedure Test_Pi (T : in out Test_Case'Class) is
   begin
      Replay ("Pi");
   end Test_Pi;
   procedure Test_Bernreal (T : in out Test_Case'Class);
   procedure Test_Bernreal (T : in out Test_Case'Class) is
   begin
      Replay ("bernreal");
   end Test_Bernreal;
   procedure Test_Harmreal (T : in out Test_Case'Class);
   procedure Test_Harmreal (T : in out Test_Case'Class) is
   begin
      Replay ("harmreal");
   end Test_Harmreal;
   overriding procedure Register_Tests (T : in out Real_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Exponentialintegral'Access, "ExponentialIntegral");
      Registration.Register_Routine
        (T, Test_Logarithmicintegral'Access, "LogarithmicIntegral");
      Registration.Register_Routine
        (T, Test_Riemannzeta'Access, "RiemannZeta");
      Registration.Register_Routine
        (T, Test_Riemannr'Access, "RiemannR");
      Registration.Register_Routine
        (T, Test_Lambertw'Access, "LambertW");
      Registration.Register_Routine
        (T, Test_Inverse_Li'Access, "inverse_li");
      Registration.Register_Routine
        (T, Test_Inverse_Li_Nv'Access, "inverse_li_nv");
      Registration.Register_Routine
        (T, Test_Pi'Access, "Pi");
      Registration.Register_Routine
        (T, Test_Bernreal'Access, "bernreal");
      Registration.Register_Routine
        (T, Test_Harmreal'Access, "harmreal");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Real_Case);
      return Result;
   end Suite;
end Compat_Real;
