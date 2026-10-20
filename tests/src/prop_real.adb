with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Numerics.Long_Elementary_Functions;
with Math_Prime_Util.Real;
package body Prop_Real is
   use AUnit.Test_Cases;
   use type Math_Prime_Util.U64;
   use Math_Prime_Util.Real;
   use Ada.Numerics.Long_Elementary_Functions;
   type Real_Case is new Test_Case with null record;
   overriding function Name (T : Real_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Real_Case);
   overriding function Name (T : Real_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Real");
   end Name;
   procedure Check_Laws (T : in out Test_Case'Class);
   procedure Check_Laws (T : in out Test_Case'Class) is
      X, W : F64;
      Seed : Math_Prime_Util.U64 := 20_261_020;
   begin
      AUnit.Assertions.Assert
        (abs (Riemannzeta (2.0) + 1.0 -
          3.14159265358979323846 ** 2 / 6.0) < 1.0E-15,
         "zeta two identity");
      AUnit.Assertions.Assert (Riemannr (1.0) = 1.0, "R(1)");
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         X := F64 (Seed mod 100 + 1) / 10.0;
         W := Inverse_Li (F64 (I));
         AUnit.Assertions.Assert
           (Logarithmicintegral (W) >= F64 (I) and then
            Logarithmicintegral (W - 1.0) < F64 (I),
            "integer inverse ceiling");
         W := Lambertw (X);
         AUnit.Assertions.Assert
           (abs (W * Exp (W) - X) < 1.0E-13 * X,
            "Lambert inverse seed 20261020");
         AUnit.Assertions.Assert
           (abs (Logarithmicintegral (Exp (X)) -
              Exponentialintegral (X)) <
                1.0E-12 * abs Exponentialintegral (X), "li/Ei identity");
         AUnit.Assertions.Assert
           (abs (Logarithmicintegral (Inverse_Li_Nv (X)) - X) <
              1.0E-12 * X, "inverse li round trip");
         AUnit.Assertions.Assert
           (abs (Harmreal (I) - Harmreal (I - 1) - 1.0 / F64 (I)) <
              1.0E-14, "harmonic recurrence");
         AUnit.Assertions.Assert
           (Bernreal (2 * I + 1) = 0.0, "odd Bernoulli zero");
         AUnit.Assertions.Assert
           (Riemannr (X) = Riemannr (X), "repeat call");
      end loop;
   end Check_Laws;
   procedure Concurrent_Calls (T : in out Test_Case'Class);
   procedure Concurrent_Calls (T : in out Test_Case'Class) is
      type Results is array (1 .. 2) of F64;
      Values : Results := [others => 0.0];
      task type Worker (Index : Positive);
      task body Worker is
      begin
         for I in 1 .. 100 loop
            Values (Index) := Riemannr (1000.0) +
              Lambertw (1000.0) + Harmreal (1000);
         end loop;
      end Worker;
   begin
      declare
         First : Worker (1);
         Second : Worker (2);
      begin
         null;
      end;
      AUnit.Assertions.Assert
        (Values (1) = Values (2) and Values (1) > 0.0,
         "independent concurrent calls");
   end Concurrent_Calls;
   overriding procedure Register_Tests (T : in out Real_Case) is
   begin
      Registration.Register_Routine
        (T, Concurrent_Calls'Access, "concurrent real calls");
      Registration.Register_Routine (T, Check_Laws'Access, "real laws");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Real_Case);
      return Result;
   end Suite;
end Prop_Real;
