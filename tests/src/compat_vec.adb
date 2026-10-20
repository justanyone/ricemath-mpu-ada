with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Vec;

package body Compat_Vec is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util.Vec;

   type Vec_Case is new Test_Case with null record;
   overriding function Name (T : Vec_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Vec_Case);

   overriding function Name (T : Vec_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Vec");
   end Name;

   function Image (A : Vector) return String is
      R : Unbounded_String;
   begin
      for V of A loop
         if Length (R) > 0 then
            Append (R, " ");
         end if;
         Append (R, Ada.Strings.Fixed.Trim
           (I64'Image (V), Ada.Strings.Both));
      end loop;
      return To_String (R);
   end Image;

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("vec"), Func);
      Checked : Natural := 0;
   begin
      for C of Cases loop
         declare
            A, B : Vector (1 .. Natural (C.Args.Length));
            NA, NB : Natural := 0;
            Second : Boolean := False;
            Native : Boolean := True;
            V : I64;
            Actual : Unbounded_String;
            Flag : Boolean := False;
         begin
            for Arg of C.Args loop
               if Arg = "|" then
                  Second := True;
               else
                  begin
                     V := I64'Value (To_String (Arg));
                     if Second then
                        NB := NB + 1;
                        B (NB) := V;
                     else
                        NA := NA + 1;
                        A (NA) := V;
                     end if;
                  exception
                     when Constraint_Error => Native := False;
                  end;
               end if;
            end loop;
            --  Native_I64_Only: bigint rows require the future bigint tier.
            if Native then
               declare
                  X : constant Vector := A (1 .. NA);
                  Y : constant Vector := B (1 .. NB);
                  SX : constant Vector := Toset (X);
                  SY : constant Vector := Toset (Y);
               begin
                  if Func = "vecsort" then
                     Actual := To_Unbounded_String
                       (Image (Vecsort (X)));
                  elsif Func = "vecrsort" then
                     Actual := To_Unbounded_String
                       (Image (Vecrsort (X)));
                  elsif Func = "vecsorti" then
                     Actual := To_Unbounded_String
                       (Image (Vecsorti (X)));
                  elsif Func = "vecrsorti" then
                     Actual := To_Unbounded_String
                       (Image (Vecrsorti (X)));
                  elsif Func = "toset" then
                     Actual := To_Unbounded_String
                       (Image (Toset (X)));
                  elsif Func = "vecuniq" then
                     Actual := To_Unbounded_String
                       (Image (Vecuniq (X)));
                  elsif Func = "vecsingleton" then
                     Actual := To_Unbounded_String
                       (Image (Vecsingleton (X)));
                  elsif Func = "setunion" then
                     Actual := To_Unbounded_String
                       (Image (Setunion (SX, SY)));
                  elsif Func = "setintersect" then
                     Actual := To_Unbounded_String
                       (Image (Setintersect (SX, SY)));
                  elsif Func = "setminus" then
                     Actual := To_Unbounded_String
                       (Image (Setminus (SX, SY)));
                  elsif Func = "setdelta" then
                     Actual := To_Unbounded_String
                       (Image (Setdelta (SX, SY)));
                  elsif Func = "setinsert" then
                     Actual := To_Unbounded_String
                       (Image (Setinsert (SX, SY)));
                  elsif Func = "setremove" then
                     Actual := To_Unbounded_String
                       (Image (Setremove (SX, SY)));
                  elsif Func = "setinvert" then
                     Actual := To_Unbounded_String
                       (Image (Setinvert (SX, SY)));
                  elsif Func = "vecmex" or Func = "vecpmex" then
                     V := (if Func = "vecmex" then Vecmex (X)
                           else Vecpmex (X));
                     Actual := To_Unbounded_String (Ada.Strings.Fixed.Trim
                       (I64'Image (V), Ada.Strings.Both));
                  else
                     if Func = "vecequal" then
                        Flag := Vecequal (X, Y);
                     elsif Func = "setcontains" then
                        Flag := Setcontains (SX, SY);
                     elsif Func = "setcontainsany" then
                        Flag := Setcontainsany (SX, SY);
                     elsif Func = "set_is_disjoint" then
                        Flag := Set_Is_Disjoint (SX, SY);
                     elsif Func = "set_is_equal" then
                        Flag := Set_Is_Equal (SX, SY);
                     elsif Func = "set_is_subset" then
                        Flag := Set_Is_Subset (SX, SY);
                     elsif Func = "set_is_proper_subset" then
                        Flag := Set_Is_Proper_Subset (SX, SY);
                     elsif Func = "set_is_superset" then
                        Flag := Set_Is_Superset (SX, SY);
                     elsif Func = "set_is_proper_superset" then
                        Flag := Set_Is_Proper_Superset (SX, SY);
                     elsif Func = "set_is_proper_intersection" then
                        Flag := Set_Is_Proper_Intersection (SX, SY);
                     elsif Func = "is_sidon_set" then
                        Flag := Is_Sidon_Set (SX);
                     elsif Func = "is_sumfree_set" then
                        Flag := Is_Sumfree_Set (SX);
                     end if;
                     Actual := To_Unbounded_String
                       (if Flag then "1" else "0");
                  end if;
                  AUnit.Assertions.Assert
                    (Actual = C.Result, Func &
                     Positive'Image (C.Line_Number) & ": " &
                     To_String (Actual) & " /= " & To_String (C.Result));
                  Checked := Checked + 1;
               end;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Checked > 0, Func & " no native rows");
   end Replay;

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

   procedure Test_Toset (T : in out Test_Case'Class) is
   begin
      Replay ("toset");
   end Test_Toset;

   procedure Test_Vecuniq (T : in out Test_Case'Class) is
   begin
      Replay ("vecuniq");
   end Test_Vecuniq;

   procedure Test_Vecsingleton (T : in out Test_Case'Class) is
   begin
      Replay ("vecsingleton");
   end Test_Vecsingleton;

   procedure Test_Vecmex (T : in out Test_Case'Class) is
   begin
      Replay ("vecmex");
   end Test_Vecmex;

   procedure Test_Vecpmex (T : in out Test_Case'Class) is
   begin
      Replay ("vecpmex");
   end Test_Vecpmex;

   procedure Test_Vecequal (T : in out Test_Case'Class) is
   begin
      Replay ("vecequal");
   end Test_Vecequal;

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
   end Test_Setinsert;

   procedure Test_Setremove (T : in out Test_Case'Class) is
   begin
      Replay ("setremove");
   end Test_Setremove;

   procedure Test_Setinvert (T : in out Test_Case'Class) is
   begin
      Replay ("setinvert");
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

   procedure Test_Is_Sidon_Set (T : in out Test_Case'Class) is
   begin
      Replay ("is_sidon_set");
   end Test_Is_Sidon_Set;

   procedure Test_Is_Sumfree_Set (T : in out Test_Case'Class) is
   begin
      Replay ("is_sumfree_set");
   end Test_Is_Sumfree_Set;

   overriding procedure Register_Tests (T : in out Vec_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Vecsort'Access, "vecsort");
      Registration.Register_Routine
        (T, Test_Vecrsort'Access, "vecrsort");
      Registration.Register_Routine
        (T, Test_Vecsorti'Access, "vecsorti");
      Registration.Register_Routine
        (T, Test_Vecrsorti'Access, "vecrsorti");
      Registration.Register_Routine
        (T, Test_Toset'Access, "toset");
      Registration.Register_Routine
        (T, Test_Vecuniq'Access, "vecuniq");
      Registration.Register_Routine
        (T, Test_Vecsingleton'Access, "vecsingleton");
      Registration.Register_Routine
        (T, Test_Vecmex'Access, "vecmex");
      Registration.Register_Routine
        (T, Test_Vecpmex'Access, "vecpmex");
      Registration.Register_Routine
        (T, Test_Vecequal'Access, "vecequal");
      Registration.Register_Routine
        (T, Test_Setunion'Access, "setunion");
      Registration.Register_Routine
        (T, Test_Setintersect'Access, "setintersect");
      Registration.Register_Routine
        (T, Test_Setminus'Access, "setminus");
      Registration.Register_Routine
        (T, Test_Setdelta'Access, "setdelta");
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
        (T, Test_Set_Is_Proper_Superset'Access, "set_is_proper_superset");
      Registration.Register_Routine
        (T, Test_Set_Is_Proper_Intersection'Access, "set_is_proper_intersection");
      Registration.Register_Routine
        (T, Test_Is_Sidon_Set'Access, "is_sidon_set");
      Registration.Register_Routine
        (T, Test_Is_Sumfree_Set'Access, "is_sumfree_set");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Vec_Case);
      return Result;
   end Suite;
end Compat_Vec;
