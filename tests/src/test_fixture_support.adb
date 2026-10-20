with Ada.Containers;
with Ada.Strings.Unbounded;
with Ada.Text_IO;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util;

package body Test_Fixture_Support is
   use AUnit.Assertions;
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use type Ada.Containers.Count_Type;
   use type AUnit.Message_String;
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
      Assert (Roots (1).Func = "sqrtint", "function name");
      Assert (Roots (1).Args (1) = "1524155677489", "first argument");
      Assert (Roots (1).Result = "1234567", "first result");
      Assert (Roots (1).Line_Number = 2, "comment counts as a line");
      Assert (Roots (152).Result = "4294967295", "last result");
      Assert (not Roots (1).Undef and then not Roots (1).Error, "value flags");
      Assert (For_Function (Cases, "missing").Is_Empty, "absent function");
      Assert (Again.Length = Cases.Length, "repeated load count");
      Assert (Again (1).Line_Number = 2, "load resets line number");
      for C of Powers loop
         if C.Line_Number = 1_074 then
            Assert (C.Undef and then not C.Error, "undef flags");
            Assert (C.Result = "undef", "undef result");
            Assert (C.Args.Length = 2, "argument count");
            Assert (C.Args (1) = "2", "first power argument");
            Assert (C.Args (2) = "64", "second power argument");
            Found_Undef := True;
         end if;
      end loop;
      for C of Nth_Roots loop
         if C.Line_Number = 841 then
            Assert (C.Error and then not C.Undef, "error flags");
            Assert (C.Result = "ERROR", "error result");
            Found_Error := True;
         end if;
      end loop;
      Assert (Found_Undef and then Found_Error, "marker rows found");
   end Check_Fixtures;

   procedure Check_Parsers (T : in out Test_Case'Class) is
      Small : Math_Prime_Util.U64;
      Large : Math_Prime_Util.U128;

      procedure Reject_U64 (Text : String) is
      begin
         Assert (not Parse_U64 (Text, Small) and then Small = 0,
                 "reject U64: " & Text);
      end Reject_U64;

      procedure Reject_U128 (Text : String) is
      begin
         Assert (not Parse_U128 (Text, Large) and then Large = 0,
                 "reject U128: " & Text);
      end Reject_U128;
   begin
      Assert (T.Name /= null, "test has a name");
      Assert (Parse_U64 ("0", Small) and then Small = 0, "U64 zero");
      Assert (Parse_U64 ("00012", Small) and then Small = 12, "zeros");
      Assert (Parse_U64 ("18446744073709551615", Small)
              and then Small = Math_Prime_Util.U64'Last, "U64 maximum");
      Reject_U64 ("18446744073709551616");
      Reject_U64 ("340282366920938463463374607431768211456");
      Reject_U64 ("");
      Reject_U64 ("-1");
      Reject_U64 ("1 2");
      Assert (Parse_U128 ("0", Large) and then Large = 0, "U128 zero");
      Assert (Parse_U128 ("340282366920938463463374607431768211455", Large)
              and then Large = Math_Prime_Util.U128'Last, "U128 maximum");
      Reject_U128 ("340282366920938463463374607431768211456");
      Reject_U128 ("999999999999999999999999999999999999999999");
      Reject_U128 ("");
      Reject_U128 ("+1");
      Reject_U128 ("12x");
   end Check_Parsers;

   procedure Check_Independent_Loads (T : in out Test_Case'Class) is
      task type Reader is
         entry Get_Count (Count : out Natural);
      end Reader;

      task body Reader is
         Cases : constant Case_Vectors.Vector := Load ("int");
      begin
         accept Get_Count (Count : out Natural) do
            Count := Natural (Cases.Length);
         end Get_Count;
      end Reader;

      First, Second : Reader;
      A, B : Natural;
   begin
      Assert (T.Name /= null, "test has a name");
      First.Get_Count (A);
      Second.Get_Count (B);
      Assert (A = 14_560 and then B = A, "concurrent loads are independent");
      begin
         declare
            Missing : constant Case_Vectors.Vector :=
              Load ("fixture_support_nonexistent");
         begin
            Assert (Missing.Is_Empty, "missing fixture contains no cases");
            Assert (False, "missing fixture must raise Name_Error");
         end;
      exception
         when Ada.Text_IO.Name_Error => null;
      end;
      Assert (Load ("int").Length = 14_560, "load after missing fixture");
   end Check_Independent_Loads;

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
      Registration.Register_Routine
        (T, Check_Independent_Loads'Access, "Independent fixture loads");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Fixture_Case);
      return Result;
   end Suite;
end Test_Fixture_Support;
