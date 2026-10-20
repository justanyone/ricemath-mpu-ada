with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Numerics.Long_Elementary_Functions;
with Math_Prime_Util.Real;
package body Prop_Real is
   use AUnit.Test_Cases;
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
   begin
      for I in 1 .. 100 loop
         X := F64 (I) / 10.0;
         W := Lambert_W (X);
         AUnit.Assertions.Assert
           (abs (W * Exp (W) - X) < 1.0E-13 * X,
            "Lambert inverse seed 20261020");
         AUnit.Assertions.Assert
           (abs (Logarithmic_Integral (Exp (X)) -
              Exponential_Integral (X)) <
                1.0E-12 * abs Exponential_Integral (X), "li/Ei identity");
         AUnit.Assertions.Assert
           (abs (Logarithmic_Integral (Inverse_Li_Nv (X)) - X) <
              1.0E-12 * X, "inverse li round trip");
         AUnit.Assertions.Assert
           (abs (Harmreal (I) - Harmreal (I - 1) - 1.0 / F64 (I)) <
              1.0E-14, "harmonic recurrence");
         AUnit.Assertions.Assert
           (Bernreal (2 * I + 1) = 0.0, "odd Bernoulli zero");
         AUnit.Assertions.Assert
           (Riemann_R (X) = Riemann_R (X), "repeat call");
      end loop;
   end Check_Laws;
   overriding procedure Register_Tests (T : in out Real_Case) is
   begin
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
