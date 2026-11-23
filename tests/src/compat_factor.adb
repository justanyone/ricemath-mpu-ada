with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Factor;

package body Compat_Factor is
   use AUnit.Test_Cases;
   use AUnit.Test_Cases.Registration;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Factor;
   use type U64;
   use type U128;

   type Factor_Case is new Test_Case with null record;
   overriding function Name (T : Factor_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Factor_Case);

   procedure Check_Fixtures (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("factor"), "ecm_factor");
      Args : array (1 .. 4) of U64;
      Text : Unbounded_String;
   begin
      AUnit.Assertions.Assert (Natural (Cases.Length) = 57, "ECM rows");
      for C of Cases loop
         Args := [0, 4_000, 0, 100];
         for I in 1 .. Natural (C.Args.Length) loop
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (I)), Args (I)),
               "native ECM input");
         end loop;
         Text := Null_Unbounded_String;
         declare
            Got : constant Factor_List :=
              Ecm_Factor (Args (1), Args (2), Args (3), Args (4));
         begin
            for F of Got loop
               if Length (Text) > 0 then
                  Append (Text, " ");
               end if;
               Append (Text, Ada.Strings.Fixed.Trim
                 (U64'Image (F), Ada.Strings.Both));
            end loop;
            if Got'Length = 0 then
               Text := To_Unbounded_String ("undef");
            end if;
         end;
         AUnit.Assertions.Assert
           (Text = C.Result,
            "ecm_factor row" & Positive'Image (C.Line_Number)
            & " expected " & To_String (C.Result)
            & " got " & To_String (Text));
      end loop;
   end Check_Fixtures;

   procedure Check_Edges (T : in out Test_Case'Class) is
      Inputs : constant Factor_List :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last];
      Product : U128;
      Seed : U64 := 16#EC_075#;
      N : U64;
   begin
      for N of Inputs loop
         declare
            Got : constant Factor_List := Ecm_Factor (N);
         begin
            Product := 1;
            for I in Got'Range loop
               Product := Product * U128 (Got (I));
               AUnit.Assertions.Assert
                 (I = Got'First or else Got (I - 1) <= Got (I),
                  "sorted ECM result");
            end loop;
            AUnit.Assertions.Assert (Product = U128 (N), "ECM product");
         end;
      end loop;
      --  Seeded decomposition law, including ECM exhaustion: every result
      --  must multiply back to its input even if it is not fully factored.
      for Trial in 1 .. 128 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := Seed mod 2 ** 32;
         declare
            Got : constant Factor_List :=
              Ecm_Factor (N, B1 => 50, B2 => 500, Curves => 3);
         begin
            Product := 1;
            for I in Got'Range loop
               Product := Product * U128 (Got (I));
               AUnit.Assertions.Assert
                 (I = Got'First or else Got (I - 1) <= Got (I),
                  "seed=16#EC_075# trial" & Integer'Image (Trial));
            end loop;
            AUnit.Assertions.Assert
              (Product = U128 (N),
               "seed=16#EC_075# trial" & Integer'Image (Trial)
               & " N=" & U64'Image (N));
         end;
      end loop;
      AUnit.Assertions.Assert
        (Ecm_Factor (49, Curves => 0) = Factor_List'(1 => 49),
         "zero curves leaves the cofactor");
      AUnit.Assertions.Assert
        (Ecm_Factor (210, Curves => 0) = Factor_List'(2, 3, 5, 7),
         "small factors are stripped even without curves");
      AUnit.Assertions.Assert
        (Ecm_Factor (77, B1 => 0, B2 => 0, Curves => 1) =
          Factor_List'(7, 11), "curve setup can discover a factor");
      AUnit.Assertions.Assert
        (Ecm_Factor (49, B1 => 0, B2 => 0, Curves => 0) =
          Factor_List'(1 => 49), "zero bounds and curves");
      AUnit.Assertions.Assert
        (Ecm_Factor (49, B1 => U64'Last, Curves => 0) =
          Factor_List'(1 => 49), "default B2 saturates without wrapping");
      AUnit.Assertions.Assert
        (Ecm_Factor (77, B1 => 0, B2 => 1, Curves => U64'Last) =
          Ecm_Factor (77, B1 => 0, B2 => 1, Curves => 400),
         "curve count is capped");
   end Check_Edges;

   overriding function Name (T : Factor_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Factor");
   end Name;

   overriding procedure Register_Tests (T : in out Factor_Case) is
   begin
      Register_Routine (T, Check_Fixtures'Access, "ecm_factor fixtures");
      Register_Routine (T, Check_Edges'Access, "ecm_factor edges");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Factor_Case);
      return Result;
   end Suite;
end Compat_Factor;
