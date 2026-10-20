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

   overriding procedure Register_Tests (T : in out Count_Case) is
   begin
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
