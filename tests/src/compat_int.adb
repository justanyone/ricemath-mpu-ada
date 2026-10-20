with AUnit.Assertions;
with Ada.Assertions;
with Ada.Characters.Handling;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Unbounded;
with Ada.Strings.Fixed;
with Fixture_Support;
with Math_Prime_Util.Config;
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
            if C.Error then
               declare
                  Raised : Boolean := False;
               begin
                  begin
                     if Func = "rootint" then
                        V := Rootint (A (1), A (2));
                     elsif Func = "crootint" then
                        V := Crootint (A (1), A (2));
                     else
                        V := Logint (A (1), A (2));
                     end if;
                  exception
                     when Constraint_Error | Ada.Assertions.Assertion_Error =>
                        Raised := True;
                  end;
                  AUnit.Assertions.Assert (Raised, "expected input error");
               end;
            else
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

   --  No int.tsv row names the config functions: their rows are in
   --  config.tsv, replayed by Test_Config_Replay. The tests check the
   --  values that Math::Prime::Util 0.75 gives on a 64-bit build.
   procedure Test_Prime_Get_Config (T : in out Test_Case'Class) is
      C : constant Math_Prime_Util.Config.Config_Record :=
        Math_Prime_Util.Config.Prime_Get_Config;
   begin
      AUnit.Assertions.Assert (C.Maxbits = 64, "maxbits");
      AUnit.Assertions.Assert (C.Verbose = 0, "verbose default");
      AUnit.Assertions.Assert (not C.Assume_RH, "assume_rh default");
   end Test_Prime_Get_Config;

   --  True when Prime_Set_Config rejects the key or value: a
   --  precondition failure in tests, Config_Error in release builds.
   function Rejected (Key : String; Value : String) return Boolean is
   begin
      Math_Prime_Util.Config.Prime_Set_Config (Key, Value);
      return False;
   exception
      when Math_Prime_Util.Config.Config_Error
         | Ada.Assertions.Assertion_Error =>
         return True;
   end Rejected;

   --  Replays config.tsv: key, value and the result (the setting or
   --  ERROR). An ERROR row must be rejected and keep the settings.
   procedure Test_Config_Replay (T : in out Test_Case'Class) is
      use Math_Prime_Util.Config;
      Rows : constant Case_Vectors.Vector := Load ("config");
   begin
      AUnit.Assertions.Assert (not Rows.Is_Empty, "config has no rows");
      for C of Rows loop
         declare
            Key    : constant String := To_String (C.Args (1));
            Value  : constant String := To_String (C.Args (2));
            Result : constant String := To_String (C.Result);
            Before : constant Config_Record := Prime_Get_Config;
            Failed : constant Boolean := Rejected (Key, Value);
            After  : constant Config_Record := Prime_Get_Config;
         begin
            if C.Error then
               AUnit.Assertions.Assert
                 (Failed and then After = Before, Key & " must be rejected");
            else
               AUnit.Assertions.Assert
                 (not Failed, Key & " must be accepted");
               if Ada.Characters.Handling.To_Lower (Key) = "verbose" then
                  AUnit.Assertions.Assert
                    (After.Verbose = Natural'Value (Result),
                     Key & " = " & Result);
               else
                  AUnit.Assertions.Assert
                    (After.Assume_RH = (Result = "1"), Key & " = " & Result);
               end if;
            end if;
            Prime_Set_Config ("verbose", "0");
            Prime_Set_Config ("assume_rh", "0");
         end;
      end loop;
   end Test_Config_Replay;

   procedure Test_Prime_Set_Config (T : in out Test_Case'Class) is
      use Math_Prime_Util.Config;
   begin
      --  Restore the defaults after each step: the settings are global.
      Prime_Set_Config ("VERBOSE", "2");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Verbose = 2, "verbose 2");
      Prime_Set_Config ("verbose", "no");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Verbose = 0, "verbose no");
      Prime_Set_Config ("assume rh", "1");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Assume_RH, "assume rh on");
      Prime_Set_Config ("riemann hypothesis", "0");
      AUnit.Assertions.Assert
        (not Prime_Get_Config.Assume_RH, "riemann hypothesis off");
      --  Keys match as MPU does: no space or underscore removal.
      AUnit.Assertions.Assert
        (Rejected ("ver_bose", "2") and then Prime_Get_Config.Verbose = 0,
         "ver_bose rejected");
      AUnit.Assertions.Assert
        (Rejected ("r h", "1") and then not Prime_Get_Config.Assume_RH,
         "r h rejected");
      Prime_Set_Config ("riemann" & ASCII.HT & "hypothesis", "1");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Assume_RH, "riemann tab hypothesis on");
      Prime_Set_Config ("assume_rh", "0");
      --  Verbose digits: leading zeros and the Natural boundary.
      Prime_Set_Config ("verbose", "1000000000");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Verbose = 1_000_000_000, "verbose 10 digits");
      Prime_Set_Config ("verbose", "0000000000");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Verbose = 0, "verbose ten zeros");
      Prime_Set_Config ("verbose", "00000000002");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Verbose = 2, "verbose leading zeros");
      Prime_Set_Config ("verbose", "2147483647");
      AUnit.Assertions.Assert
        (Prime_Get_Config.Verbose = Natural'Last, "verbose Natural'Last");
      AUnit.Assertions.Assert
        (Rejected ("verbose", "2147483648")
         and then Prime_Get_Config.Verbose = Natural'Last,
         "verbose above Natural'Last rejected");
      Prime_Set_Config ("verbose", "0");
      AUnit.Assertions.Assert
        (Rejected ("no_such_key", "1") and then Prime_Get_Config.Verbose = 0,
         "unknown key rejected");
   end Test_Prime_Set_Config;

   procedure Test_Uvsize (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Config.Uvsize = 8, "uvsize");
   end Test_Uvsize;

   procedure Test_Uvbits (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Config.Uvbits = 64, "uvbits");
   end Test_Uvbits;

   procedure Test_Ivsize (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Config.Ivsize = 8, "ivsize");
   end Test_Ivsize;

   procedure Test_Nvsize (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Config.Nvsize = 8, "nvsize");
   end Test_Nvsize;

   procedure Test_Nvmantbits (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Config.Nvmantbits = 53, "nvmantbits");
   end Test_Nvmantbits;

   procedure Test_Nvmantdigits (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Config.Nvmantdigits = 16, "nvmantdigits");
   end Test_Nvmantdigits;

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
      Registration.Register_Routine
        (T, Test_Prime_Get_Config'Access, "prime_get_config");
      Registration.Register_Routine
        (T, Test_Prime_Set_Config'Access, "prime_set_config");
      Registration.Register_Routine
        (T, Test_Config_Replay'Access, "config_replay");
      Registration.Register_Routine
        (T, Test_Uvsize'Access, "_uvsize");
      Registration.Register_Routine
        (T, Test_Uvbits'Access, "_uvbits");
      Registration.Register_Routine
        (T, Test_Ivsize'Access, "_ivsize");
      Registration.Register_Routine
        (T, Test_Nvsize'Access, "_nvsize");
      Registration.Register_Routine
        (T, Test_Nvmantbits'Access, "_nvmantbits");
      Registration.Register_Routine
        (T, Test_Nvmantdigits'Access, "_nvmantdigits");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Int_Case);
      return Result;
   end Suite;
end Compat_Int;
