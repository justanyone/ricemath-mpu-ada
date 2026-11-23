with Ada.Assertions;
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
   use Math_Prime_Util;
   use Math_Prime_Util.Vec;
   use type I128;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);
   overriding function Name (T : Vec_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Vec"));

   function Image (V : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (V), Ada.Strings.Both));

   procedure Add (S : in out Unbounded_String; V : String) is
   begin
      if Length (S) > 0 then
         Append (S, " ");
      end if;
      Append (S, V);
   end Add;

   function Image (A : Integer_Array) return String is
      R : Unbounded_String;
   begin
      for V of A loop
         Add (R, Image (V));
      end loop;
      return To_String (R);
   end Image;

   function Image (V : Optional_Value) return String is
     (if V.Defined then Image (V.Value) else "undef");

   function Canonical (S : String) return String is
      R : Unbounded_String;
      First : Positive := S'First;
   begin
      for I in S'First .. S'Last + 1 loop
         if I > S'Last or else S (I) = ' ' then
            if First < I then
               declare
                  W : constant String := S (First .. I - 1);
               begin
                  if W (W'First) in '-' | '0' .. '9' then
                     Add (R, Image (I128'Value (W)));
                  else
                     Add (R, W);
                  end if;
               end;
            end if;
            First := I + 1;
         end if;
      end loop;
      return To_String (R);
   end Canonical;

   procedure Replay (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("vec");
      Checked, Skipped : Natural := 0;
   begin
      for C of Cases loop
         declare
            Func : constant String := To_String (C.Func);
            A, B : Integer_Array (1 .. Natural (C.Args.Length));
            NA, NB : Natural := 0;
            Right, Skip, Letters : Boolean := False;
            Actual : Unbounded_String;
            Expected : Unbounded_String;
         begin
            for Arg of C.Args loop
               declare
                  S : constant String := To_String (Arg);
                  V : I128;
               begin
                  if S = "|" then
                     Right := True;
                  else
                     if S'Length = 1 and then S (S'First) in 'a' .. 'z' then
                        V := I128 (Character'Pos (S (S'First)));
                        Letters := True;
                     else
                        begin
                           V := I128'Value (S);
                           --  Bigint_Input: the native API covers signed and
                           --  unsigned 64-bit values; larger rows await bigint.
                           if V < -I128 (U64'Last)
                             or else V > I128 (U64'Last)
                           then
                              Skip := True;
                           end if;
                        exception
                           when Constraint_Error =>
                              Skip := True;
                              V := 0;
                        end;
                     end if;
                     if Right then
                        NB := NB + 1;
                        B (NB) := V;
                     else
                        NA := NA + 1;
                        A (NA) := V;
                     end if;
                  end if;
               end;
            end loop;
            begin
               Expected := To_Unbounded_String
                 (Canonical (To_String (C.Result)));
            exception
               --  Bigint_Result: native product/sum results beyond I128.
               when Constraint_Error => Skip := True;
            end;
            if not Skip then
               declare
                  X : constant Integer_Array := A (1 .. NA);
                  Y : constant Integer_Array := B (1 .. NB);
                  F : Optional_Value;
                  Flag : Boolean;
               begin
                  begin
                     if Func = "vecsum" then
                        Actual := To_Unbounded_String
                          (Image (Vecsum (X)));
                     elsif Func = "vecprod" then
                        Actual := To_Unbounded_String
                          (Image (Vecprod (X)));
                     elsif Func = "vecmex" then
                        Actual := To_Unbounded_String
                          (Image (Vecmex (X)));
                     elsif Func = "vecpmex" then
                        Actual := To_Unbounded_String
                          (Image (Vecpmex (X)));
                     elsif Func = "setinsert_n" then
                        Actual := To_Unbounded_String
                          (Image (I128 (Setinsert (X, Y))));
                     elsif Func = "setremove_n" then
                        Actual := To_Unbounded_String
                          (Image (I128 (Setremove (X, Y))));
                     elsif Func = "setinvert_n" then
                        Actual := To_Unbounded_String
                          (Image (I128 (Setinvert (X, Y))));
                     elsif Func = "vecprefixsum" then
                        Actual := To_Unbounded_String
                          (Image (Vecprefixsum (X)));
                     elsif Func = "vecuniq" then
                        Actual := To_Unbounded_String
                          (Image (Vecuniq (X)));
                     elsif Func = "vecsingleton" then
                        Actual := To_Unbounded_String
                          (Image (Vecsingleton (X)));
                     elsif Func = "vecfreq" then
                        Actual := To_Unbounded_String
                          (Image (Vecfreq (X)));
                     elsif Func = "vecsort" then
                        Actual := To_Unbounded_String
                          (Image (Vecsort (X)));
                     elsif Func = "vecrsort" then
                        Actual := To_Unbounded_String
                          (Image (Vecrsort (X)));
                     elsif Func = "toset" then
                        Actual := To_Unbounded_String
                          (Image (Toset (X)));
                     elsif Func = "setunion" then
                        Actual := To_Unbounded_String
                          (Image (Setunion (X, Y)));
                     elsif Func = "setintersect" then
                        Actual := To_Unbounded_String
                          (Image (Setintersect (X, Y)));
                     elsif Func = "setminus" then
                        Actual := To_Unbounded_String
                          (Image (Setminus (X, Y)));
                     elsif Func = "setdelta" then
                        Actual := To_Unbounded_String
                          (Image (Setdelta (X, Y)));
                     elsif Func = "setinsert" then
                        Actual := To_Unbounded_String
                          (Image (Setunion (X, Y)));
                     elsif Func = "setinsert_set" then
                        Actual := To_Unbounded_String
                          (Image (Setunion (X, Y)));
                     elsif Func = "setremove" then
                        Actual := To_Unbounded_String
                          (Image (Setminus (X, Y)));
                     elsif Func = "setremove_set" then
                        Actual := To_Unbounded_String
                          (Image (Setminus (X, Y)));
                     elsif Func = "setinvert" then
                        Actual := To_Unbounded_String
                          (Image (Setdelta (X, Y)));
                     elsif Func = "setinvert_set" then
                        Actual := To_Unbounded_String
                          (Image (Setdelta (X, Y)));
                     elsif Func = "sumset" then
                        Actual := To_Unbounded_String
                          (Image ((if Right then Sumset (X, Y) else Sumset (X))));
                     elsif Func = "vecequal" then
                        Flag := Vecequal (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "setcontains" then
                        Flag := Setcontains (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "setcontainsany" then
                        Flag := Setcontainsany (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_disjoint" then
                        Flag := Set_is_disjoint (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_equal" then
                        Flag := Set_is_equal (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_subset" then
                        Flag := Set_is_subset (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_proper_subset" then
                        Flag := Set_is_proper_subset (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_superset" then
                        Flag := Set_is_superset (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_proper_superset" then
                        Flag := Set_is_proper_superset (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "set_is_proper_intersection" then
                        Flag := Set_is_proper_intersection (X, Y);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "is_sidon_set" then
                        Flag := Is_Sidon_Set (X);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "is_sumfree_set" then
                        Flag := Is_Sumfree_Set (X);
                        Actual := To_Unbounded_String
                          (if Flag then "1" else "0");
                     elsif Func = "vecmin" or else Func = "vecmax" then
                        F := (if Func = "vecmin" then Vecmin (X)
                              else Vecmax (X));
                        Actual := To_Unbounded_String (Image (F));
                     elsif Func = "vecsorti" or else Func = "vecrsorti" then
                        if Func = "vecsorti" then
                           Vecsorti (A (1 .. NA));
                        else
                           Vecrsorti (A (1 .. NA));
                        end if;
                        Actual := To_Unbounded_String (Image (A (1 .. NA)));
                     elsif Func = "vecextract" or Func = "vecextract_idx" then
                        declare
                           Values : Optional_Array (1 .. NA + NB);
                           N : Natural := 0;
                        begin
                           if Func = "vecextract" then
                              if Y (1) < 0 then
                                 raise Constraint_Error;
                              end if;
                              for V of Vecextract (X, U128 (Y (1))) loop
                                 N := N + 1;
                                 Values (N) := (True, V);
                              end loop;
                           else
                              for V of Vecextract (X, Y) loop
                                 N := N + 1;
                                 Values (N) := V;
                              end loop;
                           end if;
                           for V of Values (1 .. N) loop
                              if Letters and then V.Defined then
                                 Add (Actual, [Character'Val (V.Value)]);
                              else
                                 Add (Actual, Image (V));
                              end if;
                           end loop;
                        end;
                     else
                        AUnit.Assertions.Assert (False, "unhandled " & Func);
                     end if;
                  exception
                     when Constraint_Error | Ada.Assertions.Assertion_Error =>
                        Actual := To_Unbounded_String ("ERROR");
                  end;
                  AUnit.Assertions.Assert
                    (Actual = Expected,
                     Func & " row" & Positive'Image (C.Line_Number)
                     & " expected [" & To_String (Expected) & "] got ["
                     & To_String (Actual) & "]");
               end;
               Checked := Checked + 1;
            else
               Skipped := Skipped + 1;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Checked > 8_000, "fixture replay coverage");
      AUnit.Assertions.Assert (Skipped < 1_500, "unexpected native skips");
   end Replay;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine (T, Replay'Access, "vec.tsv");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      R : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      R.Add_Test (new Vec_Case);
      return R;
   end Suite;
end Compat_Vec;
