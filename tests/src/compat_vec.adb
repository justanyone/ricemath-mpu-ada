with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Assertions;
with Ada.Containers.Indefinite_Vectors;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Vec;

package body Compat_Vec is
   use AUnit.Test_Cases;
   use Ada.Numerics.Big_Numbers.Big_Integers;
   use Math_Prime_Util.Vec;
   use type Ada.Containers.Count_Type;

   package Vecs is new Ada.Containers.Indefinite_Vectors
     (Index_Type => Positive, Element_Type => Big_Integer);

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   function S (Value : Ada.Strings.Unbounded.Unbounded_String)
     return String is
     (Ada.Strings.Unbounded.To_String (Value));

   function Parse_Big (Text : String) return Big_Integer is
      First : Integer := Text'First;
      Negative : Boolean := False;
   begin
      if Text'Length = 0 then
         raise Constraint_Error;
      end if;
      if Text (First) = '-' then
         Negative := True;
         First := First + 1;
      end if;
      while First < Text'Last and then Text (First) = '0' loop
         First := First + 1;
      end loop;
      if Negative and then Text (First .. Text'Last) /= "0" then
         return -From_String (Text (First .. Text'Last));
      end if;
      return From_String (Text (First .. Text'Last));
   end Parse_Big;

   function Parse_List (Text : String) return Vecs.Vector is
      Acc : Vecs.Vector;
      Start : Integer := Text'First;
   begin
      if Text'Length = 0 then
         return Acc;
      end if;
      for I in Text'Range loop
         if Text (I) = ' ' then
            if I > Start then
               Acc.Append (Parse_Big (Text (Start .. I - 1)));
            end if;
            Start := I + 1;
         end if;
      end loop;
      if Start <= Text'Last then
         Acc.Append (Parse_Big (Text (Start .. Text'Last)));
      end if;
      return Acc;
   end Parse_List;

   function To_Array (Acc : Vecs.Vector) return Int_Vector is
      Result : Int_Vector (1 .. Natural (Acc.Length));
      Index : Natural := 0;
   begin
      for V of Acc loop
         Index := Index + 1;
         Result (Index) := V;
      end loop;
      return Result;
   end To_Array;

   function Same (Items : Vecs.Vector; Text : String) return Boolean is
      Exp : constant Vecs.Vector := Parse_List (Text);
   begin
      if Items.Length /= Exp.Length then
         return False;
      end if;
      for I in 1 .. Natural (Items.Length) loop
         if Items.Element (I) /= Exp.Element (I) then
            return False;
         end if;
      end loop;
      return True;
   end Same;

   --  XS sorts one native class. PP hash order is not numeric
   --  (upstream finding 12). Leading-zero spellings are integers
   --  (upstream finding 5). Compare the sorted numeric pairs.
   function Same_Freq (Items : Vecs.Vector; Text : String)
     return Boolean
   is
      Exp : Int_Vector := To_Array (Parse_List (Text));
      Key_V, Key_C : Big_Integer;
      J : Integer;
      I : Integer := 3;
   begin
      if Exp'Length mod 2 /= 0 then
         return False;
      end if;
      while I <= Exp'Last loop
         Key_V := Exp (I);
         Key_C := Exp (I + 1);
         J := I - 2;
         while J >= Exp'First and then Exp (J) > Key_V loop
            Exp (J + 2) := Exp (J);
            Exp (J + 3) := Exp (J + 1);
            J := J - 2;
         end loop;
         Exp (J + 2) := Key_V;
         Exp (J + 3) := Key_C;
         I := I + 2;
      end loop;
      if Natural (Items.Length) /= Exp'Length then
         return False;
      end if;
      for K in Exp'Range loop
         if Items.Element (K) /= Exp (K) then
            return False;
         end if;
      end loop;
      return True;
   end Same_Freq;

   function Is_Integral_Token (Text : String) return Boolean is
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
   end Is_Integral_Token;

   function Integral (C : Fixture_Support.Case_Record) return Boolean is
   begin
      for Arg of C.Args loop
         declare
            T : constant String := S (Arg);
         begin
            if T /= "|" and then not Is_Integral_Token (T) then
               return False;
            end if;
         end;
      end loop;
      return True;
   end Integral;

   type Answer is record
      Fault : Boolean := False;
      Is_Bool : Boolean := False;
      Is_Number : Boolean := False;
      Flag : Boolean := False;
      Number : Big_Integer := 0;
      Items : Vecs.Vector;
   end record;

   procedure Take (A : in out Answer; Got : Int_Vector) is
   begin
      for V of Got loop
         A.Items.Append (V);
      end loop;
   end Take;

   function Evaluate
     (Func : String; Left, Right : Int_Vector; Two : Boolean)
      return Answer
   is
      A : Answer;
      L : Int_Vector renames Left;
      R : Int_Vector renames Right;
   begin
      if Func = "vecsum" then
         A.Is_Number := True;
         A.Number := Vecsum (L);
      elsif Func = "vecprod" then
         A.Is_Number := True;
         A.Number := Vecprod (L);
      elsif Func = "vecmin" then
         A.Is_Number := True;
         A.Number := Vecmin (L);
      elsif Func = "vecmax" then
         A.Is_Number := True;
         A.Number := Vecmax (L);
      elsif Func = "vecprefixsum" then
         Take (A, Vecprefixsum (L));
      elsif Func = "vecuniq" then
         Take (A, Vecuniq (L));
      elsif Func = "vecsingleton" then
         Take (A, Vecsingleton (L));
      elsif Func = "vecfreq" then
         Take (A, Vecfreq (L));
      elsif Func = "vecsort" then
         Take (A, Vecsort (L));
      elsif Func = "vecrsort" then
         Take (A, Vecrsort (L));
      elsif Func = "vecsorti" then
         Take (A, Vecsorti (L));
      elsif Func = "vecrsorti" then
         Take (A, Vecrsorti (L));
      elsif Func = "vecmex" then
         A.Is_Number := True;
         A.Number := Vecmex (L);
      elsif Func = "vecpmex" then
         A.Is_Number := True;
         A.Number := Vecpmex (L);
      elsif Func = "toset" then
         Take (A, Toset (L));
      elsif Func = "is_sidon_set" then
         A.Is_Bool := True;
         A.Flag := Is_Sidon_Set (L);
      elsif Func = "is_sumfree_set" then
         A.Is_Bool := True;
         A.Flag := Is_Sumfree_Set (L);
      elsif Func = "sumset" then
         if Two then
            Take (A, Sumset (L, R));
         else
            Take (A, Sumset (L));
         end if;
      elsif Func = "vecequal" then
         A.Is_Bool := True;
         A.Flag := Vecequal (L, R);
      elsif Func = "vecextract" then
         Take (A, Vecextract (L, R (R'First)));
      elsif Func = "vecextract_idx" then
         Take (A, Vecextract (L, R));
      elsif Func = "setunion" then
         Take (A, Setunion (L, R));
      elsif Func = "setintersect" then
         Take (A, Setintersect (L, R));
      elsif Func = "setminus" then
         Take (A, Setminus (L, R));
      elsif Func = "setdelta" then
         Take (A, Setdelta (L, R));
      elsif Func = "set_is_disjoint" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Disjoint (L, R);
      elsif Func = "set_is_equal" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Equal (L, R);
      elsif Func = "set_is_subset" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Subset (L, R);
      elsif Func = "set_is_proper_subset" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Proper_Subset (L, R);
      elsif Func = "set_is_superset" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Superset (L, R);
      elsif Func = "set_is_proper_superset" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Proper_Superset (L, R);
      elsif Func = "set_is_proper_intersection" then
         A.Is_Bool := True;
         A.Flag := Set_Is_Proper_Intersection (L, R);
      elsif Func = "setinsert" or else Func = "setinsert_set" then
         Take (A, Setinsert (L, R));
      elsif Func = "setinsert_n" then
         A.Is_Number := True;
         A.Number := To_Big_Integer (Setinsert (L, R)'Length)
           - To_Big_Integer (Toset (L)'Length);
      elsif Func = "setremove" or else Func = "setremove_set" then
         Take (A, Setremove (L, R));
      elsif Func = "setremove_n" then
         A.Is_Number := True;
         A.Number := To_Big_Integer (Toset (L)'Length)
           - To_Big_Integer (Setremove (L, R)'Length);
      elsif Func = "setinvert" or else Func = "setinvert_set" then
         Take (A, Setinvert (L, R));
      elsif Func = "setinvert_n" then
         A.Is_Number := True;
         A.Number := To_Big_Integer (Setinvert (L, R)'Length)
           - To_Big_Integer (Toset (L)'Length);
      elsif Func = "setcontains" then
         A.Is_Bool := True;
         A.Flag := Setcontains (L, R);
      elsif Func = "setcontainsany" then
         A.Is_Bool := True;
         A.Flag := Setcontainsany (L, R);
      else
         AUnit.Assertions.Assert (False, "unknown " & Func);
      end if;
      return A;
   exception
      when Constraint_Error | Ada.Assertions.Assertion_Error =>
         return (Fault => True, others => <>);
   end Evaluate;

   procedure Check_Edges (T : in out Test_Case'Class) is
      None : Int_Vector (1 .. 0);
      Zero : constant Int_Vector := (1 => To_Big_Integer (0));
      Raised : Boolean := False;
   begin
      AUnit.Assertions.Assert (Vecsum (None) = 0, "empty sum");
      AUnit.Assertions.Assert (Vecprod (None) = 1, "empty product");
      AUnit.Assertions.Assert (Vecmex (None) = 0, "empty mex");
      AUnit.Assertions.Assert (Vecpmex (None) = 1, "empty pmex");
      AUnit.Assertions.Assert (Vecmex (Zero) = 1, "mex of zero");
      AUnit.Assertions.Assert (Is_Sidon_Set (None), "empty sidon");
      AUnit.Assertions.Assert (not Is_Sumfree_Set (Zero), "zero sumfree");
      AUnit.Assertions.Assert (Is_Sumfree_Set (None), "empty sumfree");
      AUnit.Assertions.Assert (Set_Is_Disjoint (None, None), "disjoint");
      AUnit.Assertions.Assert (Vecequal (None, None), "equal empty");
      AUnit.Assertions.Assert
        (Vecextract (Zero, To_Big_Integer (0))'Length = 0, "mask 0");
      AUnit.Assertions.Assert
        (Vecextract (Zero, (1 => To_Big_Integer (-1))) (1) = 0,
         "index -1");
      begin
         declare
            Ignored : constant Big_Integer := Vecmin (None);
         begin
            if Ignored = 0 then
               Raised := False;
            end if;
         end;
      exception
         when Constraint_Error | Ada.Assertions.Assertion_Error =>
            Raised := True;
      end;
      AUnit.Assertions.Assert (Raised, "empty min");
   end Check_Edges;

   procedure Check_Fixture (T : in out Test_Case'Class) is
      Cases : constant Fixture_Support.Case_Vectors.Vector :=
        Fixture_Support.Load ("vec");
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing vec");
      for C of Cases loop
         declare
            Func : constant String := S (C.Func);
            Where : constant String :=
              Func & Positive'Image (C.Line_Number);
            LV, RV : Vecs.Vector;
            Two : Boolean := False;
         begin
            --  Skipped: vecextract of a..z with mask 12345758
            --  (vec.tsv line 3113) and vecextract_idx of a..z with
            --  indexes 22 14 17 10 18 and 15 17 8 12 4 (lines 3122
            --  and 3123). Those rows are character labels.
            if not Integral (C) then
               AUnit.Assertions.Assert
                 (C.Line_Number in 3113 | 3122 | 3123, Where);
            else
               for Arg of C.Args loop
                  declare
                     Token : constant String := S (Arg);
                  begin
                     if Token = "|" then
                        Two := True;
                     elsif not Two then
                        LV.Append (Parse_Big (Token));
                     else
                        RV.Append (Parse_Big (Token));
                     end if;
                  end;
               end loop;
               declare
                  A : constant Answer :=
                    Evaluate (Func, To_Array (LV), To_Array (RV), Two);
                  Text : constant String := S (C.Result);
               begin
                  if C.Error or else C.Undef then
                     AUnit.Assertions.Assert (A.Fault, Where);
                  elsif Func = "vecfreq" then
                     AUnit.Assertions.Assert
                       (not A.Fault and then Same_Freq (A.Items, Text),
                        Where);
                  elsif A.Is_Bool then
                     AUnit.Assertions.Assert
                       (not A.Fault
                          and then Text = (if A.Flag then "1" else "0"),
                        Where);
                  elsif A.Is_Number then
                     AUnit.Assertions.Assert
                       (not A.Fault and then A.Number = Parse_Big (Text),
                        Where);
                  else
                     AUnit.Assertions.Assert
                       (not A.Fault and then Same (A.Items, Text), Where);
                  end if;
               end;
            end if;
         end;
      end loop;
   end Check_Fixture;

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Vec");
   end Name;

   overriding procedure Register_Tests (T : in out Vec_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Check_Edges'Access, "vec edges");
      Register_Routine (T, Check_Fixture'Access, "vec.tsv");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;

end Compat_Vec;
