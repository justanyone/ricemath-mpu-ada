with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Families;

package body Prop_Families is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Families;
   use type Lucky_Vectors.Vector;
   type Families_Case is new Test_Case with null record;
   overriding function Name (T : Families_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Families_Case);
   overriding function Name (T : Families_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Families seed 20261020");
   end Name;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, V : U64;
      Left, Right : Lucky_Vectors.Vector;
   begin
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 1 + Seed mod 2_000;
         V := Nth_Lucky (N).Value;
         AUnit.Assertions.Assert
           (Is_Lucky (V) and Lucky_Count (V) = N,
            "count/nth inverse seed 20261020");
         AUnit.Assertions.Assert
           (Lucky_Count_Lower (V) <= N and N <= Lucky_Count_Upper (V),
            "count bounds seed 20261020");
         AUnit.Assertions.Assert
           (Nth_Lucky_Lower (N).Value <= V and
            V <= Nth_Lucky_Upper (N).Value, "nth bounds seed 20261020");
         Left := Lucky_Numbers (0, N);
         Right := Lucky_Numbers (N + 1, 2 * N);
         Left.Append (Right);
         AUnit.Assertions.Assert
           (Left = Lucky_Numbers (2 * N), "range partition");
      end loop;
      AUnit.Assertions.Assert
        (Lucky_Numbers (9, 1).Is_Empty and Lucky_Count (0) = 0,
         "reversed and zero ranges");
      AUnit.Assertions.Assert
        (not Is_Lucky (U64'Last) and not Is_Lucky (2 ** 63),
         "native boundary prefilters");
      AUnit.Assertions.Assert
        (Nth_Lucky_Approx (U64'Last).Value =
           18_446_744_073_709_551_517, "estimate saturation");
   end Laws;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine (T, Laws'Access, "lucky laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Families_Case);
      return Result;
   end Suite;
end Prop_Families;
