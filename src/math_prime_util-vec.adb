with Ada.Containers;
with Ada.Containers.Generic_Array_Sort;
with Ada.Containers.Ordered_Maps;
with Ada.Containers.Ordered_Sets;

package body Math_Prime_Util.Vec is
   package Int_Sets is new Ada.Containers.Ordered_Sets
     (Element_Type => Big_Integer);
   use type Int_Sets.Set;
   package Count_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type => Big_Integer, Element_Type => Natural);

   procedure Array_Sort is new Ada.Containers.Generic_Array_Sort
     (Index_Type => Positive,
      Element_Type => Big_Integer,
      Array_Type => Int_Array);

   function None return Int_Array is
      Empty : Int_Array (1 .. 0);
   begin
      return Empty;
   end None;

   function As_Set (Items : Int_Array) return Int_Sets.Set is
      S : Int_Sets.Set;
   begin
      for V of Items loop
         S.Include (V);
      end loop;
      return S;
   end As_Set;

   function From_Set (S : Int_Sets.Set) return Int_Array is
      R : Int_Array (1 .. Natural (S.Length));
      I : Natural := 0;
   begin
      for V of S loop
         I := I + 1;
         R (I) := V;
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

   function Vecsum (Items : Int_Array) return Big_Integer is
      Sum : Big_Integer := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
      end loop;
      return Sum;
   end Vecsum;

   function Vecprod (Items : Int_Array) return Big_Integer is
      Prod : Big_Integer := 1;
   begin
      for V of Items loop
         Prod := Prod * V;
      end loop;
      return Prod;
   end Vecprod;

   function Vecmin (Items : Int_Array) return Optional_Big is
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

   function Vecmax (Items : Int_Array) return Optional_Big is
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

   function Vecprefixsum (Items : Int_Array) return Int_Array is
      Result : Int_Array (1 .. Items'Length);
      Sum : Big_Integer := 0;
      I : Natural := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
         I := I + 1;
         Result (I) := Sum;
      end loop;
      return Result;
   end Vecprefixsum;

   function Vecuniq (Items : Int_Array) return Int_Array is
      Seen : Int_Sets.Set;
      Tmp : Int_Array (1 .. Items'Length);
      N : Natural := 0;
   begin
      for V of Items loop
         if not Seen.Contains (V) then
            Seen.Insert (V);
            N := N + 1;
            Tmp (N) := V;
         end if;
      end loop;
      return Tmp (1 .. N);
   end Vecuniq;

   function Vecsingleton (Items : Int_Array) return Int_Array is
      Counts : Count_Maps.Map;
      Tmp : Int_Array (1 .. Items'Length);
      N : Natural := 0;
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
            N := N + 1;
            Tmp (N) := V;
         end if;
      end loop;
      return Tmp (1 .. N);
   end Vecsingleton;

   function Vecfreq (Items : Int_Array) return Int_Array is
      Counts : Count_Maps.Map;
      Result : Int_Array (1 .. 2 * Natural (0));
      I : Natural := 0;
   begin
      for V of Items loop
         if Counts.Contains (V) then
            Counts (V) := Counts (V) + 1;
         else
            Counts.Insert (V, 1);
         end if;
      end loop;
      declare
         Pairs : Int_Array (1 .. 2 * Natural (Counts.Length));
      begin
         for C in Counts.Iterate loop
            I := I + 1;
            Pairs (I) := Count_Maps.Key (C);
            I := I + 1;
            Pairs (I) := To_Big_Integer (Count_Maps.Element (C));
         end loop;
         return Pairs;
      end;
   end Vecfreq;

   procedure Vecsorti (Items : in out Int_Array) is
   begin
      Array_Sort (Items);
   end Vecsorti;

   procedure Vecrsorti (Items : in out Int_Array) is
      Tmp : Big_Integer;
   begin
      Array_Sort (Items);
      for I in 1 .. Items'Length / 2 loop
         Tmp := Items (Items'First + I - 1);
         Items (Items'First + I - 1) := Items (Items'Last - I + 1);
         Items (Items'Last - I + 1) := Tmp;
      end loop;
   end Vecrsorti;

   function Vecsort (Items : Int_Array) return Int_Array is
      Copy : Int_Array := Items;
   begin
      Vecsorti (Copy);
      return Copy;
   end Vecsort;

   function Vecrsort (Items : Int_Array) return Int_Array is
      Copy : Int_Array := Items;
   begin
      Vecrsorti (Copy);
      return Copy;
   end Vecrsort;

   function Mex (Items : Int_Array; Positive_Only : Boolean)
      return Big_Integer
   is
      N : constant Big_Integer := To_Big_Integer (Items'Length);
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

   function Vecmex (Items : Int_Array) return Big_Integer is
     (Mex (Items, Positive_Only => False));

   function Vecpmex (Items : Int_Array) return Big_Integer is
     (Mex (Items, Positive_Only => True));

   function Toset (Items : Int_Array) return Int_Array is
     (From_Set (As_Set (Items)));

   function Is_Sidon_Set (Items : Int_Array) return Boolean is
      S : constant Int_Array := Toset (Items);
      Sums : Int_Sets.Set;
      Total : Big_Integer;
   begin
      for V of S loop
         if V < 0 then
            return False;
         end if;
      end loop;
      if S'Length = 0 then
         return True;
      end if;
      for I in S'Range loop
         for J in I .. S'Last loop
            Total := S (I) + S (J);
            if Sums.Contains (Total) then
               return False;
            end if;
            Sums.Insert (Total);
         end loop;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (Items : Int_Array) return Boolean is
      S : constant Int_Array := Toset (Items);
      Members : constant Int_Sets.Set := As_Set (S);
   begin
      for I in S'Range loop
         for J in I .. S'Last loop
            if Members.Contains (S (I) + S (J)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Sumset (Left, Right : Int_Array) return Int_Array is
      Sums : Int_Sets.Set;
   begin
      if Left'Length = 0 or else Right'Length = 0 then
         return None;
      end if;
      for X of Left loop
         for Y of Right loop
            Sums.Include (X + Y);
         end loop;
      end loop;
      return From_Set (Sums);
   end Sumset;

   function Sumset (Items : Int_Array) return Int_Array is
     (Sumset (Items, Items));

   function Vecequal (Left, Right : Int_Array) return Boolean is
   begin
      if Left'Length /= Right'Length then
         return False;
      end if;
      for I in Left'Range loop
         if Left (I) /= Right (Right'First + (I - Left'First)) then
            return False;
         end if;
      end loop;
      return True;
   end Vecequal;

   function Vecextract (Items : Int_Array; Mask : Big_Integer)
      return Int_Array
   is
      Tmp : Int_Array (1 .. Items'Length);
      Bit : Big_Integer := Mask;
      Index : Natural := 0;
      N : Natural := 0;
   begin
      if Mask < 0 then
         raise Constraint_Error with "vecextract negative mask";
      end if;
      while Bit > 0 loop
         if Bit mod 2 = 1 then
            if Index >= Items'Length then
               raise Undefined_Element;
            end if;
            N := N + 1;
            Tmp (N) := Items (Items'First + Index);
         end if;
         Bit := Bit / 2;
         Index := Index + 1;
      end loop;
      return Tmp (1 .. N);
   end Vecextract;

   function Vecextract (Items, Indexes : Int_Array) return Int_Array is
      Result : Int_Array (1 .. Indexes'Length);
      Place : Natural := 0;
      Resolved : Integer;
   begin
      for Index of Indexes loop
         Resolved := Resolve (Index, Items'Length);
         if Resolved < 0 then
            raise Undefined_Element;
         end if;
         Place := Place + 1;
         Result (Place) := Items (Items'First + Resolved);
      end loop;
      return Result;
   end Vecextract;

   function Setunion (Left, Right : Int_Array) return Int_Array is
      S : Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         S.Include (V);
      end loop;
      return From_Set (S);
   end Setunion;

   function Setintersect (Left, Right : Int_Array) return Int_Array is
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

   function Setminus (Left, Right : Int_Array) return Int_Array is
      S : Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         S.Exclude (V);
      end loop;
      return From_Set (S);
   end Setminus;

   function Setdelta (Left, Right : Int_Array) return Int_Array is
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

   function Set_Is_Disjoint (Left, Right : Int_Array) return Boolean is
      L : constant Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         if L.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Disjoint;

   function Set_Is_Equal (Left, Right : Int_Array) return Boolean is
     (Left'Length = Right'Length and then As_Set (Left) = As_Set (Right));

   function Set_Is_Subset (Left, Right : Int_Array) return Boolean is
      L : constant Int_Sets.Set := As_Set (Left);
   begin
      for V of Right loop
         if not L.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Subset;

   function Set_Is_Proper_Subset (Left, Right : Int_Array)
      return Boolean is
     (Left'Length > Right'Length
        and then Set_Is_Subset (Left, Right));

   function Set_Is_Superset (Left, Right : Int_Array) return Boolean is
      R : constant Int_Sets.Set := As_Set (Right);
   begin
      for V of Left loop
         if not R.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Superset;

   function Set_Is_Proper_Superset (Left, Right : Int_Array)
      return Boolean is
     (Right'Length > Left'Length
        and then Set_Is_Superset (Left, Right));

   function Set_Is_Proper_Intersection (Left, Right : Int_Array)
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
      if Left'Length < Right'Length then
         Min_Size := Left'Length;
      else
         Min_Size := Right'Length;
      end if;
      return Inter > 0 and then Inter < Min_Size;
   end Set_Is_Proper_Intersection;

   function Setcontains (Items, Values : Int_Array) return Boolean is
      S : constant Int_Sets.Set := As_Set (Items);
   begin
      for V of Values loop
         if not S.Contains (V) then
            return False;
         end if;
      end loop;
      return True;
   end Setcontains;

   function Setcontainsany (Items, Values : Int_Array) return Boolean is
      S : constant Int_Sets.Set := As_Set (Items);
   begin
      for V of Values loop
         if S.Contains (V) then
            return True;
         end if;
      end loop;
      return False;
   end Setcontainsany;

   function Setinsert
     (Items, Values : Int_Array; Count : out Integer) return Int_Array
   is
      Result : constant Int_Array := Setunion (Items, Values);
   begin
      Count := Integer (Result'Length) - Integer (Items'Length);
      return Result;
   end Setinsert;

   function Setremove
     (Items, Values : Int_Array; Count : out Integer) return Int_Array
   is
      Result : constant Int_Array := Setminus (Items, Values);
   begin
      Count := Integer (Items'Length) - Integer (Result'Length);
      return Result;
   end Setremove;

   function Setinvert
     (Items, Values : Int_Array; Count : out Integer) return Int_Array
   is
      Result : constant Int_Array := Setdelta (Items, Values);
   begin
      Count := Integer (Result'Length) - Integer (Items'Length);
      return Result;
   end Setinvert;
end Math_Prime_Util.Vec;
