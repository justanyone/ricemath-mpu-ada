with AUnit.Assertions;
with Ada.Assertions;
with Ada.Strings.Fixed;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Factor;

package body Compat_Factor is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Factor;
   use type U64;

   type Factor_Case is new Test_Case with null record;
   overriding function Name (T : Factor_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Factor_Case);

   overriding function Name (T : Factor_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Factor");
   end Name;

   function Show (Values : Factor_Vectors.Vector) return String is
      Text : Unbounded_String;
   begin
      for Index in Values.First_Index .. Values.Last_Index loop
         if Index /= Values.First_Index then
            Append (Text, ' ');
         end if;
         Append
           (Text,
            Ada.Strings.Fixed.Trim (Values (Index)'Image, Ada.Strings.Left));
      end loop;
      return To_String (Text);
   end Show;

   --  A native row has only unsigned values that fit in U64.
   function Native (C : Case_Record) return Boolean is
      Value : U64;
      Text : Unbounded_String;
   begin
      for Arg of C.Args loop
         Text := Arg;
         if not Parse_U64 (To_String (Text), Value) then
            return False;
         end if;
      end loop;
      return True;
   end Native;

   function Arg (C : Case_Record; Index : Positive) return U64 is
      Value : U64;
   begin
      if not Parse_U64 (To_String (C.Args (Index)), Value) then
         raise Constraint_Error with "non-native fixture input";
      end if;
      return Value;
   end Arg;

   function Evaluate (C : Case_Record; F : String)
      return Factor_Vectors.Vector is
      N : constant U64 := Arg (C, 1);
   begin
      if F = "factor" then
         return Factor (N);
      elsif F = "divisors" then
         if Natural (C.Args.Length) = 1 then
            return Divisors (N);
         end if;
         return Divisors (N, Arg (C, 2));
      elsif F = "trial_factor" then
         if Natural (C.Args.Length) = 1 then
            return Trial_Factor (N);
         end if;
         return Trial_Factor (N, Arg (C, 2));
      elsif F = "fermat_factor" then
         if Natural (C.Args.Length) = 1 then
            return Fermat_Factor (N);
         end if;
         return Fermat_Factor (N, Arg (C, 2));
      elsif F = "holf_factor" then
         if Natural (C.Args.Length) = 1 then
            return Holf_Factor (N);
         end if;
         return Holf_Factor (N, Arg (C, 2));
      elsif F = "squfof_factor" then
         if Natural (C.Args.Length) = 1 then
            return Squfof_Factor (N);
         end if;
         return Squfof_Factor (N, Arg (C, 2));
      elsif F = "lehman_factor" then
         if Natural (C.Args.Length) = 1 then
            return Lehman_Factor (N);
         end if;
         return Lehman_Factor (N, Arg (C, 2) /= 0);
      elsif F = "prho_factor" then
         if Natural (C.Args.Length) = 1 then
            return Prho_Factor (N);
         end if;
         --  XS.xs ignores a third prho_factor argument.
         return Prho_Factor (N, Arg (C, 2));
      elsif F = "pbrent_factor" then
         if Natural (C.Args.Length) = 1 then
            return Pbrent_Factor (N);
         elsif Natural (C.Args.Length) = 2 then
            return Pbrent_Factor (N, Arg (C, 2));
         end if;
         return Pbrent_Factor (N, Arg (C, 2), Arg (C, 3));
      elsif F = "pminus1_factor" then
         if Natural (C.Args.Length) = 1 then
            return Pminus1_Factor (N);
         elsif Natural (C.Args.Length) = 2 then
            return Pminus1_Factor (N, Arg (C, 2));
         end if;
         return Pminus1_Factor (N, Arg (C, 2), Arg (C, 3));
      elsif F = "pplus1_factor" then
         if Natural (C.Args.Length) = 1 then
            return Pplus1_Factor (N);
         end if;
         return Pplus1_Factor (N, Arg (C, 2));
      end if;
      raise Constraint_Error with "unknown function";
   end Evaluate;

   procedure Replay (F : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("factor"), F);
      Values : Factor_Vectors.Vector;
      Raised : Boolean;
      Got : Unbounded_String;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & F);
      for C of Cases loop
         --  Skipped: Native_U64_Domain. The argument does not fit in a
         --  native unsigned 64-bit integer. Those rows belong to the
         --  bigint API. Invalid text is still required to fail.
         if not Native (C) and then not C.Error then
            null;
         else
            Raised := False;
            begin
               Values := Evaluate (C, F);
            exception
               when Constraint_Error | Ada.Assertions.Assertion_Error =>
                  Raised := True;
            end;
            AUnit.Assertions.Assert
              (Raised = C.Error,
               F & " error row" & C.Line_Number'Image);
            if not Raised then
               Got := To_Unbounded_String (Show (Values));
               if C.Undef then
                  AUnit.Assertions.Assert
                    (Values.Is_Empty,
                     F & " row" & C.Line_Number'Image & " expected undef");
               else
                  AUnit.Assertions.Assert
                    (To_String (Got) = To_String (C.Result),
                     F & " row" & C.Line_Number'Image);
               end if;
            end if;
         end if;
      end loop;
   end Replay;

   procedure Test_Factor (T : in out Test_Case'Class);
   procedure Test_Factor (T : in out Test_Case'Class) is
   begin
      Replay ("factor");
   end Test_Factor;

   procedure Test_Divisors (T : in out Test_Case'Class);
   procedure Test_Divisors (T : in out Test_Case'Class) is
   begin
      Replay ("divisors");
   end Test_Divisors;

   procedure Test_Trial (T : in out Test_Case'Class);
   procedure Test_Trial (T : in out Test_Case'Class) is
   begin
      Replay ("trial_factor");
   end Test_Trial;

   procedure Test_Fermat (T : in out Test_Case'Class);
   procedure Test_Fermat (T : in out Test_Case'Class) is
   begin
      Replay ("fermat_factor");
   end Test_Fermat;

   procedure Test_Holf (T : in out Test_Case'Class);
   procedure Test_Holf (T : in out Test_Case'Class) is
   begin
      Replay ("holf_factor");
   end Test_Holf;

   procedure Test_Squfof (T : in out Test_Case'Class);
   procedure Test_Squfof (T : in out Test_Case'Class) is
   begin
      Replay ("squfof_factor");
   end Test_Squfof;

   procedure Test_Lehman (T : in out Test_Case'Class);
   procedure Test_Lehman (T : in out Test_Case'Class) is
   begin
      Replay ("lehman_factor");
   end Test_Lehman;

   procedure Test_Prho (T : in out Test_Case'Class);
   procedure Test_Prho (T : in out Test_Case'Class) is
   begin
      Replay ("prho_factor");
   end Test_Prho;

   procedure Test_Pbrent (T : in out Test_Case'Class);
   procedure Test_Pbrent (T : in out Test_Case'Class) is
   begin
      Replay ("pbrent_factor");
   end Test_Pbrent;

   procedure Test_Pminus1 (T : in out Test_Case'Class);
   procedure Test_Pminus1 (T : in out Test_Case'Class) is
   begin
      Replay ("pminus1_factor");
   end Test_Pminus1;

   procedure Test_Pplus1 (T : in out Test_Case'Class);
   procedure Test_Pplus1 (T : in out Test_Case'Class) is
   begin
      Replay ("pplus1_factor");
   end Test_Pplus1;

   overriding procedure Register_Tests (T : in out Factor_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Factor'Access, "factor");
      Registration.Register_Routine
        (T, Test_Divisors'Access, "divisors");
      Registration.Register_Routine
        (T, Test_Trial'Access, "trial_factor");
      Registration.Register_Routine
        (T, Test_Fermat'Access, "fermat_factor");
      Registration.Register_Routine
        (T, Test_Holf'Access, "holf_factor");
      Registration.Register_Routine
        (T, Test_Squfof'Access, "squfof_factor");
      Registration.Register_Routine
        (T, Test_Lehman'Access, "lehman_factor");
      Registration.Register_Routine
        (T, Test_Prho'Access, "prho_factor");
      Registration.Register_Routine
        (T, Test_Pbrent'Access, "pbrent_factor");
      Registration.Register_Routine
        (T, Test_Pminus1'Access, "pminus1_factor");
      Registration.Register_Routine
        (T, Test_Pplus1'Access, "pplus1_factor");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Factor_Case);
      return Result;
   end Suite;
end Compat_Factor;
