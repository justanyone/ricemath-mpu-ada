with Ada.Containers.Ordered_Maps;
with Ada.Containers.Ordered_Sets;

package body Math_Prime_Util.Vec is
   package Int_Sets is new Ada.Containers.Ordered_Sets
     (Element_Type => Big_Integer);
   package Count_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type => Big_Integer, Element_Type => Natural);
   package Vec_Sort is new Int_Vectors.Generic_Sorting;

   function Len (Items : Int_Vector) return Natural is
     (Natural (Items.Length));

   function As_Set (Items : Int_Vector) return Int_Sets.Set is
      S : Int_Sets.Set;
   begin
      for V of Items loop
         S.Include (V);
      end loop;
      return S;
   end As_Set;

   function From_Set (S : Int_Sets.Set) return Int_Vector is
      R : Int_Vector;
   begin
      for V of S loop
         R.Append (V);
      end loop;
      return R;
   end From_Set;

   function Resolve (Index : Big_Integer; Length : Natural)
      return Integer
   is
      Limit : constant Big_Integer := To_Big_Integer (Length);
      Adjusted : Big_Integer;
   begin
      if Index >= 0 then
         Adjusted := Index;
      else
         Adjusted := Index + Limit;
      end if;
      if Adjusted < 0 or else Adjusted >= Limit then
         return -1;
      end if;
      return To_Integer (Adjusted);
   end Resolve;

   function Vecsum (Items : Int_Vector) return Big_Integer is
      Sum : Big_Integer := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
      end loop;
      return Sum;
   end Vecsum;

   function Vecprod (Items : Int_Vector) return Big_Integer is
      Prod : Big_Integer := 1;
   begin
      for V of Items loop
         Prod := Prod * V;
      end loop;
      return Prod;
   end Vecprod;

   function Vecmin (Items : Int_Vector) return Optional_Big is
      Best : Big_Integer;
      Any : Boolean := False;
   begin
      for V of Items loop
         if not Any or else V < Best then
            Best := V;
            Any := True;
         end if;
      end loop;
      if Any then
         return (Defined => True, Value => Best);
      end if;
      return (Defined => False, Value => 0);
   end Vecmin;

   function Vecmax (Items : Int_Vector) return Optional_Big is
      Best : Big_Integer;
      Any : Boolean := False;
   begin
      for V of Items loop
         if not Any or else V > Best then
            Best := V;
            Any := True;
         end if;
      end loop;
      if Any then
         return (Defined => True, Value => Best);
      end if;
      return (Defined => False, Value => 0);
   end Vecmax;

   function Vecprefixsum (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector;
      Sum : Big_Integer := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
         Result.Append (Sum);
      end loop;
      return Result;
   end Vecprefixsum;

   function Vecuniq (Items : Int_Vector) return Int_Vector is
      Seen : Int_Sets.Set;
      Result : Int_Vector;
   begin
      for V of Items loop
         if not Seen.Contains (V) then
            Seen.Insert (V);
            Result.Append (V);
         end if;
      end loop;
      return Result;
   end Vecuniq;

   function Vecsingleton (Items : Int_Vector) return Int_Vector is
      Counts : Count_Maps.Map;
      Result : Int_Vector;
   begin
      for V of Items loop
         if Counts.Contains (V) then
            Counts (V) := Counts (V) + 1;
         else
            Counts.Insert (V, 1);
         end if;
      end loop;
      for V of Items loop
         if Counts (V) = 1 then
            Result.Append (V);
         end if;
      end loop;
      return Result;
   end Vecsingleton;

   function Vecfreq (Items : Int_Vector) return Int_Vector is
      Counts : Count_Maps.Map;
      Result : Int_Vector;
   begin
      for V of Items loop
         if Counts.Contains (V) then
            Counts (V) := Counts (V) + 1;
         else
            Counts.Insert (V, 1);
         end if;
      end loop;
      for C in Counts.Iterate loop
         Result.Append (Count_Maps.Key (C));
         Result.Append (To_Big_Integer (Count_Maps.Element (C)));
      end loop;
      return Result;
   end Vecfreq;

   procedure Vecsorti (Items : in out Int_Vector) is
   begin
      Vec_Sort.Sort (Items);
   end Vecsorti;

   procedure Vecrsorti (Items : in out Int_Vector) is
   begin
      Vec_Sort.Sort (Items);
      Int_Vectors.Reverse_Elements (Items);
   end Vecrsorti;

   function Vecsort (Items : Int_Vector) return Int_Vector is
      Copy : Int_Vector := Items;
   begin
      Vecsorti (Copy);
      return Copy;
   end Vecsort;

   function Vecrsort (Items : Int_Vector) return Int_Vector is
      Copy : Int_Vector := Items;
   begin
      Vecrsorti (Copy);
      return Copy;
   end Vecrsort;

   function Mex (Items : Int_Vector; Positive_Only : Boolean)
      return Big_Integer
   is
      N : constant Big_Integer := To_Big_Integer (Len (Items));
      Origin : constant Big_Integer :=
        (if Positive_Only then To_Big_Integer (1) else To_Big_Integer (0));
      Seen : Int_Sets.Set;
      Cursor : Big_Integer;
   begin
      for V of Items loop
         if Positive_Only then
            if V <= 0 then
               raise Constraint_Error with "vecpmex non-positive";
            end if;
         elsif V < 0 then
            raise Constraint_Error with "vecmex negative";
         end if;
         if V >= Origin and then V < Origin + N then
            Seen.Include (V);
         end if;
      end loop;
      Cursor := Origin;
      while Cursor < Origin + N loop
         if not Seen.Contains (Cursor) then
            return Cursor;
         end if;
         Cursor := Cursor + 1;
      end loop;
      return Origin + N;
   end Mex;

   function Vecmex (Items : Int_Vector) return Big_Integer is
     (Mex (Items, Positive_Only => False));

   function Vecpmex (Items : Int_Vector) return Big_Integer is
     (Mex (Items, Positive_Only => True));

   function Toset (Items : Int_Vector) return Int_Vector is
     (From_Set (As_Set (Items)));

   function Is_Sidon_Set (Items : Int_Vector) return Boolean is
      S : constant Int_Vector := Toset (Items);
      Sums : Int_Sets.Set;
      Total : Big_Integer;
   begin
      for V of S loop
         if V < 0 then
            return False;
         end if;
      end loop;
      if S.Is_Empty then
         return True;
      end if;
      for I in S.First_Index .. S.Last_Index loop
         for J in I .. S.Last_Index loop
            Total := S (I) + S (J);
            if Sums.Contains (Total) then
               return False;
            end if;
            Sums.Insert (Total);
         end loop;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (Items : Int_Vector) return Boolean is
      S : constant Int_Vector := Toset (Items);
      Members : constant Int_Sets.Set := As_Set (S);
   begin
      if S.Is_Empty then
         return True;
      end if;
      for I in S.First_Index .. S.Last_Index loop
         for J in I .. S.Last_Index loop
            if Members.Contains (S (I) + S (J)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Sumset (Left, Right : Int_Vector) return Int_Vector is
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

   function Sumset (Items : Int_Vector) return Int_Vector is
     (Sumset (Items, Items));

   function Vecequal (Left, Right : Int_Vector) return Boolean is
   begin
      if Left.Length /= Right.Length then
         return False;
      end if;
      for I in Left.First_Index .. Left.Last_Index loop
         if Left (I) /= Right (I) then
            return False;
         end if;
      end loop;
      return True;
   end Vecequal;

   function Vecextract (Items : Int_Vector; Mask : Big_Integer)
      return Int_Vector
   is
      Result : Int_Vector;
      Bit : Big_Integer := Mask;
      Index : Natural := 0;
   begin
      if Mask < 0 then
         raise Constraint_Error with "vecextract negative mask";
      end if;
      while Bit > 0 loop
         if Bit mod 2 = 1 then
            if Index >= Len (Items) then
               raise Undefined_Element;
            end if;
            Result.Append (Items (Index + 1));
         end if;
         Bit := Bit / 2;
         Index := Index + 1;
      end loop;
      return Result;
   end Vecextract;

   function Vecextract (Items, Indexes : Int_Vector) return Int_Vector is
      Result : Int_Vector;
      N : constant Natural := Len (Items);
      Resolved : Integer;
   begin
      for Index of Indexes loop
         Resolved := Resolve (Index, N);
         if Resolved < 0 then
            raise Undefined_Element;
         end if;
         Result.Append (Items (Resolved + 1));
      end loop;
      return Result;
   end Vecextract;

   function Setunion (Left, Right : Int_Vector) return Int_Vector is
      S : Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         S.Include (V);
      end loop;
      return From_Set (S);
   end Setunion;

   function Setintersect (Left, Right : Int_Vector) return Int_Vector is
      L : constant Int_Sets.Set := As_Set (Left);
      S : Int_Sets.Set;
   begin
      for V of Right loop
         if L.Contains (V) then
            S.Include (V);
         end if;
      end loop;
      return From_Set (S);
   end Setintersect;

   function Setminus (Left, Right : Int_Vector) return Int_Vector is
      S : Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         S.Exclude (V);
      end loop;
      return From_Set (S);
   end Setminus;

   function Setdelta (Left, Right : Int_Vector) return Int_Vector is
      L : constant Int_Sets.Set := As_Set (Left);
      R : constant Int_Sets.Set := As_Set (Right);
      S : Int_Sets.Set;
   begin
      for V of L loop
         if not R.Contains (V) then
            S.Insert (V);
         end if;
      end loop;
      for V of R loop
         if not L.Contains (V) then
            S.Insert (V);
         end if;
      end loop;
      return From_Set (S);
   end Setdelta;

   function Set_Is_Disjoint (Left, Right : Int_Vector) return Boolean is
      L : constant Int_Sets.Set := As_Set (Left);
   begin
      if Left.Is_Empty or else Right.Is_Empty then
         return True;
      end if;
      for V of Right loop
         if L.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Disjoint;

   function Set_Is_Equal (Left, Right : Int_Vector) return Boolean is
     (Left.Length = Right.Length and then As_Set (Left) = As_Set (Right));

   function Set_Is_Subset (Left, Right : Int_Vector) return Boolean is
      L : constant Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         if not L.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Subset;

   function Set_Is_Proper_Subset (Left, Right : Int_Vector)
      return Boolean is
     (Left.Length > Right.Length
        and then Set_Is_Subset (Left, Right));

   function Set_Is_Superset (Left, Right : Int_Vector) return Boolean is
     (Set_Is_Subset (Right, Left));

   function Set_Is_Proper_Superset (Left, Right : Int_Vector)
      return Boolean is
     (Set_Is_Proper_Subset (Right, Left));

   function Set_Is_Proper_Intersection (Left, Right : Int_Vector)
      return Boolean
   is
      L : constant Int_Sets.Set := As_Set (Left);
      R : constant Int_Sets.Set := As_Set (Right);
      Inter : Natural := 0;
      Min_Size : Natural;
   begin
      for V of L loop
         if R.Contains (V) then
            Inter := Inter + 1;
         end if;
      end loop;
      if Len (Left) < Len (Right) then
         Min_Size := Len (Left);
      else
         Min_Size := Len (Right);
      end if;
      return Inter > 0 and then Inter < Min_Size;
   end Set_Is_Proper_Intersection;

   function Setcontains (Items, Values : Int_Vector) return Boolean is
      S : constant Int_Sets.Set := As_Set (Items);
   begin
      for V of Values loop
         if not S.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Setcontains;

   function Setcontainsany (Items, Values : Int_Vector) return Boolean is
      S : constant Int_Sets.Set := As_Set (Items);
   begin
      if Items.Is_Empty or else Values.Is_Empty then
         return False;
      end if;
      for V of Values loop
         if S.Contains (V) then
            return True;
         end if;
      end loop;
      return False;
   end Setcontainsany;

   function Setinsert (Items : in out Int_Vector; Values : Int_Vector)
      return Integer
   is
      Before : constant Integer := Len (Items);
   begin
      Items := Setunion (Items, Values);
      return Len (Items) - Before;
   end Setinsert;

   function Setremove (Items : in out Int_Vector; Values : Int_Vector)
      return Integer
   is
      Before : constant Integer := Len (Items);
   begin
      Items := Setminus (Items, Values);
      return Before - Len (Items);
   end Setremove;

   function Setinvert (Items : in out Int_Vector; Values : Int_Vector)
      return Integer
   is
      Before : constant Integer := Len (Items);
   begin
      Items := Setdelta (Items, Values);
      return Len (Items) - Before;
   end Setinvert;
end Math_Prime_Util.Vec;
