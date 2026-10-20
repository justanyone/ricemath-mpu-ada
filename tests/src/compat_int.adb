with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Fixture_Support;
with Math_Prime_Util.Int;

package body Compat_Int is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use Math_Prime_Util.Int;
   use type U64;
   use type I128;

   type Int_Case is new Test_Case with null record;
   overriding function Name (T : Int_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Int_Case);

   function Image (N : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("int"), Func);
      A : array (1 .. 4) of U64 := [others => 0];
      V : U64;
      O : Optional_U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, Func & " has no rows");
      for C of Cases loop
         if Func = "gcdext" then
            declare
               R : constant Bezout_Result := Gcdext
                 (I128'Value (To_String (C.Args (1))),
                  I128'Value (To_String (C.Args (2))));
               Actual : constant String := Image (I128 (R.D)) & " " &
                 Image (R.X) & " " & Image (R.Y);
            begin
               AUnit.Assertions.Assert
                 (Actual = To_String (C.Result),
                  Func & Positive'Image (C.Line_Number) & ": " & Actual);
            end;
         else
            for I in 1 .. Natural (C.Args.Length) loop
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (I)), A (I)),
                  "invalid unsigned fixture argument");
            end loop;
            O := (Defined => False);
            if Func = "sqrtint" then
               O := (True, Sqrtint (A (1)));
            elsif Func = "is_square" then
               O := (True, (if Is_Square (A (1)) then 1 else 0));
            elsif Func = "rootint" then
               O := (True, Rootint (A (1), A (2)));
            elsif Func = "crootint" then
               O := (True, Crootint (A (1), A (2)));
            elsif Func = "is_power" then
               O := (True, (if Is_Power (A (1), A (2)) then 1 else 0));
            elsif Func = "powint" then
               O := Powint (A (1), A (2));
            elsif Func = "is_power_exp" then
               O := (True, Is_Power_Exp (A (1)));
            elsif Func = "logint" then
               O := (True, Logint (A (1), A (2)));
            elsif Func = "gcd" then
               O := (True, Gcd (A (1), A (2)));
            elsif Func = "lcm" then
               O := Lcm (A (1), A (2));
            elsif Func = "negmod" then
               O := Negmod (A (1), A (2));
            elsif Func = "invmod" then
               O := Invmod (A (1), A (2));
            elsif Func = "sqrmod" then
               O := Sqrmod (A (1), A (2));
            elsif Func = "addmod" then
               O := Addmod (A (1), A (2), A (3));
            elsif Func = "submod" then
               O := Submod (A (1), A (2), A (3));
            elsif Func = "mulmod" then
               O := Mulmod (A (1), A (2), A (3));
            elsif Func = "powmod" then
               O := Powmod (A (1), A (2), A (3));
            elsif Func = "muladdmod" then
               O := Muladdmod (A (1), A (2), A (3), A (4));
            elsif Func = "mulsubmod" then
               O := Mulsubmod (A (1), A (2), A (3), A (4));
            end if;
            AUnit.Assertions.Assert
              (O.Defined /= C.Undef, Func & " definedness, row" &
               Positive'Image (C.Line_Number));
            if O.Defined then
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Result), V), "invalid result");
               AUnit.Assertions.Assert
                 (O.Value = V, Func & " row" &
                  Positive'Image (C.Line_Number) & " expected" &
                  U64'Image (V) & " got" & U64'Image (O.Value));
            end if;
         end if;
      end loop;
   end Replay;

   overriding function Name (T : Int_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Int");
   end Name;

   procedure Test_Sqrtint (T : in out Test_Case'Class) is
   begin
      Replay ("sqrtint");
   end Test_Sqrtint;

   procedure Test_Is_Square (T : in out Test_Case'Class) is
   begin
      Replay ("is_square");
   end Test_Is_Square;

   procedure Test_Rootint (T : in out Test_Case'Class) is
   begin
      Replay ("rootint");
   end Test_Rootint;

   procedure Test_Crootint (T : in out Test_Case'Class) is
   begin
      Replay ("crootint");
   end Test_Crootint;

   procedure Test_Is_Power (T : in out Test_Case'Class) is
   begin
      Replay ("is_power");
   end Test_Is_Power;

   procedure Test_Powint (T : in out Test_Case'Class) is
   begin
      Replay ("powint");
   end Test_Powint;

   procedure Test_Is_Power_Exp (T : in out Test_Case'Class) is
   begin
      Replay ("is_power_exp");
   end Test_Is_Power_Exp;

   procedure Test_Logint (T : in out Test_Case'Class) is
   begin
      Replay ("logint");
   end Test_Logint;

   procedure Test_Gcd (T : in out Test_Case'Class) is
   begin
      Replay ("gcd");
   end Test_Gcd;

   procedure Test_Lcm (T : in out Test_Case'Class) is
   begin
      Replay ("lcm");
   end Test_Lcm;

   procedure Test_Gcdext (T : in out Test_Case'Class) is
   begin
      Replay ("gcdext");
   end Test_Gcdext;

   procedure Test_Negmod (T : in out Test_Case'Class) is
   begin
      Replay ("negmod");
   end Test_Negmod;

   procedure Test_Invmod (T : in out Test_Case'Class) is
   begin
      Replay ("invmod");
   end Test_Invmod;

   procedure Test_Sqrmod (T : in out Test_Case'Class) is
   begin
      Replay ("sqrmod");
   end Test_Sqrmod;

   procedure Test_Addmod (T : in out Test_Case'Class) is
   begin
      Replay ("addmod");
   end Test_Addmod;

   procedure Test_Submod (T : in out Test_Case'Class) is
   begin
      Replay ("submod");
   end Test_Submod;

   procedure Test_Mulmod (T : in out Test_Case'Class) is
   begin
      Replay ("mulmod");
   end Test_Mulmod;

   procedure Test_Powmod (T : in out Test_Case'Class) is
   begin
      Replay ("powmod");
   end Test_Powmod;

   procedure Test_Muladdmod (T : in out Test_Case'Class) is
   begin
      Replay ("muladdmod");
   end Test_Muladdmod;

   procedure Test_Mulsubmod (T : in out Test_Case'Class) is
   begin
      Replay ("mulsubmod");
   end Test_Mulsubmod;

   overriding procedure Register_Tests (T : in out Int_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Sqrtint'Access, "sqrtint");
      Registration.Register_Routine
        (T, Test_Is_Square'Access, "is_square");
      Registration.Register_Routine
        (T, Test_Rootint'Access, "rootint");
      Registration.Register_Routine
        (T, Test_Crootint'Access, "crootint");
      Registration.Register_Routine
        (T, Test_Is_Power'Access, "is_power");
      Registration.Register_Routine
        (T, Test_Powint'Access, "powint");
      Registration.Register_Routine
        (T, Test_Is_Power_Exp'Access, "is_power_exp");
      Registration.Register_Routine
        (T, Test_Logint'Access, "logint");
      Registration.Register_Routine
        (T, Test_Gcd'Access, "gcd");
      Registration.Register_Routine
        (T, Test_Lcm'Access, "lcm");
      Registration.Register_Routine
        (T, Test_Gcdext'Access, "gcdext");
      Registration.Register_Routine
        (T, Test_Negmod'Access, "negmod");
      Registration.Register_Routine
        (T, Test_Invmod'Access, "invmod");
      Registration.Register_Routine
        (T, Test_Sqrmod'Access, "sqrmod");
      Registration.Register_Routine
        (T, Test_Addmod'Access, "addmod");
      Registration.Register_Routine
        (T, Test_Submod'Access, "submod");
      Registration.Register_Routine
        (T, Test_Mulmod'Access, "mulmod");
      Registration.Register_Routine
        (T, Test_Powmod'Access, "powmod");
      Registration.Register_Routine
        (T, Test_Muladdmod'Access, "muladdmod");
      Registration.Register_Routine
        (T, Test_Mulsubmod'Access, "mulsubmod");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Int_Case);
      return Result;
   end Suite;
end Compat_Int;
