with Ada.Assertions;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Containers.Ordered_Maps;
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
   use Ada.Numerics.Big_Numbers.Big_Integers;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   function Image (V : Big_Integer) return String is
     (Ada.Strings.Fixed.Trim (To_String (V), Ada.Strings.Both));

   function Image (Items : Int_List) return String is
      R : Unbounded_String;
   begin
      for V of Items loop
         if Length (R) > 0 then
            Append (R, ' ');
         end if;
         Append (R, Image (V));
      end loop;
      return To_String (R);
   end Image;

   function Image (N : Integer) return String is
     (Ada.Strings.Fixed.Trim (Integer'Image (N), Ada.Strings.Both));

   --  Accept a leading minus and redundant leading zeroes.
   function Parse_Int (Text : String) return Big_Integer is
      First : Integer := Text'First;
      Neg : Boolean := False;
   begin
      if Text'Length = 0 then
         raise Constraint_Error with "empty integer";
      end if;
      if Text (First) = '-' then
         Neg := True;
         First := First + 1;
      end if;
      while First < Text'Last and then Text (First) = '0' loop
         First := First + 1;
      end loop;
      declare
         V : Big_Integer := From_String (Text (First .. Text'Last));
      begin
         if Neg then
            V := -V;
         end if;
         return V;
      end;
   end Parse_Int;

   function Integer_Token (Text : String) return Boolean is
      First : Integer := Text'First;
   begin
      if Text'Length = 0 then
         return False;
      end if;
      if Text (First) = '-' then
         if Text'Length = 1 then
            return False;
         end if;
         First := First + 1;
      end if;
      for I in First .. Text'Last loop
         if Text (I) not in '0' .. '9' then
            return False;
         end if;
      end loop;
      return True;
   end Integer_Token;

   function Canonical_List (Text : String) return String is
      Start : Integer := Text'First;
      R : Unbounded_String;
      procedure Add (Tok : String) is
      begin
         if Length (R) > 0 then
            Append (R, ' ');
         end if;
         Append (R, Image (Parse_Int (Tok)));
      end Add;
   begin
      if Text'Length = 0 then
         return "";
      end if;
      for I in Text'Range loop
         if Text (I) = ' ' then
            if I > Start then
               Add (Text (Start .. I - 1));
            end if;
            Start := I + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Add (Text (Start .. Text'Last));
      end if;
      return To_String (R);
   end Canonical_List;

   --  XS sorts native vecfreq keys. Bigint rows follow Perl hash order.
   --  The numeric pairs are the result, so both sides are sorted by value.
   function Sorted_Freq (Text : String) return String is
      package Maps is new Ada.Containers.Ordered_Maps
        (Key_Type => Big_Integer, Element_Type => Big_Integer);
      M : Maps.Map;
      Start : Integer := Text'First;
      Kind : Boolean := True;
      Key : Big_Integer := 0;
      R : Int_List;
      procedure Take (Tok : String) is
      begin
         if Kind then
            Key := Parse_Int (Tok);
         else
            M.Include (Key, Parse_Int (Tok));
         end if;
         Kind := not Kind;
      end Take;
   begin
      if Text'Length = 0 then
         return "";
      end if;
      for I in Text'Range loop
         if Text (I) = ' ' then
            if I > Start then
               Take (Text (Start .. I - 1));
            end if;
            Start := I + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Take (Text (Start .. Text'Last));
      end if;
      for C in M.Iterate loop
         R.Append (Maps.Key (C));
         R.Append (Maps.Element (C));
      end loop;
      return Image (R);
   end Sorted_Freq;

   procedure Split
     (C : Case_Record; A, B : out Int_List; Two : out Boolean)
   is
   begin
      A.Clear;
      B.Clear;
      Two := False;
      for Arg of C.Args loop
         declare
            T : constant String := To_String (Arg);
         begin
            if T = "|" then
               Two := True;
            elsif Two then
               B.Append (Parse_Int (T));
            else
               A.Append (Parse_Int (T));
            end if;
         end;
      end loop;
   end Split;

   function Non_Integer (C : Case_Record) return Boolean is
   begin
      for Arg of C.Args loop
         declare
            T : constant String := To_String (Arg);
         begin
            if T /= "|" and then not Integer_Token (T) then
               return True;
            end if;
         end;
      end loop;
      return False;
   end Non_Integer;

   function List_Text (R : List_Result) return String is
     (if R.Defined then Image (R.Items) else "undef");

   function Value_Text (R : Value_Result) return String is
     (if R.Defined then Image (R.Value) else "undef");

   function Run
     (Func : String; A, B : Int_List; Two : Boolean) return String
   is
   begin
      if Func = "vecsum" then
         return Image (Vecsum (A));
      elsif Func = "vecprod" then
         return Image (Vecprod (A));
      elsif Func = "vecmin" then
         return Value_Text (Vecmin (A));
      elsif Func = "vecmax" then
         return Value_Text (Vecmax (A));
      elsif Func = "vecprefixsum" then
         return Image (Vecprefixsum (A));
      elsif Func = "vecuniq" then
         return Image (Vecuniq (A));
      elsif Func = "vecsingleton" then
         return Image (Vecsingleton (A));
      elsif Func = "vecfreq" then
         return Image (Vecfreq (A));
      elsif Func = "vecsort" then
         return Image (Vecsort (A));
      elsif Func = "vecrsort" then
         return Image (Vecrsort (A));
      elsif Func = "vecsorti" then
         return Image (Vecsorti (A));
      elsif Func = "vecrsorti" then
         return Image (Vecrsorti (A));
      elsif Func = "vecmex" then
         return Image (Vecmex (A));
      elsif Func = "vecpmex" then
         return Image (Vecpmex (A));
      elsif Func = "toset" then
         return Image (Toset (A));
      elsif Func = "is_sidon_set" then
         return (if Is_Sidon_Set (A) then "1" else "0");
      elsif Func = "is_sumfree_set" then
         return (if Is_Sumfree_Set (A) then "1" else "0");
      elsif Func = "sumset" then
         return Image (if Two then Sumset (A, B) else Sumset (A));
      elsif Func = "vecequal" then
         return (if Vecequal (A, B) then "1" else "0");
      elsif Func = "setunion" then
         return Image (Setunion (A, B));
      elsif Func = "setintersect" then
         return Image (Setintersect (A, B));
      elsif Func = "setminus" then
         return Image (Setminus (A, B));
      elsif Func = "setdelta" then
         return Image (Setdelta (A, B));
      elsif Func = "set_is_disjoint" then
         return (if Set_Is_Disjoint (A, B) then "1" else "0");
      elsif Func = "set_is_equal" then
         return (if Set_Is_Equal (A, B) then "1" else "0");
      elsif Func = "set_is_subset" then
         return (if Set_Is_Subset (A, B) then "1" else "0");
      elsif Func = "set_is_proper_subset" then
         return (if Set_Is_Proper_Subset (A, B) then "1" else "0");
      elsif Func = "set_is_superset" then
         return (if Set_Is_Superset (A, B) then "1" else "0");
      elsif Func = "set_is_proper_superset" then
         return (if Set_Is_Proper_Superset (A, B) then "1" else "0");
      elsif Func = "set_is_proper_intersection" then
         return (if Set_Is_Proper_Intersection (A, B) then "1" else "0");
      elsif Func in "setinsert" | "setinsert_set" then
         return Image (Setinsert (A, B).Items);
      elsif Func = "setinsert_n" then
         return Image (Setinsert (A, B).Count);
      elsif Func in "setremove" | "setremove_set" then
         return Image (Setremove (A, B).Items);
      elsif Func = "setremove_n" then
         return Image (Setremove (A, B).Count);
      elsif Func in "setinvert" | "setinvert_set" then
         return Image (Setinvert (A, B).Items);
      elsif Func = "setinvert_n" then
         return Image (Setinvert (A, B).Count);
      elsif Func = "setcontains" then
         return (if Setcontains (A, B) then "1" else "0");
      elsif Func = "setcontainsany" then
         return (if Setcontainsany (A, B) then "1" else "0");
      elsif Func = "vecextract" then
         return List_Text (Vecextract (A, B.Element (1)));
      elsif Func = "vecextract_idx" then
         return List_Text (Vecextract (A, B));
      end if;
      raise Constraint_Error with "unknown vec function";
   end Run;

   function Expected (Func, Result : String) return String is
     (if Result in "undef" | "ERROR" or else Result'Length = 0 then Result
      elsif Func = "vecfreq" then Sorted_Freq (Result)
      else Canonical_List (Result));

   procedure Replay
     (Cases : Case_Vectors.Vector; Func : String; Skipped : in out Natural)
   is
      Rows : constant Case_Vectors.Vector := For_Function (Cases, Func);
   begin
      AUnit.Assertions.Assert (not Rows.Is_Empty, Func & " has no rows");
      for C of Rows loop
         --  Skipped: vecextract line 3113 and vecextract_idx lines 3122
         --  and 3123. The elements are the letters a..z, which this
         --  integer port does not represent.
         if Non_Integer (C) then
            AUnit.Assertions.Assert
              (C.Line_Number in 3113 | 3122 | 3123,
               "unexpected non-integer row" & Positive'Image (C.Line_Number));
            Skipped := Skipped + 1;
         else
            declare
               A, B : Int_List;
               Two : Boolean;
               Got : Unbounded_String;
               Raised : Boolean := False;
            begin
               Split (C, A, B, Two);
               begin
                  Got := To_Unbounded_String (Run (Func, A, B, Two));
               exception
                  when Constraint_Error | Ada.Assertions.Assertion_Error =>
                     Raised := True;
               end;
               if C.Error then
                  AUnit.Assertions.Assert
                    (Raised,
                     Func & Positive'Image (C.Line_Number)
                       & " expected ERROR");
               else
                  AUnit.Assertions.Assert
                    (not Raised and then
                       To_String (Got) = Expected (Func, To_String (C.Result)),
                     Func & Positive'Image (C.Line_Number) & " got " &
                       To_String (Got) & " expected " & To_String (C.Result));
               end if;
            end;
         end if;
      end loop;
   end Replay;

   procedure Test_Vec_Fixture (T : in out AUnit.Test_Cases.Test_Case'Class) is
      pragma Unreferenced (T);
      Cases : constant Case_Vectors.Vector := Load ("vec");
      Skipped : Natural := 0;
   begin
      Replay (Cases, "vecsum", Skipped);
      Replay (Cases, "vecprod", Skipped);
      Replay (Cases, "vecmin", Skipped);
      Replay (Cases, "vecmax", Skipped);
      Replay (Cases, "vecprefixsum", Skipped);
      Replay (Cases, "vecuniq", Skipped);
      Replay (Cases, "vecsingleton", Skipped);
      Replay (Cases, "vecfreq", Skipped);
      Replay (Cases, "vecsort", Skipped);
      Replay (Cases, "vecrsort", Skipped);
      Replay (Cases, "vecsorti", Skipped);
      Replay (Cases, "vecrsorti", Skipped);
      Replay (Cases, "vecmex", Skipped);
      Replay (Cases, "vecpmex", Skipped);
      Replay (Cases, "toset", Skipped);
      Replay (Cases, "is_sidon_set", Skipped);
      Replay (Cases, "is_sumfree_set", Skipped);
      Replay (Cases, "sumset", Skipped);
      Replay (Cases, "vecequal", Skipped);
      Replay (Cases, "setunion", Skipped);
      Replay (Cases, "setintersect", Skipped);
      Replay (Cases, "setminus", Skipped);
      Replay (Cases, "setdelta", Skipped);
      Replay (Cases, "set_is_disjoint", Skipped);
      Replay (Cases, "set_is_equal", Skipped);
      Replay (Cases, "set_is_subset", Skipped);
      Replay (Cases, "set_is_proper_subset", Skipped);
      Replay (Cases, "set_is_superset", Skipped);
      Replay (Cases, "set_is_proper_superset", Skipped);
      Replay (Cases, "set_is_proper_intersection", Skipped);
      Replay (Cases, "setinsert", Skipped);
      Replay (Cases, "setinsert_n", Skipped);
      Replay (Cases, "setremove", Skipped);
      Replay (Cases, "setremove_n", Skipped);
      Replay (Cases, "setinvert", Skipped);
      Replay (Cases, "setinvert_n", Skipped);
      Replay (Cases, "setinsert_set", Skipped);
      Replay (Cases, "setremove_set", Skipped);
      Replay (Cases, "setinvert_set", Skipped);
      Replay (Cases, "setcontains", Skipped);
      Replay (Cases, "setcontainsany", Skipped);
      Replay (Cases, "vecextract", Skipped);
      Replay (Cases, "vecextract_idx", Skipped);
      AUnit.Assertions.Assert
        (Skipped = 3, "letter rows skipped" & Natural'Image (Skipped));
   end Test_Vec_Fixture;

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("compat_vec");
   end Name;

   overriding procedure Register_Tests (T : in out Vec_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Vec_Fixture'Access, "vec.tsv");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Compat_Vec;
