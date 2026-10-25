with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Combinat;
with Math_Prime_Util.Int;

package body Prop_Combinat is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Combinat;
   use type U64;
   use type U128;

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
      for N in U64 range 1 .. 20 loop
         for K in U64 range 0 .. N loop
            AUnit.Assertions.Assert
              (Falling_Factorial (I128 (N), K).Value
                 = I128 (Factorial (N).Value / Factorial (N - K).Value),
               "falling factorial quotient");
            AUnit.Assertions.Assert
              (Rising_Factorial (-I128 (N), K).Value
                 = (if K mod 2 = 0 then 1 else -1)
                   * Falling_Factorial (I128 (N), K).Value,
               "signed factorial duality");
         end loop;
         for K in U64 range 1 .. 5 loop
            AUnit.Assertions.Assert
              (Powersum (N, K).Value - Powersum (N - 1, K).Value
                 = N ** Natural (K), "power sum difference");
         end loop;
         AUnit.Assertions.Assert
           (Consecutive_Integer_Lcm (N).Value mod N = 0,
            "LCM divisibility");
      end loop;
      AUnit.Assertions.Assert
        (Rising_Factorial (I128 (U64'Last), 1).Value
           = I128 (U64'Last)
           and not Rising_Factorial (I128 (U64'Last), 2).Defined
           and Falling_Factorial (0, U64'Last).Value = 0
           and Rising_Factorial (0, U64'Last).Value = 0,
         "factorial boundaries and overflow");
      for N in U64 range 1 .. 30 loop
         declare
            A : constant Optional_Fraction := Harmfrac (N - 1);
            B : constant Optional_Fraction := Harmfrac (N);
         begin
            AUnit.Assertions.Assert
              (U128 (B.Num) * A.Den * U128 (N)
                 = U128 (A.Num) * B.Den * U128 (N) + A.Den * B.Den,
               "harmonic difference");
         end;
      end loop;
      AUnit.Assertions.Assert
        (Harmfrac (88).Defined and not Harmfrac (89).Defined
           and not Harmfrac (U64'Last).Defined,
         "harmonic overflow boundaries");
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
      for A in U64 range 1 .. 40 loop
         for B in U64 range 1 .. 40 loop
            AUnit.Assertions.Assert
              (Integer_Complexity (A + B)
                 <= Integer_Complexity (A) + Integer_Complexity (B)
               and Integer_Complexity (A * B)
                 <= Integer_Complexity (A) + Integer_Complexity (B),
               "integer complexity sub-additive and sub-multiplicative");
         end loop;
      end loop;
      for A in U64 range 2 .. 12 loop
         for B in A + 1 .. 13 loop
            if Math_Prime_Util.Int.Gcd (A, B) = 1 then
               AUnit.Assertions.Assert
                 (Frobenius_Number ([A, B]).Value = I128 (A * B - A - B)
                  and Frobenius_Number ([A, B, A + B]).Value
                    <= I128 (A * B - A - B),
                  "frobenius two-term formula");
            end if;
         end loop;
      end loop;
      AUnit.Assertions.Assert
        (Is_Congruent_Number (5) and Is_Congruent_Number (6)
           and Is_Congruent_Number (7) and not Is_Congruent_Number (1)
           and not Is_Congruent_Number (0)
           and Is_Congruent_Number (20) = Is_Congruent_Number (5),
         "congruent number basics");
      AUnit.Assertions.Assert
        (Bernfrac (2) = (True, 1, 6) and Bernfrac (4) = (True, -1, 30)
           and Bernfrac (1) = (True, 1, 2) and Bernfrac (7) = (True, 0, 1)
           and not Bernfrac (64).Defined,
         "bernoulli values");
      AUnit.Assertions.Assert
        (Hclassno (3).Value = 4 and Hclassno (4).Value = 6
           and Hclassno (5).Value = 0 and not Hclassno (0).Defined,
         "class number values");
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
