with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Config;
with Math_Prime_Util.Int;

package body Prop_Int is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Int;
   use type U64;
   use type U128;
   use type I128;

   type Int_Case is new Test_Case with null record;
   overriding function Name (T : Int_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Int_Case);

   overriding function Name (T : Int_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Int seed 20261020");
   end Name;

   procedure Check_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      A, B, N, R : U64;
      Inv : Optional_U64;
   begin
      for I in 1 .. 1_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         A := Seed;
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         B := Seed;
         N := B or 1;
         R := Sqrtint (A);
         AUnit.Assertions.Assert
           (U128 (R) ** 2 <= U128 (A) and then
            (U128 (R) + 1) ** 2 > U128 (A), "sqrt seed 20261020");
         AUnit.Assertions.Assert
           (Gcd (A, B) = Gcd (B, A), "gcd seed 20261020");
         AUnit.Assertions.Assert
           (Submod (Addmod (A, B, N).Value, B, N).Value = A mod N,
            "add/sub seed 20261020");
         AUnit.Assertions.Assert
           (U128 (Mulmod (A, B, N).Value) =
              U128 (A) * U128 (B) mod U128 (N),
            "wide product seed 20261020");
         Inv := Invmod (A, N);
         AUnit.Assertions.Assert
           (Inv.Defined = (Gcd (A, N) = 1), "inverse seed 20261020");
         if Inv.Defined then
            AUnit.Assertions.Assert
              (Mulmod (A, Inv.Value, N).Value = 1 mod N,
               "inverse product seed 20261020");
         end if;
         AUnit.Assertions.Assert
           (Powmod (A, 2, N).Value = Sqrmod (A, N).Value,
            "square seed 20261020");
      end loop;
      --  Zero moduli return undefined, including duplicate calls.
      for I in 1 .. 2 loop
         AUnit.Assertions.Assert
           (not Mulmod (U64'Last, U64'Last, 0).Defined,
            "zero modulus");
      end loop;
      AUnit.Assertions.Assert
        (not Powint (2, 64).Defined and then
         Powint (2, 63).Value = 2 ** 63, "power overflow boundary");
      AUnit.Assertions.Assert
        (Gcdext (-(2 ** 63), 0).D = 2 ** 63,
         "signed minimum gcdext");
   end Check_Laws;

   --  Laws of prime_set_config and prime_get_config: a set value is
   --  read back, and the platform sizes agree with each other.
   procedure Check_Config_Laws (T : in out Test_Case'Class) is
      use Math_Prime_Util.Config;
      Saved : constant Config_Record := Prime_Get_Config;
   begin
      for V in Natural range 0 .. 999 loop
         Prime_Set_Config ("verbose", Natural'Image (V) (2 ..
           Natural'Image (V)'Last));
         AUnit.Assertions.Assert
           (Prime_Get_Config.Verbose = V, "verbose round trip");
      end loop;
      for Flag in Boolean loop
         Prime_Set_Config ("rh", (if Flag then "1" else "0"));
         AUnit.Assertions.Assert
           (Prime_Get_Config.Assume_RH = Flag, "assume_rh round trip");
      end loop;
      AUnit.Assertions.Assert
        (Uvbits = Uvsize * 8, "uvbits is 8 times uvsize");
      AUnit.Assertions.Assert
        (Nvmantdigits < Nvmantbits, "digits are fewer than bits");
      Prime_Set_Config ("verbose", Natural'Image (Saved.Verbose) (2 ..
        Natural'Image (Saved.Verbose)'Last));
      Prime_Set_Config ("rh", (if Saved.Assume_RH then "1" else "0"));
   end Check_Config_Laws;

   overriding procedure Register_Tests (T : in out Int_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Laws'Access, "integer laws seed 20261020");
      Registration.Register_Routine
        (T, Check_Config_Laws'Access, "config laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Int_Case);
      return Result;
   end Suite;
end Prop_Int;
