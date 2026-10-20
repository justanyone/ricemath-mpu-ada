with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Combinat;

package body Prop_Combinat is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Combinat;
   use type U64;

   type Combinat_Case is new Test_Case with null record;
   overriding function Name
     (T : Combinat_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Combinat_Case);

   procedure Check_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, K : U64;
      Edges : constant array (Positive range 1 .. 8) of U64 :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63 + 1, U64'Last];
   begin
      for I in 1 .. 1_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 2 + Seed mod 18;
         K := 1 + Seed mod (N - 1);
         AUnit.Assertions.Assert
           (Binomial (N, K).Value = Binomial (N, N - K).Value,
            "symmetry seed 20261020");
         AUnit.Assertions.Assert
           (Binomial (N, K).Value = Binomial (N - 1, K - 1).Value
              + Binomial (N - 1, K).Value,
            "Pascal seed 20261020");
         AUnit.Assertions.Assert
           (Factorial (N).Value = N * Factorial (N - 1).Value
              and Multifactorial (N, 1).Value = Factorial (N).Value,
            "factorial seed 20261020");
      end loop;
      for N of Edges
      loop
         AUnit.Assertions.Assert
           (Binomial (N, 0).Value = 1
              and Binomial (N, 1).Value = N
              and Multifactorial (N, U64'Last).Value = U64'Max (1, N),
            "native boundaries");
         for Repeat in 1 .. 2 loop
            AUnit.Assertions.Assert
              (Factorial (N).Defined = (N <= 20)
                 and Bell_Number (N).Defined = (N <= 25),
               "repeat calls and bounds");
         end loop;
      end loop;
   end Check_Laws;

   overriding function Name
     (T : Combinat_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Combinat seed 20261020");
   end Name;

   overriding procedure Register_Tests (T : in out Combinat_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Check_Laws'Access, "algebraic laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Combinat_Case);
      return Result;
   end Suite;
end Prop_Combinat;
