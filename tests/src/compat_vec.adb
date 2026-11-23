with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Assertions;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Vec;

package body Compat_Vec is
   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use Ada.Strings.Unbounded;
   use Ada.Numerics.Big_Numbers.Big_Integers;
   use Fixture_Support;
   use Math_Prime_Util.Vec;
   use type Big_Integer;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   function Trim (Text : String) return String is
     (if Text'Length > 0 and then Text (Text'First) = ' '
      then Text (Text'First + 1 .. Text'Last) else Text);

   function Image (Value : Big_Integer) return String is
     (Trim (To_String (Value)));

   function Image (Value : Integer) return String is
     (Trim (Integer'Image (Value)));

   function Parse_Integer (Text : String) return Big_Integer is
      Negative : Boolean := False;
      First : Integer := Text'First;
   begin
      if Text'Length = 0 then
         raise Constraint_Error with "empty integer";
      end if;
      if Text (First) = '-' then
         Negative := True;
         First := First + 1;
      elsif Text (First) = '+' then
         First := First + 1;
      end if;
      while First < Text'Last and then Text (First) = '0' loop
         First := First + 1;
      end loop;
      declare
         Digits : constant String :=
           (if First > Text'Last then "0" else Text (First .. Text'Last));
         Value : constant Big_Integer := From_String (Digits);
      begin
         return (if Negative then -Value else Value);
      end;
   end Parse_Integer;

   function Tokens (Text : String) return String_Vectors.Vector is
      Result : String_Vectors.Vector;
      Start : Integer := Text'First;
   begin
      if Text'Length = 0 then
         return Result;
      end if;
      for Index in Text'Range loop
         if Text (Index) = ' ' then
            if Index > Start then
               Result.Append (To_Unbounded_String (Text (Start .. Index - 1)));
            end if;
            Start := Index + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Result.Append (To_Unbounded_String (Text (Start .. Text'Last)));
      end if;
      return Result;
   end Tokens;

   function Canon (Text : String) return String is
      Parts : constant String_Vectors.Vector := Tokens (Text);
      Result : Unbounded_String;
   begin
      for Part of Parts loop
         if Length (Result) > 0 then
            Append (Result, ' ');
         end if;
         Append (Result, Image (Parse_Integer (To_String (Part))));
      end loop;
      return To_String (Result);
   end Canon;

   function Canon_Freq (Text : String) return String is
      Parts : constant String_Vectors.Vector := Tokens (Text);
      type Pair is record
         Key : Big_Integer;
         Count : Big_Integer;
      end record;
      Pairs : array (1 .. 256) of Pair;
      Used : Natural := 0;
      Result : Unbounded_String;
   begin
      if Parts.Length mod 2 /= 0 or else Parts.Length / 2 > 256 then
         return Text;
      end if;
      while Used < Natural (Parts.Length / 2) loop
         Used := Used + 1;
         Pairs (Used) :=
           (Key => Parse_Integer (To_String (Parts (Used * 2 - 1))),
            Count => Parse_Integer (To_String (Parts (Used * 2))));
      end loop;
      for I in 2 .. Used loop
         declare
            Key : constant Pair := Pairs (I);
            J : Natural := I - 1;
         begin
            while J >= 1 and then Pairs (J).Key > Key.Key loop
               Pairs (J + 1) := Pairs (J);
               J := J - 1;
            end loop;
            Pairs (J + 1) := Key;
         end;
      end loop;
      for I in 1 .. Used loop
         if Length (Result) > 0 then
            Append (Result, ' ');
         end if;
         Append (Result, Image (Pairs (I).Key));
         Append (Result, ' ');
         Append (Result, Image (Pairs (I).Count));
      end loop;
      return To_String (Result);
   end Canon_Freq;

   function Join (Items : Integer_Vectors.Vector) return String is
      Result : Unbounded_String;
   begin
      for Value of Items loop
         if Length (Result) > 0 then
            Append (Result, ' ');
         end if;
         Append (Result, Image (Value));
      end loop;
      return To_String (Result);
   end Join;

   function Join_Freq (Items : Freq_Vectors.Vector) return String is
      Result : Unbounded_String;
   begin
      for Pair of Items loop
         if Length (Result) > 0 then
            Append (Result, ' ');
         end if;
         Append (Result, Image (Pair.Value));
         Append (Result, ' ');
         Append (Result, Image (Pair.Count));
      end loop;
      return To_String (Result);
   end Join_Freq;

   function Join_Text (Items : Text_Vectors.Vector) return String is
      Result : Unbounded_String;
   begin
      for Value of Items loop
         if Length (Result) > 0 then
            Append (Result, ' ');
         end if;
         Append (Result, To_String (Value));
      end loop;
      return To_String (Result);
   end Join_Text;

   function Bit (Value : Boolean) return String is
     (if Value then "1" else "0");

   procedure Split
     (Args : String_Vectors.Vector;
      Left, Right : out Integer_Vectors.Vector;
      Left_Text, Right_Text : out Text_Vectors.Vector;
      Has_Bar : out Boolean)
   is
      On_Right : Boolean := False;
   begin
      Left := Integer_Vectors.Empty_Vector;
      Right := Integer_Vectors.Empty_Vector;
      Left_Text := Text_Vectors.Empty_Vector;
      Right_Text := Text_Vectors.Empty_Vector;
      Has_Bar := False;
      for Arg of Args loop
         declare
            Text : constant String := To_String (Arg);
         begin
            if Text = "|" then
               On_Right := True;
               Has_Bar := True;
            elsif On_Right then
               Right_Text.Append (Arg);
            else
               Left_Text.Append (Arg);
            end if;
         end;
      end loop;
   end Split;

   function Numbers (Items : Text_Vectors.Vector) return Integer_Vectors.Vector
   is
      Result : Integer_Vectors.Vector;
   begin
      for Item of Items loop
         Result.Append (Parse_Integer (To_String (Item)));
      end loop;
      return Result;
   end Numbers;

   procedure Fail_If_Error (Name : String; C : Case_Record) is
   begin
      if C.Error then
         Assert (False, Name & Positive'Image (C.Line_Number) & " error");
      end if;
   end Fail_If_Error;

   procedure Match
     (Name : String; C : Case_Record; Actual : String; As_Freq : Boolean)
   is
      Label : constant String := Name & Positive'Image (C.Line_Number);
      Expected : constant String := To_String (C.Result);
   begin
      Fail_If_Error (Name, C);
      Assert (not C.Undef, Label & " undef");
      if As_Freq then
         Assert
           (Canon_Freq (Actual) = Canon_Freq (Expected),
            Label & " got " & Actual);
      elsif Name in "vecextract" | "vecextract_idx" then
         Assert (Actual = Expected, Label & " got " & Actual);
      else
         Assert (Canon (Actual) = Canon (Expected), Label & " got " & Actual);
      end if;
   end Match;

   procedure Match_Undef (Name : String; C : Case_Record; Undef : Boolean) is
      Label : constant String := Name & Positive'Image (C.Line_Number);
   begin
      Fail_If_Error (Name, C);
      Assert (Undef = C.Undef, Label & " definedness");
   end Match_Undef;

   procedure Check_Row (Name : String; C : Case_Record) is
      Left_Text, Right_Text : Text_Vectors.Vector;
      Has_Bar : Boolean;
      Left, Right : Integer_Vectors.Vector;
   begin
      Split (C.Args, Left, Right, Left_Text, Right_Text, Has_Bar);
      if Name not in "vecextract" | "vecextract_idx" then
         Left := Numbers (Left_Text);
         Right := Numbers (Right_Text);
      end if;
      if Name = "vecsum" then
         Match (Name, C, Image (Vecsum (Left)), False);
      elsif Name = "vecprod" then
         Match (Name, C, Image (Vecprod (Left)), False);
      elsif Name = "vecmin" then
         declare
            Value : constant Optional_Integer := Vecmin (Left);
         begin
            if not Value.Defined then
               Match_Undef (Name, C, True);
            else
               Match (Name, C, Image (Value.Value), False);
            end if;
         end;
      elsif Name = "vecmax" then
         declare
            Value : constant Optional_Integer := Vecmax (Left);
         begin
            if not Value.Defined then
               Match_Undef (Name, C, True);
            else
               Match (Name, C, Image (Value.Value), False);
            end if;
         end;
      elsif Name = "vecprefixsum" then
         Match (Name, C, Join (Vecprefixsum (Left)), False);
      elsif Name = "vecuniq" then
         Match (Name, C, Join (Vecuniq (Left)), False);
      elsif Name = "vecsingleton" then
         Match (Name, C, Join (Vecsingleton (Left)), False);
      elsif Name = "vecfreq" then
         Match (Name, C, Join_Freq (Vecfreq (Left)), True);
      elsif Name = "vecsort" then
         Match (Name, C, Join (Vecsort (Left)), False);
      elsif Name = "vecrsort" then
         Match (Name, C, Join (Vecrsort (Left)), False);
      elsif Name = "vecsorti" then
         declare
            Copy : Integer_Vectors.Vector := Left;
         begin
            Vecsorti (Copy);
            Match (Name, C, Join (Copy), False);
         end;
      elsif Name = "vecrsorti" then
         declare
            Copy : Integer_Vectors.Vector := Left;
         begin
            Vecrsorti (Copy);
            Match (Name, C, Join (Copy), False);
         end;
      elsif Name = "vecmex" then
         Match (Name, C, Image (Vecmex (Left)), False);
      elsif Name = "vecpmex" then
         Match (Name, C, Image (Vecpmex (Left)), False);
      elsif Name = "toset" then
         Match (Name, C, Join (Toset (Left)), False);
      elsif Name = "is_sidon_set" then
         Match (Name, C, Bit (Is_Sidon_Set (Left)), False);
      elsif Name = "is_sumfree_set" then
         Match (Name, C, Bit (Is_Sumfree_Set (Left)), False);
      elsif Name = "sumset" then
         if Has_Bar then
            Match (Name, C, Join (Sumset (Left, Right)), False);
         else
            Match (Name, C, Join (Sumset (Left)), False);
         end if;
      elsif Name = "vecequal" then
         Match (Name, C, Bit (Vecequal (Left, Right)), False);
      elsif Name = "setunion" then
         Match (Name, C, Join (Setunion (Left, Right)), False);
      elsif Name = "setintersect" then
         Match (Name, C, Join (Setintersect (Left, Right)), False);
      elsif Name = "setminus" then
         Match (Name, C, Join (Setminus (Left, Right)), False);
      elsif Name = "setdelta" then
         Match (Name, C, Join (Setdelta (Left, Right)), False);
      elsif Name in "setinsert" | "setinsert_set" then
         Match (Name, C, Join (Setinsert (Left, Right)), False);
      elsif Name = "setinsert_n" then
         Match
           (Name, C,
            Image (Integer (Setinsert (Left, Right).Length) -
                     Integer (Left.Length)),
            False);
      elsif Name in "setremove" | "setremove_set" then
         Match (Name, C, Join (Setremove (Left, Right)), False);
      elsif Name = "setremove_n" then
         Match
           (Name, C,
            Image (Integer (Left.Length) -
                     Integer (Setremove (Left, Right).Length)),
            False);
      elsif Name in "setinvert" | "setinvert_set" then
         Match (Name, C, Join (Setinvert (Left, Right)), False);
      elsif Name = "setinvert_n" then
         Match
           (Name, C,
            Image (Integer (Setinvert (Left, Right).Length) -
                     Integer (Left.Length)),
            False);
      elsif Name = "setcontains" then
         Match (Name, C, Bit (Setcontains (Left, Right)), False);
      elsif Name = "setcontainsany" then
         Match (Name, C, Bit (Setcontainsany (Left, Right)), False);
      elsif Name = "set_is_disjoint" then
         Match (Name, C, Bit (Set_Is_Disjoint (Left, Right)), False);
      elsif Name = "set_is_equal" then
         Match (Name, C, Bit (Set_Is_Equal (Left, Right)), False);
      elsif Name = "set_is_subset" then
         Match (Name, C, Bit (Set_Is_Subset (Left, Right)), False);
      elsif Name = "set_is_proper_subset" then
         Match (Name, C, Bit (Set_Is_Proper_Subset (Left, Right)), False);
      elsif Name = "set_is_superset" then
         Match (Name, C, Bit (Set_Is_Superset (Left, Right)), False);
      elsif Name = "set_is_proper_superset" then
         Match (Name, C, Bit (Set_Is_Proper_Superset (Left, Right)), False);
      elsif Name = "set_is_proper_intersection" then
         Match
           (Name, C, Bit (Set_Is_Proper_Intersection (Left, Right)), False);
      elsif Name = "vecextract" then
         declare
            Mask : constant Big_Integer :=
              Parse_Integer (To_String (Right_Text (1)));
            Value : constant Text_Result := Vecextract (Left_Text, Mask);
         begin
            if not Value.Defined then
               Match_Undef (Name, C, True);
            else
               Match (Name, C, Join_Text (Value.Items), False);
            end if;
         end;
      elsif Name = "vecextract_idx" then
         declare
            Value : constant Text_Result :=
              Vecextract (Left_Text, Numbers (Right_Text));
         begin
            if not Value.Defined then
               Match_Undef (Name, C, True);
            else
               Match (Name, C, Join_Text (Value.Items), False);
            end if;
         end;
      else
         Assert (False, "unlisted " & Name);
      end if;
   exception
      when Constraint_Error | Ada.Assertions.Assertion_Error =>
         Assert
           (C.Error, Name & Positive'Image (C.Line_Number) & " raised");
   end Check_Row;

   --  No vec.tsv row is skipped. vecfreq pairs are sorted before compare
   --  because Perl hash order is upstream finding 12. setinsert_n,
   --  setremove_n, setinvert_n and the _set rows call Setinsert,
   --  Setremove and Setinvert. vecextract_idx is the index form of
   --  Vecextract. A leading zero in an oracle integer matches its value.
   procedure Replay (Name : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("vec"), Name);
   begin
      Assert (not Cases.Is_Empty, "missing " & Name);
      for C of Cases loop
         Check_Row (Name, C);
      end loop;
   end Replay;

   procedure Check_Fixture (T : in out Test_Case'Class) is
   begin
      Replay ("vecsum");
      Replay ("vecprod");
      Replay ("vecmin");
      Replay ("vecmax");
      Replay ("vecprefixsum");
      Replay ("vecuniq");
      Replay ("vecsingleton");
      Replay ("vecfreq");
      Replay ("vecsort");
      Replay ("vecrsort");
      Replay ("vecsorti");
      Replay ("vecrsorti");
      Replay ("vecmex");
      Replay ("vecpmex");
      Replay ("toset");
      Replay ("is_sidon_set");
      Replay ("is_sumfree_set");
      Replay ("sumset");
      Replay ("vecextract");
      Replay ("vecextract_idx");
      Replay ("vecequal");
      Replay ("setunion");
      Replay ("setintersect");
      Replay ("setminus");
      Replay ("setdelta");
      Replay ("setinsert");
      Replay ("setinsert_n");
      Replay ("setinsert_set");
      Replay ("setremove");
      Replay ("setremove_n");
      Replay ("setremove_set");
      Replay ("setinvert");
      Replay ("setinvert_n");
      Replay ("setinvert_set");
      Replay ("setcontains");
      Replay ("setcontainsany");
      Replay ("set_is_disjoint");
      Replay ("set_is_equal");
      Replay ("set_is_subset");
      Replay ("set_is_proper_subset");
      Replay ("set_is_superset");
      Replay ("set_is_proper_superset");
      Replay ("set_is_proper_intersection");
   end Check_Fixture;

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Vec");
   end Name;

   overriding procedure Register_Tests (T : in out Vec_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Check_Fixture'Access, "vec fixture");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Compat_Vec;
