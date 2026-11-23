with Ada.Assertions;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Vec;

package body Prop_Vec is
   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use Math_Prime_Util;
   use Math_Prime_Util.Vec;
   use type I128;
   use type U64;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);
   overriding function Name (T : Vec_Case) return AUnit.Message_String is
     (AUnit.Format ("Prop_Vec"));

   function Positive_Value (V : I128) return Boolean is (V > 0);
   function Plus (A, B : I128) return I128 is (A + B);
   function Both (A, B : I128) return Integer_Array is ([A, B]);
   function Window_Sum (A : Integer_Array) return Integer_Array is
     ([Vecsum (A)]);
   function First_Draw (Upper : Positive) return Positive is
     (Positive'Min (1, Upper));
   function All_Positive is new Vecall (Positive_Value);
   function Any_Positive is new Vecany (Positive_Value);
   function None_Positive is new Vecnone (Positive_Value);
   function Not_All_Positive is new Vecnotall (Positive_Value);
   function First_Positive is new Vecfirst (Positive_Value);
   function First_Positive_Index is new Vecfirstidx (Positive_Value);
   function Reduce_Sum is new Vecreduce (Plus);
   function Slide_Sum is new Vecslide (Plus);
   function Pair_Both is new Vecpairwise (Both);
   function Window_Sums is new Vecwindow (Window_Sum);
   function Pair_Sums is new Setbinop (Plus);
   function Sample is new Vecsample (First_Draw);

   procedure Callbacks (T : in out Test_Case'Class) is
      Empty : constant Integer_Array := [];
      A : constant Integer_Array (7 .. 10) := [-2, 0, 3, 5];
   begin
      Assert (All_Positive (Empty), "empty all");
      Assert (not Any_Positive (Empty), "empty any");
      Assert (None_Positive (Empty), "empty none");
      Assert (not Not_All_Positive (Empty), "empty notall");
      Assert (not All_Positive (A), "all");
      Assert (Any_Positive (A), "any");
      Assert (not None_Positive (A), "none");
      Assert (Not_All_Positive (A), "notall");
      Assert (First_Positive (A).Value = 3, "first");
      Assert (First_Positive_Index (A) = 2, "zero based index");
      Assert (First_Positive_Index (Empty) = -1, "absent index");
      Assert (not First_Positive (Empty).Defined, "absent value");
      Assert (not Reduce_Sum (Empty).Defined, "empty reduce");
      Assert (Reduce_Sum (A).Value = 6, "left fold");
      Assert (Slide_Sum (A) = [-2, 3, 8], "slide");
      Assert (Slide_Sum (Empty)'Length = 0, "empty slide");
      Assert (Slide_Sum ([1])'Length = 0, "singleton slide");
      Assert (Pair_Both (A, [8, 9]) = [-2, 8, 0, 9], "pair tails");
      Assert (Pair_Both (Empty, A)'Length = 0, "empty pair");
      Assert (Window_Sums (A, 1, 2) = [-2, 3, 8], "windows");
      Assert (Window_Sums (A, 3, 2) = [-2], "window gaps");
      Assert (Window_Sums (A, 1, 5)'Length = 0, "incomplete window");
      Assert (Pair_Sums (A, [0, 1]) = Sumset (A, [0, 1]), "setbinop");
      Assert (Sample (A, 2) = [-2, 0], "sample order");
      Assert (Sample (A, 0)'Length = 0, "empty sample");
      Assert (Sample (A, 9) = A, "oversize sample");
   end Callbacks;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 16#5EED_075#;
      X, Y : Integer_Array (1 .. 8);
      function Next return I128 is
      begin
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         return I128 (Seed mod 41) - 20;
      end Next;
   begin
      for Trial in 1 .. 100 loop
         for I in X'Range loop
            X (I) := Next;
            Y (I) := Next;
         end loop;
         Assert (Setunion (X, Y) = Setunion (Y, X), "union commutes");
         Assert (Setintersect (X, Y) = Setintersect (Y, X),
                 "intersection commutes");
         Assert (Setdelta (X, X)'Length = 0, "self delta");
         Assert (Toset (Toset (X)) = Toset (X), "set idempotence");
         Assert (Set_Is_Disjoint (Setminus (X, Y), Y), "difference");
         Assert (Vecsum (X) = Vecsum (Vecsort (X)), "sum permutation");
         Assert (Vecsort (Vecrsort (X)) = Vecsort (X), "sort permutation");
         Assert (Vecprefixsum (X) (X'Length) = Vecsum (X), "prefix sum");
      end loop;
   exception
      when Ada.Assertions.Assertion_Error =>
         Assert (False, "seed 0x5EED075 current" & U64'Image (Seed));
   end Laws;

   procedure Boundaries (T : in out Test_Case'Class) is
      A : constant Integer_Array :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1, 2 ** 63 - 1,
         2 ** 63 + 1, I128 (U64'Last), -I128 (U64'Last),
         I128'First, I128'Last];
      R : I128;
      Raised : Boolean := False;
   begin
      Assert (Vecmin (A).Value = I128'First, "minimum boundary");
      Assert (Vecmax (A).Value = I128'Last, "maximum boundary");
      Assert (Vecsort (A) (1) = I128'First, "signed boundary sort");
      Assert (Vecsum ([I128'First, I128'Last]) = -1, "wide sum");
      Assert (Vecprod ([I128'Last, 2, 0]) = 0, "zero product");
      begin
         R := Vecprod ([I128'Last, 2]);
      exception
         when Constraint_Error => Raised := True;
      end;
      Assert (Raised, "checked product overflow" & I128'Image (R));
      Assert (Vecextract ([1, 2, 3], [3, -4]) =
                [Optional_Value'(Defined => False),
                 Optional_Value'(Defined => False)], "undefined indices");
   end Boundaries;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine (T, Callbacks'Access, "callbacks");
      Registration.Register_Routine (T, Laws'Access, "laws seed 0x5EED075");
      Registration.Register_Routine (T, Boundaries'Access, "boundaries");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      R : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      R.Add_Test (new Vec_Case);
      return R;
   end Suite;
end Prop_Vec;
