with Ada.Calendar;
with Ada.Containers;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Count;

package body Compat_Count is
   use AUnit.Test_Cases;
   use type Ada.Containers.Count_Type;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   use Math_Prime_Util.Count;
   type Count_Case is new Test_Case with null record;
   overriding function Name (T : Count_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Count_Case);
   overriding function Name (T : Count_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Count");
   end Name;

   procedure Test_Count (T : in out Test_Case'Class) is
      N, Expected : U64;
      Rows : Natural := 0;
      --  Local count workspaces must not interfere across concurrent calls.
      task type Counter is
         entry Finish (Passed : out Boolean);
      end Counter;
      task body Counter is
         Valid : Boolean := True;
      begin
         for I in 1 .. 3 loop
            Valid := Valid and then Prime_Count (100_000_000) = 5_761_455;
         end loop;
         accept Finish (Passed : out Boolean) do
            Passed := Valid;
         end Finish;
      end Counter;
      Workers : array (1 .. 2) of Counter;
      Passed : Boolean;
   begin
      for Worker of Workers loop
         Worker.Finish (Passed);
         AUnit.Assertions.Assert (Passed, "concurrent repeated counts");
      end loop;
      --  This checkout lacks the prior count suite. Keep this replay bounded
      --  until the large native fixtures have a measured gate time budget.
      for C of For_Function (Load ("count"), "prime_count") loop
         if C.Args.Length = 1
           and then Parse_U64 (To_String (C.Args (1)), N)
           and then N <= 100_000_000_000
           and then Parse_U64 (To_String (C.Result), Expected)
         then
            AUnit.Assertions.Assert
              (Prime_Count (N) = Expected,
               "prime_count fixture" & Positive'Image (C.Line_Number));
            Rows := Rows + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Rows > 100, "count fixtures replayed");
      for I in U64 range 0 .. 100 loop
         AUnit.Assertions.Assert
           (Prime_Count (Nth_Prime (I)) = I, "inverse count");
      end loop;
   end Test_Count;

   procedure Benchmark (T : in out Test_Case'Class) is
      use Ada.Calendar;
      type Expected_Counts is array (Positive range <>) of U64;
      Expected : constant Expected_Counts :=
        (4, 25, 168, 1229, 9592, 78498, 664579, 5761455, 50847534,
         455052511, 4118054813, 37607912018, 346065536839);
      N : U64 := 1;
      Start : Time;
      Actual : U64;
   begin
      for K in Expected'Range loop
         N := N * 10;
         Start := Clock;
         Actual := Prime_Count (N);
         Ada.Text_IO.Put_Line
           ("Lehmer 10^" & Integer'Image (K) & " seconds" &
            Duration'Image (Clock - Start));
         AUnit.Assertions.Assert (Actual = Expected (K), "power of ten");
      end loop;
   end Benchmark;

   overriding procedure Register_Tests (T : in out Count_Case) is
   begin
      Registration.Register_Routine (T, Test_Count'Access, "count");
      Registration.Register_Routine (T, Benchmark'Access, "benchmark");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Count_Case);
      return Result;
   end Suite;
end Compat_Count;
