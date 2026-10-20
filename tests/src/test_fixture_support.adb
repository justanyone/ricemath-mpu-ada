with Ada.Containers;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util;

package body Test_Fixture_Support is
   use AUnit.Assertions;
   use AUnit.Test_Cases;
   use Fixture_Support;
   use type Ada.Containers.Count_Type;
   use type Math_Prime_Util.U64;
   use type Math_Prime_Util.U128;

   type Fixture_Case is new Test_Case with null record;
   overriding function Name (T : Fixture_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Fixture_Case);

   procedure Check_Fixtures (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("int");
      Roots : constant Case_Vectors.Vector :=
        For_Function (Cases, "sqrtint");
      Powers : constant Case_Vectors.Vector :=
        For_Function (Cases, "powint");
      Nth_Roots : constant Case_Vectors.Vector :=
        For_Function (Cases, "rootint");
      Again : constant Case_Vectors.Vector := Load ("int");
      Found_Undef : Boolean := False;
      Found_Error : Boolean := False;
   begin
      Assert (T.Name /= null, "test has a name");
      Assert (Cases.Length = 14_560, "int case count");
      Assert (Roots.Length = 152, "sqrtint case count");
      Assert (Roots (1).Func.all = "sqrtint", "function name");
      Assert (Roots (1).Args (1).all = "1524155677489", "first argument");
      Assert (Roots (1).Result.all = "1234567", "first result");
      Assert (Roots (1).Line_Number = 2, "comment counts as a line");
      Assert (Roots (152).Result.all = "4294967295", "last result");
      Assert (not Roots (1).Undef and not Roots (1).Error, "value flags");
      Assert (For_Function (Cases, "missing").Is_Empty, "absent function");
      Assert (Again.Length = Cases.Length, "repeated load count");
      Assert (Again (1).Line_Number = 2, "load resets line number");
      for C of Powers loop
         if C.Line_Number = 1_074 then
            Assert (C.Undef and not C.Error, "undef flags");
            Assert (C.Result.all = "undef", "undef result");
            Assert (C.Args.Length = 2, "argument count");
            Assert (C.Args (1).all = "2", "first power argument");
            Assert (C.Args (2).all = "64", "second power argument");
            Found_Undef := True;
         end if;
      end loop;
      for C of Nth_Roots loop
         if C.Line_Number = 841 then
            Assert (C.Error and not C.Undef, "error flags");
            Assert (C.Result.all = "ERROR", "error result");
            Found_Error := True;
         end if;
      end loop;
      Assert (Found_Undef and Found_Error, "marker rows found");
   end Check_Fixtures;

   procedure Check_Parsers (T : in out Test_Case'Class) is
      Small : Math_Prime_Util.U64;
      Large : Math_Prime_Util.U128;
   begin
      Assert (T.Name /= null, "test has a name");
      Assert (Parse_U64 ("0", Small) and then Small = 0, "U64 zero");
      Assert (Parse_U64 ("00012", Small) and then Small = 12, "zeros");
      Assert (Parse_U64 ("18446744073709551615", Small)
              and then Small = Math_Prime_Util.U64'Last, "U64 maximum");
      Assert (not Parse_U64 ("18446744073709551616", Small), "U64 overflow");
      Assert (not Parse_U64 ("", Small), "empty U64");
      Assert (not Parse_U64 ("-1", Small), "negative U64");
      Assert (not Parse_U64 ("1 2", Small), "U64 list");
      Assert (Parse_U128 ("0", Large) and then Large = 0, "U128 zero");
      Assert (Parse_U128 ("340282366920938463463374607431768211455", Large)
              and then Large = Math_Prime_Util.U128'Last, "U128 maximum");
      Assert (not Parse_U128
                ("340282366920938463463374607431768211456", Large),
              "U128 overflow must not wrap to zero");
      Assert (not Parse_U128 ("", Large), "empty U128");
      Assert (not Parse_U128 ("+1", Large), "signed U128");
      Assert (not Parse_U128 ("12x", Large), "invalid U128");
   end Check_Parsers;

   overriding function Name (T : Fixture_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Fixture support");
   end Name;

   overriding procedure Register_Tests (T : in out Fixture_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Fixtures'Access, "Fixture loader reads int.tsv");
      Registration.Register_Routine
        (T, Check_Parsers'Access, "Decimal parser boundaries");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Fixture_Case);
      return Result;
   end Suite;
end Test_Fixture_Support;
