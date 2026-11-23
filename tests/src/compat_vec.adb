with Ada.Containers.Vectors;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Strings.Fixed;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Vec;

package body Compat_Vec is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util.Vec;
   package BI renames Ada.Numerics.Big_Numbers.Big_Integers;
   use type BI.Big_Integer;
   package Nums is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => BI.Big_Integer);

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   type Arg_Split is record
      Left_Num, Right_Num : Nums.Vector;
      Left_Text, Right_Text : String_Vectors.Vector;
      Has_Bar : Boolean := False;
      Left_Ok : Boolean := True;
      Right_Ok : Boolean := True;
   end record;

   function Img (V : BI.Big_Integer) return String is
      S : constant String := BI.To_String (V);
      A : Positive := S'First;
      B : Natural := S'Last;
   begin
      while A <= B and then S (A) = ' ' loop
         A := A + 1;
      end loop;
      while B >= A and then S (B) = ' ' loop
         B := B - 1;
      end loop;
      return S (A .. B);
   end Img;

   function To_Array (Items : Nums.Vector) return Int_Array is
      Result : Int_Array (1 .. Natural (Items.Length));
      Index : Natural := 0;
   begin
      for Value of Items loop
         Index := Index + 1;
         Result (Index) := Value;
      end loop;
      return Result;
   end To_Array;

   function Join (Items : Int_Array) return String is
      Acc : Unbounded_String;
      First : Boolean := True;
   begin
      for V of Items loop
         if not First then
            Append (Acc, " ");
         end if;
         First := False;
         Append (Acc, Img (V));
      end loop;
      return To_String (Acc);
   end Join;

   function Tokens_Of (Text : String) return String_Vectors.Vector is
      Result : String_Vectors.Vector;
      Start : Positive := Text'First;
   begin
      if Text'Length = 0 then
         return Result;
      end if;
      for I in Text'Range loop
         if Text (I) = ' ' then
            if I > Start then
               Result.Append (To_Unbounded_String (Text (Start .. I - 1)));
            end if;
            Start := I + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Result.Append (To_Unbounded_String (Text (Start .. Text'Last)));
      end if;
      return Result;
   end Tokens_Of;

   function Canonical (Text : String) return String is
      Tokens : constant String_Vectors.Vector := Tokens_Of (Text);
      Acc : Unbounded_String;
      First : Boolean := True;
   begin
      for Token of Tokens loop
         if not First then
            Append (Acc, " ");
         end if;
         First := False;
         Append (Acc, Img (BI.From_String (To_String (Token))));
      end loop;
      return To_String (Acc);
   end Canonical;

   --  Pair order follows Perl's hash for some bigint rows. Compare the
   --  sorted numeric pairs so those rows still prove the counts.
   function Norm_Freq (Text : String) return String is
      Tokens : constant String_Vectors.Vector := Tokens_Of (Text);
      N : constant Natural := Natural (Tokens.Length) / 2;
      Acc : Unbounded_String;
      type Pair is record
         Key, Count : BI.Big_Integer;
      end record;
      P : array (1 .. Integer'Max (N, 1)) of Pair;
      Tmp : Pair;
   begin
      if N = 0 then
         return "";
      end if;
      if Natural (Tokens.Length) mod 2 /= 0 then
         raise Constraint_Error;
      end if;
      for I in 1 .. N loop
         P (I).Key := BI.From_String (To_String (Tokens (2 * I - 1)));
         P (I).Count := BI.From_String (To_String (Tokens (2 * I)));
      end loop;
      for I in 1 .. N - 1 loop
         for J in I + 1 .. N loop
            if P (J).Key < P (I).Key then
               Tmp := P (I);
               P (I) := P (J);
               P (J) := Tmp;
            end if;
         end loop;
      end loop;
      for I in 1 .. N loop
         if I > 1 then
            Append (Acc, " ");
         end if;
         Append (Acc, Img (P (I).Key) & " " & Img (P (I).Count));
      end loop;
      return To_String (Acc);
   end Norm_Freq;

   function Match (Func, Actual, Expected : String) return Boolean is
   begin
      if Func = "vecfreq" then
         return Norm_Freq (Actual) = Norm_Freq (Expected);
      end if;
      if Actual = Expected then
         return True;
      end if;
      begin
         return Canonical (Actual) = Canonical (Expected);
      exception
         when Constraint_Error =>
            return False;
      end;
   end Match;

   function Split (Args : String_Vectors.Vector) return Arg_Split is
      Item : Arg_Split;
      Seen_Bar : Boolean := False;
      Value : BI.Big_Integer;
   begin
      for Token of Args loop
         if To_String (Token) = "|" then
            Seen_Bar := True;
            Item.Has_Bar := True;
         elsif not Seen_Bar then
            Item.Left_Text.Append (Token);
            begin
               Value := BI.From_String (To_String (Token));
               Item.Left_Num.Append (Value);
            exception
               when Constraint_Error =>
                  Item.Left_Ok := False;
            end;
         else
            Item.Right_Text.Append (Token);
            begin
               Value := BI.From_String (To_String (Token));
               Item.Right_Num.Append (Value);
            exception
               when Constraint_Error =>
                  Item.Right_Ok := False;
            end;
         end if;
      end loop;
      return Item;
   end Split;

   function Positions (Count : Natural) return Int_Array is
      Result : Int_Array (1 .. Count);
   begin
      for I in Result'Range loop
         Result (I) := BI.To_Big_Integer (I - 1);
      end loop;
      return Result;
   end Positions;

   function Map_Tokens
     (Tokens : String_Vectors.Vector; Indexes : Int_Array) return String
   is
      Acc : Unbounded_String;
      First : Boolean := True;
      Pos : Integer;
   begin
      for Index of Indexes loop
         Pos := BI.To_Integer (Index);
         if not First then
            Append (Acc, " ");
         end if;
         First := False;
         Append (Acc, To_String (Tokens (Pos + 1)));
      end loop;
      return To_String (Acc);
   end Map_Tokens;

   function Flag (V : Boolean) return String is
     (if V then "1" else "0");

   function Count_Image (N : Integer) return String is
     (Ada.Strings.Fixed.Trim (Integer'Image (N), Ada.Strings.Both));

   --  Skipped cases: none.
   --  vecmax line 797 spells the maximum as 02. Numeric comparison
   --  accepts 2 (docs/upstream-findings.md item 5).
   --  vecfreq lines 225, 279, 729, 891, 999, 2853, 2871, 2889 and any
   --  other Perl hash-order row are compared as sorted value-count pairs.
   function Evaluate (Func : String; Item : Arg_Split) return String is
      L : Nums.Vector renames Item.Left_Num;
      R : Nums.Vector renames Item.Right_Num;
   begin
      if not Item.Left_Ok or else not Item.Right_Ok then
         if Func = "vecextract" then
            declare
               Masks : constant Int_Array := To_Array (R);
            begin
               return Map_Tokens
                 (Item.Left_Text,
                  Vecextract
                    (Positions (Natural (Item.Left_Text.Length)),
                     Masks (Masks'First)));
            end;
         elsif Func = "vecextract_idx" then
            return Map_Tokens
              (Item.Left_Text,
               Vecextract (Positions (Natural (Item.Left_Text.Length)),
                           To_Array (R)));
         end if;
         raise Constraint_Error with "non-integer argument";
      end if;
      if Func = "vecsum" then
         return Img (Vecsum (To_Array (L)));
      elsif Func = "vecprod" then
         return Img (Vecprod (To_Array (L)));
      elsif Func = "vecmin" then
         declare
            M : constant Optional_Big := Vecmin (To_Array (L));
         begin
            if not M.Defined then
               raise Undefined_Element;
            end if;
            return Img (M.Value);
         end;
      elsif Func = "vecmax" then
         declare
            M : constant Optional_Big := Vecmax (To_Array (L));
         begin
            if not M.Defined then
               raise Undefined_Element;
            end if;
            return Img (M.Value);
         end;
      elsif Func = "vecprefixsum" then
         return Join (Vecprefixsum (To_Array (L)));
      elsif Func = "vecuniq" then
         return Join (Vecuniq (To_Array (L)));
      elsif Func = "vecsingleton" then
         return Join (Vecsingleton (To_Array (L)));
      elsif Func = "vecfreq" then
         return Join (Vecfreq (To_Array (L)));
      elsif Func = "vecsort" then
         return Join (Vecsort (To_Array (L)));
      elsif Func = "vecrsort" then
         return Join (Vecrsort (To_Array (L)));
      elsif Func = "vecsorti" then
         declare
            S : Int_Array := To_Array (L);
         begin
            Vecsorti (S);
            return Join (S);
         end;
      elsif Func = "vecrsorti" then
         declare
            S : Int_Array := To_Array (L);
         begin
            Vecrsorti (S);
            return Join (S);
         end;
      elsif Func = "vecmex" then
         return Img (Vecmex (To_Array (L)));
      elsif Func = "vecpmex" then
         return Img (Vecpmex (To_Array (L)));
      elsif Func = "toset" then
         return Join (Toset (To_Array (L)));
      elsif Func = "is_sidon_set" then
         return Flag (Is_Sidon_Set (To_Array (L)));
      elsif Func = "is_sumfree_set" then
         return Flag (Is_Sumfree_Set (To_Array (L)));
      elsif Func = "sumset" then
         if Item.Has_Bar then
            return Join (Sumset (To_Array (L), To_Array (R)));
         end if;
         return Join (Sumset (To_Array (L)));
      elsif Func = "vecequal" then
         return Flag (Vecequal (To_Array (L), To_Array (R)));
      elsif Func = "vecextract" then
         declare
            Masks : constant Int_Array := To_Array (R);
         begin
            return Join (Vecextract (To_Array (L), Masks (Masks'First)));
         end;
      elsif Func = "vecextract_idx" then
         return Join (Vecextract (To_Array (L), To_Array (R)));
      elsif Func = "setunion" then
         return Join (Setunion (To_Array (L), To_Array (R)));
      elsif Func = "setintersect" then
         return Join (Setintersect (To_Array (L), To_Array (R)));
      elsif Func = "setminus" then
         return Join (Setminus (To_Array (L), To_Array (R)));
      elsif Func = "setdelta" then
         return Join (Setdelta (To_Array (L), To_Array (R)));
      elsif Func = "set_is_disjoint" then
         return Flag (Set_Is_Disjoint (To_Array (L), To_Array (R)));
      elsif Func = "set_is_equal" then
         return Flag (Set_Is_Equal (To_Array (L), To_Array (R)));
      elsif Func = "set_is_subset" then
         return Flag (Set_Is_Subset (To_Array (L), To_Array (R)));
      elsif Func = "set_is_proper_subset" then
         return Flag (Set_Is_Proper_Subset (To_Array (L), To_Array (R)));
      elsif Func = "set_is_superset" then
         return Flag (Set_Is_Superset (To_Array (L), To_Array (R)));
      elsif Func = "set_is_proper_superset" then
         return Flag (Set_Is_Proper_Superset (To_Array (L), To_Array (R)));
      elsif Func = "set_is_proper_intersection" then
         return Flag
           (Set_Is_Proper_Intersection (To_Array (L), To_Array (R)));
      elsif Func = "setcontains" then
         return Flag (Setcontains (To_Array (L), To_Array (R)));
      elsif Func = "setcontainsany" then
         return Flag (Setcontainsany (To_Array (L), To_Array (R)));
      elsif Func = "setinsert" or else Func = "setinsert_set" then
         declare
            Added : Integer;
            S : constant Int_Array :=
              Setinsert (To_Array (L), To_Array (R), Added);
         begin
            if Added < 0 then
               raise Constraint_Error with "insert count";
            end if;
            return Join (S);
         end;
      elsif Func = "setinsert_n" then
         declare
            Base : constant Int_Array := To_Array (L);
            Added : Integer;
            S : constant Int_Array :=
              Setinsert (Base, To_Array (R), Added);
         begin
            if Integer (S'Length) - Integer (Base'Length) /= Added then
               raise Constraint_Error with "insert count";
            end if;
            return Count_Image (Added);
         end;
      elsif Func = "setremove" or else Func = "setremove_set" then
         declare
            Added : Integer;
            S : constant Int_Array :=
              Setremove (To_Array (L), To_Array (R), Added);
         begin
            if Added < 0 then
               raise Constraint_Error with "remove count";
            end if;
            return Join (S);
         end;
      elsif Func = "setremove_n" then
         declare
            Base : constant Int_Array := To_Array (L);
            Added : Integer;
            S : constant Int_Array :=
              Setremove (Base, To_Array (R), Added);
         begin
            if Integer (Base'Length) - Integer (S'Length) /= Added then
               raise Constraint_Error with "remove count";
            end if;
            return Count_Image (Added);
         end;
      elsif Func = "setinvert" or else Func = "setinvert_set" then
         declare
            Added : Integer;
            S : constant Int_Array :=
              Setinvert (To_Array (L), To_Array (R), Added);
         begin
            if Added = Integer'First then
               raise Constraint_Error with "invert count";
            end if;
            return Join (S);
         end;
      elsif Func = "setinvert_n" then
         declare
            Base : constant Int_Array := To_Array (L);
            Added : Integer;
            S : constant Int_Array :=
              Setinvert (Base, To_Array (R), Added);
         begin
            if Integer (S'Length) - Integer (Base'Length) /= Added then
               raise Constraint_Error with "invert count";
            end if;
            return Count_Image (Added);
         end;
      end if;
      raise Constraint_Error with "unknown function";
   end Evaluate;

   function Clip (Text : String) return String is
     (if Text'Length <= 100 then Text
      else Text (Text'First .. Text'First + 99));

   procedure Check (C : Case_Record) is
      Item : constant Arg_Split := Split (C.Args);
      Func : constant String := To_String (C.Func);
      Actual : Unbounded_String;
      Died : Boolean := False;
      Undef : Boolean := False;
   begin
      begin
         Actual := To_Unbounded_String (Evaluate (Func, Item));
      exception
         when Constraint_Error =>
            Died := True;
         when Undefined_Element =>
            Undef := True;
      end;
      if C.Error then
         AUnit.Assertions.Assert
           (Died, Func & " line" & C.Line_Number'Image & " expected ERROR");
      elsif C.Undef then
         AUnit.Assertions.Assert
           (Undef, Func & " line" & C.Line_Number'Image & " expected undef");
      else
         AUnit.Assertions.Assert
           (not Died and then not Undef,
            Func & " line" & C.Line_Number'Image & " unexpected failure");
         AUnit.Assertions.Assert
           (Match (Func, To_String (Actual), To_String (C.Result)),
            Func & " line" & C.Line_Number'Image & " got " &
            Clip (To_String (Actual)));
      end if;
   end Check;

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Vec");
   end Name;

   procedure Test_Vec (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("vec");
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "vec fixture is empty");
      for C of Cases loop
         Check (C);
      end loop;
   end Test_Vec;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine (T, Test_Vec'Access, "vec");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Compat_Vec;
