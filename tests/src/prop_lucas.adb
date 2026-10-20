with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Lucas;
with Math_Prime_Util.Int;

package body Prop_Lucas is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Lucas;
   use type U64;
   use type U128;
   use type I128;
   type Lucas_Case is new Test_Case with null record;
   overriding function Name (T : Lucas_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Lucas_Case);

   overriding function Name (T : Lucas_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Lucas seed 20261020");
   end Name;

   procedure Check_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, K : U64;
      P, Q : I64;
      A, B, C : Residue_Pair;
      S : Sequence_Result;
      function Modulo (V : I128) return U64 is
        (U64 (V mod I128 (N)));
   begin
      for I in 1 .. 1_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := Seed / 2 + 1;
         K := Seed mod 100;
         P := I64 (Seed mod 21) - 10;
         Q := I64 (Seed / 32 mod 21) - 10;
         A := Lucasuvmod (P, Q, K, N);
         B := Lucasuvmod (P, Q, K + 1, N);
         C := Lucasuvmod (P, Q, K + 2, N);
         AUnit.Assertions.Assert
           (C.U = Modulo (I128 (P) * I128 (B.U) -
                          I128 (Q) * I128 (A.U)) and
            C.V = Modulo (I128 (P) * I128 (B.V) -
                          I128 (Q) * I128 (A.V)),
            "recurrence seed 20261020");
         S := Lucas_Sequence (N, P, Q, K);
         AUnit.Assertions.Assert
           (S.U = A.U and S.V = A.V and
            S.Qk = Int.Powmod (Modulo (I128 (Q)), K, N).Value,
            "sequence seed 20261020");
         AUnit.Assertions.Assert
           (Lucasuvmod (P, Q, K, N) = A,
            "repeat call seed 20261020");
      end loop;
      for J in I64 range 2 .. 90 loop
         AUnit.Assertions.Assert
           (Fibonacci (J).Value = Fibonacci (J - 1).Value +
              Fibonacci (J - 2).Value, "Fibonacci recurrence");
         AUnit.Assertions.Assert
           (Lucas_Number (J).Value = Fibonacci (J - 1).Value +
              Fibonacci (J + 1).Value, "Lucas/Fibonacci identity");
      end loop;
      AUnit.Assertions.Assert
        (not Fibonacci (I64'First).Defined and
         not Lucas_Number (I64'First).Defined, "minimum signed index");
   end Check_Laws;

   overriding procedure Register_Tests (T : in out Lucas_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Laws'Access, "Lucas laws seed 20261020");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Lucas_Case);
      return Result;
   end Suite;
end Prop_Lucas;
