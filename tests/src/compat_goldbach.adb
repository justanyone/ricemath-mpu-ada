with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util;
with Math_Prime_Util.Goldbach;
with Math_Prime_Util.Int;

package body Compat_Goldbach is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use type Math_Prime_Util.U64;
   use Math_Prime_Util.Goldbach;

   type Goldbach_Case is new Test_Case with null record;
   overriding function Name (T : Goldbach_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Goldbach_Case);

   overriding function Name (T : Goldbach_Case) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Compat_Goldbach");
   end Name;

   function Image (N : Math_Prime_Util.U64) return String is
     (Ada.Strings.Fixed.Trim
        (Math_Prime_Util.U64'Image (N), Ada.Strings.Both));
   function Image (N : Math_Prime_Util.Int.Optional_U64) return String is
     (if N.Defined then Image (N.Value) else "undef");

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("families"), Func);
      N : Math_Prime_Util.U64;
      Got : Unbounded_String;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         N := Math_Prime_Util.U64'Value (To_String (C.Args (1)));
         if Func = "minimal_goldbach_pair" then
            Got := To_Unbounded_String (Image (Minimal_Goldbach_Pair (N)));
         elsif Func = "goldbach_pair_count" then
            Got := To_Unbounded_String (Image (Goldbach_Pair_Count (N)));
         else
            declare
               Pairs : constant Pair_Vectors.Vector := Goldbach_Pairs (N);
            begin
               Got := Null_Unbounded_String;
               for P of Pairs loop
                  if Length (Got) > 0 then
                     Append (Got, " ");
                  end if;
                  Append (Got, Image (P));
               end loop;
               if Pairs.Is_Empty then
                  Got := To_Unbounded_String ("undef");
               end if;
            end;
         end if;
         AUnit.Assertions.Assert
           (Got = C.Result, Func & " line" & C.Line_Number'Image &
            " expected " & To_String (C.Result) & " got " & To_String (Got));
      end loop;
   end Replay;

   procedure Test_Minimal (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Replay ("minimal_goldbach_pair");
   end Test_Minimal;

   procedure Test_Count (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Replay ("goldbach_pair_count");
   end Test_Count;

   procedure Test_Pairs (T : in out Test_Case'Class) is
      pragma Unreferenced (T);
   begin
      Replay ("goldbach_pairs");
   end Test_Pairs;

   overriding procedure Register_Tests (T : in out Goldbach_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Minimal'Access, "minimal_goldbach_pair");
      Registration.Register_Routine
        (T, Test_Count'Access, "goldbach_pair_count");
      Registration.Register_Routine
        (T, Test_Pairs'Access, "goldbach_pairs");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (Goldbach_Case' (null record));
      return Result;
   end Suite;
end Compat_Goldbach;
