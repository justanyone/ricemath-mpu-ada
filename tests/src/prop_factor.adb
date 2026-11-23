with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;

package body Prop_Factor is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Factor;
   use type U64;
   use type U128;
   use type Primality.Prime_Result;

   type Factor_Case is new Test_Case with null record;
   overriding function Name (T : Factor_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Factor_Case);

   overriding function Name (T : Factor_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Factor seed 20261123");
   end Name;

   procedure Check (N : U64) is
      Pairs : constant Factor_Exp_Vectors.Vector := Factor_Exp (N);
      Signature : constant U64_Vectors.Vector := Prime_Signature (N);
      Split : constant Factor_List := Cheb_Factor (N, B => 100);
      Product, Split_Product : U128 := 1;
      Sum : Natural := 0;
      Square_Free : Boolean := N /= 0;
      Last : U64 := 0;
      Histogram : array (Factor_Exponent) of Natural := [others => 0];
      Message : constant String := "seed 20261123 N=" & U64'Image (N);
   begin
      for I in 1 .. Natural (Pairs.Length) loop
         declare
            Pair : constant Prime_Exponent := Pairs.Element (I);
         begin
            Product := Product * U128 (Pair.Prime) ** Pair.Exponent;
            Sum := Sum + Pair.Exponent;
            Square_Free := Square_Free and then Pair.Exponent = 1;
            Histogram (Pair.Exponent) := Histogram (Pair.Exponent) + 1;
            AUnit.Assertions.Assert
              (N = 0 or else (Pair.Prime > Last
               and then Primality.Is_Prime (Pair.Prime) = 2), Message);
            Last := Pair.Prime;
         end;
      end loop;
      AUnit.Assertions.Assert
        (Product = U128 (N) and then Prime_Bigomega (N) = Sum
         and then Prime_Omega (N) = Natural (Pairs.Length), Message);
      AUnit.Assertions.Assert
        (Is_Square_Free (N) = Square_Free
         and then Is_Semiprime (N) = (Sum = 2), Message);
      for K in U64 range 0 .. 65 loop
         AUnit.Assertions.Assert
           (Is_Almost_Prime (K, N) = (N > 0 and then K = U64 (Sum))
            and then Is_Omega_Prime (K, N)
              = (N > 0 and then K = U64 (Pairs.Length)), Message);
      end loop;
      for I in 1 .. Natural (Signature.Length) loop
         declare
            E : constant Factor_Exponent :=
              Factor_Exponent (Signature.Element (I));
         begin
            AUnit.Assertions.Assert (Histogram (E) > 0, Message);
            Histogram (E) := Histogram (E) - 1;
            AUnit.Assertions.Assert
              (I = 1 or else Signature.Element (I - 1)
                 >= Signature.Element (I), Message);
         end;
      end loop;
      AUnit.Assertions.Assert
        (Natural (Signature.Length) = Natural (Pairs.Length)
         and then (for all Count of Histogram => Count = 0), Message);
      for I in 1 .. Split.Count loop
         Split_Product := Split_Product * U128 (Split.Value (I));
      end loop;
      AUnit.Assertions.Assert (Split_Product = U128 (N), Message);
   end Check;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_123;
   begin
      for I in 1 .. 128 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         Check (Seed mod 1_000_000 + 1);
      end loop;
   end Laws;

   procedure Boundaries (T : in out Test_Case'Class) is
      Inputs : constant array (Positive range <>) of U64 :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last];
      Split : Factor_List;
   begin
      for N of Inputs loop
         Check (N);
         AUnit.Assertions.Assert
           (not Is_Almost_Prime (U64'Last, N)
            and then not Is_Omega_Prime (U64'Last, N), "huge K");
      end loop;
      Split := Cheb_Factor (221, 100, U64'Last);
      AUnit.Assertions.Assert
        (Split.Count = 2 and then Split.Value (1) = 13
         and then Split.Value (2) = 17, "reduce initial value");
      Split := Cheb_Factor (49, 1);
      AUnit.Assertions.Assert
        (Split.Count = 1 and then Split.Value (1) = 49,
         "exhausted bound preserves cofactor");
      Split := Cheb_Factor (2_466_600_463_243_213_733, 1_000);
      AUnit.Assertions.Assert
        (Split.Count = 2 and then Split.Value (1) = 1_552_318_819
         and then Split.Value (2) = 1_588_978_007, "64-bit Chebyshev split");
   end Boundaries;

   overriding procedure Register_Tests (T : in out Factor_Case) is
   begin
      Registration.Register_Routine (T, Laws'Access, "factor laws");
      Registration.Register_Routine (T, Boundaries'Access, "boundaries");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Factor_Case);
      return Result;
   end Suite;
end Prop_Factor;
