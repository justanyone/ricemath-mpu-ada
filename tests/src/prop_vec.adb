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

   function Add (L, R : I64) return I64 is (L + R);
   function Positive_Value (V : I64) return Boolean is (V > 0);
   function Total (A : Vector) return I64 is (I64 (Vecsum (A)));

   procedure Check_Callbacks (T : in out Test_Case'Class);

   procedure Check_Callbacks (T : in out Test_Case'Class) is
      A : constant Vector (7 .. 10) := [-1, 2, 3, 4];
      Empty : constant Vector := [];
      use type U128;
   begin
      AUnit.Assertions.Assert
        (Vecreduce (A, Add'Access) = Optional_Integer'(True, 8)
         and then not Vecreduce (Empty, Add'Access).Present,
         "left fold and empty fold");
      AUnit.Assertions.Assert
        (Vecany (A, Positive_Value'Access)
         and then not Vecall (A, Positive_Value'Access)
         and then not Vecnone (A, Positive_Value'Access)
         and then Vecnotall (A, Positive_Value'Access), "quantifiers");
      AUnit.Assertions.Assert
        (not Vecany (Empty, Positive_Value'Access)
         and then Vecall (Empty, Positive_Value'Access)
         and then Vecnone (Empty, Positive_Value'Access)
         and then not Vecnotall (Empty, Positive_Value'Access),
         "empty quantifiers");
      AUnit.Assertions.Assert
        (Vecfirst (A, Positive_Value'Access) =
           Optional_Integer'(True, 2)
         and then Vecfirstidx (A, Positive_Value'Access) = 1
         and then Vecfirstidx (Empty, Positive_Value'Access) = -1,
         "first positions use zero origin");
      AUnit.Assertions.Assert
        (Vecslide (A, Add'Access) = Vector'[1, 5, 7]
         and then Vecpairwise (A, Vector'[5, 6], Add'Access) =
           Vector'[4, 8], "adjacent and pairwise callbacks");
      AUnit.Assertions.Assert
        (Vecwindow (A, 2, 2, Total'Access) = Vector'[1, 7]
         and then Vecwindow (A, 1, 5, Total'Access)'Length = 0,
         "complete stepped windows");
      AUnit.Assertions.Assert
        (Setbinop (Vector'[1, 2], Vector'[2, 3], Add'Access) =
           Vector'[3, 4, 5], "Cartesian set callback deduplicates");
      AUnit.Assertions.Assert
        (Vecextract (A, U128'(5)) =
           Optional_Vector'[(True, -1), (True, 3)]
         and then Vecextract (A, Vector'[-1, 8]) =
           Optional_Vector'[(True, 4), (Present => False)],
         "mask and signed index extraction");
      AUnit.Assertions.Assert
        (Vecsum (Unsigned_Vector'[U64'Last, 1]) = 2 ** 64,
         "unsigned sum widens on overflow");
      AUnit.Assertions.Assert
        (Vecprod (Vector'[I64'Last, I64'Last, I64'Last, 0]) = 0,
         "zero annihilates a large product");
   end Check_Callbacks;

   procedure Check_Laws (T : in out Test_Case'Class);

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
            declare
               Invalid : constant Vector :=
                 Setunion (Vector'[2, 1], Vector'[3]);
            begin
               AUnit.Assertions.Assert
                 (Invalid'Length = 0, "invalid input must raise");
            end;
         exception
            when Ada.Assertions.Assertion_Error | Constraint_Error =>
               Raised := True;
         end;
         AUnit.Assertions.Assert (Raised, "unsorted set rejected");
      end;
      AUnit.Assertions.Assert
        (Is_Sumfree_Set (Vector'[I64'First, I64'Last]),
         "wide signed sums");
   end Check_Laws;

   procedure Check_List_Laws (T : in out Test_Case'Class);

   procedure Check_List_Laws (T : in out Test_Case'Class) is
      Calls : Natural := 0;
      function Pair (L, R : I64) return Vector is
      begin
         Calls := Calls + 1;
         return [L, R];
      end Pair;
      function Identity (A : Vector) return Vector is
      begin
         Calls := Calls + 1;
         return A;
      end Identity;
      function Probe (V : I64) return Boolean is
      begin
         Calls := Calls + 1;
         return V > 0;
      end Probe;
      A : constant Vector (7 .. 10) := [-1, 2, 3, 4];
      B : constant Vector (3 .. 4) := [5, 6];
   begin
      AUnit.Assertions.Assert
        (Vecpairwise (A, B, Pair'Access) = Vector'[-1, 5, 2, 6]
         and then Calls = 2, "list pair order and one call per pair");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecwindow (A, 2, 2, Identity'Access) = A and then Calls = 2,
         "disjoint identity windows reconstruct input");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecwindow (A, 1, 1, Identity'Access) = A and then Calls = 4,
         "singleton identity windows reconstruct input");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecwindow (A, Positive'Last, 2, Identity'Access) =
           Vector'[-1, 2] and then Calls = 1, "large window step");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecany (A, Probe'Access) and then Calls = 2,
         "any stops on first true");
      Calls := 0;
      AUnit.Assertions.Assert
        (not Vecall (A, Probe'Access) and then Calls = 1,
         "all stops on first false");
      Calls := 0;
      AUnit.Assertions.Assert
        (not Vecnone (A, Probe'Access) and then Calls = 2,
         "none stops on first true");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecnotall (A, Probe'Access) and then Calls = 1,
         "notall stops on first false");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecfirst (A, Probe'Access) = Optional_Integer'(True, 2)
         and then Calls = 2, "first stops at first match");
      Calls := 0;
      AUnit.Assertions.Assert
        (Vecfirstidx (A, Probe'Access) = 1 and then Calls = 2,
         "firstidx stops at first match");
   end Check_List_Laws;

   procedure Check_Upper_Bounds (T : in out Test_Case'Class);

   procedure Check_Upper_Bounds (T : in out Test_Case'Class) is
      A : constant Vector (Positive'Last - 1 .. Positive'Last) := [1, 2];
      Indices : constant Vector (Positive'Last .. Positive'Last) := [1];
      function Identity (Window : Vector) return Vector is (Window);
   begin
      AUnit.Assertions.Assert
        (Setunion (A, A) = Vector'[1, 2], "set at upper index bound");
      AUnit.Assertions.Assert
        (Vecprefixsum (A) = Wide_Vector'[1, 3],
         "prefix sum at upper index bound");
      AUnit.Assertions.Assert
        (Vecextract (A, Indices) = Optional_Vector'[(True, 2)],
         "extraction indices at upper index bound");
      AUnit.Assertions.Assert
        (Vecslide (A, Add'Access) = Vector'[3],
         "slide at upper index bound");
      AUnit.Assertions.Assert
        (Vecpairwise (A, A, Add'Access) = Vector'[2, 4],
         "pairwise at upper index bound");
      AUnit.Assertions.Assert
        (Vecwindow (A, 1, 2, Total'Access) = Vector'[3]
         and then Vecwindow (A, 1, 2, Identity'Access) = A,
         "window at upper index bound");
   end Check_Upper_Bounds;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Upper_Bounds'Access, "upper index bounds");
      Registration.Register_Routine
        (T, Check_List_Laws'Access, "list laws and short circuit");
      Registration.Register_Routine (T, Check_Laws'Access, "set laws");
      Registration.Register_Routine
        (T, Check_Callbacks'Access, "callback and arithmetic boundaries");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Prop_Vec;
