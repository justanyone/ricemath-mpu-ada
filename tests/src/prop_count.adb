with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Count;
with Math_Prime_Util.Sieve;

package body Prop_Count is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use type U64;
   type Count_Case is new Test_Case with null record;
   overriding function Name (T : Count_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Count_Case);

   overriding function Name (T : Count_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Count seed 20261020");
   end Name;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N : U64;
      Expected : U64;
   begin
      for K in U64 range 1 .. 100 loop
         N := Count.Nth_Prime (K);
         AUnit.Assertions.Assert
           (Count.Prime_Count (N) = K, "count nth inverse seed 20261020");
         AUnit.Assertions.Assert
           (Count.Prime_Count (N - 1) = K - 1,
            "count prime increment seed 20261020");
         AUnit.Assertions.Assert
           (Count.Nth_Prime_Lower (K) <= N and then
            N <= Count.Nth_Prime_Upper (K), "nth bounds seed 20261020");
         AUnit.Assertions.Assert
           (Count.Prime_Count_Lower (N) <= K and then
            K <= Count.Prime_Count_Upper (N), "count bounds seed 20261020");
         AUnit.Assertions.Assert
           (Count.Legendre_Phi (N, 1) = N - N / 2,
            "phi parity seed 20261020");
      end loop;
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 2 + Seed mod 10_000;
         Expected := 0;
         declare
            Primes : constant Sieve.Prime_Vectors.Vector := Sieve.Primes (N);
         begin
            for J in Primes.First_Index .. Primes.Last_Index loop
               Expected := Expected + Primes.Element (J);
            end loop;
         end;
         AUnit.Assertions.Assert
           (Count.Sum_Primes (N).Value = Expected, "sieve sum seed 20261020");
         AUnit.Assertions.Assert
           (Count.Sum_Primes (N).Value = Count.Sum_Primes (N / 2).Value +
            Count.Sum_Primes (N / 2 + 1, N).Value, "partition seed 20261020");
      end loop;
      AUnit.Assertions.Assert
        (Count.Sum_Primes (100, 2).Value = 0, "reversed bounds");
      AUnit.Assertions.Assert
        (Count.Sum_Primes (U64'Last, U64'Last).Value = 0, "above last prime");
      AUnit.Assertions.Assert
        (Count.Sum_Primes (0).Value = 0 and Count.Sum_Primes (1).Value = 0,
         "empty prefixes");
   end Laws;

   procedure Boundaries (T : in out Test_Case'Class) is
      Last_Prime : constant U64 := 18_446_744_073_709_551_557;
   begin
      AUnit.Assertions.Assert
        (not Count.Sum_Primes (29_505_444_491).Defined,
         "first prefix sum overflow");
      AUnit.Assertions.Assert
        (not Count.Sum_Primes (U64'Last).Defined, "maximum prefix");
      AUnit.Assertions.Assert
        (Count.Sum_Primes (Last_Prime, U64'Last).Value = Last_Prime,
         "last native prime");
      for K in 1 .. 2 loop
         AUnit.Assertions.Assert
           (Count.Sum_Primes (100_000).Value = 454_396_537,
            "repeated calls use independent scratch storage");
      end loop;
   end Boundaries;

   procedure Concurrent_Calls (T : in out Test_Case'Class) is
      type Results is array (Positive range 1 .. 2) of U64;
      Values : Results := (others => 0);
      task type Worker (Index : Positive);
      task body Worker is
      begin
         Values (Index) := Count.Sum_Primes (100_000).Value;
      end Worker;
   begin
      declare
         First : Worker (1);
         Second : Worker (2);
      begin
         null;
      end;
      AUnit.Assertions.Assert
        (Values (1) = 454_396_537 and Values (2) = Values (1),
         "concurrent sums use independent scratch storage");
   end Concurrent_Calls;

   overriding procedure Register_Tests (T : in out Count_Case) is
   begin
      Registration.Register_Routine
        (T, Boundaries'Access, "sum boundaries and repeated calls");
      Registration.Register_Routine
        (T, Concurrent_Calls'Access, "concurrent sums");
      Registration.Register_Routine (T, Laws'Access, "sum laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Count_Case);
      return Result;
   end Suite;
end Prop_Count;
