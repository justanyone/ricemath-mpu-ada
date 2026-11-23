with Ada.Containers.Generic_Array_Sort;

package body Math_Prime_Util.Vec is

   procedure Sort_Asc is new Ada.Containers.Generic_Array_Sort
     (Index_Type   => Positive,
      Element_Type => Big_Integer,
      Array_Type   => Integer_Array);

   function Empty return Integer_Array is
      R : Integer_Array (1 .. 0);
   begin
      return R;
   end Empty;

   function Missing return Sequence is
      R : Sequence (-1);
   begin
      return R;
   end Missing;

   function Copy (Items : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. Items'Length);
   begin
      for I in R'Range loop
         R (I) := Items (Items'First + I - 1);
      end loop;
      return R;
   end Copy;

   procedure Reverse_Items (Items : in out Integer_Array) is
      Lo   : Integer := Items'First;
      Hi   : Integer := Items'Last;
      Swap : Big_Integer;
   begin
      while Lo < Hi loop
         Swap := Items (Lo);
         Items (Lo) := Items (Hi);
         Items (Hi) := Swap;
         Lo := Lo + 1;
         Hi := Hi - 1;
      end loop;
   end Reverse_Items;

   function Unique_Sorted (Items : Integer_Array) return Integer_Array is
      N : Natural := 0;
   begin
      if Items'Length = 0 then
         return Empty;
      end if;
      N := 1;
      for I in Items'First + 1 .. Items'Last loop
         if Items (I) /= Items (I - 1) then
            N := N + 1;
         end if;
      end loop;
      return R : Integer_Array (1 .. N) do
         N := 1;
         R (1) := Items (Items'First);
         for I in Items'First + 1 .. Items'Last loop
            if Items (I) /= R (N) then
               N := N + 1;
               R (N) := Items (I);
            end if;
         end loop;
      end return;
   end Unique_Sorted;

   function Contains
     (Sorted : Integer_Array; Value : Big_Integer) return Boolean
   is
      Lo : Integer := Sorted'First;
      Hi : Integer := Sorted'Last;
   begin
      while Lo <= Hi loop
         declare
            Mid : constant Integer := Lo + (Hi - Lo) / 2;
         begin
            if Sorted (Mid) = Value then
               return True;
            elsif Sorted (Mid) < Value then
               Lo := Mid + 1;
            else
               Hi := Mid - 1;
            end if;
         end;
      end loop;
      return False;
   end Contains;

   type Set_Op is (Op_Union, Op_Inter, Op_Minus, Op_Delta);

   function Merge
     (Left, Right : Integer_Array; Op : Set_Op) return Integer_Array
   is
      A   : constant Integer_Array := Toset (Left);
      B   : constant Integer_Array := Toset (Right);
      Tmp : Integer_Array (1 .. A'Length + B'Length);
      N   : Natural := 0;
      I   : Natural := 1;
      J   : Natural := 1;
   begin
      while I <= A'Length and then J <= B'Length loop
         if A (I) = B (J) then
            if Op in Op_Union | Op_Inter then
               N := N + 1;
               Tmp (N) := A (I);
            end if;
            I := I + 1;
            J := J + 1;
         elsif A (I) < B (J) then
            if Op in Op_Union | Op_Minus | Op_Delta then
               N := N + 1;
               Tmp (N) := A (I);
            end if;
            I := I + 1;
         else
            if Op in Op_Union | Op_Delta then
               N := N + 1;
               Tmp (N) := B (J);
            end if;
            J := J + 1;
         end if;
      end loop;
      if Op in Op_Union | Op_Minus | Op_Delta then
         while I <= A'Length loop
            N := N + 1;
            Tmp (N) := A (I);
            I := I + 1;
         end loop;
      end if;
      if Op in Op_Union | Op_Delta then
         while J <= B'Length loop
            N := N + 1;
            Tmp (N) := B (J);
            J := J + 1;
         end loop;
      end if;
      return Tmp (1 .. N);
   end Merge;

   function Make
     (Items : Integer_Array; Changed : Integer) return Set_Change
   is
      R : Set_Change (Items'Length);
   begin
      R.Changed := Changed;
      for I in R.Items'Range loop
         R.Items (I) := Items (Items'First + I - 1);
      end loop;
      return R;
   end Make;

   function Mask_Slots
     (Count : Natural; Mask : Big_Integer) return Integer_Array
   is
      Bits : Natural := 0;
      Walk : Big_Integer := Mask;
   begin
      if Mask < 0 then
         raise Constraint_Error with "vecextract: negative mask";
      end if;
      while Walk > 0 loop
         Bits := Bits + 1;
         Walk := Walk / 2;
      end loop;
      declare
         Raw : Integer_Array (1 .. Bits);
         M   : Big_Integer := Mask;
         Bit : Natural := 0;
         N   : Natural := 0;
      begin
         while M > 0 loop
            if M mod 2 /= 0 then
               N := N + 1;
               if Bit >= Count then
                  Raw (N) := 0;
               else
                  Raw (N) := To_Big_Integer (Bit + 1);
               end if;
            end if;
            M := M / 2;
            Bit := Bit + 1;
         end loop;
         return Raw (1 .. N);
      end;
   end Mask_Slots;

   function Index_Slots
     (Count : Natural; Indexes : Integer_Array) return Integer_Array
   is
      R : Integer_Array (1 .. Indexes'Length);
      K : Natural := 0;
   begin
      for Idx of Indexes loop
         declare
            Pos : Integer := 0;
            Sum : constant Long_Long_Integer :=
              Long_Long_Integer (Count) + Long_Long_Integer (Idx);
         begin
            K := K + 1;
            if Idx >= 0 then
               if Long_Long_Integer (Idx) < Long_Long_Integer (Count) then
                  Pos := Idx + 1;
               end if;
            elsif Sum + 1 >= 1
              and then Sum + 1 <= Long_Long_Integer (Count)
            then
               Pos := Integer (Sum + 1);
            end if;
            R (K) := To_Big_Integer (Pos);
         end;
      end loop;
      return R;
   end Index_Slots;

   function From_Slots
     (Items : Integer_Array; Slots : Integer_Array) return Sequence
   is
   begin
      for S of Slots loop
         if S <= 0 then
            return Missing;
         end if;
      end loop;
      return R : Sequence (Slots'Length) do
         for I in Slots'Range loop
            R.Items (I - Slots'First + 1) :=
              Items (Items'First + To_Integer (Slots (I)) - 1);
         end loop;
      end return;
   end From_Slots;

   function Vecsum (Items : Integer_Array) return Big_Integer is
      Sum : Big_Integer := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
      end loop;
      return Sum;
   end Vecsum;

   function Vecprod (Items : Integer_Array) return Big_Integer is
      Prod : Big_Integer := 1;
   begin
      for V of Items loop
         Prod := Prod * V;
      end loop;
      return Prod;
   end Vecprod;

   function Vecmin (Items : Integer_Array) return Optional_Big is
      Best : Big_Integer;
   begin
      if Items'Length = 0 then
         return (Defined => False);
      end if;
      Best := Items (Items'First);
      for V of Items loop
         if V < Best then
            Best := V;
         end if;
      end loop;
      return (Defined => True, Value => Best);
   end Vecmin;

   function Vecmax (Items : Integer_Array) return Optional_Big is
      Best : Big_Integer;
   begin
      if Items'Length = 0 then
         return (Defined => False);
      end if;
      Best := Items (Items'First);
      for V of Items loop
         if V > Best then
            Best := V;
         end if;
      end loop;
      return (Defined => True, Value => Best);
   end Vecmax;

   function Vecprefixsum (Items : Integer_Array) return Integer_Array is
      R   : Integer_Array (1 .. Items'Length);
      Sum : Big_Integer := 0;
      K   : Natural := 0;
   begin
      for V of Items loop
         Sum := Sum + V;
         K := K + 1;
         R (K) := Sum;
      end loop;
      return R;
   end Vecprefixsum;

   function Vecuniq (Items : Integer_Array) return Integer_Array is
      Seen : Integer_Array (1 .. Items'Length);
      N    : Natural := 0;
   begin
      for V of Items loop
         declare
            Found : Boolean := False;
         begin
            for I in 1 .. N loop
               if Seen (I) = V then
                  Found := True;
                  exit;
               end if;
            end loop;
            if not Found then
               N := N + 1;
               Seen (N) := V;
            end if;
         end;
      end loop;
      return Seen (1 .. N);
   end Vecuniq;

   function Vecsingleton (Items : Integer_Array) return Integer_Array is
      Outs : Integer_Array (1 .. Items'Length);
      N    : Natural := 0;
   begin
      for I in Items'Range loop
         declare
            Times : Natural := 0;
         begin
            for V of Items loop
               if V = Items (I) then
                  Times := Times + 1;
               end if;
            end loop;
            if Times = 1 then
               N := N + 1;
               Outs (N) := Items (I);
            end if;
         end;
      end loop;
      return Outs (1 .. N);
   end Vecsingleton;

   function Vecfreq (Items : Integer_Array) return Frequency_Array is
      S : constant Integer_Array := Vecsort (Items);
      N : Natural := 0;
   begin
      if S'Length = 0 then
         declare
            R : Frequency_Array (1 .. 0);
         begin
            return R;
         end;
      end if;
      N := 1;
      for I in 2 .. S'Length loop
         if S (I) /= S (I - 1) then
            N := N + 1;
         end if;
      end loop;
      return R : Frequency_Array (1 .. N) do
         declare
            K : Positive := 1;
            C : Positive := 1;
         begin
            for I in 2 .. S'Length loop
               if S (I) = S (I - 1) then
                  C := C + 1;
               else
                  R (K) := (Value => S (I - 1), Count => C);
                  K := K + 1;
                  C := 1;
               end if;
            end loop;
            R (K) := (Value => S (S'Last), Count => C);
         end;
      end return;
   end Vecfreq;

   function Vecsort (Items : Integer_Array) return Integer_Array is
      R : Integer_Array := Copy (Items);
   begin
      Sort_Asc (R);
      return R;
   end Vecsort;

   function Vecrsort (Items : Integer_Array) return Integer_Array is
      R : Integer_Array := Vecsort (Items);
   begin
      Reverse_Items (R);
      return R;
   end Vecrsort;

   procedure Vecsorti (Items : in out Integer_Array) is
   begin
      Sort_Asc (Items);
   end Vecsorti;

   procedure Vecrsorti (Items : in out Integer_Array) is
   begin
      Sort_Asc (Items);
      Reverse_Items (Items);
   end Vecrsorti;

   function Vecmex (Items : Integer_Array) return Big_Integer is
      Lim  : constant Natural := Items'Length;
      Seen : array (0 .. Lim) of Boolean := (others => False);
   begin
      for V of Items loop
         if V < 0 then
            raise Constraint_Error with "vecmex: negative value";
         end if;
         if V < To_Big_Integer (Lim) then
            Seen (To_Integer (V)) := True;
         end if;
      end loop;
      for I in 0 .. Lim - 1 loop
         if not Seen (I) then
            return To_Big_Integer (I);
         end if;
      end loop;
      return To_Big_Integer (Lim);
   end Vecmex;

   function Vecpmex (Items : Integer_Array) return Big_Integer is
      Lim  : constant Natural := Items'Length;
      Seen : array (1 .. Lim + 1) of Boolean := (others => False);
   begin
      for V of Items loop
         if V <= 0 then
            raise Constraint_Error with "vecpmex: non-positive value";
         end if;
         if V <= To_Big_Integer (Lim) then
            Seen (To_Integer (V)) := True;
         end if;
      end loop;
      for I in 1 .. Lim loop
         if not Seen (I) then
            return To_Big_Integer (I);
         end if;
      end loop;
      return To_Big_Integer (Lim + 1);
   end Vecpmex;

   function Toset (Items : Integer_Array) return Integer_Array is
     (Unique_Sorted (Vecsort (Items)));

   function Vecequal (Left, Right : Integer_Array) return Boolean is
   begin
      if Left'Length /= Right'Length then
         return False;
      end if;
      for I in 0 .. Left'Length - 1 loop
         if Left (Left'First + I) /= Right (Right'First + I) then
            return False;
         end if;
      end loop;
      return True;
   end Vecequal;

   function Vecextract
     (Items : Integer_Array; Mask : Big_Integer) return Sequence
   is
   begin
      return From_Slots (Items, Mask_Slots (Items'Length, Mask));
   end Vecextract;

   function Vecextract
     (Items : Integer_Array; Indexes : Integer_Array) return Sequence
   is
      Idx : Integer_Array (1 .. Indexes'Length);
   begin
      for I in Indexes'Range loop
         declare
            N : constant Integer := To_Integer (Indexes (I));
         begin
            Idx (I - Indexes'First + 1) := To_Big_Integer (N);
         end;
      end loop;
      return From_Slots (Items, Index_Slots (Items'Length, Idx));
   end Vecextract;

   function Is_Sidon_Set (Items : Integer_Array) return Boolean is
      S : constant Integer_Array := Toset (Items);
      N : constant Natural := S'Length;
   begin
      for V of S loop
         if V < 0 then
            return False;
         end if;
      end loop;
      if N > 1 and then N - 1 > (Natural'Last / N) - 1 then
         raise Constraint_Error with "sidon set is too large";
      end if;
      declare
         Pairs : constant Natural :=
           (if N = 0 then 0 else N * (N + 1) / 2);
         Sums  : Integer_Array (1 .. Pairs);
         K     : Natural := 0;
      begin
         for I in S'Range loop
            for J in I .. S'Last loop
               K := K + 1;
               Sums (K) := S (I) + S (J);
            end loop;
         end loop;
         Sort_Asc (Sums);
         for I in 2 .. Sums'Length loop
            if Sums (I) = Sums (I - 1) then
               return False;
            end if;
         end loop;
      end;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (Items : Integer_Array) return Boolean is
      S : constant Integer_Array := Toset (Items);
   begin
      for I in S'Range loop
         for J in I .. S'Last loop
            if Contains (S, S (I) + S (J)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Sumset (Left, Right : Integer_Array) return Integer_Array is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
   begin
      if A'Length = 0 or else B'Length = 0 then
         return Empty;
      end if;
      if B'Length > Natural'Last / A'Length then
         raise Constraint_Error with "sumset is too large";
      end if;
      declare
         Tmp : Integer_Array (1 .. A'Length * B'Length);
         K   : Natural := 0;
      begin
         for X of A loop
            for Y of B loop
               K := K + 1;
               Tmp (K) := X + Y;
            end loop;
         end loop;
         return Toset (Tmp);
      end;
   end Sumset;

   function Sumset (Items : Integer_Array) return Integer_Array is
     (Sumset (Items, Items));

   function Setunion (Left, Right : Integer_Array) return Integer_Array is
     (Merge (Left, Right, Op_Union));

   function Setintersect
     (Left, Right : Integer_Array) return Integer_Array
   is
     (Merge (Left, Right, Op_Inter));

   function Setminus (Left, Right : Integer_Array) return Integer_Array is
     (Merge (Left, Right, Op_Minus));

   function Setdelta (Left, Right : Integer_Array) return Integer_Array is
     (Merge (Left, Right, Op_Delta));

   function Overlap (Left, Right : Integer_Array) return Natural is
     (Merge (Left, Right, Op_Inter)'Length);

   function Set_Is_Disjoint (Left, Right : Integer_Array) return Boolean is
     (Overlap (Left, Right) = 0);

   function Set_Is_Equal (Left, Right : Integer_Array) return Boolean is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
   begin
      return A'Length = B'Length
        and then Overlap (Left, Right) = B'Length;
   end Set_Is_Equal;

   function Set_Is_Subset (Left, Right : Integer_Array) return Boolean is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
   begin
      return A'Length >= B'Length
        and then Overlap (Left, Right) = B'Length;
   end Set_Is_Subset;

   function Set_Is_Proper_Subset
     (Left, Right : Integer_Array) return Boolean
   is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
   begin
      return A'Length > B'Length
        and then Overlap (Left, Right) = B'Length;
   end Set_Is_Proper_Subset;

   function Set_Is_Superset (Left, Right : Integer_Array) return Boolean is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
   begin
      return A'Length <= B'Length
        and then Overlap (Left, Right) = A'Length;
   end Set_Is_Superset;

   function Set_Is_Proper_Superset
     (Left, Right : Integer_Array) return Boolean
   is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
   begin
      return A'Length < B'Length
        and then Overlap (Left, Right) = A'Length;
   end Set_Is_Proper_Superset;

   function Set_Is_Proper_Intersection
     (Left, Right : Integer_Array) return Boolean
   is
      A : constant Integer_Array := Toset (Left);
      B : constant Integer_Array := Toset (Right);
      R : constant Natural := Overlap (Left, Right);
   begin
      return R > 0 and then R < A'Length and then R < B'Length;
   end Set_Is_Proper_Intersection;

   function Setinsert
     (Set, Values : Integer_Array) return Set_Change
   is
      Base : constant Integer_Array := Toset (Set);
      U    : constant Integer_Array := Setunion (Set, Values);
   begin
      return Make (U, U'Length - Base'Length);
   end Setinsert;

   function Setremove
     (Set, Values : Integer_Array) return Set_Change
   is
      Base : constant Integer_Array := Toset (Set);
      M    : constant Integer_Array := Setminus (Set, Values);
   begin
      return Make (M, Base'Length - M'Length);
   end Setremove;

   function Setinvert
     (Set, Values : Integer_Array) return Set_Change
   is
      V     : constant Integer_Array := Toset (Values);
      Inter : constant Integer_Array := Setintersect (Set, Values);
      Diff  : constant Integer_Array := Setdelta (Set, Values);
   begin
      return Make (Diff, V'Length - 2 * Inter'Length);
   end Setinvert;

   function Setcontains (Set, Values : Integer_Array) return Boolean is
      V : constant Integer_Array := Toset (Values);
   begin
      return Overlap (Set, V) = V'Length;
   end Setcontains;

   function Setcontainsany (Set, Values : Integer_Array) return Boolean is
     (Overlap (Set, Values) > 0);

end Math_Prime_Util.Vec;
