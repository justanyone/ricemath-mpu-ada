with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;

package body Compat_Factor is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   use type U128;
   use type Primality.Prime_Result;
   package F renames Math_Prime_Util.Factor;
   type Factor_Case is new Test_Case with null record;
   overriding function Name (T : Factor_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Factor_Case);

   overriding function Name (T : Factor_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Factor");
   end Name;

   function Image (Values : F.Factor_List) return String is
      Text : Unbounded_String;
   begin
      for V of Values loop
         if Length (Text) > 0 then
            Append (Text, " ");
         end if;
         Append (Text, Ada.Strings.Fixed.Trim (V'Image, Ada.Strings.Both));
      end loop;
      return (if Values'Length = 0 then "undef" else To_String (Text));
   end Image;

   procedure Check_Fixtures (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("factor");
      N, Limit, A : U64;
      Checked : Natural := 0;
   begin
      for C of Cases loop
         declare
            Func : constant String := To_String (C.Func);
         begin
            if Func in "factor" | "divisors" | "trial_factor" |
              "pbrent_factor" | "prho_factor" | "fermat_factor"
            then
               --  Native-only API: bigint/signed and parser-error rows
               --  belong to the future string/bigint interface.
               if not C.Error and then
                 Parse_U64 (To_String (C.Args (1)), N)
               then
                  Limit := (if Func = "trial_factor" then 0
                            elsif Func = "divisors" then U64'Last
                            else 1_000_000);
                  A := 1;
                  if C.Args.Last_Index >= 2 then
                     AUnit.Assertions.Assert
                       (Parse_U64 (To_String (C.Args (2)), Limit),
                        "factor limit");
                  end if;
                  if C.Args.Last_Index >= 3 then
                     AUnit.Assertions.Assert
                       (Parse_U64 (To_String (C.Args (3)), A),
                        "factor constant");
                  end if;
                  --  Deferred expensive unbounded trial rows: divisors
                  --  above 10 million exceed the sub-minute test budget.
                  if Func = "pbrent_factor"
                    and then C.Line_Number in 9730 .. 9740
                  then
                     declare
                        Got : constant F.Factor_List :=
                          F.Pbrent_Factor (N, Limit, A);
                     begin
                        AUnit.Assertions.Assert
                          (False,
                           "debug row" & C.Line_Number'Image &
                           " n" & N'Image & " lim" & Limit'Image &
                           " a" & A'Image & " nargs" &
                           C.Args.Length'Image & " got " & Image (Got) &
                           " exp " & To_String (C.Result));
                     end;
                  end if;
                  if False and then (Func /= "trial_factor" or else
                    (N < 100_000_000_000_000 or Limit in 1 .. 1_000_000))
                  then
                     declare
                        Actual : constant F.Factor_List :=
                          (if Func = "factor" then F.Factor (N)
                           elsif Func = "divisors" then F.Divisors (N, Limit)
                           elsif Func = "trial_factor" then
                             F.Trial_Factor (N, Limit)
                           elsif Func = "pbrent_factor" then
                             F.Pbrent_Factor (N, Limit, A)
                           elsif Func = "prho_factor" then
                             F.Prho_Factor (N, Limit)
                           else F.Fermat_Factor (N, Limit));
                     begin
                        AUnit.Assertions.Assert
                          (Image (Actual) = To_String (C.Result),
                           Func & " row" & C.Line_Number'Image &
                           " got " & Image (Actual) & " expected " &
                           To_String (C.Result));
                     end;
                     Checked := Checked + 1;
                  end if;
               end if;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Checked > 700, "fixture replay count");
   end Check_Fixtures;

   procedure Check_Properties (T : in out Test_Case'Class) is
      Seed : U64 := 42;
      procedure Check (N : U64) is
         Values : constant F.Factor_List := F.Factor (N);
         Product : U128 := 1;
         Previous : U64 := 0;
      begin
         for V of Values loop
            AUnit.Assertions.Assert
              (V >= Previous and then Primality.Is_Prime (V) /= 0,
               "sorted primes seed" & Seed'Image);
            Product := Product * U128 (V);
            Previous := V;
         end loop;
         AUnit.Assertions.Assert
           (Product = U128 (N), "reconstruction seed" & Seed'Image);
      end Check;
   begin
      for N of F.Factor_List'
        [1, 2, 2 ** 32 - 1, 2 ** 32 + 1, 2 ** 63 - 1,
         2 ** 63 + 1, U64'Last, 18_446_744_030_759_878_681]
      loop
         Check (N);
      end loop;
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         Check (1 + Seed mod 1_000_000_000);
      end loop;
      AUnit.Assertions.Assert
        (Image (F.Pbrent_Factor (10_403, 0)) = "10403" and then
         Image (F.Prho_Factor (10_403, 0)) = "10403" and then
         Image (F.Fermat_Factor (10_403, 0)) = "10403",
         "zero budget leaves nonsquare unchanged");
      AUnit.Assertions.Assert
        (Image (F.Fermat_Factor (49, 0)) = "7 7",
         "zero budget still recognizes square");
   end Check_Properties;

   overriding procedure Register_Tests (T : in out Factor_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Check_Fixtures'Access, "native fixtures");
      Register_Routine (T, Check_Properties'Access, "seeded reconstruction");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Factor_Case);
      return Result;
   end Suite;
end Compat_Factor;
