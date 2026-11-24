with Ada.Assertions;
with Ada.Containers.Vectors;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Vec;
with Math_Prime_Util.Vec.Folds;

package body Compat_Vec is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util.Vec;
   package BI renames Ada.Numerics.Big_Numbers.Big_Integers;
   use type BI.Big_Integer;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   Cached : Case_Vectors.Vector;
   Loaded : Boolean := False;

   function Image (V : BI.Big_Integer) return String is
     (Ada.Strings.Fixed.Trim (BI.To_String (V), Ada.Strings.Both));
   function Image (V : Integer) return String is
     (Ada.Strings.Fixed.Trim (Integer'Image (V), Ada.Strings.Both));
   function Flag (B : Boolean) return String is
     (if B then "1" else "0");

   function Join (Items : Int_Vector) return String is
      Acc : Unbounded_String;
   begin
      for I in Items.First_Index .. Items.Last_Index loop
         if Length (Acc) > 0 then
            Append (Acc, " ");
         end if;
         Append (Acc, Image (Items.Element (I)));
      end loop;
      return To_String (Acc);
   end Join;

   --  A token such as 02 or 0006 keeps a spelling Big_Integer cannot.
   function Has_Leading_Zero (Text : String) return Boolean is
      First : Natural := Text'First;
   begin
      if Text'Length = 0 then
         return False;
      end if;
      if Text (First) in '-' | '+' then
         if First = Text'Last then
            return False;
         end if;
         First := First + 1;
      end if;
      return Text (First) = '0' and then First < Text'Last;
   end Has_Leading_Zero;

   function Row_Has_Leading_Zero (C : Case_Record) return Boolean is
   begin
      for A of C.Args loop
         if Has_Leading_Zero (To_String (A)) then
            return True;
         end if;
      end loop;
      return False;
   end Row_Has_Leading_Zero;

   procedure Split
     (C : Case_Record;
      Left, Right : out Math_Prime_Util.Vec.String_Vectors.Vector;
      Has_Right : out Boolean)
   is
   begin
      Left.Clear;
      Right.Clear;
      Has_Right := False;
      for A of C.Args loop
         if To_String (A) = "|" then
            Has_Right := True;
         elsif Has_Right then
            Right.Append (A);
         else
            Left.Append (A);
         end if;
      end loop;
   end Split;

   function As_Ints
     (Items : Math_Prime_Util.Vec.String_Vectors.Vector) return Int_Vector
   is
      Result : Int_Vector;
   begin
      for I in Items.First_Index .. Items.Last_Index loop
         Result.Append (BI.From_String (To_String (Items.Element (I))));
      end loop;
      return Result;
   end As_Ints;

   function Format_Extract (Items : Extract_Vectors.Vector) return String is
      Acc : Unbounded_String;
   begin
      if Items.Is_Empty then
         return "";
      end if;
      if Items.First_Element.Missing then
         return "undef";
      end if;
      for I in Items.First_Index .. Items.Last_Index loop
         if Length (Acc) > 0 then
            Append (Acc, " ");
         end if;
         if not Items.Element (I).Missing then
            Append (Acc, Items.Element (I).Text);
         end if;
      end loop;
      return To_String (Acc);
   end Format_Extract;

   --  vecfreq keys are compared as integers. Perl hash order differs
   --  between runs (docs/upstream-findings.md item 12).
   function Canonical_Freq (Text : String) return String is
      type Pair is record
         Key, Count : BI.Big_Integer;
      end record;
      package Pair_Vectors is new Ada.Containers.Vectors
        (Index_Type => Positive, Element_Type => Pair);
      function Less (L, R : Pair) return Boolean is (L.Key < R.Key);
      package Pair_Sort is new Pair_Vectors.Generic_Sorting (Less);
      Pairs : Pair_Vectors.Vector;
      Acc : Unbounded_String;
      Start : Natural := Text'First;
      package Token_Vectors is new Ada.Containers.Vectors
        (Index_Type => Positive, Element_Type => Unbounded_String);
      Tokens : Token_Vectors.Vector;
   begin
      if Text'Length = 0 then
         return "";
      end if;
      for I in Text'Range loop
         if Text (I) = ' ' then
            if I > Start then
               Tokens.Append (To_Unbounded_String (Text (Start .. I - 1)));
            end if;
            Start := I + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Tokens.Append (To_Unbounded_String (Text (Start .. Text'Last)));
      end if;
      for I in 1 .. Integer (Tokens.Length) / 2 loop
         Pairs.Append
           (Pair'(Key => BI.From_String (To_String (Tokens (2 * I - 1))),
             Count => BI.From_String (To_String (Tokens (2 * I)))));
      end loop;
      Pair_Sort.Sort (Pairs);
      for P of Pairs loop
         if Length (Acc) > 0 then
            Append (Acc, " ");
         end if;
         Append (Acc, Image (P.Key) & " " & Image (P.Count));
      end loop;
      return To_String (Acc);
   end Canonical_Freq;

   function Evaluate (C : Case_Record; Func : String) return String is
      Left_Text, Right_Text : Math_Prime_Util.Vec.String_Vectors.Vector;
      Has_Right : Boolean;
      Left, Right : Int_Vector;
      Merged : Int_Vector;
   begin
      Split (C, Left_Text, Right_Text, Has_Right);
      if Func in "vecextract" | "vecextract_idx" then
         if Func = "vecextract" then
            return Format_Extract
              (Vecextract (Left_Text,
                           BI.From_String
                             (To_String (Right_Text.Element (1)))));
         end if;
         return Format_Extract
           (Vecextract (Left_Text, As_Ints (Right_Text)));
      end if;
      Left := As_Ints (Left_Text);
      if Has_Right then
         Right := As_Ints (Right_Text);
      end if;
      if Func = "vecsum" then
         return Image (Vecsum (Left));
      elsif Func = "vecprod" then
         return Image (Vecprod (Left));
      elsif Func = "vecmin" then
         return Image (Vecmin (Left));
      elsif Func = "vecmax" then
         return Image (Vecmax (Left));
      elsif Func = "vecprefixsum" then
         return Join (Vecprefixsum (Left));
      elsif Func = "vecuniq" then
         return Join (Vecuniq (Left));
      elsif Func = "vecsingleton" then
         return Join (Vecsingleton (Left));
      elsif Func = "vecfreq" then
         return Join (Vecfreq (Left));
      elsif Func = "vecsort" then
         return Join (Vecsort (Left));
      elsif Func = "vecrsort" then
         return Join (Vecrsort (Left));
      elsif Func = "vecsorti" then
         Vecsorti (Left);
         return Join (Left);
      elsif Func = "vecrsorti" then
         Vecrsorti (Left);
         return Join (Left);
      elsif Func = "vecmex" then
         return Image (Vecmex (Left));
      elsif Func = "vecpmex" then
         return Image (Vecpmex (Left));
      elsif Func = "toset" then
         return Join (Toset (Left));
      elsif Func = "is_sidon_set" then
         return Flag (Is_Sidon_Set (Left));
      elsif Func = "is_sumfree_set" then
         return Flag (Is_Sumfree_Set (Left));
      elsif Func = "sumset" then
         if Has_Right then
            return Join (Sumset (Left, Right));
         end if;
         return Join (Sumset (Left));
      elsif Func = "vecequal" then
         return Flag (Vecequal (Left, Right));
      elsif Func = "setunion" then
         return Join (Setunion (Left, Right));
      elsif Func = "setintersect" then
         return Join (Setintersect (Left, Right));
      elsif Func = "setminus" then
         return Join (Setminus (Left, Right));
      elsif Func = "setdelta" then
         return Join (Setdelta (Left, Right));
      elsif Func in "setinsert" | "setinsert_set" then
         return Join (Setinsert (Left, Right));
      elsif Func = "setinsert_n" then
         Merged := Setinsert (Left, Right);
         return Image (Integer (Merged.Length) - Integer (Left.Length));
      elsif Func in "setremove" | "setremove_set" then
         return Join (Setremove (Left, Right));
      elsif Func = "setremove_n" then
         Merged := Setremove (Left, Right);
         return Image (Integer (Left.Length) - Integer (Merged.Length));
      elsif Func in "setinvert" | "setinvert_set" then
         return Join (Setinvert (Left, Right));
      elsif Func = "setinvert_n" then
         Merged := Setinvert (Left, Right);
         return Image (Integer (Merged.Length) - Integer (Left.Length));
      elsif Func = "setcontains" then
         return Flag (Setcontains (Left, Right));
      elsif Func = "setcontainsany" then
         return Flag (Setcontainsany (Left, Right));
      elsif Func = "set_is_disjoint" then
         return Flag (Set_Is_Disjoint (Left, Right));
      elsif Func = "set_is_equal" then
         return Flag (Set_Is_Equal (Left, Right));
      elsif Func = "set_is_subset" then
         return Flag (Set_Is_Subset (Left, Right));
      elsif Func = "set_is_proper_subset" then
         return Flag (Set_Is_Proper_Subset (Left, Right));
      elsif Func = "set_is_superset" then
         return Flag (Set_Is_Superset (Left, Right));
      elsif Func = "set_is_proper_superset" then
         return Flag (Set_Is_Proper_Superset (Left, Right));
      elsif Func = "set_is_proper_intersection" then
         return Flag (Set_Is_Proper_Intersection (Left, Right));
      end if;
      raise Constraint_Error with "unknown vec function";
   end Evaluate;

   procedure Replay (Func : String) is
      Seen, Checked : Natural := 0;
      Actual : Unbounded_String;
      Expected : Unbounded_String;
      Raised : Boolean;
      Same : Boolean;
   begin
      if not Loaded then
         Cached := Load ("vec");
         Loaded := True;
      end if;
      for C of Cached loop
         if C.Func = Func then
            Seen := Seen + 1;
            --  Skipped: vecmin, vecmax, vecuniq, and vecsingleton rows
            --  whose scalars have a leading zero. XS keeps that spelling
            --  (vec.tsv 797 vecmax "02", 799 vecuniq "2", 800
            --  vecsingleton empty, 2869 vecuniq "0006", 2903 vecmax
            --  "0000000000000000000007", 2938 vecmin padded 8).
            --  docs/upstream-findings.md finding 5. Big_Integer is
            --  canonical decimal, so those rows are not replayed.
            if Func in "vecmin" | "vecmax" | "vecuniq" | "vecsingleton"
              and then Row_Has_Leading_Zero (C)
            then
               null;
            else
               Checked := Checked + 1;
               Raised := False;
               Actual := Null_Unbounded_String;
               begin
                  Actual := To_Unbounded_String (Evaluate (C, Func));
               exception
                  when Constraint_Error | Ada.Assertions.Assertion_Error =>
                     Raised := True;
               end;
               if Func = "vecfreq" and then not Raised and then not C.Error
               then
                  Expected := To_Unbounded_String
                    (Canonical_Freq (To_String (C.Result)));
                  Actual := To_Unbounded_String
                    (Canonical_Freq (To_String (Actual)));
               else
                  Expected := C.Result;
               end if;
               if C.Error
                 or else (C.Undef
                          and then Func in "vecmin" | "vecmax")
               then
                  Same := Raised;
               else
                  Same := not Raised and then Actual = Expected;
               end if;
               AUnit.Assertions.Assert
                 (Same,
                  Func & Positive'Image (C.Line_Number) & ": " &
                  To_String (Actual) & " expected " &
                  To_String (Expected));
            end if;
         end if;
      end loop;
      AUnit.Assertions.Assert (Seen > 0, "missing " & Func);
      AUnit.Assertions.Assert (Checked > 0, "all skipped " & Func);
   end Replay;

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Vec");
   end Name;

   procedure Test_Vecsum (T : in out Test_Case'Class) is
   begin
      Replay ("vecsum");
   end Test_Vecsum;
   procedure Test_Vecprod (T : in out Test_Case'Class) is
   begin
      Replay ("vecprod");
   end Test_Vecprod;
   procedure Test_Vecmin (T : in out Test_Case'Class) is
   begin
      Replay ("vecmin");
   end Test_Vecmin;
   procedure Test_Vecmax (T : in out Test_Case'Class) is
   begin
      Replay ("vecmax");
   end Test_Vecmax;
   procedure Test_Vecprefixsum (T : in out Test_Case'Class) is
   begin
      Replay ("vecprefixsum");
   end Test_Vecprefixsum;
   procedure Test_Vecuniq (T : in out Test_Case'Class) is
   begin
      Replay ("vecuniq");
   end Test_Vecuniq;
   procedure Test_Vecsingleton (T : in out Test_Case'Class) is
   begin
      Replay ("vecsingleton");
   end Test_Vecsingleton;
   procedure Test_Vecfreq (T : in out Test_Case'Class) is
   begin
      Replay ("vecfreq");
   end Test_Vecfreq;
   procedure Test_Vecsort (T : in out Test_Case'Class) is
   begin
      Replay ("vecsort");
   end Test_Vecsort;
   procedure Test_Vecrsort (T : in out Test_Case'Class) is
   begin
      Replay ("vecrsort");
   end Test_Vecrsort;
   procedure Test_Vecsorti (T : in out Test_Case'Class) is
   begin
      Replay ("vecsorti");
   end Test_Vecsorti;
   procedure Test_Vecrsorti (T : in out Test_Case'Class) is
   begin
      Replay ("vecrsorti");
   end Test_Vecrsorti;
   procedure Test_Vecmex (T : in out Test_Case'Class) is
   begin
      Replay ("vecmex");
   end Test_Vecmex;
   procedure Test_Vecpmex (T : in out Test_Case'Class) is
   begin
      Replay ("vecpmex");
   end Test_Vecpmex;
   procedure Test_Toset (T : in out Test_Case'Class) is
   begin
      Replay ("toset");
   end Test_Toset;
   procedure Test_Is_Sidon_Set (T : in out Test_Case'Class) is
   begin
      Replay ("is_sidon_set");
   end Test_Is_Sidon_Set;
   procedure Test_Is_Sumfree_Set (T : in out Test_Case'Class) is
   begin
      Replay ("is_sumfree_set");
   end Test_Is_Sumfree_Set;
   procedure Test_Sumset (T : in out Test_Case'Class) is
   begin
      Replay ("sumset");
   end Test_Sumset;
   procedure Test_Vecequal (T : in out Test_Case'Class) is
   begin
      Replay ("vecequal");
   end Test_Vecequal;
   procedure Test_Vecextract (T : in out Test_Case'Class) is
   begin
      Replay ("vecextract");
      Replay ("vecextract_idx");
   end Test_Vecextract;
   procedure Test_Setunion (T : in out Test_Case'Class) is
   begin
      Replay ("setunion");
   end Test_Setunion;
   procedure Test_Setintersect (T : in out Test_Case'Class) is
   begin
      Replay ("setintersect");
   end Test_Setintersect;
   procedure Test_Setminus (T : in out Test_Case'Class) is
   begin
      Replay ("setminus");
   end Test_Setminus;
   procedure Test_Setdelta (T : in out Test_Case'Class) is
   begin
      Replay ("setdelta");
   end Test_Setdelta;
   procedure Test_Setinsert (T : in out Test_Case'Class) is
   begin
      Replay ("setinsert");
      Replay ("setinsert_n");
      Replay ("setinsert_set");
   end Test_Setinsert;
   procedure Test_Setremove (T : in out Test_Case'Class) is
   begin
      Replay ("setremove");
      Replay ("setremove_n");
      Replay ("setremove_set");
   end Test_Setremove;
   procedure Test_Setinvert (T : in out Test_Case'Class) is
   begin
      Replay ("setinvert");
      Replay ("setinvert_n");
      Replay ("setinvert_set");
   end Test_Setinvert;
   procedure Test_Setcontains (T : in out Test_Case'Class) is
   begin
      Replay ("setcontains");
   end Test_Setcontains;
   procedure Test_Setcontainsany (T : in out Test_Case'Class) is
   begin
      Replay ("setcontainsany");
   end Test_Setcontainsany;
   procedure Test_Set_Is_Disjoint (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_disjoint");
   end Test_Set_Is_Disjoint;
   procedure Test_Set_Is_Equal (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_equal");
   end Test_Set_Is_Equal;
   procedure Test_Set_Is_Subset (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_subset");
   end Test_Set_Is_Subset;
   procedure Test_Set_Is_Proper_Subset (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_proper_subset");
   end Test_Set_Is_Proper_Subset;
   procedure Test_Set_Is_Superset (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_superset");
   end Test_Set_Is_Superset;
   procedure Test_Set_Is_Proper_Superset (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_proper_superset");
   end Test_Set_Is_Proper_Superset;
   procedure Test_Set_Is_Proper_Intersection
     (T : in out Test_Case'Class) is
   begin
      Replay ("set_is_proper_intersection");
   end Test_Set_Is_Proper_Intersection;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine (T, Test_Vecsum'Access, "vecsum");
      Registration.Register_Routine (T, Test_Vecprod'Access, "vecprod");
      Registration.Register_Routine (T, Test_Vecmin'Access, "vecmin");
      Registration.Register_Routine (T, Test_Vecmax'Access, "vecmax");
      Registration.Register_Routine
        (T, Test_Vecprefixsum'Access, "vecprefixsum");
      Registration.Register_Routine (T, Test_Vecuniq'Access, "vecuniq");
      Registration.Register_Routine
        (T, Test_Vecsingleton'Access, "vecsingleton");
      Registration.Register_Routine (T, Test_Vecfreq'Access, "vecfreq");
      Registration.Register_Routine (T, Test_Vecsort'Access, "vecsort");
      Registration.Register_Routine (T, Test_Vecrsort'Access, "vecrsort");
      Registration.Register_Routine (T, Test_Vecsorti'Access, "vecsorti");
      Registration.Register_Routine
        (T, Test_Vecrsorti'Access, "vecrsorti");
      Registration.Register_Routine (T, Test_Vecmex'Access, "vecmex");
      Registration.Register_Routine (T, Test_Vecpmex'Access, "vecpmex");
      Registration.Register_Routine (T, Test_Toset'Access, "toset");
      Registration.Register_Routine
        (T, Test_Is_Sidon_Set'Access, "is_sidon_set");
      Registration.Register_Routine
        (T, Test_Is_Sumfree_Set'Access, "is_sumfree_set");
      Registration.Register_Routine (T, Test_Sumset'Access, "sumset");
      Registration.Register_Routine (T, Test_Vecequal'Access, "vecequal");
      Registration.Register_Routine
        (T, Test_Vecextract'Access, "vecextract");
      Registration.Register_Routine (T, Test_Setunion'Access, "setunion");
      Registration.Register_Routine
        (T, Test_Setintersect'Access, "setintersect");
      Registration.Register_Routine (T, Test_Setminus'Access, "setminus");
      Registration.Register_Routine (T, Test_Setdelta'Access, "setdelta");
      Registration.Register_Routine
        (T, Test_Setinsert'Access, "setinsert");
      Registration.Register_Routine
        (T, Test_Setremove'Access, "setremove");
      Registration.Register_Routine
        (T, Test_Setinvert'Access, "setinvert");
      Registration.Register_Routine
        (T, Test_Setcontains'Access, "setcontains");
      Registration.Register_Routine
        (T, Test_Setcontainsany'Access, "setcontainsany");
      Registration.Register_Routine
        (T, Test_Set_Is_Disjoint'Access, "set_is_disjoint");
      Registration.Register_Routine
        (T, Test_Set_Is_Equal'Access, "set_is_equal");
      Registration.Register_Routine
        (T, Test_Set_Is_Subset'Access, "set_is_subset");
      Registration.Register_Routine
        (T, Test_Set_Is_Proper_Subset'Access, "set_is_proper_subset");
      Registration.Register_Routine
        (T, Test_Set_Is_Superset'Access, "set_is_superset");
      Registration.Register_Routine
        (T, Test_Set_Is_Proper_Superset'Access,
         "set_is_proper_superset");
      Registration.Register_Routine
        (T, Test_Set_Is_Proper_Intersection'Access,
         "set_is_proper_intersection");
   end Register_Tests;

   package Folds is
      --  Build the native callback compatibility suite.
      function Suite return AUnit.Test_Suites.Access_Test_Suite;
   end Folds;

   package body Folds is
      use AUnit.Assertions;
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
                     Got : constant Value_Array :=
                       Set_Add (Left, Right'Access);
                  begin
                     Assert ((if C.Undef then Got'Length = 0
                              else Image (Got) = To_String (C.Result)),
                             "bigint_sets.tsv:" &
                               Positive'Image (C.Line_Number));
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
   end Folds;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      Result.Add_Test (Folds.Suite);
      return Result;
   end Suite;
end Compat_Vec;
