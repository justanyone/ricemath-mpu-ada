with Ada.Assertions;
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
      Calls : Natural := 0;
      function Count (A, B : U64) return U64 is
      begin
         Calls := Calls + 1;
         return A + B;
      end Count;
      function Count_Reduce is new Vecreduce (Count);
   begin
      Assert (not Reduce ([]).Defined, "26-vec.t:266 empty");
      Assert (Count_Reduce ([15]).Value = 15 and Calls = 0,
              "26-vec.t:267 singleton does not call block");
      Assert (Reduce_Xor ([4, 2]).Value = 6, "26-vec.t:268 xor");
      Assert (Reduce_Squares ([1, 17, 18, 19]).Value = 33_802_596,
              "26-vec.t:269 left fold product of squares");
      --  26-vec.t:271-272 skipped: negative result outside U64.
      --  26-vec.t:274-276 skipped: 2**64 bigint input outside U64.
      Assert (Reduce ([U64'Last, 0]).Value = U64'Last, "U64 boundary");
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
      Equal (Windows (1, 2, Value_Array'(7 => 1, 8 => 2)), [1, 2],
             "window non-one bound");
   end Check_Windows;
