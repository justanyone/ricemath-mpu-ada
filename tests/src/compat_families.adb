with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Families;
with Math_Prime_Util.Int;

package body Compat_Families is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   use Math_Prime_Util.Families;
   type Families_Case is new Test_Case with null record;
   overriding function Name (T : Families_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Families_Case);
   overriding function Name (T : Families_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Families");
   end Name;

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));
   function Image (N : Int.Optional_U64) return String is
     (if N.Defined then Image (N.Value) else "undef");

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("families"), Func);
      N : U64;
      Got : Unbounded_String;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         N := U64'Value (To_String (C.Args (1)));
         Got := Null_Unbounded_String;
         if Func = "lucky_numbers" or Func = "twin_primes"
           or Func = "semi_primes"
         then
            declare
               V : constant Lucky_Vectors.Vector :=
                 (if Func = "twin_primes" then
                    (if Natural (C.Args.Length) = 1 then Twin_Primes (N)
                     else Twin_Primes
                       (N, U64'Value (To_String (C.Args (2)))))
                  elsif Func = "semi_primes" then
                    (if Natural (C.Args.Length) = 1 then Semi_Primes (N)
                     else Semi_Primes
                       (N, U64'Value (To_String (C.Args (2)))))
                  elsif Natural (C.Args.Length) = 1 then Lucky_Numbers (N)
                  else Lucky_Numbers
                    (N, U64'Value (To_String (C.Args (2)))));
            begin
               for J in V.First_Index .. V.Last_Index loop
                  if Length (Got) > 0 then
                     Append (Got, " ");
                  end if;
                  Append (Got, Image (V.Element (J)));
               end loop;
               if V.Is_Empty then
                  Got := To_Unbounded_String ("undef");
               end if;
            end;
         elsif Func = "twin_prime_count" then
            Got := To_Unbounded_String
              (Image ((if Natural (C.Args.Length) = 1 then Twin_Prime_Count (N)
                       else Twin_Prime_Count
                         (N, U64'Value (To_String (C.Args (2)))))));
         elsif Func = "semiprime_count" then
            Got := To_Unbounded_String
              (Image ((if Natural (C.Args.Length) = 1 then Semiprime_Count (N)
                       else Semiprime_Count
                         (N, U64'Value (To_String (C.Args (2)))))));
         elsif Func = "twin_prime_count_approx" then
            Got := To_Unbounded_String (Image (Twin_Prime_Count_Approx (N)));
         elsif Func = "semiprime_count_approx" then
            Got := To_Unbounded_String (Image (Semiprime_Count_Approx (N)));
         elsif Func = "nth_twin_prime" then
            Got := To_Unbounded_String (Image (Nth_Twin_Prime (N)));
         elsif Func = "nth_twin_prime_approx" then
            Got := To_Unbounded_String (Image (Nth_Twin_Prime_Approx (N)));
         elsif Func = "nth_semiprime" then
            Got := To_Unbounded_String (Image (Nth_Semiprime (N)));
         elsif Func = "nth_semiprime_approx" then
            Got := To_Unbounded_String (Image (Nth_Semiprime_Approx (N)));
         elsif Func = "is_lucky" then
            Got := To_Unbounded_String ((if Is_Lucky (N) then "1" else "0"));
         elsif Func = "lucky_count" then
            Got := To_Unbounded_String
              (Image ((if Natural (C.Args.Length) = 1 then Lucky_Count (N)
                       else Lucky_Count
                         (N, U64'Value (To_String (C.Args (2)))))));
         elsif Func = "lucky_count_approx" then
            Got := To_Unbounded_String (Image (Lucky_Count_Approx (N)));
         elsif Func = "lucky_count_lower" then
            Got := To_Unbounded_String (Image (Lucky_Count_Lower (N)));
         elsif Func = "lucky_count_upper" then
            Got := To_Unbounded_String (Image (Lucky_Count_Upper (N)));
         elsif Func = "nth_lucky" then
            Got := To_Unbounded_String (Image (Nth_Lucky (N)));
         elsif Func = "nth_lucky_approx" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Approx (N)));
         elsif Func = "nth_lucky_lower" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Lower (N)));
         elsif Func = "nth_lucky_upper" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Upper (N)));
         end if;
         AUnit.Assertions.Assert
           (Got = C.Result, Func & " line" & C.Line_Number'Image &
            " expected " & To_String (C.Result) & " got " & To_String (Got));
      end loop;
   end Replay;

   procedure Test_Lucky_Numbers (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_numbers");
   end Test_Lucky_Numbers;

   procedure Test_Is_Lucky (T : in out Test_Case'Class) is
   begin
      Replay ("is_lucky");
   end Test_Is_Lucky;

   procedure Test_Lucky_Count (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count");
   end Test_Lucky_Count;

   procedure Test_Lucky_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_approx");
   end Test_Lucky_Count_Approx;

   procedure Test_Lucky_Count_Lower (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_lower");
   end Test_Lucky_Count_Lower;

   procedure Test_Lucky_Count_Upper (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_upper");
   end Test_Lucky_Count_Upper;

   procedure Test_Nth_Lucky (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky");
   end Test_Nth_Lucky;

   procedure Test_Nth_Lucky_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_approx");
   end Test_Nth_Lucky_Approx;

   procedure Test_Nth_Lucky_Lower (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_lower");
   end Test_Nth_Lucky_Lower;

   procedure Test_Nth_Lucky_Upper (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_upper");
   end Test_Nth_Lucky_Upper;

   procedure Test_Twin_Primes (T : in out Test_Case'Class) is
   begin
      Replay ("twin_primes");
   end Test_Twin_Primes;

   procedure Test_Twin_Prime_Count (T : in out Test_Case'Class) is
   begin
      Replay ("twin_prime_count");
   end Test_Twin_Prime_Count;

   procedure Test_Twin_Prime_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("twin_prime_count_approx");
   end Test_Twin_Prime_Count_Approx;

   procedure Test_Nth_Twin_Prime (T : in out Test_Case'Class) is
   begin
      Replay ("nth_twin_prime");
   end Test_Nth_Twin_Prime;

   procedure Test_Nth_Twin_Prime_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("nth_twin_prime_approx");
   end Test_Nth_Twin_Prime_Approx;

   procedure Test_Semi_Primes (T : in out Test_Case'Class) is
   begin
      Replay ("semi_primes");
   end Test_Semi_Primes;

   procedure Test_Semiprime_Count (T : in out Test_Case'Class) is
   begin
      Replay ("semiprime_count");
   end Test_Semiprime_Count;

   procedure Test_Semiprime_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("semiprime_count_approx");
   end Test_Semiprime_Count_Approx;

   procedure Test_Nth_Semiprime (T : in out Test_Case'Class) is
   begin
      Replay ("nth_semiprime");
   end Test_Nth_Semiprime;

   procedure Test_Nth_Semiprime_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("nth_semiprime_approx");
   end Test_Nth_Semiprime_Approx;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Lucky_Numbers'Access, "lucky_numbers");
      Registration.Register_Routine
        (T, Test_Is_Lucky'Access, "is_lucky");
      Registration.Register_Routine
        (T, Test_Lucky_Count'Access, "lucky_count");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Approx'Access, "lucky_count_approx");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Lower'Access, "lucky_count_lower");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Upper'Access, "lucky_count_upper");
      Registration.Register_Routine
        (T, Test_Nth_Lucky'Access, "nth_lucky");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Approx'Access, "nth_lucky_approx");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Lower'Access, "nth_lucky_lower");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Upper'Access, "nth_lucky_upper");
      Registration.Register_Routine
        (T, Test_Twin_Primes'Access, "twin_primes");
      Registration.Register_Routine
        (T, Test_Twin_Prime_Count'Access, "twin_prime_count");
      Registration.Register_Routine
        (T, Test_Twin_Prime_Count_Approx'Access, "twin_prime_count_approx");
      Registration.Register_Routine
        (T, Test_Nth_Twin_Prime'Access, "nth_twin_prime");
      Registration.Register_Routine
        (T, Test_Nth_Twin_Prime_Approx'Access, "nth_twin_prime_approx");
      Registration.Register_Routine
        (T, Test_Semi_Primes'Access, "semi_primes");
      Registration.Register_Routine
        (T, Test_Semiprime_Count'Access, "semiprime_count");
      Registration.Register_Routine
        (T, Test_Semiprime_Count_Approx'Access, "semiprime_count_approx");
      Registration.Register_Routine
        (T, Test_Nth_Semiprime'Access, "nth_semiprime");
      Registration.Register_Routine
        (T, Test_Nth_Semiprime_Approx'Access, "nth_semiprime_approx");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Families_Case);
      return Result;
   end Suite;
end Compat_Families;
