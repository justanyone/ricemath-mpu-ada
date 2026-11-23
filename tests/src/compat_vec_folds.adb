with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Vec.Folds;

package body Compat_Vec_Folds is
   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use Math_Prime_Util.Vec.Folds;
   use type U64;
   type Fold_Case is new Test_Case with null record;
   overriding function Name (T : Fold_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Fold_Case);

   function Add (A, B : U64) return U64 is (A + B);
   function Xor_Values (A, B : U64) return U64 is (A xor B);
   function Squares (A, B : U64) return U64 is (A * B ** 2);
   function Reverse_Subtract (A, B : U64) return U64 is (B - A);
   function Weighted (A, B : U64) return U64 is (A + 2 * B);
   function Mod_Four (A, B : U64) return U64 is ((A + B) mod 4);
   function Power (A, B : U64) return U64 is (A ** Natural (B));
   function Assigned (A, B : U64) return U64 is (10 * A + B + 1);
   function Pair_Sum (A, B : U64) return Value_Array is ([A + B]);
   function Pair_List (A, B : U64) return Value_Array is ([A, B]);
   function Pair_Filter (A, B : U64) return Value_Array is
     (if B = 0 then [] else [A, B]);
   function Identity (Window : Value_Array) return Value_Array is (Window);
   function Sum (Window : Value_Array) return Value_Array is
      Acc : U64 := 0;
   begin
      for V of Window loop
         Acc := Acc + V;
      end loop;
      return [Acc];
   end Sum;
   function Reverse_Window (Window : Value_Array) return Value_Array is
      Result : Value_Array (1 .. Window'Length);
   begin
      for I in Result'Range loop
         Result (I) := Window (Window'Last - I + 1);
      end loop;
      return Result;
   end Reverse_Window;
   function Difference (Window : Value_Array) return Value_Array is
     ([Window (Window'First + 1) - Window (Window'First)]);
   function Change_Window (Window : Value_Array) return Value_Array is
      Copy : Value_Array := Window;
   begin
      Copy (Copy'First) := Copy (Copy'First) * 10;
      Copy (Copy'Last) := Copy (Copy'Last) + 1;
      return Copy;
   end Change_Window;

   function Reduce is new Vecreduce (Add);
   function Reduce_Xor is new Vecreduce (Xor_Values);
   function Reduce_Squares is new Vecreduce (Squares);
   function Slide is new Vecslide (Add);
   function Slide_Change is new Vecslide (Assigned);
   function Pairs is new Vecpairwise (Pair_Sum);
   function Lists is new Vecpairwise (Pair_List);
   function Filter is new Vecpairwise (Pair_Filter);
   function Windows is new Vecwindow (Identity);
   function Sums is new Vecwindow (Sum);
   function Reversals is new Vecwindow (Reverse_Window);
   function Differences is new Vecwindow (Difference);
   function Changes is new Vecwindow (Change_Window);
   function Set_Add is new Setbinop (Add);
   function Set_Sub is new Setbinop (Reverse_Subtract);
   function Set_Weighted is new Setbinop (Weighted);
   function Set_Mod is new Setbinop (Mod_Four);
   function Set_Power is new Setbinop (Power);

   procedure Equal (Got, Expected : Value_Array; Source : String) is
   begin
      Assert (Got = Expected, Source);
   end Equal;

   procedure Check_Reduce (T : in out Test_Case'Class) is
      Boundaries : constant Value_Array :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63 + 1, U64'Last];
      Calls : Natural := 0;
      function Count (A, B : U64) return U64 is
      begin
         Calls := Calls + 1;
         return A + B;
      end Count;
      function Count_Reduce is new Vecreduce (Count);
   begin
      Assert (not Reduce ([]).Defined, "26-vec.t:266 empty");
      Assert (Count_Reduce ([15]).Value = 15 and then Calls = 0,
              "26-vec.t:267 singleton does not call block");
      Assert (Reduce_Xor ([4, 2]).Value = 6, "26-vec.t:268 xor");
      Assert (Reduce_Squares ([1, 17, 18, 19]).Value = 33_802_596,
              "26-vec.t:269 left fold product of squares");
      --  26-vec.t:271-272 skipped: negative result outside U64.
      --  26-vec.t:274-276 skipped: 2**64 bigint input outside U64.
      for V of Boundaries loop
         Assert (Reduce ([V, 0]).Value = V, "native boundary fold");
         Equal (Slide ([V, 0]), [V], "native boundary slide");
         Equal (Pairs ([V], [0]), [V], "native boundary pair");
         Equal (Windows (1, 1, [V]), [V], "native boundary window");
      end loop;
   end Check_Reduce;

   procedure Check_Slide (T : in out Test_Case'Class) is
      Input : constant Value_Array := [1, 2, 3, 4, 5];
      Got : Value_Array := Slide (Input);
   begin
      Equal (Slide ([]), [], "26-vec.t:704 empty");
      Equal (Slide ([1]), [], "26-vec.t:705 singleton");
      Equal (Got, [3, 5, 7, 9], "26-vec.t:707 sums");
      Equal (Slide_Change (Input), [13, 24, 35, 46],
             "26-vec.t:711 assignments");
      Got (1) := 99;
      Equal (Input, [1, 2, 3, 4, 5], "26-vec.t:622,712 no aliases");
      --  26-vec.t:708-709 skipped: reference/string values, not U64.
      Equal (Slide (Value_Array'(7 => 1, 8 => 2)), [3],
             "non-one lower bound");
   end Check_Slide;

   procedure Check_Pairs (T : in out Test_Case'Class) is
      Input : constant Value_Array := [1, 2, 3];
      Got : Value_Array := Pairs (Input, [10, 20, 30]);
   begin
      Equal (Pairs ([], []), [], "26-vec.t:672 empty");
      Equal (Pairs (Input, [10]), [11], "26-vec.t:673 trailing");
      Equal (Got, [11, 22, 33], "26-vec.t:674 sums");
      Equal (Lists ([1, 2], [3, 4]), [1, 3, 2, 4],
             "26-vec.t:681 list returns");
      Equal (Filter (Input, [1, 0, 4]), [1, 1, 3, 4],
             "26-vec.t:682 empty returns");
      Assert (Pairs ([1, 2], [3, 4])'Length = 2, "26-vec.t:684 count");
      Assert (Lists ([1, 2], [3, 4])'Length = 4, "26-vec.t:685 count");
      Got (1) := 99;
      Equal (Input, [1, 2, 3], "26-vec.t:633-634,693-694 no aliases");
      --  26-vec.t:675,678-679,688-689 skipped: non-U64 values/undef.
      --  26-vec.t:696-699: wrong array types rejected by Ada at compile.
      Equal (Pairs ([10], Input), [11], "right trailing ignored");
      Equal (Pairs (Input, []), [], "empty right");
   end Check_Pairs;

   procedure Check_Windows (T : in out Test_Case'Class) is
      Input : constant Value_Array := [1, 2, 3, 4];
      Got : Value_Array := Sums (1, 2, Input);
   begin
      Equal (Windows (1, 3, []), [], "26-vec.t:640 empty");
      Equal (Windows (1, 3, [1, 2]), [], "26-vec.t:641 short");
      Equal (Windows (1, 3, [1, 2, 3]), [1, 2, 3], "26-vec.t:642 exact");
      Equal (Windows (2, 2, [1, 2, 3, 4, 5, 6]), [1, 2, 3, 4, 5, 6],
             "26-vec.t:645 pairs");
      Equal (Sums (3, 3, [1, 2, 3, 4, 5, 6, 7, 8, 9]), [6, 15, 24],
             "26-vec.t:646 chunk sums");
      Equal (Reversals (4, 4, [1, 2, 3, 4, 5, 6, 7, 8]),
             [4, 3, 2, 1, 8, 7, 6, 5], "26-vec.t:647 reverse");
      Equal (Windows (3, 3, [1, 2, 3, 4, 5, 6, 7]), [1, 2, 3, 4, 5, 6],
             "26-vec.t:649 tail dropped");
      Equal (Differences (1, 2, [1, 2, 3, 4, 5]), [1, 1, 1, 1],
             "26-vec.t:652 differences");
      Equal (Sums (1, 3, [1, 2, 3, 4, 5]), [6, 9, 12],
             "26-vec.t:653 running sum");
      Equal (Sums (3, 2, [1, 2, 3, 4, 5, 6, 7, 8]), [3, 9, 15],
             "26-vec.t:656 gaps");
      Equal (Reversals (2, 2, Input), [2, 1, 4, 3], "26-vec.t:659 list");
      Equal (Windows (1, 2, [1, 2, 3]), [1, 2, 2, 3], "26-vec.t:660");
      Equal (Sums (1, 2, [1, 2, 3]), [3, 5], "26-vec.t:661 nested");
      Equal (Changes (1, 2, Input), [10, 3, 20, 4, 30, 5],
             "26-vec.t:665-666 assignments");
      Got (1) := 99;
      Equal (Input, [1, 2, 3, 4], "26-vec.t:623,667 no aliases");
      Equal (Windows (Positive'Last, 1, Input), [1], "huge step");
      Equal (Windows (1, Positive'Last, Input), [], "huge size");
      Equal (Windows (1, 1, Value_Array'(Positive'Last => 42)),
             [42], "maximum index window");
      Equal (Windows (1, 2, Value_Array'(7 => 1, 8 => 2)), [1, 2],
             "window non-one bound");
   end Check_Windows;

   procedure Check_Set (T : in out Test_Case'Class) is
      B : aliased constant Value_Array := [3, 5, 7];
      C : aliased constant Value_Array := [5, 7, 9];
      Exponents : aliased constant Value_Array := [2, 3, 5];
      Empty : aliased constant Value_Array := [];
      Left : Value_Array := [1, 2];
      Right : aliased Value_Array := [10, 20];
      function Snapshot (A, B : U64) return U64 is
      begin
         Left := [0, 0];
         Right := [0, 0];
         return A + B;
      end Snapshot;
      function Snap_Set is new Setbinop (Snapshot);
      Calls : Natural := 0;
      function Ordered (A, B : U64) return U64 is
      begin
         Calls := Calls + 1;
         Assert (A = (if Calls <= 2 then 1 else 2), "sorted left");
         Assert (B = (if Calls mod 2 = 1 then 1 else 2), "sorted right");
         return A + B;
      end Ordered;
      function Ordered_Set is new Setbinop (Ordered);
   begin
      Equal (Set_Add ([], B'Access), [], "26-setbinop.t:12 empty");
      Equal (Set_Add ([2, 4, 6]), [4, 6, 8, 10, 12], "26-setbinop.t:14");
      Equal (Set_Add ([2, 4, 6, 8], B'Access), [5, 7, 9, 11, 13, 15],
             "26-setbinop.t:18");
      --  26-setbinop.t:22 skipped: negative results outside U64.
      Equal (Set_Sub ([1, 2, 3], C'Access), [2, 3, 4, 5, 6, 7, 8],
             "26-setbinop.t:26");
      Equal (Set_Weighted ([1, 2, 3], C'Access),
             [11, 12, 13, 15, 16, 17, 19, 20, 21], "26-setbinop.t:30");
      Equal (Set_Mod ([3, 7, 14]), [0, 1, 2], "26-setbinop.t:34");
      Equal (Set_Power ([2, 3, 5, 7, 11, 13], Exponents'Access),
             [4, 8, 9, 25, 27, 32, 49, 121, 125, 169, 243, 343,
              1331, 2197, 3125, 16807, 161051, 371293], "26-setbinop.t:39");
      --  26-setbinop.t:48-50 skipped: A-A has negative results.
      Equal (Snap_Set (Left, Right'Access), [11, 12, 21, 22],
             "26-setbinop.t:56-57 snapshots");
      Equal (Set_Mod (Value_Array'(Positive'Last => 1)), [2],
             "maximum index canonical set");
      Equal (Set_Add ([1], Empty'Access), [], "explicit empty right");
      Equal (Ordered_Set ([2, 1, 2]), [2, 3, 4], "canonical callbacks");
      Assert (Calls = 4, "each canonical Cartesian pair once");
      Equal (Set_Add ([U64'Last], Empty'Access), [], "native maximum");
   end Check_Set;

   function Parse_Set (Text : String; Fits : out Boolean)
      return Value_Array
   is
      Buffer : Value_Array (1 .. Text'Length);
      Count : Natural := 0;
      Start : Positive := Text'First;
      Value : U64;
   begin
      Fits := True;
      if Text = "-" then
         return [];
      end if;
      for I in Text'First .. Text'Last + 1 loop
         if I > Text'Last or else Text (I) = ',' then
            if not Fixture_Support.Parse_U64 (Text (Start .. I - 1), Value)
            then
               Fits := False;
               return [];
            end if;
            Count := Count + 1;
            Buffer (Count) := Value;
            Start := I + 1;
         end if;
      end loop;
      return Buffer (1 .. Count);
   end Parse_Set;

   function Image (Items : Value_Array) return String is
      Text : Unbounded_String;
   begin
      for V of Items loop
         if Length (Text) > 0 then
            Append (Text, " ");
         end if;
         Append (Text, Ada.Strings.Fixed.Trim
                   (U64'Image (V), Ada.Strings.Both));
      end loop;
      return To_String (Text);
   end Image;

   --  bigint_sets.tsv skipped rows (input outside U64):
   --  84, 102, 120, 138, 156, 174, 260, 278.
   --  296, 314, 332, 350, 436, 454, 472, 490.
   --  508, 526, 558, 576, 594, 612, 630, 648.
   --  666, 684, 702, 734, 752, 770, 788, 806.
   --  824, 842, 860, 878, 910, 928, 946, 964.
   --  982, 1000, 1018, 1036, 1054, 1086, 1104, 1122.
   --  1140, 1158, 1176, 1194, 1212, 1230, 1260, 1278.
   --  1296, 1314, 1332, 1350, 1368, 1386, 1404, 1436.
   --  1454, 1472, 1490, 1508, 1526, 1544, 1562, 1580.

   procedure Check_Fixtures (T : in out Test_Case'Class) is
      Cases : constant Fixture_Support.Case_Vectors.Vector :=
        Fixture_Support.For_Function
          (Fixture_Support.Load ("bigint_sets"), "setbinop");
      Count : Natural := 0;
      Fits_Left, Fits_Right : Boolean;
   begin
      for C of Cases loop
         declare
            Left : constant Value_Array :=
              Parse_Set (To_String (C.Args (1)), Fits_Left);
            Right : aliased constant Value_Array :=
              Parse_Set (To_String (C.Args (2)), Fits_Right);
         begin
            if Fits_Left and Fits_Right then
               declare
                  Got : constant Value_Array := Set_Add (Left, Right'Access);
               begin
                  Assert ((if C.Undef then Got'Length = 0
                           else Image (Got) = To_String (C.Result)),
                          "bigint_sets.tsv:" & Positive'Image (C.Line_Number));
                  Count := Count + 1;
               end;
            end if;
         end;
      end loop;
      Assert (Count = 9, "all nine native fixture rows replayed");
   end Check_Fixtures;

   overriding function Name (T : Fold_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Vec_Folds"));
   overriding procedure Register_Tests (T : in out Fold_Case) is
   begin
      Registration.Register_Routine (T, Check_Reduce'Access, "vecreduce");
      Registration.Register_Routine (T, Check_Slide'Access, "vecslide");
      Registration.Register_Routine (T, Check_Pairs'Access, "vecpairwise");
      Registration.Register_Routine (T, Check_Windows'Access, "vecwindow");
      Registration.Register_Routine (T, Check_Set'Access, "setbinop");
      Registration.Register_Routine (T, Check_Fixtures'Access, "fixtures");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Fold_Case);
      return Result;
   end Suite;
end Compat_Vec_Folds;
