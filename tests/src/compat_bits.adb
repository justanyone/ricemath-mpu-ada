with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util;
with Math_Prime_Util.Bits;

package body Compat_Bits is
   use AUnit.Assertions;
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Bits;
   use type U64;

   type Bits_Case is new Test_Case with null record;
   overriding function Name (T : Bits_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Bits_Case);

   overriding function Name (T : Bits_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Bits"));

   High : constant U64 := 2 ** 63;
   Max : constant U64 := U64'Last;
   Edges : constant array (Positive range 1 .. 10) of U64 :=
     [0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
      High - 1, High, High + 1, Max];

   type Operation is (Intersection, Union, Exclusive_Union, Difference);

   --  Arithmetic truth table checks each bit independently of Ada logic.
   function Expected (A, B : U64; Op : Operation) return U64 is
      Left : U64 := A;
      Right : U64 := B;
      Weight : U64 := 1;
      Result : U64 := 0;
      X, Y : U64;
      Set : Boolean;
   begin
      for Bit in 0 .. 63 loop
         X := Left mod 2;
         Y := Right mod 2;
         case Op is
            when Intersection => Set := X * Y = 1;
            when Union => Set := X + Y > 0;
            when Exclusive_Union => Set := X /= Y;
            when Difference => Set := X > Y;
         end case;
         if Set then
            Result := Result + Weight;
         end if;
         Left := Left / 2;
         Right := Right / 2;
         Weight := Weight * 2;
      end loop;
      return Result;
   end Expected;

   procedure Test_Bitand (T : in out Test_Case'Class) is
   begin
      Assert (Bitand (12, 10) = 8, "bitand example");
      for A of Edges loop
         for B of Edges loop
            Assert (Bitand (A, B) = Expected (A, B, Intersection),
                    "bitand edges" & A'Image & B'Image);
         end loop;
      end loop;
   end Test_Bitand;

   procedure Test_Bitor (T : in out Test_Case'Class) is
   begin
      Assert (Bitor (12, 10) = 14, "bitor example");
      for A of Edges loop
         for B of Edges loop
            Assert (Bitor (A, B) = Expected (A, B, Union),
                    "bitor edges" & A'Image & B'Image);
         end loop;
      end loop;
   end Test_Bitor;

   procedure Test_Bitxor (T : in out Test_Case'Class) is
   begin
      Assert (Bitxor (12, 10) = 6, "bitxor example");
      for A of Edges loop
         for B of Edges loop
            Assert (Bitxor (A, B) = Expected (A, B, Exclusive_Union),
                    "bitxor edges" & A'Image & B'Image);
         end loop;
      end loop;
   end Test_Bitxor;

   procedure Test_Bitnot (T : in out Test_Case'Class) is
   begin
      Assert (Bitnot (0) = Max, "bitnot zero complements all 64 bits");
      for N of Edges loop
         Assert (Bitnot (N) = Max - N, "bitnot edges" & N'Image);
      end loop;
      for Bit in 0 .. 63 loop
         Assert (Bitnot (2 ** Bit) = Max - 2 ** Bit,
                 "bitnot single bit" & Bit'Image);
      end loop;
   end Test_Bitnot;

   procedure Test_Bitandnot (T : in out Test_Case'Class) is
   begin
      Assert (Bitandnot (12, 10) = 4, "bitandnot example");
      for A of Edges loop
         for B of Edges loop
            Assert (Bitandnot (A, B) = Expected (A, B, Difference),
                    "bitandnot edges" & A'Image & B'Image);
         end loop;
      end loop;
   end Test_Bitandnot;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      A, B : U64;
   begin
      for I in 1 .. 1_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         A := Seed;
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         B := Seed;
         Assert (Bitandnot (A, B) = Bitand (A, Bitnot (B)),
                 "andnot law seed 20261020 case" & I'Image);
         Assert (Bitxor (A, A) = 0,
                 "xor self law seed 20261020 case" & I'Image);
         Assert (Bitand (A, B) = Expected (A, B, Intersection),
                 "and truth table seed 20261020 case" & I'Image);
         Assert (Bitor (A, B) = Expected (A, B, Union),
                 "or truth table seed 20261020 case" & I'Image);
         Assert (Bitxor (A, B) = Expected (A, B, Exclusive_Union),
                 "xor truth table seed 20261020 case" & I'Image);
         Assert (Bitnot (A) = Max - A,
                 "not truth table seed 20261020 case" & I'Image);
         Assert (Bitandnot (A, B) = Expected (A, B, Difference),
                 "andnot truth table seed 20261020 case" & I'Image);
      end loop;
   end Laws;

   overriding procedure Register_Tests (T : in out Bits_Case) is
   begin
      Registration.Register_Routine (T, Test_Bitand'Access, "bitand");
      Registration.Register_Routine (T, Test_Bitor'Access, "bitor");
      Registration.Register_Routine (T, Test_Bitxor'Access, "bitxor");
      Registration.Register_Routine (T, Test_Bitnot'Access, "bitnot");
      Registration.Register_Routine (T, Test_Bitandnot'Access, "bitandnot");
      Registration.Register_Routine (T, Laws'Access, "laws seed 20261020");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Bits_Case);
      return Result;
   end Suite;
end Compat_Bits;
