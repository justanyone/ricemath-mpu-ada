with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Families;

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


   --  Given seeded intervals, when factor families are partitioned, then
   --  lists, counts and one-based selection agree independently.
   procedure Factor_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_123;
      High : U64;
      A, B : Family_Vectors.Vector;
   begin
      for Iteration in 1 .. 20 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         High := 1 + Seed mod 500;
         for K in 0 .. 9 loop
            A := Almost_Primes (K, High);
            AUnit.Assertions.Assert
              (U64 (A.Length) = Almost_Prime_Count (K, High),
               "almost list/count seed 20261123");
            B := Almost_Primes (K, 0, High / 2);
            B.Append (Almost_Primes (K, High / 2 + 1, High));
            AUnit.Assertions.Assert (A = B, "almost partition seed 20261123");
            A := Omega_Primes (K, High);
            AUnit.Assertions.Assert
              (U64 (A.Length) = Omega_Prime_Count (K, High),
               "omega list/count seed 20261123");
            B := Omega_Primes (K, 0, High / 2);
            B.Append (Omega_Primes (K, High / 2 + 1, High));
            AUnit.Assertions.Assert (A = B, "omega partition seed 20261123");
         end loop;
      end loop;
      for K in 1 .. 5 loop
         for N in U64 range 1 .. 12 loop
            High := Nth_Almost_Prime (K, N).Value;
            AUnit.Assertions.Assert
              (Almost_Prime_Count (K, High) = N and then
               Almost_Prime_Count (K, High - 1) = N - 1,
               "almost nth inverse");
            High := Nth_Omega_Prime (K, N).Value;
            AUnit.Assertions.Assert
              (Omega_Prime_Count (K, High) = N and then
               Omega_Prime_Count (K, High - 1) = N - 1,
               "omega nth inverse");
         end loop;
      end loop;
      AUnit.Assertions.Assert
        (Almost_Primes (2, 10, 1).Is_Empty and then
         Omega_Primes (2, 10, 1).Is_Empty and then
         Almost_Prime_Count (2, 10, 1) = 0 and then
         Omega_Prime_Count (2, 10, 1) = 0,
         "reversed ranges");
      AUnit.Assertions.Assert
        (Almost_Prime_Count (0, 0, 1) = 1 and then
         Omega_Prime_Count (0, 0, 1) = 1 and then
         Almost_Prime_Count (63, U64'Last) = 2 and then
         not Nth_Almost_Prime (63, 3).Defined and then
         not Nth_Omega_Prime (16, 1).Defined,
         "zero-factor and native overflow edges");
      declare
         Edges : constant array (Positive range 1 .. 5) of U64 :=
           [2 ** 32 - 1, 2 ** 32 + 1, 2 ** 63 - 1, 2 ** 63 + 1, U64'Last];
      begin
         for Edge of Edges loop
            AUnit.Assertions.Assert
              (Almost_Primes (64, Edge, Edge).Is_Empty and then
               Omega_Primes (16, Edge, Edge).Is_Empty,
               "impossible factor counts at native boundaries");
         end loop;
      end;
   end Factor_Laws;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine
        (T, Factor_Laws'Access, "factor family laws");
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
