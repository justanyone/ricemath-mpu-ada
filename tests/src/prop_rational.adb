with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Rational;

package body Prop_Rational is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Rational;
   use type U64;
   use type I128;
   type Rational_Case is new Test_Case with null record;
   overriding function Name (T : Rational_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Rational_Case);

   overriding function Name (T : Rational_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Rational seed 20261020");
   end Name;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N : U64;
      CW, SB, R : Fraction;
   begin
      for I in 1 .. 1_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 1 + Seed mod 1_000_000;
         CW := Nth_Calkin_Wilf (N);
         SB := Nth_Stern_Brocot (N);
         AUnit.Assertions.Assert
           (Calkin_Wilf_N (U64 (CW.Num), CW.Den) = N and then
            Stern_Brocot_N (U64 (SB.Num), SB.Den) = N,
            "tree inverse seed 20261020");
         R := From_Contfrac (Contfrac (CW.Num, CW.Den));
         AUnit.Assertions.Assert
           (R = CW, "continued fraction inverse seed 20261020");
         AUnit.Assertions.Assert
           (Next_Calkin_Wilf (U64 (CW.Num), CW.Den) =
              Nth_Calkin_Wilf (N + 1) and then
            Next_Stern_Brocot (U64 (SB.Num), SB.Den) =
              Nth_Stern_Brocot (N + 1), "successor seed 20261020");
         AUnit.Assertions.Assert
           (Nth_Stern_Diatomic (N) = U64 (CW.Num),
            "diatomic seed 20261020");
      end loop;
      for N in 1 .. 25 loop
         declare
            Values : constant Fraction_Array := Farey (N);
         begin
            for I in Values'Range loop
               AUnit.Assertions.Assert
                 (Farey_Rank (N, U64 (Values (I).Num),
                              Values (I).Den) = U64 (I - 1),
                  "Farey rank law");
               if I < Values'Last then
                  AUnit.Assertions.Assert
                    (Next_Farey (U64 (N), U64 (Values (I).Num),
                                 Values (I).Den) = Values (I + 1),
                     "Farey successor law");
               end if;
            end loop;
         end;
      end loop;
      --  Invalid and overflowing results are stable across repeated calls.
      for I in 1 .. 2 loop
         AUnit.Assertions.Assert
           (not Next_Calkin_Wilf (2, 4).Defined and then
            not Next_Calkin_Wilf (U64'Last, 1).Defined and then
            not Next_Stern_Brocot (0, 1).Defined and then
            not Next_Farey (0, 0, 1).Defined and then
            not From_Contfrac ([1, 0]).Defined and then
            not Bestrational (1.5, 0).Defined,
            "invalid input and native overflow");
      end loop;
      for N in U64'(2 ** 32 - 1) .. U64'(2 ** 32 + 1) loop
         CW := Nth_Calkin_Wilf (N);
         AUnit.Assertions.Assert
           (Calkin_Wilf_N (U64 (CW.Num), CW.Den) = N,
            "32-bit boundary");
      end loop;
   end Laws;

   overriding procedure Register_Tests (T : in out Rational_Case) is
   begin
      Registration.Register_Routine (T, Laws'Access, "rational laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Rational_Case);
      return Result;
   end Suite;
end Prop_Rational;
