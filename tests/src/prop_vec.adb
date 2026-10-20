with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Assertions;
with Math_Prime_Util.Vec;

package body Prop_Vec is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Vec;
   use type U64;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Vec seed 20261020");
   end Name;

   procedure Check_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      A, B : Vector (1 .. 12);
   begin
      for Trial in 1 .. 100 loop
         for I in A'Range loop
            Seed := Seed * 6_364_136_223_846_793_005 + 1;
            A (I) := I64 (Seed mod 31) - 15;
            Seed := Seed * 6_364_136_223_846_793_005 + 1;
            B (I) := I64 (Seed mod 31) - 15;
         end loop;
         declare
            X : constant Vector := Toset (A);
            Y : constant Vector := Toset (B);
         begin
            AUnit.Assertions.Assert
              (Is_Set (X) and then Toset (X) = X,
               "normalization seed 20261020");
            AUnit.Assertions.Assert
              (Setunion (X, Y) = Setunion (Y, X) and then
               Setintersect (X, Y) = Setintersect (Y, X),
               "commutativity seed 20261020");
            AUnit.Assertions.Assert
              (Setdelta (Setdelta (X, Y), Y) = X and then
               Setminus (X, X)'Length = 0,
               "cancellation seed 20261020");
            AUnit.Assertions.Assert
              (Setunion (Setminus (X, Y), Setintersect (X, Y)) = X,
               "partition seed 20261020");
         end;
      end loop;
      --  Nonstandard lower bounds must have the same semantics.
      AUnit.Assertions.Assert
        (Toset (Vector'(7 .. 9 => 3)) = Vector'(1 => 3),
         "shifted bounds and duplicates");
      --  Repeat calls cannot retain state from an earlier operation.
      for I in 1 .. 2 loop
         AUnit.Assertions.Assert
           (Setinsert (Vector'(1 => 2), Vector'(1 => 2)) =
            Vector'(1 => 2), "duplicate insert");
      end loop;
      declare
         Raised : Boolean := False;
      begin
         begin
            A := Setunion (Vector'[2, 1], Vector'[3]);
         exception
            when Ada.Assertions.Assertion_Error => Raised := True;
         end;
         AUnit.Assertions.Assert (Raised, "unsorted set rejected");
      end;
      AUnit.Assertions.Assert
        (Is_Sumfree_Set (Vector'[I64'First, I64'Last]),
         "wide signed sums");
   end Check_Laws;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine (T, Check_Laws'Access, "set laws");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Prop_Vec;
