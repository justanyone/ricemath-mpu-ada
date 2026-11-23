with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Vec;

--  Skipped vec.tsv rows: none. Every vec* and set* row is replayed.
--  Leading-zero spellings are compared as canonical integers.
--  vecfreq is compared as a value-sorted map: bigint rows in the
--  fixture follow Perl hash order from PP.pm vecfreq.
package body Compat_Vec is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util.Vec;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   function Image (V : Big_Integer) return String is
      use Ada.Numerics.Big_Numbers.Big_Integers;
   begin
      return To_String (V);
   end Image;

   function None return Integer_Array is
      R : Integer_Array (1 .. 0);
   begin
      return R;
   end None;

   function Identity (N : Natural) return Integer_Array is
      use Ada.Numerics.Big_Numbers.Big_Integers;
      R : Integer_Array (1 .. N);
   begin
      for I in R'Range loop
         R (I) := To_Big_Integer (I);
      end loop;
      return R;
   end Identity;

   function Is_Int_Token (Text : String) return Boolean is
      I : Natural := Text'First;
   begin
      if Text'Length = 0 then
         return False;
      end if;
      if Text (I) in '+' | '-' then
         if I = Text'Last then
            return False;
         end if;
         I := I + 1;
      end if;
      for J in I .. Text'Last loop
         if Text (J) not in '0' .. '9' then
            return False;
         end if;
      end loop;
      return True;
   end Is_Int_Token;

   function Parse_Int (Text : String) return Big_Integer is
      use Ada.Numerics.Big_Numbers.Big_Integers;
      First : Integer := Text'First;
      Last  : constant Integer := Text'Last;
      Neg   : Boolean := False;
   begin
      if Text'Length = 0 then
         raise Constraint_Error with "empty integer";
      end if;
      if Text (First) = '+' then
         First := First + 1;
      elsif Text (First) = '-' then
         Neg := True;
         First := First + 1;
      end if;
      if First > Last then
         raise Constraint_Error with "sign only";
      end if;
      while First < Last and then Text (First) = '0' loop
         First := First + 1;
      end loop;
      declare
         V : constant Big_Integer := From_String (Text (First .. Last));
      begin
         if Neg then
            return -V;
         end if;
         return V;
      end;
   end Parse_Int;

   function Img (N : Integer) return String is
      S : constant String := Integer'Image (N);
   begin
      if S (S'First) = ' ' then
         return S (S'First + 1 .. S'Last);
      end if;
      return S;
   end Img;

   function Arg (C : Case_Record; I : Natural) return String is
     (To_String (C.Args (Positive (I))));

   function Bar_At (C : Case_Record) return Natural is
      Last : constant Natural := Natural (C.Args.Length);
   begin
      for I in 1 .. Last loop
         if Arg (C, I) = "|" then
            return I;
         end if;
      end loop;
      return 0;
   end Bar_At;

   function All_Int (C : Case_Record; Lo, Hi : Integer) return Boolean is
   begin
      for I in Lo .. Hi loop
         if not Is_Int_Token (Arg (C, Natural (I))) then
            return False;
         end if;
      end loop;
      return True;
   end All_Int;

   function List_Of
     (C : Case_Record; Lo, Hi : Integer) return Integer_Array
   is
      N : constant Natural := (if Hi < Lo then 0 else Hi - Lo + 1);
      R : Integer_Array (1 .. N);
      K : Natural := 0;
   begin
      for I in Lo .. Hi loop
         K := K + 1;
         R (K) := Parse_Int (Arg (C, Natural (I)));
      end loop;
      return R;
   end List_Of;

   function Join (Items : Integer_Array) return String is
      Acc : Unbounded_String;
   begin
      for I in Items'Range loop
         if I /= Items'First then
            Append (Acc, " ");
         end if;
         Append (Acc, Image (Items (I)));
      end loop;
      return To_String (Acc);
   end Join;

   function Join_Seq (S : Sequence) return String is
   begin
      if S.Length < 0 then
         return "undef";
      end if;
      return Join (S.Items);
   end Join_Seq;

   function Bit (B : Boolean) return String is
     (if B then "1" else "0");

   function Canon_Tokens (Text : String) return String is
      Acc   : Unbounded_String;
      Start : Integer := Text'First;
      First : Boolean := True;

      procedure Emit (Tok : String) is
      begin
         if Tok'Length = 0 then
            return;
         end if;
         if not First then
            Append (Acc, " ");
         end if;
         First := False;
         if Is_Int_Token (Tok) then
            Append (Acc, Image (Parse_Int (Tok)));
         else
            Append (Acc, Tok);
         end if;
      end Emit;
   begin
      if Text'Length = 0 then
         return "";
      end if;
      for I in Text'Range loop
         if Text (I) = ' ' then
            if I > Start then
               Emit (Text (Start .. I - 1));
            end if;
            Start := I + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Emit (Text (Start .. Text'Last));
      end if;
      return To_String (Acc);
   end Canon_Tokens;

   function Token_Count (Text : String) return Natural is
      N      : Natural := 0;
      In_Tok : Boolean := False;
   begin
      for Ch of Text loop
         if Ch = ' ' then
            In_Tok := False;
         elsif not In_Tok then
            N := N + 1;
            In_Tok := True;
         end if;
      end loop;
      return N;
   end Token_Count;

   function Canon_Freq (Text : String) return String is
      Ntok  : constant Natural := Token_Count (Text);
      Pairs : constant Natural := Ntok / 2;
      Keys  : Integer_Array (1 .. Pairs);
      Cts   : Integer_Array (1 .. Pairs);
      Start : Integer := Text'First;
      Seen  : Natural := 0;
      P     : Natural := 0;
      Acc   : Unbounded_String;

      procedure Take (Tok : String) is
      begin
         if Tok'Length = 0 then
            return;
         end if;
         Seen := Seen + 1;
         if Seen mod 2 = 1 then
            P := P + 1;
            Keys (P) := Parse_Int (Tok);
         else
            Cts (P) := Parse_Int (Tok);
         end if;
      end Take;
   begin
      if Ntok = 0 then
         return "";
      end if;
      if Ntok mod 2 /= 0 then
         return Text;
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
      for I in 2 .. Pairs loop
         declare
            K : constant Big_Integer := Keys (I);
            C : constant Big_Integer := Cts (I);
            J : Natural := I;
         begin
            while J > 1 and then Keys (J - 1) > K loop
               Keys (J) := Keys (J - 1);
               Cts (J) := Cts (J - 1);
               J := J - 1;
            end loop;
            Keys (J) := K;
            Cts (J) := C;
         end;
      end loop;
      for I in 1 .. Pairs loop
         if I > 1 then
            Append (Acc, " ");
         end if;
         Append (Acc, Image (Keys (I)));
         Append (Acc, " ");
         Append (Acc, Image (Cts (I)));
      end loop;
      return To_String (Acc);
   end Canon_Freq;

   function Starts (Func, Prefix : String) return Boolean is
     (Func'Length >= Prefix'Length
        and then
        Func (Func'First .. Func'First + Prefix'Length - 1) = Prefix);

   function Map_Tokens (C : Case_Record; S : Sequence) return String is
      use Ada.Numerics.Big_Numbers.Big_Integers;
      Acc : Unbounded_String;
   begin
      if S.Length < 0 then
         return "undef";
      end if;
      for I in S.Items'Range loop
         if I /= S.Items'First then
            Append (Acc, " ");
         end if;
         Append (Acc, Arg (C, Natural (To_Integer (S.Items (I)))));
      end loop;
      return To_String (Acc);
   end Map_Tokens;

   function Eval_Extract (C : Case_Record) return String is
      Func : constant String := To_String (C.Func);
      Bar  : constant Natural := Bar_At (C);
      Last : constant Natural := Natural (C.Args.Length);
      H1   : constant Integer := Integer (Bar) - 1;
   begin
      if All_Int (C, 1, H1) then
         declare
            Items : constant Integer_Array := List_Of (C, 1, H1);
         begin
            if Func = "vecextract" then
               return Join_Seq
                 (Vecextract (Items, Parse_Int (Arg (C, Bar + 1))));
            end if;
            return Join_Seq (Vecextract (Items, List_Of (C, Bar + 1, Last)));
         end;
      end if;
      declare
         Id : constant Integer_Array := Identity (Natural (H1));
      begin
         if Func = "vecextract" then
            return Map_Tokens
              (C, Vecextract (Id, Parse_Int (Arg (C, Bar + 1))));
         end if;
         return Map_Tokens
           (C, Vecextract (Id, List_Of (C, Bar + 1, Integer (Last))));
      end;
   end Eval_Extract;

   function Eval_Edit
     (Func : String; A, B : Integer_Array) return String
   is
      E : constant Set_Change :=
        (if Starts (Func, "setinsert") then Setinsert (A, B)
         elsif Starts (Func, "setremove") then Setremove (A, B)
         else Setinvert (A, B));
   begin
      if Func'Length > 2
        and then Func (Func'Last - 1 .. Func'Last) = "_n"
      then
         return Img (E.Changed);
      end if;
      return Join (E.Items);
   end Eval_Edit;

   function Eval (C : Case_Record) return String is
      Func : constant String := To_String (C.Func);
      Bar  : constant Natural := Bar_At (C);
      Last : constant Integer := Integer (C.Args.Length);
      Two  : constant Boolean := Bar > 0;
      H1   : constant Integer := (if Two then Integer (Bar) - 1 else Last);
      A    : constant Integer_Array := List_Of (C, 1, H1);
      B    : constant Integer_Array :=
        (if Two then List_Of (C, Integer (Bar) + 1, Last) else None);
   begin
      if Func in "vecextract" | "vecextract_idx" then
         return Eval_Extract (C);
      elsif Func = "vecsum" then
         return Image (Vecsum (A));
      elsif Func = "vecprod" then
         return Image (Vecprod (A));
      elsif Func = "vecmin" then
         declare
            O : constant Optional_Big := Vecmin (A);
         begin
            if not O.Defined then
               return "undef";
            end if;
            return Image (O.Value);
         end;
      elsif Func = "vecmax" then
         declare
            O : constant Optional_Big := Vecmax (A);
         begin
            if not O.Defined then
               return "undef";
            end if;
            return Image (O.Value);
         end;
      elsif Func = "vecprefixsum" then
         return Join (Vecprefixsum (A));
      elsif Func = "vecuniq" then
         return Join (Vecuniq (A));
      elsif Func = "vecsingleton" then
         return Join (Vecsingleton (A));
      elsif Func = "vecfreq" then
         declare
            F : constant Frequency_Array := Vecfreq (A);
            Acc : Unbounded_String;
         begin
            for I in F'Range loop
               if I /= F'First then
                  Append (Acc, " ");
               end if;
               Append (Acc, Image (F (I).Value));
               Append (Acc, " ");
               Append (Acc, Img (F (I).Count));
            end loop;
            return To_String (Acc);
         end;
      elsif Func = "vecsort" then
         return Join (Vecsort (A));
      elsif Func = "vecrsort" then
         return Join (Vecrsort (A));
      elsif Func = "vecsorti" then
         declare
            M : Integer_Array := A;
         begin
            Vecsorti (M);
            return Join (M);
         end;
      elsif Func = "vecrsorti" then
         declare
            M : Integer_Array := A;
         begin
            Vecrsorti (M);
            return Join (M);
         end;
      elsif Func = "vecmex" then
         return Image (Vecmex (A));
      elsif Func = "vecpmex" then
         return Image (Vecpmex (A));
      elsif Func = "toset" then
         return Join (Toset (A));
      elsif Func = "is_sidon_set" then
         return Bit (Is_Sidon_Set (A));
      elsif Func = "is_sumfree_set" then
         return Bit (Is_Sumfree_Set (A));
      elsif Func = "sumset" then
         if Two then
            return Join (Sumset (A, B));
         end if;
         return Join (Sumset (A));
      elsif Func = "vecequal" then
         return Bit (Vecequal (A, B));
      elsif Func = "setunion" then
         return Join (Setunion (A, B));
      elsif Func = "setintersect" then
         return Join (Setintersect (A, B));
      elsif Func = "setminus" then
         return Join (Setminus (A, B));
      elsif Func = "setdelta" then
         return Join (Setdelta (A, B));
      elsif Func = "set_is_disjoint" then
         return Bit (Set_Is_Disjoint (A, B));
      elsif Func = "set_is_equal" then
         return Bit (Set_Is_Equal (A, B));
      elsif Func = "set_is_subset" then
         return Bit (Set_Is_Subset (A, B));
      elsif Func = "set_is_proper_subset" then
         return Bit (Set_Is_Proper_Subset (A, B));
      elsif Func = "set_is_superset" then
         return Bit (Set_Is_Superset (A, B));
      elsif Func = "set_is_proper_superset" then
         return Bit (Set_Is_Proper_Superset (A, B));
      elsif Func = "set_is_proper_intersection" then
         return Bit (Set_Is_Proper_Intersection (A, B));
      elsif Func = "setcontains" then
         return Bit (Setcontains (A, B));
      elsif Func = "setcontainsany" then
         return Bit (Setcontainsany (A, B));
      elsif Starts (Func, "setinsert")
        or else Starts (Func, "setremove")
        or else Starts (Func, "setinvert")
      then
         return Eval_Edit (Func, A, B);
      end if;
      return "UNKNOWN " & Func;
   exception
      when Constraint_Error | Ada.Assertions.Assertion_Error =>
         return "ERROR";
   end Eval;

   function Clip (S : String) return String is
     (if S'Length > 80 then S (S'First .. S'First + 79) else S);

   function Replay (Func : String) return String is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("vec"), Func);
   begin
      if Cases.Is_Empty then
         return Func & " has no rows";
      end if;
      for C of Cases loop
         declare
            Actual : constant String := Eval (C);
            Expect : constant String := To_String (C.Result);
            Want   : constant String :=
              (if Expect in "ERROR" | "undef" then Expect
               elsif Func = "vecfreq" then Canon_Freq (Expect)
               else Canon_Tokens (Expect));
            Got    : constant String :=
              (if Actual in "ERROR" | "undef" then Actual
               elsif Func = "vecfreq" then Canon_Freq (Actual)
               else Canon_Tokens (Actual));
         begin
            if Got /= Want then
               return Func & " line" & Positive'Image (C.Line_Number)
                 & " expected " & Clip (Want) & " got " & Clip (Got);
            end if;
         end;
      end loop;
      return "";
   end Replay;

   procedure Add
     (Acc : in out Unbounded_String; N : in out Natural; Func : String)
   is
   begin
      if N >= 6 then
         return;
      end if;
      declare
         Msg : constant String := Replay (Func);
      begin
         if Msg'Length = 0 then
            return;
         end if;
         N := N + 1;
         if Length (Acc) > 0 then
            Append (Acc, " || ");
         end if;
         Append (Acc, Msg);
      end;
   end Add;

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Vec");
   end Name;

   procedure Test_Vec_Fixture (T : in out Test_Case'Class) is
      Acc : Unbounded_String;
      N   : Natural := 0;
   begin
      Add (Acc, N, "vecsum");
      Add (Acc, N, "vecprod");
      Add (Acc, N, "vecmin");
      Add (Acc, N, "vecmax");
      Add (Acc, N, "vecprefixsum");
      Add (Acc, N, "vecuniq");
      Add (Acc, N, "vecsingleton");
      Add (Acc, N, "vecfreq");
      Add (Acc, N, "vecsort");
      Add (Acc, N, "vecrsort");
      Add (Acc, N, "vecsorti");
      Add (Acc, N, "vecrsorti");
      Add (Acc, N, "vecmex");
      Add (Acc, N, "vecpmex");
      Add (Acc, N, "toset");
      Add (Acc, N, "is_sidon_set");
      Add (Acc, N, "is_sumfree_set");
      Add (Acc, N, "sumset");
      Add (Acc, N, "vecequal");
      Add (Acc, N, "vecextract");
      Add (Acc, N, "vecextract_idx");
      Add (Acc, N, "setunion");
      Add (Acc, N, "setintersect");
      Add (Acc, N, "setminus");
      Add (Acc, N, "setdelta");
      Add (Acc, N, "set_is_disjoint");
      Add (Acc, N, "set_is_equal");
      Add (Acc, N, "set_is_subset");
      Add (Acc, N, "set_is_proper_subset");
      Add (Acc, N, "set_is_superset");
      Add (Acc, N, "set_is_proper_superset");
      Add (Acc, N, "set_is_proper_intersection");
      Add (Acc, N, "setinsert");
      Add (Acc, N, "setinsert_n");
      Add (Acc, N, "setremove");
      Add (Acc, N, "setremove_n");
      Add (Acc, N, "setinvert");
      Add (Acc, N, "setinvert_n");
      Add (Acc, N, "setinsert_set");
      Add (Acc, N, "setremove_set");
      Add (Acc, N, "setinvert_set");
      Add (Acc, N, "setcontains");
      Add (Acc, N, "setcontainsany");
      AUnit.Assertions.Assert (N = 0, To_String (Acc));
   end Test_Vec_Fixture;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Vec_Fixture'Access, "vec.tsv");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Compat_Vec;
