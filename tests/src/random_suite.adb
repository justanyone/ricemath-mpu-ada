with AUnit.Test_Cases;
with Ada.Tags;
with Compat_Random;
package body Random_Suite is
   type Random_Case is new AUnit.Test_Cases.Test_Case with null record;
   overriding function Name (T : Random_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Random_Case);
   overriding function Name (T : Random_Case) return AUnit.Message_String is
     (AUnit.Format (Ada.Tags.Expanded_Name (Random_Case'Class (T)'Tag)));
   overriding procedure Register_Tests (T : in out Random_Case) is
   begin
      AUnit.Test_Cases.Registration.Register_Routine
        (T, Compat_Random'Access, "Fixtures and seeded boundary properties");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Random_Case);
      return Result;
   end Suite;
end Random_Suite;
