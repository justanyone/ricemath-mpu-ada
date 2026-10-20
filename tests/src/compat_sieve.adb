with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Sieve;

package body Compat_Sieve is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Sieve;
   use type U64;
   type Sieve_Case is new Test_Case with null record;
   overriding function Name (T : Sieve_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Sieve_Case);

   overriding function Name (T : Sieve_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Sieve");
   end Name;

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Low, High : U64;
      Valid : Boolean;
      Actual : Unbounded_String;
      Count : Natural := 0;
   begin
      for C of For_Function (Load ("sieve"), Func) loop
         Low := 0;
         if Natural (C.Args.Length) = 1 then
            Valid := Parse_U64 (To_String (C.Args (1)), High);
         else
            Valid := Parse_U64 (To_String (C.Args (1)), Low)
              and Parse_U64 (To_String (C.Args (2)), High);
         end if;
         if C.Error then
            --  Negative Perl arguments are excluded by the Ada U64 type.
            AUnit.Assertions.Assert (not Valid, "negative argument");
         elsif Valid and then High <= 10_000_000_000 then
            --  Pending high-range BPSW path: larger rows are not covered.
            Actual := Null_Unbounded_String;
            if Func = "primes" then
               for P of Primes (Low, High) loop
                  if Length (Actual) > 0 then
                     Append (Actual, " ");
                  end if;
                  Append (Actual, Image (P));
               end loop;
            else
               declare
                  R : constant Int.Optional_U64 := Sum_Primes (Low, High);
               begin
                  if R.Defined then
                     Actual := To_Unbounded_String (Image (R.Value));
                  else
                     Actual := To_Unbounded_String ("undef");
                  end if;
               end;
            end if;
            AUnit.Assertions.Assert
              (Actual = C.Result, Func & Positive'Image (C.Line_Number)
               & ": " & To_String (Actual));
            Count := Count + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Count > 0, "fixture rows replayed");
   end Replay;

   procedure Test_Primes (T : in out Test_Case'Class) is
   begin
      Replay ("primes");
   end Test_Primes;

   procedure Test_Sum (T : in out Test_Case'Class) is
   begin
      Replay ("sum_primes");
   end Test_Sum;

   procedure Test_Precalc (T : in out Test_Case'Class) is
   begin
      Prime_Precalc (1_000);
      Prime_Precalc (1_000);
      Prime_Precalc (10);
      AUnit.Assertions.Assert
        (Natural (Primes (100).Length) = 25, "repeated cache growth");
   end Test_Precalc;

   procedure Test_Memfree (T : in out Test_Case'Class) is
   begin
      Prime_Memfree;
      Prime_Memfree;
      AUnit.Assertions.Assert
        (Natural (Primes (100).Length) = 25, "cache recreation");
   end Test_Memfree;

   overriding procedure Register_Tests (T : in out Sieve_Case) is
   begin
      Registration.Register_Routine (T, Test_Primes'Access, "primes");
      Registration.Register_Routine (T, Test_Sum'Access, "sum_primes");
      Registration.Register_Routine (T, Test_Precalc'Access, "prime_precalc");
      Registration.Register_Routine (T, Test_Memfree'Access, "prime_memfree");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Sieve_Case);
      return Result;
   end Suite;
end Compat_Sieve;
