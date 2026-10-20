with Ada.Numerics.Big_Numbers.Big_Integers;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Digit_Operations;
with Math_Prime_Util.Digit_Operations.Bigints;

package body Prop_Digits is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Digit_Operations;
   use type U64;
   use type U128;
   use type I128;
   type Digits_Case is new Test_Case with null record;
   overriding function Name (T : Digits_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Digits_Case);

   overriding function Name (T : Digits_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Digits seed 20261020");
   end Name;

   procedure Check_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, B : U128;
      A : I128;
      D : Division_Result;
      package BI renames Ada.Numerics.Big_Numbers.Big_Integers;
      package Big renames Math_Prime_Util.Digit_Operations.Bigints;
      use type BI.Big_Integer;
      X, Y : BI.Big_Integer;
      BD : Big.Division_Result;
   begin
      for I in 1 .. 1_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := U128 (Seed);
         B := 2 + N mod 35;
         A := I128 (Seed) - 2 ** 63;
         X := BI.From_String (U64'Image (Seed)) *
           BI.To_Big_Integer (2) ** 160 + 1;
         Y := BI.To_Big_Integer (97);
         AUnit.Assertions.Assert
           (Big.Is_Odd (X) and then not Big.Is_Even (X) and then
            Big.Is_Divisible (X * Y, Y) and then
            Big.Is_Congruent (X + Y, X, Y) and then
            Big.Is_Congruent (X, X, BI.To_Big_Integer (0)) and then
            Big.Is_Divisible (BI.To_Big_Integer (0),
                              BI.To_Big_Integer (0)),
            "bigint parity and residues seed 20261020");
         for Mode in 1 .. 4 loop
            BD := (case Mode is
                     when 1 => Big.Divrem (-X, -Y),
                     when 2 => Big.Tdivrem (-X, Y),
                     when 3 => Big.Fdivrem (-X, Y),
                     when 4 => Big.Cdivrem (-X, Y));
            AUnit.Assertions.Assert
              (BD.Quotient * (if Mode = 1 then -Y else Y) +
               BD.Remainder = -X,
               "bigint division identity seed 20261020");
         end loop;
         AUnit.Assertions.Assert
           (Big.Fromdigits (Big.Todigitstring (X, Y - 61), Y - 61) = X
            and then Big.Fromzeckendorf (Big.Tozeckendorf (X)) = X
            and then Big.Subint (Big.Addint (X, Y), Y) = X
            and then Big.Rashiftint (-X, 3) = Big.Fdivrem
              (-X, BI.To_Big_Integer (8)).Quotient,
            "bigint conversion and arithmetic laws seed 20261020");
         AUnit.Assertions.Assert
           (Fromdigits (Todigitstring (N, B), B) = N and then
            Fromzeckendorf (Tozeckendorf (Seed)) = Seed,
            "conversion roundtrip seed 20261020");
         D := Fdivrem (A, 97);
         AUnit.Assertions.Assert
           (D.Quotient * 97 + D.Remainder = A and then
            D.Remainder in 0 .. 96, "floor division seed 20261020");
         AUnit.Assertions.Assert
           (Subint (Addint (A, 123).Value, 123).Value = A and then
            Is_Odd (A) /= Is_Even (A) and then
            Is_Divisible (A, 1) and then Is_Congruent (A, A, 0),
            "integer laws seed 20261020");
      end loop;
      for I in 1 .. 2 loop
         AUnit.Assertions.Assert
           (not Add1int (I128'Last).Defined and then
            not Negint (I128'First).Defined and then
            not Mulint (I128'Last, 2).Defined and then
            not Divint (1, 0).Defined and then
            not Divint (I128'First, -1).Defined and then
            Lshiftint (-1, 127).Value = I128'First and then
            Rashiftint (-1, 200).Value = -1 and then
            Rshiftint (-1, 200).Value = 0,
            "overflow, zero division, and repeat calls");
      end loop;
   end Check_Laws;

   overriding procedure Register_Tests (T : in out Digits_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Laws'Access, "digit and integer algebraic laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Digits_Case);
      return Result;
   end Suite;
end Prop_Digits;
