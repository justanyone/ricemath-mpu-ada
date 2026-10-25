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
   package Pc renames Math_Prime_Util.Count;
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
            Actual := Pc.Sum_Primes (Low);
         else
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (2)), High), "sum upper bound");
            Actual := Pc.Sum_Primes (Low, High);
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

   --  Rows above the limits of Count (Prime_Count_Limit 2 * 10**13,
   --  Nth_Prime_Limit, Legendre_Index_Limit) are skipped: the full LMO
   --  method for arguments up to 2**64 needs tables not ported yet.
   --  Rows with undef results are skipped: a Pre check rejects them.
   procedure Check_Prime_Count (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "prime_count");
      Low, High : U64 := 0;
      Expected : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "prime_count present");
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), Low), "prime_count argument");
         if C.Args.Last_Index = 1 then
            High := Low;
            Low := 0;
         else
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (2)), High), "prime_count high");
         end if;
         if not C.Undef and then High <= Pc.Prime_Count_Limit then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected),
               "prime_count result");
            --  A range row counts primes in Low .. High; an empty range
            --  (Low > High) has no primes.
            AUnit.Assertions.Assert
              ((if Low > High then 0 else
                  Pc.Prime_Count (High) -
                  (if Low <= 1 then 0 else Pc.Prime_Count (Low - 1))) =
                Expected,
               "prime_count row" & Positive'Image (C.Line_Number));
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
           N <= Pc.Nth_Prime_Limit
         then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected),
               "nth_prime result");
            AUnit.Assertions.Assert
              (Pc.Nth_Prime (N) = Expected, "nth_prime row" &
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
         if not C.Undef and then X <= Pc.Prime_Count_Limit and then
           Index <= U64 (Pc.Legendre_Index_Limit)
         then
            A := Natural (Index);
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected),
               "legendre_phi result");
            AUnit.Assertions.Assert
              (Pc.Legendre_Phi (X, A) = Expected, "legendre_phi row" &
               Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Legendre_Phi;

   procedure Check_Prime_Count_Lower (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "prime_count_lower");
      N : U64;
      Expected : U64;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N <= 100_000_000_000_000 then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "result");
            AUnit.Assertions.Assert
              (Pc.Prime_Count_Lower (N) = Expected,
               "prime_count_lower row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Prime_Count_Lower;

   procedure Check_Prime_Count_Upper (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "prime_count_upper");
      N : U64;
      Expected : U64;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N <= 100_000_000_000_000 then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "result");
            AUnit.Assertions.Assert
              (Pc.Prime_Count_Upper (N) = Expected,
               "prime_count_upper row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Prime_Count_Upper;

   procedure Check_Prime_Count_Approx (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "prime_count_approx");
      N : U64;
      Expected : U64;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N <= 100_000_000_000_000 then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "result");
            AUnit.Assertions.Assert
              (Pc.Prime_Count_Approx (N) = Expected,
               "prime_count_approx row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Prime_Count_Approx;

   procedure Check_Nth_Prime_Lower (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "nth_prime_lower");
      N : U64;
      Expected : U64;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N >= 1 and then N <= 100_000_000_000_000 then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "result");
            AUnit.Assertions.Assert
              (Pc.Nth_Prime_Lower (N) = Expected,
               "nth_prime_lower row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Nth_Prime_Lower;

   procedure Check_Nth_Prime_Upper (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "nth_prime_upper");
      N : U64;
      Expected : U64;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N >= 1 and then N <= 100_000_000_000_000 then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "result");
            AUnit.Assertions.Assert
              (Pc.Nth_Prime_Upper (N) = Expected,
               "nth_prime_upper row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Nth_Prime_Upper;

   procedure Check_Nth_Prime_Approx (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "nth_prime_approx");
      N : U64;
      Expected : U64;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N >= 1 and then N <= 100_000_000_000_000 then
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Result), Expected), "result");
            AUnit.Assertions.Assert
              (Pc.Nth_Prime_Approx (N) = Expected,
               "nth_prime_approx row" & Positive'Image (C.Line_Number) &
               " actual" & U64'Image (Pc.Nth_Prime_Approx (N)) &
               " expected" & U64'Image (Expected));
         end if;
      end loop;
   end Check_Nth_Prime_Approx;

   procedure Check_Chebyshev_Theta (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "chebyshev_theta");
      N : U64;
      Expected : Long_Float;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N <= Pc.Prime_Count_Limit then
            Expected := Long_Float'Value (To_String (C.Result));
            AUnit.Assertions.Assert
              (abs (Pc.Chebyshev_Theta (N) - Expected) <=
                 1.0E-12 * Long_Float'Max (1.0, Expected),
               "chebyshev_theta row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Chebyshev_Theta;

   procedure Check_Chebyshev_Psi (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("count"), "chebyshev_psi");
      N : U64;
      Expected : Long_Float;
   begin
      for C of Cases loop
         AUnit.Assertions.Assert
           (Parse_U64 (To_String (C.Args (1)), N), "argument");
         --  Extended precision and large Chebyshev table replay pending.
         if not C.Undef and then N <= Pc.Prime_Count_Limit then
            Expected := Long_Float'Value (To_String (C.Result));
            AUnit.Assertions.Assert
              (abs (Pc.Chebyshev_Psi (N) - Expected) <=
                 1.0E-12 * Long_Float'Max (1.0, Expected),
               "chebyshev_psi row" & Positive'Image (C.Line_Number));
         end if;
      end loop;
   end Check_Chebyshev_Psi;

   overriding procedure Register_Tests (T : in out Count_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Prime_Count_Lower'Access, "prime_count_lower");
      Registration.Register_Routine
        (T, Check_Prime_Count_Upper'Access, "prime_count_upper");
      Registration.Register_Routine
        (T, Check_Prime_Count_Approx'Access, "prime_count_approx");
      Registration.Register_Routine
        (T, Check_Nth_Prime_Lower'Access, "nth_prime_lower");
      Registration.Register_Routine
        (T, Check_Nth_Prime_Upper'Access, "nth_prime_upper");
      Registration.Register_Routine
        (T, Check_Nth_Prime_Approx'Access, "nth_prime_approx");
      Registration.Register_Routine
        (T, Check_Chebyshev_Theta'Access, "chebyshev_theta");
      Registration.Register_Routine
        (T, Check_Chebyshev_Psi'Access, "chebyshev_psi");
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
