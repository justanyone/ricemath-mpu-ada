with AUnit.Assertions;
with AUnit.Test_Cases;
with Interfaces;
with Math_Prime_Util;
with Fixture_Support;

package body Version_Suite is
   use AUnit.Test_Cases;

   type Version_Case is new Test_Case with null record;
   overriding function Name (T : Version_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Version_Case);

   procedure Test_Version_Set (T : in out Test_Case'Class);
   procedure Test_U128_Width (T : in out Test_Case'Class);
   procedure Test_Fixtures (T : in out Test_Case'Class);

   overriding function Name (T : Version_Case) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Root package");
   end Name;

   procedure Test_Version_Set (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.Version'Length > 0, "version is empty");
   end Test_Version_Set;

   procedure Test_U128_Width (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      use type Interfaces.Unsigned_128;
   begin
      AUnit.Assertions.Assert
        (Math_Prime_Util.U128'Last
           > Math_Prime_Util.U128 (Math_Prime_Util.U64'Last),
         "U128 is not wider than U64");
   end Test_U128_Width;

   procedure Test_Fixtures (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
      Cases : constant Fixture_Support.Case_Vectors.Vector :=
        Fixture_Support.Load ("int");
      Sqrt_Cases : constant Fixture_Support.Case_Vectors.Vector :=
        Fixture_Support.For_Function (Cases, "sqrtint");
   begin
      AUnit.Assertions.Assert (Cases.Length > 1_000, "int fixture too small");
      AUnit.Assertions.Assert (Sqrt_Cases.Length > 10, "sqrtint count");
      AUnit.Assertions.Assert (Sqrt_Cases (1).Args (1).all = "1524155677489",
                               "first sqrtint argument");
      AUnit.Assertions.Assert (Sqrt_Cases (1).Result.all = "1234567",
                               "first sqrtint result");
   end Test_Fixtures;

   overriding procedure Register_Tests (T : in out Version_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Version_Set'Access, "Version is set");
      Registration.Register_Routine
        (T, Test_U128_Width'Access, "U128 is wider than U64");
      Registration.Register_Routine
        (T, Test_Fixtures'Access, "Fixture loader reads int.tsv");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Version_Case);
      return Result;
   end Suite;
end Version_Suite;
