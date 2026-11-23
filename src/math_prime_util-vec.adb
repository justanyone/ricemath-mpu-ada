with Ada.Containers;
with Ada.Containers.Ordered_Maps;
with Ada.Containers.Ordered_Sets;

package body Math_Prime_Util.Vec is
   use type Ada.Containers.Count_Type;
   use type Big_Integer;

   package Big_Sets is new Ada.Containers.Ordered_Sets (Big_Integer);
   use type Big_Sets.Set;
   package Count_Maps is new Ada.Containers.Ordered_Maps
     (Key_Type => Big_Integer, Element_Type => Natural);

   procedure Sort_Up (Items : in out Integer_Vectors.Vector) is
   begin
      for I in 2 .. Items.Last_Index loop
         declare
            Key : constant Big_Integer := Items (I);
            J : Natural := I - 1;
         begin
            while J >= 1 and then Items (J) > Key loop
               Items (J + 1) := Items (J);
               J := J - 1;
            end loop;
            Items (J + 1) := Key;
         end;
      end loop;
   end Sort_Up;

   procedure Reverse_Order (Items : in out Integer_Vectors.Vector) is
      Lo : Positive := 1;
      Hi : Integer := Integer (Items.Length);
   begin
      while Lo < Hi loop
         declare
            Swap : constant Big_Integer := Items (Lo);
         begin
            Items (Lo) := Items (Positive (Hi));
            Items (Positive (Hi)) := Swap;
         end;
         Lo := Lo + 1;
         Hi := Hi - 1;
      end loop;
   end Reverse_Order;

   function As_Set (Items : Integer_Vectors.Vector) return Big_Sets.Set is
      Result : Big_Sets.Set;
   begin
      for Value of Items loop
         Result.Include (Value);
      end loop;
      return Result;
   end As_Set;

   function To_Vector (Items : Big_Sets.Set) return Integer_Vectors.Vector is
      Result : Integer_Vectors.Vector;
   begin
      for Value of Items loop
         Result.Append (Value);
      end loop;
      return Result;
   end To_Vector;

   function Counts (Items : Integer_Vectors.Vector) return Count_Maps.Map is
      Result : Count_Maps.Map;
   begin
      for Value of Items loop
         if Result.Contains (Value) then
            Result (Value) := Result (Value) + 1;
         else
            Result.Insert (Value, 1);
         end if;
      end loop;
      return Result;
   end Counts;

   function Vecsum (Items : Integer_Vectors.Vector) return Big_Integer is
      Total : Big_Integer := 0;
   begin
      for Value of Items loop
         Total := Total + Value;
      end loop;
      return Total;
   end Vecsum;

   function Vecprod (Items : Integer_Vectors.Vector) return Big_Integer is
      Total : Big_Integer := 1;
   begin
      for Value of Items loop
         Total := Total * Value;
      end loop;
      return Total;
   end Vecprod;

   function Vecmin (Items : Integer_Vectors.Vector) return Optional_Integer is
      Best : Big_Integer;
      Seen : Boolean := False;
   begin
      for Value of Items loop
         if not Seen or else Value < Best then
            Best := Value;
            Seen := True;
         end if;
      end loop;
      if not Seen then
         return (Defined => False, Value => 0);
      end if;
      return (Defined => True, Value => Best);
   end Vecmin;

   function Vecmax (Items : Integer_Vectors.Vector) return Optional_Integer is
      Best : Big_Integer;
      Seen : Boolean := False;
   begin
      for Value of Items loop
         if not Seen or else Value > Best then
            Best := Value;
            Seen := True;
         end if;
      end loop;
      if not Seen then
         return (Defined => False, Value => 0);
      end if;
      return (Defined => True, Value => Best);
   end Vecmax;

   function Vecprefixsum (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
      Result : Integer_Vectors.Vector;
      Total : Big_Integer := 0;
   begin
      for Value of Items loop
         Total := Total + Value;
         Result.Append (Total);
      end loop;
      return Result;
   end Vecprefixsum;

   function Vecuniq (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
      Seen : Big_Sets.Set;
      Result : Integer_Vectors.Vector;
   begin
      for Value of Items loop
         if not Seen.Contains (Value) then
            Seen.Insert (Value);
            Result.Append (Value);
         end if;
      end loop;
      return Result;
   end Vecuniq;

   function Vecsingleton (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
      Seen : constant Count_Maps.Map := Counts (Items);
      Result : Integer_Vectors.Vector;
   begin
      for Value of Items loop
         if Seen (Value) = 1 then
            Result.Append (Value);
         end if;
      end loop;
      return Result;
   end Vecsingleton;

   function Vecfreq (Items : Integer_Vectors.Vector) return Freq_Vectors.Vector
   is
      Seen : constant Count_Maps.Map := Counts (Items);
      Result : Freq_Vectors.Vector;
   begin
      for Cursor in Seen.Iterate loop
         Result.Append
           (Freq_Pair'(Value => Count_Maps.Key (Cursor),
                       Count => Count_Maps.Element (Cursor)));
      end loop;
      return Result;
   end Vecfreq;

   procedure Vecsorti (Items : in out Integer_Vectors.Vector) is
   begin
      Sort_Up (Items);
   end Vecsorti;

   procedure Vecrsorti (Items : in out Integer_Vectors.Vector) is
   begin
      Sort_Up (Items);
      Reverse_Order (Items);
   end Vecrsorti;

   function Vecsort (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
      Result : Integer_Vectors.Vector := Items;
   begin
      Vecsorti (Result);
      return Result;
   end Vecsort;

   function Vecrsort (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
      Result : Integer_Vectors.Vector := Items;
   begin
      Vecrsorti (Result);
      return Result;
   end Vecrsort;

   function Missing
     (Items : Integer_Vectors.Vector;
      Start : Big_Integer;
      Positive_Only : Boolean) return Big_Integer
   is
      Limit : constant Natural := Natural (Items.Length);
   begin
      if Limit = 0 then
         return Start;
      end if;
      declare
         Marked : array (0 .. Limit - 1) of Boolean := [others => False];
         Bound : constant Big_Integer := Start + To_Big_Integer (Limit);
      begin
         for Value of Items loop
            if Positive_Only then
               if Value <= 0 then
                  raise Constraint_Error with "non-positive element";
               end if;
            elsif Value < 0 then
               raise Constraint_Error with "negative element";
            end if;
            if Value >= Start and then Value < Bound then
               Marked (To_Integer (Value - Start)) := True;
            end if;
         end loop;
         for Slot in 0 .. Limit - 1 loop
            if not Marked (Slot) then
               return Start + To_Big_Integer (Slot);
            end if;
         end loop;
         return Bound;
      end;
   end Missing;

   function Vecmex (Items : Integer_Vectors.Vector) return Big_Integer is
     (Missing (Items, 0, False));

   function Vecpmex (Items : Integer_Vectors.Vector) return Big_Integer is
     (Missing (Items, 1, True));

   function Vecextract
     (Items : Text_Vectors.Vector; Mask : Big_Integer) return Text_Result
   is
      Rest : Big_Integer := Mask;
      Bit : Natural := 0;
      Result : Text_Vectors.Vector;
   begin
      if Mask < 0 then
         raise Constraint_Error with "negative mask";
      end if;
      while Rest > 0 loop
         if Rest mod 2 = 1 then
            if Bit >= Natural (Items.Length) then
               return (Defined => False, Items => Text_Vectors.Empty_Vector);
            end if;
            Result.Append (Items (Bit + 1));
         end if;
         Rest := Rest / 2;
         Bit := Bit + 1;
      end loop;
      return (Defined => True, Items => Result);
   end Vecextract;

   function Vecextract
     (Items : Text_Vectors.Vector; Indexes : Integer_Vectors.Vector)
      return Text_Result
   is
      Result : Text_Vectors.Vector;
      Len : constant Integer := Integer (Items.Length);
   begin
      for Index of Indexes loop
         declare
            Slot : Integer;
         begin
            if Index < To_Big_Integer (Integer'First)
              or else Index > To_Big_Integer (Integer'Last)
            then
               return (Defined => False, Items => Text_Vectors.Empty_Vector);
            end if;
            Slot := To_Integer (Index);
            if Slot < 0 then
               Slot := Len + Slot;
            end if;
            if Slot < 0 or else Slot >= Len then
               return (Defined => False, Items => Text_Vectors.Empty_Vector);
            end if;
            Result.Append (Items (Slot + 1));
         end;
      end loop;
      return (Defined => True, Items => Result);
   end Vecextract;

   function Vecequal (Left, Right : Integer_Vectors.Vector) return Boolean is
   begin
      if Left.Length /= Right.Length or else Left.Is_Empty then
         return Left.Is_Empty and then Right.Is_Empty;
      end if;
      for Index in Left.First_Index .. Left.Last_Index loop
         if Left (Index) /= Right (Index) then
            return False;
         end if;
      end loop;
      return True;
   end Vecequal;

   function Toset (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (To_Vector (As_Set (Items)));

   function Sumset (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
      Sums : Big_Sets.Set;
   begin
      if Left.Is_Empty or else Right.Is_Empty then
         return Integer_Vectors.Empty_Vector;
      end if;
      for X of Left loop
         for Y of Right loop
            Sums.Include (X + Y);
         end loop;
      end loop;
      return To_Vector (Sums);
   end Sumset;

   function Sumset (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (Sumset (Items, Items));

   function Setunion (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (To_Vector (Big_Sets.Union (As_Set (Left), As_Set (Right))));

   function Setintersect (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (To_Vector (Big_Sets.Intersection (As_Set (Left), As_Set (Right))));

   function Setminus (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (To_Vector (Big_Sets.Difference (As_Set (Left), As_Set (Right))));

   function Setdelta (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (To_Vector
        (Big_Sets.Symmetric_Difference (As_Set (Left), As_Set (Right))));

   function Setinsert (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (Setunion (Left, Right));

   function Setremove (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (Setminus (Left, Right));

   function Setinvert (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
   is
     (Setdelta (Left, Right));

   function Setcontains (Left, Right : Integer_Vectors.Vector) return Boolean
   is
      Known : constant Big_Sets.Set := As_Set (Left);
   begin
      for Value of Right loop
         if not Known.Contains (Value) then
            return False;
         end if;
      end loop;
      return True;
   end Setcontains;

   function Setcontainsany
     (Left, Right : Integer_Vectors.Vector) return Boolean
   is
      Known : constant Big_Sets.Set := As_Set (Left);
   begin
      if Left.Is_Empty or else Right.Is_Empty then
         return False;
      end if;
      for Value of Right loop
         if Known.Contains (Value) then
            return True;
         end if;
      end loop;
      return False;
   end Setcontainsany;

   function Set_Is_Disjoint (Left, Right : Integer_Vectors.Vector)
      return Boolean
   is
     (Left.Is_Empty or else Right.Is_Empty
      or else Big_Sets.Intersection (As_Set (Left), As_Set (Right)).Is_Empty);

   function Set_Is_Equal (Left, Right : Integer_Vectors.Vector) return Boolean
   is
     (Left.Length = Right.Length and then As_Set (Left) = As_Set (Right));

   function Set_Is_Subset (Left, Right : Integer_Vectors.Vector) return Boolean
   is
   begin
      if Right.Is_Empty then
         return True;
      end if;
      if Left.Length < Right.Length then
         return False;
      end if;
      return Setcontains (Left, Right);
   end Set_Is_Subset;

   function Set_Is_Proper_Subset (Left, Right : Integer_Vectors.Vector)
      return Boolean
   is
     (Left.Length > Right.Length and then Set_Is_Subset (Left, Right));

   function Set_Is_Superset (Left, Right : Integer_Vectors.Vector)
      return Boolean
   is
     (Set_Is_Subset (Right, Left));

   function Set_Is_Proper_Superset (Left, Right : Integer_Vectors.Vector)
      return Boolean
   is
     (Set_Is_Proper_Subset (Right, Left));

   function Set_Is_Proper_Intersection (Left, Right : Integer_Vectors.Vector)
      return Boolean
   is
      Shared : constant Ada.Containers.Count_Type :=
        Big_Sets.Intersection (As_Set (Left), As_Set (Right)).Length;
      Shorter : constant Ada.Containers.Count_Type :=
        Ada.Containers.Count_Type'Min (Left.Length, Right.Length);
   begin
      return Shared > 0 and then Shared < Shorter;
   end Set_Is_Proper_Intersection;

   function Is_Sidon_Set (Items : Integer_Vectors.Vector) return Boolean is
      Ordered : constant Integer_Vectors.Vector := Toset (Items);
      Sums : Big_Sets.Set;
   begin
      if Ordered.Is_Empty then
         return True;
      end if;
      for Value of Ordered loop
         if Value < 0 then
            return False;
         end if;
      end loop;
      for I in Ordered.First_Index .. Ordered.Last_Index loop
         for J in Ordered.First_Index .. I loop
            declare
               Sum : constant Big_Integer := Ordered (I) + Ordered (J);
            begin
               if Sums.Contains (Sum) then
                  return False;
               end if;
               Sums.Insert (Sum);
            end;
         end loop;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (Items : Integer_Vectors.Vector) return Boolean is
      Members : constant Big_Sets.Set := As_Set (Items);
      Ordered : constant Integer_Vectors.Vector := Toset (Items);
   begin
      if Ordered.Is_Empty then
         return True;
      end if;
      for I in Ordered.First_Index .. Ordered.Last_Index loop
         for J in Ordered.First_Index .. I loop
            if Members.Contains (Ordered (I) + Ordered (J)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;
end Math_Prime_Util.Vec;
