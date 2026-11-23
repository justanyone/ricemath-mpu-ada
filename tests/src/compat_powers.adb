with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util;
with Math_Prime_Util.Int;
with Math_Prime_Util.Powers;

package body Compat_Powers is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Powers;
   use type U64;
   use type Int.I128;

   type Powers_Case is new Test_Case with null record;
   overriding function Name (T : Powers_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Powers_Case);
   overriding function Name (T : Powers_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Powers"));

   procedure Prime_Laws (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("families");
      N, Got : U64;
      P : Int.Optional_U64;
      Checked : Natural := 0;
   begin
      --  Replay the native classification fixtures, including large primes.
      for C of Cases loop
         if C.Func = "is_prime_power" then
            if Parse_U64 (To_String (C.Args (1)), N) then
               Got := U64 (Is_Prime_Power (N));
               AUnit.Assertions.Assert
                 (Got = U64'Value (To_String (C.Result)),
                  "is_prime_power fixture" & C.Line_Number'Image);
               Checked := Checked + 1;
            end if;
         end if;
      end loop;
      AUnit.Assertions.Assert (Checked > 0, "classification fixtures missing");
      for Index in U64 range 1 .. 100 loop
         P := Nth_Prime_Power (Index);
         AUnit.Assertions.Assert
           (P.Defined and then Is_Prime_Power (P.Value) > 0
            and then Prime_Power_Count (P.Value) = Index
            and then Prime_Power_Count (P.Value - 1) = Index - 1
            and then Nth_Prime_Power_Lower (Index).Value <= P.Value
            and then Nth_Prime_Power_Upper (Index).Value >= P.Value,
            "prime power inverse/bounds index" & Index'Image);
         AUnit.Assertions.Assert
           (Nth_Prime_Power_Approx (Index).Defined,
            "prime power approximate inverse index" & Index'Image);
      end loop;
      AUnit.Assertions.Assert
        (not Nth_Prime_Power (0).Defined
         and then not Next_Prime_Power (Max_Prime).Defined
         and then not Prev_Prime_Power (2).Defined
         and then Is_Prime_Power (2 ** 63) = 63
         and then Prime_Power_Root (2 ** 63) = 2
         and then Is_Prime_Power (U64'Last) = 0,
         "prime power native boundaries");
   end Prime_Laws;

   procedure Perfect_Laws (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Is_Perfect_Power (-27) and then Is_Perfect_Power (-64)
         and then not Is_Perfect_Power (-16)
         and then Is_Perfect_Power (-1) and then Is_Perfect_Power (0)
         and then Is_Perfect_Power (1)
         and then Is_Perfect_Power (2 ** 64)
         and then not Is_Perfect_Power (2 ** 64 - 1),
         "negative exponent odd factor and native boundaries");
      AUnit.Assertions.Assert
        (Next_Perfect_Power (-28) = -27
         and then Prev_Perfect_Power (-27) = -32
         and then Next_Perfect_Power (0) = 1
         and then Prev_Perfect_Power (0) = -1
         and then Nth_Perfect_Power
           (Max_Perfect_Power_Index + 1).Value = 2 ** 64,
         "perfect power strict neighbors and wide nth boundary");
   end Perfect_Laws;

   overriding procedure Register_Tests (T : in out Powers_Case) is
   begin
      Registration.Register_Routine (T, Prime_Laws'Access, "prime laws");
      Registration.Register_Routine (T, Perfect_Laws'Access, "perfect laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Powers_Case);
      return Result;
   end Suite;
end Compat_Powers;
