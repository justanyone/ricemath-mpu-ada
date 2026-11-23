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

   type Integer_List is array (Positive range <>) of Integer;

   function Vector_Of (Values : Integer_List) return Int_Vector is
      Result : Int_Vector;
   begin
      for V of Values loop
         Result.Append (BI.To_Big_Integer (V));
      end loop;
      return Result;
   end Vector_Of;

   function Is_One (Value : BI.Big_Integer) return Boolean is (Value = 1);
   function Is_Nine (Value : BI.Big_Integer) return Boolean is
     (8 = Value - 1);
   function Over_Six (Value : BI.Big_Integer) return Boolean is
   begin
      loop
         return Value > 6;
      end loop;
   end Over_Six;

   procedure Test_Vecany (T : in out Test_Case'Class) is
      function Check is new Vecany (Is_One);
   begin
      --  reference/mpu/t/26-vec.t:380
      AUnit.Assertions.Assert
        (Check (Vector_Of ([1, 2, 3])), "vecany t/26-vec.t:380");
      --  reference/mpu/t/26-vec.t:381
      AUnit.Assertions.Assert
        (not Check (Vector_Of ([2, 3, 4])), "vecany t/26-vec.t:381");
      --  reference/mpu/t/26-vec.t:382
      AUnit.Assertions.Assert
        (not Check (Vector_Of ([])), "vecany t/26-vec.t:382");
   end Test_Vecany;

   procedure Test_Vecall (T : in out Test_Case'Class) is
      function Check is new Vecall (Is_One);
   begin
      --  reference/mpu/t/26-vec.t:384
      AUnit.Assertions.Assert
        (Check (Vector_Of ([1, 1, 1])), "vecall t/26-vec.t:384");
      --  reference/mpu/t/26-vec.t:385
      AUnit.Assertions.Assert
        (not Check (Vector_Of ([1, 2, 3])), "vecall t/26-vec.t:385");
      --  reference/mpu/t/26-vec.t:386
      AUnit.Assertions.Assert
        (Check (Vector_Of ([])), "vecall t/26-vec.t:386");
   end Test_Vecall;

   procedure Test_Vecnotall (T : in out Test_Case'Class) is
      function Check is new Vecnotall (Is_One);
   begin
      --  reference/mpu/t/26-vec.t:388
      AUnit.Assertions.Assert
        (Check (Vector_Of ([1, 2, 3])), "vecnotall t/26-vec.t:388");
      --  reference/mpu/t/26-vec.t:389
      AUnit.Assertions.Assert
        (not Check (Vector_Of ([1, 1, 1])), "vecnotall t/26-vec.t:389");
      --  reference/mpu/t/26-vec.t:390
      AUnit.Assertions.Assert
        (not Check (Vector_Of ([])), "vecnotall t/26-vec.t:390");
   end Test_Vecnotall;

   procedure Test_Vecnone (T : in out Test_Case'Class) is
      function Check is new Vecnone (Is_One);
   begin
      --  reference/mpu/t/26-vec.t:392
      AUnit.Assertions.Assert
        (Check (Vector_Of ([2, 3, 4])), "vecnone t/26-vec.t:392");
      --  reference/mpu/t/26-vec.t:393
      AUnit.Assertions.Assert
        (not Check (Vector_Of ([1, 2, 3])), "vecnone t/26-vec.t:393");
      --  reference/mpu/t/26-vec.t:394
      AUnit.Assertions.Assert
        (Check (Vector_Of ([])), "vecnone t/26-vec.t:394");
   end Test_Vecnone;

   procedure Test_Vecfirst (T : in out Test_Case'Class) is
      procedure First_Nine is new Vecfirst (Is_Nine);
      procedure First_Large is new Vecfirst (Over_Six);
      Value : BI.Big_Integer;
      Found : Boolean;
   begin
      --  reference/mpu/t/26-vec.t:400
      First_Nine (Vector_Of ([9, 4, 5, 6]), Value, Found);
      AUnit.Assertions.Assert (Found and then Value = 9, "first success");
      --  reference/mpu/t/26-vec.t:401 (all predicates return false).
      First_Nine (Vector_Of ([1, 2, 3, 4]), Value, Found);
      AUnit.Assertions.Assert (not Found and then Value = 0, "first miss");
      --  reference/mpu/t/26-vec.t:402
      First_Nine (Vector_Of ([]), Value, Found);
      AUnit.Assertions.Assert (not Found, "first empty");
      --  t/26-vec.t:403-404 skipped: Perl reference arrays are not integers.
      --  reference/mpu/t/26-vec.t:405
      First_Large (Vector_Of ([2, 4, 6, 12]), Value, Found);
      AUnit.Assertions.Assert (Found and then Value = 12, "first loop");
   end Test_Vecfirst;

   procedure Test_Vecfirstidx (T : in out Test_Case'Class) is
      function First_Nine is new Vecfirstidx (Is_Nine);
      function First_Large is new Vecfirstidx (Over_Six);
   begin
      --  reference/mpu/t/26-vec.t:409
      AUnit.Assertions.Assert
        (First_Nine (Vector_Of ([9, 4, 5, 6])) = 0, "first idx success");
      --  reference/mpu/t/26-vec.t:410
      AUnit.Assertions.Assert
        (First_Nine (Vector_Of ([1, 2, 3, 4])) = -1, "first idx miss");
      --  reference/mpu/t/26-vec.t:411
      AUnit.Assertions.Assert
        (First_Nine (Vector_Of ([])) = -1, "first idx empty");
      --  t/26-vec.t:412 skipped: Perl reference arrays are not integers.
      --  reference/mpu/t/26-vec.t:413
      AUnit.Assertions.Assert
        (First_Large (Vector_Of ([2, 4, 6, 12])) = 3, "first idx loop");
   end Test_Vecfirstidx;

   procedure Predicate_Laws (T : in out Test_Case'Class) is
      use type Math_Prime_Util.U64;
      Seed : Math_Prime_Util.U64 := 20_261_123;
      Target : BI.Big_Integer := BI.To_Big_Integer (0);
      function Matches (Value : BI.Big_Integer) return Boolean is
        (Value = Target);
      function Any_Match is new Vecany (Matches);
      function All_Match is new Vecall (Matches);
      function None_Match is new Vecnone (Matches);
      function Not_All is new Vecnotall (Matches);
      function First_Index is new Vecfirstidx (Matches);
      procedure First_Value is new Vecfirst (Matches);
      Items : Int_Vector;
      Value : BI.Big_Integer;
      Found : Boolean;
      Index : Integer;
      procedure Check is
      begin
         Index := First_Index (Items);
         First_Value (Items, Value, Found);
         AUnit.Assertions.Assert
           (None_Match (Items) = not Any_Match (Items)
            and then Not_All (Items) = not All_Match (Items)
            and then (Index = -1) = not Any_Match (Items)
            and then Found = (Index >= 0), "laws seed 20261123");
         if Found then
            AUnit.Assertions.Assert
              (Value = Target and then Value = Items.Element (Index + 1),
               "first value seed 20261123");
            for I in 1 .. Index loop
               AUnit.Assertions.Assert
                 (Items.Element (I) /= Target, "first seed 20261123");
            end loop;
         end if;
      end Check;
   begin
      Check;
      for Trial in 1 .. 100 loop
         Items.Clear;
         for I in 1 .. Trial mod 17 loop
            Seed := Seed * 6_364_136_223_846_793_005 + 1;
            Items.Append (BI.To_Big_Integer (Integer (Seed mod 5)));
         end loop;
         Target := BI.To_Big_Integer (Trial mod 5);
         Check;
      end loop;
      --  Full integer boundaries, without converting vector values to U64.
      Items := Vector_Of ([0, 1, 2]);
      for Power of Integer_List'[32, 63, 64, 127, 128] loop
         for Offset in -1 .. 1 loop
            Items.Append (BI.To_Big_Integer (2) ** Natural (Power)
                          + BI.To_Big_Integer (Offset));
         end loop;
      end loop;
      Items.Append (-BI.To_Big_Integer (2) ** 127);
      for I in Items.First_Index .. Items.Last_Index loop
         Target := Items.Element (I);
         Check;
      end loop;
   end Predicate_Laws;

   procedure Predicate_Order (T : in out Test_Case'Class) is
      Calls : Natural := 0;
      function Matches (Value : BI.Big_Integer) return Boolean is
      begin
         Calls := Calls + 1;
         AUnit.Assertions.Assert
           (Value = BI.To_Big_Integer (Calls), "predicate input order");
         return Value = 2;
      end Matches;
      function Any_Match is new Vecany (Matches);
      function All_Match is new Vecall (Matches);
      function None_Match is new Vecnone (Matches);
      function Not_All is new Vecnotall (Matches);
      function First_Index is new Vecfirstidx (Matches);
      procedure First_Value is new Vecfirst (Matches);
      Items : constant Int_Vector := Vector_Of ([1, 2, 3, 2]);
      Value : BI.Big_Integer;
      Found : Boolean;
   begin
      AUnit.Assertions.Assert
        (Any_Match (Items) and then Calls = 2, "any short circuit");
      Calls := 0;
      AUnit.Assertions.Assert
        (not All_Match (Items) and then Calls = 1, "all short circuit");
      Calls := 0;
      AUnit.Assertions.Assert
        (not None_Match (Items) and then Calls = 2, "none short circuit");
      Calls := 0;
      AUnit.Assertions.Assert
        (Not_All (Items) and then Calls = 1, "notall short circuit");
      Calls := 0;
      AUnit.Assertions.Assert
        (First_Index (Items) = 1 and then Calls = 2, "idx short circuit");
      Calls := 0;
      First_Value (Items, Value, Found);
      AUnit.Assertions.Assert
        (Found and then Value = 2 and then Calls = 2, "first short circuit");
   end Predicate_Order;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Vecany'Access, "vecany");
      Registration.Register_Routine
        (T, Test_Vecall'Access, "vecall");
      Registration.Register_Routine
        (T, Test_Vecnone'Access, "vecnone");
      Registration.Register_Routine
        (T, Test_Vecnotall'Access, "vecnotall");
      Registration.Register_Routine
        (T, Test_Vecfirst'Access, "vecfirst");
      Registration.Register_Routine
        (T, Test_Vecfirstidx'Access, "vecfirstidx");
      Registration.Register_Routine
        (T, Predicate_Laws'Access, "predicate laws seed 20261123");
      Registration.Register_Routine
        (T, Predicate_Order'Access, "predicate order");
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

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Compat_Vec;
