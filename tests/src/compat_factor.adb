with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Factor;

package body Compat_Factor is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   package Fac renames Math_Prime_Util.Factor;

   type Factor_Case is new Test_Case with null record;
   overriding function Name (T : Factor_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Factor_Case);

   overriding function Name (T : Factor_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Factor");
   end Name;

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   function Join (V : Fac.Factor_Vectors.Vector) return String is
      Acc : Unbounded_String;
   begin
      for I in V.First_Index .. V.Last_Index loop
         if Length (Acc) > 0 then
            Append (Acc, " ");
         end if;
         Append (Acc, Image (V.Element (I)));
      end loop;
      return To_String (Acc);
   end Join;

   --  A third prho argument is ignored, matching XS.xs.
   function Run
     (Func : String; N, A, B : U64; Count : Natural)
      return Fac.Factor_Vectors.Vector is
   begin
      if Func = "factor" then
         return Fac.Factor (N);
      elsif Func = "divisors" then
         if Count = 1 then
            return Fac.Divisors (N);
         end if;
         return Fac.Divisors (N, A);
      elsif Func = "trial_factor" then
         if Count = 1 then
            return Fac.Trial_Factor (N);
         end if;
         return Fac.Trial_Factor (N, A);
      elsif Func = "fermat_factor" then
         if Count = 1 then
            return Fac.Fermat_Factor (N);
         end if;
         return Fac.Fermat_Factor (N, A);
      elsif Func = "holf_factor" then
         if Count = 1 then
            return Fac.Holf_Factor (N);
         end if;
         return Fac.Holf_Factor (N, A);
      elsif Func = "squfof_factor" then
         if Count = 1 then
            return Fac.Squfof_Factor (N);
         end if;
         return Fac.Squfof_Factor (N, A);
      elsif Func = "lehman_factor" then
         if Count = 1 then
            return Fac.Lehman_Factor (N);
         end if;
         return Fac.Lehman_Factor (N, A);
      elsif Func = "prho_factor" then
         if Count = 1 then
            return Fac.Prho_Factor (N);
         end if;
         return Fac.Prho_Factor (N, A);
      elsif Func = "pbrent_factor" then
         if Count = 1 then
            return Fac.Pbrent_Factor (N);
         elsif Count = 2 then
            return Fac.Pbrent_Factor (N, A);
         end if;
         return Fac.Pbrent_Factor (N, A, B);
      elsif Func = "pminus1_factor" then
         if Count = 1 then
            return Fac.Pminus1_Factor (N);
         elsif Count = 2 then
            return Fac.Pminus1_Factor (N, A);
         end if;
         return Fac.Pminus1_Factor (N, A, B);
      else
         if Count = 1 then
            return Fac.Pplus1_Factor (N);
         end if;
         return Fac.Pplus1_Factor (N, A);
      end if;
   end Run;

   --  Skipped, the argument does not fit in U64 (MPU bigint path):
   --  tests/fixtures/factor.tsv:1634 factor 18450931744652885087
   --  tests/fixtures/factor.tsv:1810 factor 36803912137803496523
   --  tests/fixtures/factor.tsv:1826 factor 36832540935240707603
   --  tests/fixtures/factor.tsv:9700 trial_factor 553402322211286548450
   --  tests/fixtures/factor.tsv:9713 pminus1_factor 18450931744652885087
   function Named_Skip (Line : Positive) return Boolean is
     (Line in 1634 | 1810 | 1826 | 9700 | 9713);

   procedure Replay (Func : String) is
      N, A, B : U64;
      Valid, Raised : Boolean;
      Got : Unbounded_String;
      Count : Natural := 0;
   begin
      for C of For_Function (Load ("factor"), Func) loop
         N := 0;
         A := 0;
         B := 0;
         Valid := not C.Args.Is_Empty;
         if Valid then
            Valid := Parse_U64 (To_String (C.Args (1)), N);
         end if;
         if Natural (C.Args.Length) >= 2 then
            Valid := Parse_U64 (To_String (C.Args (2)), A) and then Valid;
         end if;
         if Natural (C.Args.Length) >= 3 then
            Valid := Parse_U64 (To_String (C.Args (3)), B) and then Valid;
         end if;
         if Natural (C.Args.Length) > 3 then
            Valid := False;
         end if;
         if not Valid then
            if Named_Skip (C.Line_Number) then
               null;
            else
               AUnit.Assertions.Assert
                 (C.Error,
                  Func & " row" & C.Line_Number'Image & " not ERROR");
            end if;
         else
            Raised := False;
            begin
               Got := To_Unbounded_String
                 (Join (Run (Func, N, A, B, Natural (C.Args.Length))));
            exception
               when Constraint_Error | Ada.Assertions.Assertion_Error =>
                  Raised := True;
            end;
            AUnit.Assertions.Assert
              (not Raised,
               Func & " row" & C.Line_Number'Image & " raised");
            if not Raised then
               if C.Undef then
                  AUnit.Assertions.Assert
                    (Length (Got) = 0,
                     Func & " undef" & C.Line_Number'Image);
               else
                  AUnit.Assertions.Assert
                    (Got = C.Result,
                     Func & " row" & C.Line_Number'Image
                     & " got " & To_String (Got));
               end if;
            end if;
         end if;
         Count := Count + 1;
      end loop;
      AUnit.Assertions.Assert (Count > 0, Func & " fixture rows");
   end Replay;

   procedure Test_Factor (T : in out Test_Case'Class) is
   begin
      Replay ("factor");
   end Test_Factor;

   procedure Test_Trial (T : in out Test_Case'Class) is
   begin
      Replay ("trial_factor");
   end Test_Trial;

   procedure Test_Fermat (T : in out Test_Case'Class) is
   begin
      Replay ("fermat_factor");
   end Test_Fermat;

   procedure Test_Holf (T : in out Test_Case'Class) is
   begin
      Replay ("holf_factor");
   end Test_Holf;

   procedure Test_Squfof (T : in out Test_Case'Class) is
   begin
      Replay ("squfof_factor");
   end Test_Squfof;

   procedure Test_Lehman (T : in out Test_Case'Class) is
   begin
      Replay ("lehman_factor");
   end Test_Lehman;

   procedure Test_Prho (T : in out Test_Case'Class) is
   begin
      Replay ("prho_factor");
   end Test_Prho;

   procedure Test_Pbrent (T : in out Test_Case'Class) is
   begin
      Replay ("pbrent_factor");
   end Test_Pbrent;

   procedure Test_Pminus1 (T : in out Test_Case'Class) is
   begin
      Replay ("pminus1_factor");
   end Test_Pminus1;

   procedure Test_Pplus1 (T : in out Test_Case'Class) is
   begin
      Replay ("pplus1_factor");
   end Test_Pplus1;

   procedure Test_Divisors (T : in out Test_Case'Class) is
   begin
      Replay ("divisors");
   end Test_Divisors;

   overriding procedure Register_Tests (T : in out Factor_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Factor'Access, "factor");
      Registration.Register_Routine
        (T, Test_Trial'Access, "trial_factor");
      Registration.Register_Routine
        (T, Test_Fermat'Access, "fermat_factor");
      Registration.Register_Routine
        (T, Test_Holf'Access, "holf_factor");
      Registration.Register_Routine
        (T, Test_Squfof'Access, "squfof_factor");
      Registration.Register_Routine
        (T, Test_Lehman'Access, "lehman_factor");
      Registration.Register_Routine
        (T, Test_Prho'Access, "prho_factor");
      Registration.Register_Routine
        (T, Test_Pbrent'Access, "pbrent_factor");
      Registration.Register_Routine
        (T, Test_Pminus1'Access, "pminus1_factor");
      Registration.Register_Routine
        (T, Test_Pplus1'Access, "pplus1_factor");
      Registration.Register_Routine
        (T, Test_Divisors'Access, "divisors");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Factor_Case);
      return Result;
   end Suite;
end Compat_Factor;
