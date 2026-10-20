with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Count;
with Math_Prime_Util.Int;

package body Compat_Count is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use type U64;
   type Count_Case is new Test_Case with null record;
   overriding function Name (T : Count_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Count_Case);

   overriding function Name (T : Count_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Count");
   end Name;

   procedure Check_Sums (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "sum_primes");
      Low, High : U64;
      Actual : Int.Optional_U64;
      Expected : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "sum fixtures present");
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), Low), "sum first argument");
         if C.Args.Last_Index = 1 then
            Actual := Count.Sum_Primes (Low);
         else
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (2)), High), "sum upper bound");
            Actual := Count.Sum_Primes (Low, High);
         end if;
         AUnit.Assertions.Assert
           (Actual.Defined /= C.Undef, "sum overflow status");
         if not C.Undef then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "sum result");
            AUnit.Assertions.Assert
              (Actual.Value = Expected, "sum_primes row" &
               Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Sums;

   --  Rows above the limits of Count (Prime_Count_Limit, Nth_Prime_Limit,
   --  Legendre_Index_Limit) are skipped: the LMO tables, the Lehmer
   --  method and the 64-bit Legendre cache are not ported yet.
   --  Rows with undef results are skipped: a Pre check rejects them.
   procedure Check_Prime_Count (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "prime_count");
      N : U64;
      Expected : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "prime_count present");
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "prime_count argument");
         if not C.Undef and then N <= Count.Prime_Count_Limit then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected),
               "prime_count result");
            AUnit.Assertions.Assert
              (Count.Prime_Count (N) = Expected, "prime_count row" &
               Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Prime_Count;

   procedure Check_Nth_Prime (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "nth_prime");
      N : U64;
      Expected : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "nth_prime present");
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "nth_prime argument");
         if not C.Undef and then N >= 1 and then
           N <= Count.Nth_Prime_Limit
         then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected),
               "nth_prime result");
            AUnit.Assertions.Assert
              (Count.Nth_Prime (N) = Expected, "nth_prime row" &
               Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Nth_Prime;

   procedure Check_Legendre_Phi (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "legendre_phi");
      X : U64;
      A : Natural;
      Index : U64;
      Expected : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "legendre_phi present");
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), X), "phi first argument");
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (2)), Index), "phi index");
         if not C.Undef and then X <= Count.Prime_Count_Limit and then
           Index <= U64 (Count.Legendre_Index_Limit)
         then
            A := Natural (Index);
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected),
               "legendre_phi result");
            AUnit.Assertions.Assert
              (Count.Legendre_Phi (X, A) = Expected, "legendre_phi row" &
               Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Legendre_Phi;

   overriding procedure Register_Tests (T : in out Count_Case) is
   begin
      Registration.Register_Routine (T, Check_Sums'Access, "sum_primes");
      Registration.Register_Routine
        (T, Check_Prime_Count'Access, "prime_count");
      Registration.Register_Routine
        (T, Check_Nth_Prime'Access, "nth_prime");
      Registration.Register_Routine
        (T, Check_Legendre_Phi'Access, "legendre_phi");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Count_Case);
      return Result;
   end Suite;
end Compat_Count;
