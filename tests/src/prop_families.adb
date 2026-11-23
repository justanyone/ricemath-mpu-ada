with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Families;
with Math_Prime_Util.Ramanujan;
with Math_Prime_Util.Sieve;

package body Prop_Families is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use type U64;
   use Math_Prime_Util.Families;
   use type Lucky_Vectors.Vector;
   type Families_Case is new Test_Case with null record;
   overriding function Name (T : Families_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Families_Case);
   overriding function Name (T : Families_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Families seed 20261020");
   end Name;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, V : U64;
      Left, Right : Lucky_Vectors.Vector;
   begin
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 1 + Seed mod 2_000;
         V := Nth_Lucky (N).Value;
         AUnit.Assertions.Assert
           (Is_Lucky (V) and then Lucky_Count (V) = N,
            "count/nth inverse seed 20261020");
         AUnit.Assertions.Assert
           (Lucky_Count_Lower (V) <= N and then N <= Lucky_Count_Upper (V),
            "count bounds seed 20261020");
         AUnit.Assertions.Assert
           (Nth_Lucky_Lower (N).Value <= V and
            V <= Nth_Lucky_Upper (N).Value, "nth bounds seed 20261020");
         Left := Lucky_Numbers (0, N);
         Right := Lucky_Numbers (N + 1, 2 * N);
         Left.Append (Right);
         AUnit.Assertions.Assert
           (Left = Lucky_Numbers (2 * N), "range partition");
      end loop;
      AUnit.Assertions.Assert
        (Lucky_Numbers (9, 1).Is_Empty and then Lucky_Count (0) = 0,
         "reversed and then zero ranges");
      AUnit.Assertions.Assert
        (not Is_Lucky (U64'Last) and then not Is_Lucky (2 ** 63),
         "native boundary prefilters");
      AUnit.Assertions.Assert
        (Nth_Lucky_Approx (U64'Last).Value =
           18_446_744_073_709_551_517, "estimate saturation");
   end Laws;

   procedure Concurrent_Calls (T : in out Test_Case'Class) is
      task type Worker is
         entry Check (Success : out Boolean);
      end Worker;
      task body Worker is
         Valid : Boolean := True;
      begin
         for I in 1 .. 3 loop
            Valid := Valid and then Lucky_Count (5_964_377) = 376_288
              and then Nth_Lucky (123_456).Value = 1795453
              and then Is_Lucky (1795453);
         end loop;
         accept Check (Success : out Boolean) do
            Success := Valid;
         end Check;
      end Worker;
      Workers : array (1 .. 4) of Worker;
      Valid : Boolean;
   begin
      for W of Workers loop
         W.Check (Valid);
         AUnit.Assertions.Assert (Valid, "independent repeated sieves");
      end loop;
   end Concurrent_Calls;

   --  Noe's window must preserve membership, index, and interval identities.
   procedure Ramanujan_Laws (T : in out Test_Case'Class) is
      use Math_Prime_Util.Ramanujan;
      use type Math_Prime_Util.Sieve.Prime_Vectors.Vector;
      Seed : U64 := 20_261_123;
      N, P : U64;
      Edges : constant array (Positive range 1 .. 7) of U64 :=
        [2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last];
   begin
      for I in 1 .. 40 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 1 + Seed mod 500;
         P := Nth_Ramanujan_Prime (N).Value;
         AUnit.Assertions.Assert
           (Is_Ramanujan_Prime (P) and then
            Ramanujan_Prime_Count (P) = N and then
            Ramanujan_Prime_Count (P - 1) = N - 1 and then
            Nth_Ramanujan_Prime_Lower (N).Value <= P and then
            P <= Nth_Ramanujan_Prime_Upper (N).Value,
            "Ramanujan inverse/bounds seed 20261123 index" & N'Image);
      end loop;
      AUnit.Assertions.Assert
        (Ramanujan_Primes (100, 2).Is_Empty and then
         Ramanujan_Prime_Count (100, 2) = 0 and then
         Ramanujan_Prime_Count (0, 1) = 0 and then
         Ramanujan_Prime_Count (2, 2) = 1 and then
         Ramanujan_Primes (100, 100) = Ramanujan_Primes (1),
         "Ramanujan empty/reversed/singleton intervals");
      for Edge of Edges loop
         AUnit.Assertions.Assert
           (Ramanujan_Prime_Count_Lower (Edge) <=
              Ramanujan_Prime_Count_Approx (Edge) and then
            Ramanujan_Prime_Count_Approx (Edge) <=
              Ramanujan_Prime_Count_Upper (Edge),
            "Ramanujan native count bounds" & Edge'Image);
      end loop;
   end Ramanujan_Laws;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine
        (T, Ramanujan_Laws'Access, "Ramanujan laws seed 20261123");
      Registration.Register_Routine (T, Laws'Access, "lucky laws");
      Registration.Register_Routine
        (T, Concurrent_Calls'Access, "concurrent repeated sieves");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Families_Case);
      return Result;
   end Suite;
end Prop_Families;
