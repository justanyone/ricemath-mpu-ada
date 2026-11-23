with Ada.Containers.Ordered_Maps;
with Ada.Containers.Ordered_Sets;

package body Math_Prime_Util.Vec with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;

   package Int_Sets is new Ada.Containers.Ordered_Sets (Big_Integer);
   package Counts is new Ada.Containers.Ordered_Maps
     (Key_Type => Big_Integer, Element_Type => Big_Integer);
   package Sorting is new Int_Vectors.Generic_Sorting;

   function As_Set (Items : Int_List) return Int_Sets.Set is
      S : Int_Sets.Set;
   begin
      for V of Items loop
         S.Include (V);
      end loop;
      return S;
   end As_Set;

   function From_Set (S : Int_Sets.Set) return Int_List is
      R : Int_List;
   begin
      for V of S loop
         R.Append (V);
      end loop;
      return R;
   end From_Set;

   function Seen_Sum
     (Sums : in out Int_Sets.Set; Value : Big_Integer) return Boolean
   is
   begin
      if Sums.Contains (Value) then
         return False;
      end if;
      Sums.Include (Value);
      return True;
   end Seen_Sum;

   function Vecsum (Items : Int_List) return Big_Integer is
      Sum : Big_Integer := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
      end loop;
      return Sum;
   end Vecsum;

   function Vecprod (Items : Int_List) return Big_Integer is
      Prod : Big_Integer := 1;
   begin
      for V of Items loop
         Prod := Prod * V;
      end loop;
      return Prod;
   end Vecprod;

   function Vecmin (Items : Int_List) return Value_Result is
      Best : Big_Integer := 0;
      First : Boolean := True;
   begin
      if Items.Is_Empty then
         return (Defined => False, Value => 0);
      end if;
      for V of Items loop
         if First or else V < Best then
            Best := V;
            First := False;
         end if;
      end loop;
      return (Defined => True, Value => Best);
   end Vecmin;

   function Vecmax (Items : Int_List) return Value_Result is
      Best : Big_Integer := 0;
      First : Boolean := True;
   begin
      if Items.Is_Empty then
         return (Defined => False, Value => 0);
      end if;
      for V of Items loop
         if First or else V > Best then
            Best := V;
            First := False;
         end if;
      end loop;
      return (Defined => True, Value => Best);
   end Vecmax;

   function Vecprefixsum (Items : Int_List) return Int_List is
      Sum : Big_Integer := 0;
      R : Int_List;
   begin
      for V of Items loop
         Sum := Sum + V;
         R.Append (Sum);
      end loop;
      return R;
   end Vecprefixsum;

   function Vecuniq (Items : Int_List) return Int_List is
      Seen : Int_Sets.Set;
      R : Int_List;
   begin
      for V of Items loop
         if not Seen.Contains (V) then
            Seen.Include (V);
            R.Append (V);
         end if;
      end loop;
      return R;
   end Vecuniq;

   function Vecsingleton (Items : Int_List) return Int_List is
      M : Counts.Map;
      R : Int_List;
   begin
      for V of Items loop
         if M.Contains (V) then
            M.Replace (V, M (V) + 1);
         else
            M.Insert (V, 1);
         end if;
      end loop;
      for V of Items loop
         if M (V) = 1 then
            R.Append (V);
         end if;
      end loop;
      return R;
   end Vecsingleton;

   function Vecfreq (Items : Int_List) return Int_List is
      M : Counts.Map;
      R : Int_List;
   begin
      for V of Items loop
         if M.Contains (V) then
            M.Replace (V, M (V) + 1);
         else
            M.Insert (V, 1);
         end if;
      end loop;
      for C in M.Iterate loop
         R.Append (Counts.Key (C));
         R.Append (Counts.Element (C));
      end loop;
      return R;
   end Vecfreq;

   function Vecsorti (Items : Int_List) return Int_List is
      R : Int_List := Items.Copy;
   begin
      Sorting.Sort (R);
      return R;
   end Vecsorti;

   function Vecsort (Items : Int_List) return Int_List is
     (Vecsorti (Items));

   function Vecrsorti (Items : Int_List) return Int_List is
      Sorted : constant Int_List := Vecsort (Items);
      R : Int_List;
   begin
      for I in reverse 1 .. Sorted.Last_Index loop
         R.Append (Sorted (I));
      end loop;
      return R;
   end Vecrsorti;

   function Vecrsort (Items : Int_List) return Int_List is
     (Vecrsorti (Items));

   function Vecmex (Items : Int_List) return Big_Integer is
      Len : constant Natural := Natural (Items.Length);
      Seen : array (0 .. Len) of Boolean := [others => False];
      I : Natural := 0;
   begin
      for V of Items loop
         if V < 0 then
            raise Constraint_Error with "vecmex negative";
         end if;
         if V < To_Big_Integer (Len) then
            Seen (To_Integer (V)) := True;
         end if;
      end loop;
      while I < Len loop
         if not Seen (I) then
            return To_Big_Integer (I);
         end if;
         I := I + 1;
      end loop;
      return To_Big_Integer (Len);
   end Vecmex;

   function Vecpmex (Items : Int_List) return Big_Integer is
      Len : constant Natural := Natural (Items.Length);
      Seen : array (1 .. Len + 1) of Boolean := [others => False];
   begin
      for V of Items loop
         if V < 1 then
            raise Constraint_Error with "vecpmex non-positive";
         end if;
         if V <= To_Big_Integer (Len) then
            Seen (To_Integer (V)) := True;
         end if;
      end loop;
      for I in 1 .. Len loop
         if not Seen (I) then
            return To_Big_Integer (I);
         end if;
      end loop;
      return To_Big_Integer (Len + 1);
   end Vecpmex;

   function Vecextract
     (Items : Int_List; Mask : Big_Integer) return List_Result
   is
      M : Big_Integer := Mask;
      Len : constant Natural := Natural (Items.Length);
      I : Natural := 0;
      Out : Int_List;
   begin
      if Mask < 0 then
         raise Constraint_Error with "vecextract negative mask";
      end if;
      while M /= 0 loop
         if M mod 2 /= 0 then
            if I >= Len then
               if Out.Is_Empty then
                  return (Defined => False, Items => Int_Vectors.Empty_Vector);
               end if;
            else
               Out.Append (Items (I + 1));
            end if;
         end if;
         M := M / 2;
         I := I + 1;
      end loop;
      return (Defined => True, Items => Out);
   end Vecextract;

   function Vecextract
     (Items : Int_List; Indexes : Int_List) return List_Result
   is
      Len : constant Big_Integer := To_Big_Integer (Natural (Items.Length));
      Out : Int_List;
      J : Big_Integer;
   begin
      if Indexes.Is_Empty then
         return (Defined => True, Items => Out);
      end if;
      for Ix of Indexes loop
         J := Ix;
         if J < 0 then
            J := Len + J;
         end if;
         if J < 0 or else J >= Len then
            if Out.Is_Empty then
               return (Defined => False, Items => Int_Vectors.Empty_Vector);
            end if;
         else
            Out.Append (Items (To_Integer (J) + 1));
         end if;
      end loop;
      return (Defined => True, Items => Out);
   end Vecextract;

   function Vecequal (Left, Right : Int_List) return Boolean is
     (Left = Right);

   function Toset (Items : Int_List) return Int_List is
     (From_Set (As_Set (Items)));

   function Is_Sidon_Set (Items : Int_List) return Boolean is
      S : Int_List := Toset (Items);
      Sums : Int_Sets.Set;
      X : Big_Integer;
   begin
      while not S.Is_Empty loop
         X := S.Last_Element;
         S.Delete_Last;
         if X < 0 then
            return False;
         end if;
         if not Seen_Sum (Sums, X + X) then
            return False;
         end if;
         for Y of S loop
            if not Seen_Sum (Sums, X + Y) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (Items : Int_List) return Boolean is
      S : Int_List := Toset (Items);
      In_Set : constant Int_Sets.Set := As_Set (S);
      X : Big_Integer;
   begin
      while not S.Is_Empty loop
         X := S.Last_Element;
         S.Delete_Last;
         if In_Set.Contains (X + X) then
            return False;
         end if;
         for Y of S loop
            if In_Set.Contains (X + Y) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Sumset (Left, Right : Int_List) return Int_List is
      Sums : Int_Sets.Set;
   begin
      if Left.Is_Empty or else Right.Is_Empty then
         return Int_Vectors.Empty_Vector;
      end if;
      for X of Left loop
         for Y of Right loop
            Sums.Include (X + Y);
         end loop;
      end loop;
      return From_Set (Sums);
   end Sumset;

   function Sumset (Left : Int_List) return Int_List is
     (Sumset (Left, Left));

   function Setunion (Left, Right : Int_List) return Int_List is
     (Toset (Left & Right));

   function Setintersect (Left, Right : Int_List) return Int_List is
      In_Left : constant Int_Sets.Set := As_Set (Left);
      Acc : Int_List;
   begin
      for V of Right loop
         if In_Left.Contains (V) then
            Acc.Append (V);
         end if;
      end loop;
      return Toset (Acc);
   end Setintersect;

   function Setminus (Left, Right : Int_List) return Int_List is
      In_Right : constant Int_Sets.Set := As_Set (Right);
      Acc : Int_List;
   begin
      for V of Left loop
         if not In_Right.Contains (V) then
            Acc.Append (V);
         end if;
      end loop;
      return Toset (Acc);
   end Setminus;

   function Setdelta (Left, Right : Int_List) return Int_List is
      In_Left : constant Int_Sets.Set := As_Set (Left);
      In_Right : constant Int_Sets.Set := As_Set (Right);
      Acc : Int_List;
   begin
      for V of Left loop
         if not In_Right.Contains (V) then
            Acc.Append (V);
         end if;
      end loop;
      for V of Right loop
         if not In_Left.Contains (V) then
            Acc.Append (V);
         end if;
      end loop;
      return Toset (Acc);
   end Setdelta;

   function Setcontains (Set, Values : Int_List) return Boolean is
      Members : constant Int_Sets.Set := As_Set (Set);
   begin
      for V of Values loop
         if not Members.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Setcontains;

   function Setcontainsany (Set, Values : Int_List) return Boolean is
      Members : constant Int_Sets.Set := As_Set (Set);
   begin
      if Set.Is_Empty or else Values.Is_Empty then
         return False;
      end if;
      for V of Values loop
         if Members.Contains (V) then
            return True;
         end if;
      end loop;
      return False;
   end Setcontainsany;

   function Set_Is_Disjoint (Left, Right : Int_List) return Boolean is
     (Left.Is_Empty or else Right.Is_Empty
      or else not Setcontainsany (Left, Right));

   function Set_Is_Equal (Left, Right : Int_List) return Boolean is
     (Left.Length = Right.Length
      and then Setcontains (Left, Right)
      and then Setcontains (Right, Left));

   function Set_Is_Subset (Left, Right : Int_List) return Boolean is
     (Right.Is_Empty
      or else (Left.Length >= Right.Length and then Setcontains (Left, Right)));

   function Set_Is_Proper_Subset (Left, Right : Int_List) return Boolean is
     (Left.Length > Right.Length and then Set_Is_Subset (Left, Right));

   function Set_Is_Superset (Left, Right : Int_List) return Boolean is
     (Set_Is_Subset (Right, Left));

   function Set_Is_Proper_Superset (Left, Right : Int_List) return Boolean is
     (Set_Is_Proper_Subset (Right, Left));

   function Set_Is_Proper_Intersection
     (Left, Right : Int_List) return Boolean
   is
      Members : constant Int_Sets.Set := As_Set (Left);
      Inter : Natural := 0;
      Min_Len : constant Natural :=
        (if Left.Length < Right.Length
         then Natural (Left.Length) else Natural (Right.Length));
   begin
      for V of Right loop
         if Members.Contains (V) then
            Inter := Inter + 1;
         end if;
      end loop;
      return Inter > 0 and then Inter < Min_Len;
   end Set_Is_Proper_Intersection;

   function Setinsert (Set, Values : Int_List) return Set_Change is
      Merged : constant Int_List := Setunion (Set, Values);
   begin
      return
        (Items => Merged,
         Count => Integer (Merged.Length) - Integer (Set.Length));
   end Setinsert;

   function Setremove (Set, Values : Int_List) return Set_Change is
      Rest : constant Int_List := Setminus (Set, Values);
   begin
      return
        (Items => Rest,
         Count => Integer (Set.Length) - Integer (Rest.Length));
   end Setremove;

   function Setinvert (Set, Values : Int_List) return Set_Change is
      Next : constant Int_List := Setdelta (Set, Values);
   begin
      return
        (Items => Next,
         Count => Integer (Next.Length) - Integer (Set.Length));
   end Setinvert;
end Math_Prime_Util.Vec;
