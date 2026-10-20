with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Count;
with Math_Prime_Util.Int;

package body Compat_Count is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use type U64;
   type Count_Case is new Test_Case with null record;
   overriding function Name (T : Count_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Count_Case);

   overriding function Name (T : Count_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Count");
   end Name;

   procedure Check_Sums (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "sum_primes");
      Low, High : U64;
      Actual : Int.Optional_U64;
      Expected : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "sum fixtures present");
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), Low), "sum first argument");
         if C.Args.Last_Index = 1 then
            Actual := Count.Sum_Primes (Low);
         else
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (2)), High), "sum upper bound");
            Actual := Count.Sum_Primes (Low, High);
         end if;
         AUnit.Assertions.Assert
           (Actual.Defined /= C.Undef, "sum overflow status");
         if not C.Undef then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "sum result");
            AUnit.Assertions.Assert
              (Actual.Value = Expected, "sum_primes row" &
               Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Sums;

   overriding procedure Register_Tests (T : in out Count_Case) is
   begin
      Registration.Register_Routine (T, Check_Sums'Access, "sum_primes");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Count_Case);
      return Result;
   end Suite;
end Compat_Count;
