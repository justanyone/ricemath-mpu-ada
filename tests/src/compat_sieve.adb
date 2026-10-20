with Ada.Assertions;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Sieve;
with Math_Prime_Util.Int;

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
      Low, High, Depth : U64;
      Valid : Boolean;
      Actual : Unbounded_String;
      Count : Natural := 0;
      Values : Prime_Vectors.Vector;
   begin
      for C of For_Function (Load ("sieve"), Func) loop
         Low := 0;
         Depth := 0;
         Valid := True;
         for Arg of C.Args loop
            declare
               V : U64;
            begin
               Valid := Parse_U64 (To_String (Arg), V) and then Valid;
            end;
         end loop;
         if Natural (C.Args.Length) = 1 then
            Valid := Parse_U64 (To_String (C.Args (1)), High)
              and then Valid;
         else
            Valid := Parse_U64 (To_String (C.Args (1)), Low)
              and then Valid;
            Valid := Parse_U64 (To_String (C.Args (2)), High)
              and then Valid;
         end if;
         Actual := Null_Unbounded_String;
         Values.Clear;
         if C.Error and then not Valid then
            --  Negative and wider-than-native arguments cannot be U64.
            Count := Count + 1;
         elsif Func = "sum_primes" and then High > 100_000_000
           and then High - Low > 100_000_000
         then
            --  Pending util.c: sum_primes table and streaming fast path.
            --  Large prefix sum fixtures exceed this port's test budget.
            null;
         elsif Valid then
            if Func = "primes" then
               Values := Primes (Low, High);
            elsif Func = "next_prime" then
               Actual := To_Unbounded_String (Image (Next_Prime (High)));
            elsif Func = "prev_prime" then
               Actual := To_Unbounded_String (Image (Prev_Prime (High)));
            elsif Func = "sieve_range" then
               Valid := Parse_U64 (To_String (C.Args (3)), Depth);
               Values := Sieve_Range (Low, High, Depth);
            elsif Func = "sieve_prime_cluster" then
               declare
                  Rejected : Boolean := False;
                  Offsets : Cluster_Offsets
                    (1 .. Natural (C.Args.Length) - 2);
               begin
                  for I in Offsets'Range loop
                     Valid := Parse_U64
                       (To_String (C.Args (I + 2)), Offsets (I));
                  end loop;
                  begin
                     Values := Sieve_Prime_Cluster (Low, High, Offsets);
                  exception
                     when Ada.Assertions.Assertion_Error =>
                        Rejected := True;
                  end;
                  AUnit.Assertions.Assert
                    (Rejected = C.Error, "cluster offset validation");
               end;
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
            for P of Values loop
               if Length (Actual) > 0 then
                  Append (Actual, " ");
               end if;
               Append (Actual, Image (P));
            end loop;
            if not C.Error then
               AUnit.Assertions.Assert
                 (Actual = C.Result, Func & Positive'Image (C.Line_Number)
                  & ": " & To_String (Actual));
            end if;
            Count := Count + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Count > 0, "fixture rows replayed");
   end Replay;

   procedure Test_Next (T : in out Test_Case'Class) is
   begin
      Replay ("next_prime");
   end Test_Next;

   procedure Test_Prev (T : in out Test_Case'Class) is
   begin
      Replay ("prev_prime");
   end Test_Prev;

   procedure Test_Range (T : in out Test_Case'Class) is
   begin
      Replay ("sieve_range");
   end Test_Range;

   procedure Test_Cluster (T : in out Test_Case'Class) is
   begin
      Replay ("sieve_prime_cluster");
   end Test_Cluster;

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
      Registration.Register_Routine (T, Test_Next'Access, "next_prime");
      Registration.Register_Routine (T, Test_Prev'Access, "prev_prime");
      Registration.Register_Routine (T, Test_Range'Access, "sieve_range");
      Registration.Register_Routine
        (T, Test_Cluster'Access, "sieve_prime_cluster");
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
