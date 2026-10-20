with AUnit.Assertions;
with Ada.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Sieve;
with Math_Prime_Util.Int;

package body Prop_Sieve is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Sieve;
   use type U64;
   use type Prime_Vectors.Vector;
   type Sieve_Case is new Test_Case with null record;
   overriding function Name (T : Sieve_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Sieve_Case);

   overriding function Name (T : Sieve_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Sieve seed 20261020");
   end Name;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      Low, High, Sum : U64;
      Left, Right, Whole : Prime_Vectors.Vector;
   begin
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         Low := Seed mod 100_000;
         High := Low + 100;
         Whole := Primes (Low, High);
         Left := Primes (Low, Low + 49);
         Right := Primes (Low + 50, High);
         Left.Append (Right);
         AUnit.Assertions.Assert (Left = Whole, "partition seed 20261020");
         Sum := 0;
         --  Element returns a copy and avoids GNAT 16 reference-finalizer
         --  links across library units compiled with different profiles.
         for Index in Whole.First_Index .. Whole.Last_Index loop
            declare
               P : constant U64 := Whole.Element (Index);
            begin
            for D in U64 range 2 .. Int.Sqrtint (P) loop
               AUnit.Assertions.Assert (P mod D /= 0, "trial division");
            end loop;
            AUnit.Assertions.Assert
              (Prev_Prime (Next_Prime (P)) = P, "navigation round trip");
            Sum := Sum + P;
            end;
         end loop;
         AUnit.Assertions.Assert
           (Sum_Primes (Low, High).Value = Sum, "sum seed 20261020");
      end loop;
      AUnit.Assertions.Assert (Primes (100, 2).Is_Empty, "reversed range");
      AUnit.Assertions.Assert (Primes (0).Is_Empty, "zero bound");
      Whole := Primes (0, 1_000_000);
      AUnit.Assertions.Assert
        (Natural (Whole.Length) = 78_498, "multiple segment count");
   end Laws;

   procedure Boundaries (T : in out Test_Case'Class) is
      Last_Prime : constant U64 := 18_446_744_073_709_551_557;
      V : Prime_Vectors.Vector;
      Rejected : Boolean := False;
   begin
      AUnit.Assertions.Assert (Next_Prime (0) = 2, "zero successor");
      AUnit.Assertions.Assert (Prev_Prime (2) = 0, "no predecessor");
      AUnit.Assertions.Assert
        (Next_Prime (Last_Prime) = 0, "no native successor");
      AUnit.Assertions.Assert
        (Prev_Prime (U64'Last) = Last_Prime, "maximum predecessor");
      V := Primes (Last_Prime, U64'Last);
      AUnit.Assertions.Assert
        (Natural (V.Length) = 1 and then V.First_Element = Last_Prime,
         "native sieve boundary");
      V := Sieve_Range (U64'Last, 0, U64'Last);
      AUnit.Assertions.Assert (V.Is_Empty, "zero width at maximum");
      V := Sieve_Range (45, 10, 7);
      AUnit.Assertions.Assert
        (Natural (V.Length) = 2 and then V.First_Element = 4
         and then V.Last_Element = 8,
         "partial sieve retains offsets");
      begin
         V := Sieve_Range (U64'Last, 2, 0);
      exception
         when Ada.Assertions.Assertion_Error => Rejected := True;
      end;
      AUnit.Assertions.Assert (Rejected, "overflowing interval rejected");
   end Boundaries;

   procedure Concurrent_Cache (T : in out Test_Case'Class) is
      protected Results is
         procedure Fail;
         function Passed return Boolean;
      private
         Good : Boolean := True;
      end Results;
      protected body Results is
         procedure Fail is
         begin
            Good := False;
         end Fail;
         function Passed return Boolean is (Good);
      end Results;
      task type Worker;
      task body Worker is
      begin
         for I in 1 .. 10 loop
            Prime_Precalc (U64 (I) * 100);
            Prime_Memfree;
            if Natural (Primes (1_000).Length) /= 168 then
               Results.Fail;
            end if;
         end loop;
      exception
         when Constraint_Error | Storage_Error |
           Ada.Assertions.Assertion_Error =>
            Results.Fail;
      end Worker;
   begin
      declare
         Workers : array (1 .. 4) of Worker;
      begin
         null;
      end;
      AUnit.Assertions.Assert (Results.Passed, "concurrent cache readers");
   end Concurrent_Cache;

   overriding procedure Register_Tests (T : in out Sieve_Case) is
   begin
      Registration.Register_Routine (T, Boundaries'Access, "boundaries");
      Registration.Register_Routine (T, Laws'Access, "sieve laws");
      Registration.Register_Routine
        (T, Concurrent_Cache'Access, "concurrent cache");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Sieve_Case);
      return Result;
   end Suite;
end Prop_Sieve;
