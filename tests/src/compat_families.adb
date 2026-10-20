with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Families;
with Math_Prime_Util.Int;

package body Compat_Families is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   use Math_Prime_Util.Families;
   type Families_Case is new Test_Case with null record;
   overriding function Name (T : Families_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Families_Case);
   overriding function Name (T : Families_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Families");
   end Name;

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));
   function Image (N : Int.Optional_U64) return String is
     (if N.Defined then Image (N.Value) else "undef");

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("families"), Func);
      N : U64;
      Got : Unbounded_String;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         N := U64'Value (To_String (C.Args (1)));
         Got := Null_Unbounded_String;
         if Func = "lucky_numbers" then
            declare
               V : constant Lucky_Vectors.Vector :=
                 (if Natural (C.Args.Length) = 1 then Lucky_Numbers (N)
                  else Lucky_Numbers
                    (N, U64'Value (To_String (C.Args (2)))));
            begin
               for J in V.First_Index .. V.Last_Index loop
                  if Length (Got) > 0 then
                     Append (Got, " ");
                  end if;
                  Append (Got, Image (V.Element (J)));
               end loop;
               if V.Is_Empty then
                  Got := To_Unbounded_String ("undef");
               end if;
            end;
         elsif Func = "is_lucky" then
            Got := To_Unbounded_String ((if Is_Lucky (N) then "1" else "0"));
         elsif Func = "lucky_count" then
            Got := To_Unbounded_String (Image (Lucky_Count (N)));
         elsif Func = "lucky_count_approx" then
            Got := To_Unbounded_String (Image (Lucky_Count_Approx (N)));
         elsif Func = "lucky_count_lower" then
            Got := To_Unbounded_String (Image (Lucky_Count_Lower (N)));
         elsif Func = "lucky_count_upper" then
            Got := To_Unbounded_String (Image (Lucky_Count_Upper (N)));
         elsif Func = "nth_lucky" then
            Got := To_Unbounded_String (Image (Nth_Lucky (N)));
         elsif Func = "nth_lucky_approx" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Approx (N)));
         elsif Func = "nth_lucky_lower" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Lower (N)));
         elsif Func = "nth_lucky_upper" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Upper (N)));
         end if;
         AUnit.Assertions.Assert
           (Got = C.Result, Func & " line" & C.Line_Number'Image &
            " expected " & To_String (C.Result) & " got " & To_String (Got));
      end loop;
   end Replay;

   procedure Test_Lucky_Numbers (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_numbers");
   end Test_Lucky_Numbers;

   procedure Test_Is_Lucky (T : in out Test_Case'Class) is
   begin
      Replay ("is_lucky");
   end Test_Is_Lucky;

   procedure Test_Lucky_Count (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count");
   end Test_Lucky_Count;

   procedure Test_Lucky_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_approx");
   end Test_Lucky_Count_Approx;

   procedure Test_Lucky_Count_Lower (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_lower");
   end Test_Lucky_Count_Lower;

   procedure Test_Lucky_Count_Upper (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_upper");
   end Test_Lucky_Count_Upper;

   procedure Test_Nth_Lucky (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky");
   end Test_Nth_Lucky;

   procedure Test_Nth_Lucky_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_approx");
   end Test_Nth_Lucky_Approx;

   procedure Test_Nth_Lucky_Lower (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_lower");
   end Test_Nth_Lucky_Lower;

   procedure Test_Nth_Lucky_Upper (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_upper");
   end Test_Nth_Lucky_Upper;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Lucky_Numbers'Access, "lucky_numbers");
      Registration.Register_Routine
        (T, Test_Is_Lucky'Access, "is_lucky");
      Registration.Register_Routine
        (T, Test_Lucky_Count'Access, "lucky_count");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Approx'Access, "lucky_count_approx");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Lower'Access, "lucky_count_lower");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Upper'Access, "lucky_count_upper");
      Registration.Register_Routine
        (T, Test_Nth_Lucky'Access, "nth_lucky");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Approx'Access, "nth_lucky_approx");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Lower'Access, "nth_lucky_lower");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Upper'Access, "nth_lucky_upper");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Families_Case);
      return Result;
   end Suite;
end Compat_Families;
