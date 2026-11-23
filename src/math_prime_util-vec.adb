with Ada.Containers;

package body Math_Prime_Util.Vec with SPARK_Mode => Off is
   use type Int_Vector;

   function Less (L, R : BI.Big_Integer) return Boolean is (L < R);
   package Sorting is new Int_Vectors.Generic_Sorting (Less);

   function To_BI (N : Integer) return BI.Big_Integer
     renames BI.To_Big_Integer;

   function Contains (Items : Int_Vector; Value : BI.Big_Integer)
     return Boolean
   is
   begin
      for V of Items loop
         if V = Value then
            return True;
         end if;
      end loop;
      return False;
   end Contains;

   function Count_Of (Items : Int_Vector; Value : BI.Big_Integer)
     return Natural
   is
      N : Natural := 0;
   begin
      for V of Items loop
         if V = Value then
            N := N + 1;
         end if;
      end loop;
      return N;
   end Count_Of;

   procedure Reverse_Items (Items : in out Int_Vector) is
      Lo : Positive := Items.First_Index;
      Hi : Integer := Integer (Items.Last_Index);
      Tmp : BI.Big_Integer;
   begin
      while Integer (Lo) < Hi loop
         Tmp := Items (Lo);
         Items (Lo) := Items (Positive (Hi));
         Items (Positive (Hi)) := Tmp;
         Lo := Lo + 1;
         Hi := Hi - 1;
      end loop;
   end Reverse_Items;

   function Take
     (Items : String_Vectors.Vector; Index : BI.Big_Integer)
      return Extract_Element
   is
      use Ada.Strings.Unbounded;
      Length : constant BI.Big_Integer :=
        To_BI (Natural (Items.Length));
      Pos : BI.Big_Integer := Index;
   begin
      if Pos < 0 then
         Pos := Length + Pos;
      end if;
      if Pos < 0 or else Pos >= Length then
         return (Missing => True, Text => Null_Unbounded_String);
      end if;
      return (Missing => False,
              Text => Items (Positive (BI.To_Integer (Pos) + 1)));
   end Take;

   function Vecsum (Items : Int_Vector) return BI.Big_Integer is
      Total : BI.Big_Integer := To_BI (0);
   begin
      for V of Items loop
         Total := Total + V;
      end loop;
      return Total;
   end Vecsum;

   function Vecprod (Items : Int_Vector) return BI.Big_Integer is
      Total : BI.Big_Integer := To_BI (1);
   begin
      for V of Items loop
         Total := Total * V;
      end loop;
      return Total;
   end Vecprod;

   function Vecmin (Items : Int_Vector) return BI.Big_Integer is
      Best : BI.Big_Integer;
   begin
      if Items.Is_Empty then
         raise Constraint_Error with "vecmin of empty list";
      end if;
      Best := Items.First_Element;
      for V of Items loop
         if V < Best then
            Best := V;
         end if;
      end loop;
      return Best;
   end Vecmin;

   function Vecmax (Items : Int_Vector) return BI.Big_Integer is
      Best : BI.Big_Integer;
   begin
      if Items.Is_Empty then
         raise Constraint_Error with "vecmax of empty list";
      end if;
      Best := Items.First_Element;
      for V of Items loop
         if V >= Best then
            Best := V;
         end if;
      end loop;
      return Best;
   end Vecmax;

   function Vecprefixsum (Items : Int_Vector) return Int_Vector is
      Running : BI.Big_Integer := To_BI (0);
      Result : Int_Vector;
   begin
      for V of Items loop
         Running := Running + V;
         Result.Append (Running);
      end loop;
      return Result;
   end Vecprefixsum;

   function Vecuniq (Items : Int_Vector) return Int_Vector is
      Seen : Int_Vector;
      Result : Int_Vector;
   begin
      for V of Items loop
         if not Contains (Seen, V) then
            Seen.Append (V);
            Result.Append (V);
         end if;
      end loop;
      return Result;
   end Vecuniq;

   function Vecsingleton (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector;
   begin
      for V of Items loop
         if Count_Of (Items, V) = 1 then
            Result.Append (V);
         end if;
      end loop;
      return Result;
   end Vecsingleton;

   function Vecfreq (Items : Int_Vector) return Int_Vector is
      Copy : constant Int_Vector := Vecsort (Items);
      Result : Int_Vector;
      I : Integer := Copy.First_Index;
      Value : BI.Big_Integer;
      Count : Natural;
   begin
      while I <= Integer (Copy.Last_Index) loop
         Value := Copy (Positive (I));
         Count := 0;
         while I <= Integer (Copy.Last_Index)
           and then Copy (Positive (I)) = Value
         loop
            Count := Count + 1;
            I := I + 1;
         end loop;
         Result.Append (Value);
         Result.Append (To_BI (Count));
      end loop;
      return Result;
   end Vecfreq;

   function Vecsort (Items : Int_Vector) return Int_Vector is
      Copy : Int_Vector := Items;
   begin
      Sorting.Sort (Copy);
      return Copy;
   end Vecsort;

   function Vecrsort (Items : Int_Vector) return Int_Vector is
      Copy : Int_Vector := Items;
   begin
      Sorting.Sort (Copy);
      Reverse_Items (Copy);
      return Copy;
   end Vecrsort;

   procedure Vecsorti (Items : in out Int_Vector) is
   begin
      Sorting.Sort (Items);
   end Vecsorti;

   procedure Vecrsorti (Items : in out Int_Vector) is
   begin
      Sorting.Sort (Items);
      Reverse_Items (Items);
   end Vecrsorti;

   function Vecmex (Items : Int_Vector) return BI.Big_Integer is
      N : constant Integer := Integer (Items.Length);
      Seen : array (0 .. N) of Boolean := [others => False];
   begin
      for V of Items loop
         if V < 0 then
            raise Constraint_Error with "vecmex negative";
         end if;
         if V < To_BI (N) then
            Seen (BI.To_Integer (V)) := True;
         end if;
      end loop;
      for I in 0 .. N - 1 loop
         if not Seen (I) then
            return To_BI (I);
         end if;
      end loop;
      return To_BI (N);
   end Vecmex;

   function Vecpmex (Items : Int_Vector) return BI.Big_Integer is
      N : constant Integer := Integer (Items.Length);
      Seen : array (1 .. N) of Boolean := [others => False];
   begin
      for V of Items loop
         if V <= 0 then
            raise Constraint_Error with "vecpmex non-positive";
         end if;
         if V <= To_BI (N) then
            Seen (BI.To_Integer (V)) := True;
         end if;
      end loop;
      for I in 1 .. N loop
         if not Seen (I) then
            return To_BI (I);
         end if;
      end loop;
      return To_BI (N + 1);
   end Vecpmex;

   function Toset (Items : Int_Vector) return Int_Vector is
      Copy : Int_Vector := Items;
      Result : Int_Vector;
   begin
      Sorting.Sort (Copy);
      for V of Copy loop
         if Result.Is_Empty or else Result.Last_Element /= V then
            Result.Append (V);
         end if;
      end loop;
      return Result;
   end Toset;

   function Is_Sidon_Set (Items : Int_Vector) return Boolean is
      S : constant Int_Vector := Toset (Items);
      Sums : Int_Vector;
   begin
      for V of S loop
         if V < 0 then
            return False;
         end if;
      end loop;
      for I in S.First_Index .. S.Last_Index loop
         for J in I .. S.Last_Index loop
            Sums.Append (S (I) + S (J));
         end loop;
      end loop;
      Sorting.Sort (Sums);
      if Sums.Length < 2 then
         return True;
      end if;
      for I in Sums.First_Index + 1 .. Sums.Last_Index loop
         if Sums (I) = Sums (I - 1) then
            return False;
         end if;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (Items : Int_Vector) return Boolean is
      S : constant Int_Vector := Toset (Items);
   begin
      for I in S.First_Index .. S.Last_Index loop
         for J in I .. S.Last_Index loop
            if Contains (S, S (I) + S (J)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Sumset (Left, Right : Int_Vector) return Int_Vector is
      Acc : Int_Vector;
   begin
      if Left.Is_Empty or else Right.Is_Empty then
         return Acc;
      end if;
      for X of Left loop
         for Y of Right loop
            Acc.Append (X + Y);
         end loop;
      end loop;
      return Toset (Acc);
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

   function Vecextract
     (Items : String_Vectors.Vector; Mask : BI.Big_Integer)
      return Extract_Vectors.Vector
   is
      Rest : BI.Big_Integer := Mask;
      Two : constant BI.Big_Integer := To_BI (2);
      I : BI.Big_Integer := To_BI (0);
      Result : Extract_Vectors.Vector;
   begin
      if Mask < 0 then
         raise Constraint_Error with "vecextract negative mask";
      end if;
      while Rest > 0 loop
         if Rest mod Two = 1 then
            Result.Append (Take (Items, I));
         end if;
         Rest := Rest / Two;
         I := I + 1;
      end loop;
      return Result;
   end Vecextract;

   function Vecextract
     (Items : String_Vectors.Vector; Indexes : Int_Vector)
      return Extract_Vectors.Vector
   is
      Result : Extract_Vectors.Vector;
   begin
      for Index of Indexes loop
         Result.Append (Take (Items, Index));
      end loop;
      return Result;
   end Vecextract;

   function Setunion (Left, Right : Int_Vector) return Int_Vector is
      Both : Int_Vector := Left;
   begin
      for V of Right loop
         Both.Append (V);
      end loop;
      return Toset (Both);
   end Setunion;

   function Setintersect (Left, Right : Int_Vector) return Int_Vector is
      Known : constant Int_Vector := Toset (Left);
      Acc : Int_Vector;
   begin
      for V of Right loop
         if Contains (Known, V) then
            Acc.Append (V);
         end if;
      end loop;
      return Toset (Acc);
   end Setintersect;

   function Setminus (Left, Right : Int_Vector) return Int_Vector is
      Drop : constant Int_Vector := Toset (Right);
      Acc : Int_Vector;
   begin
      for V of Left loop
         if not Contains (Drop, V) then
            Acc.Append (V);
         end if;
      end loop;
      return Toset (Acc);
   end Setminus;

   function Setdelta (Left, Right : Int_Vector) return Int_Vector is
     (Setunion
        (Setminus (Left => Left, Right => Right),
         Setminus (Left => Right, Right => Left)));

   function Setinsert (Set, Values : Int_Vector) return Int_Vector is
     (Setunion (Set, Values));

   function Setremove (Set, Values : Int_Vector) return Int_Vector is
     (Setminus (Set, Values));

   function Setinvert (Set, Values : Int_Vector) return Int_Vector is
     (Setdelta (Set, Values));

   function Set_Is_Disjoint (Left, Right : Int_Vector) return Boolean is
   begin
      for V of Left loop
         if Contains (Right, V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Disjoint;

   function Set_Is_Equal (Left, Right : Int_Vector) return Boolean is
     (Left.Length = Right.Length and then Toset (Left) = Toset (Right));

   function Set_Is_Subset (Left, Right : Int_Vector) return Boolean is
   begin
      if Right.Is_Empty then
         return True;
      end if;
      if Left.Length < Right.Length then
         return False;
      end if;
      for V of Right loop
         if not Contains (Left, V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Subset;

   function Set_Is_Proper_Subset (Left, Right : Int_Vector) return Boolean is
     (Left.Length > Right.Length and then Set_Is_Subset (Left, Right));

   function Set_Is_Superset (Left, Right : Int_Vector) return Boolean is
     (Set_Is_Subset (Left => Right, Right => Left));

   function Set_Is_Proper_Superset (Left, Right : Int_Vector)
     return Boolean is
     (Set_Is_Proper_Subset (Left => Right, Right => Left));

   function Set_Is_Proper_Intersection (Left, Right : Int_Vector)
     return Boolean
   is
      Inter : Natural := 0;
      Smaller : constant Ada.Containers.Count_Type :=
        Ada.Containers.Count_Type'Min (Left.Length, Right.Length);
   begin
      for V of Right loop
         if Contains (Left, V) then
            Inter := Inter + 1;
         end if;
      end loop;
      return Inter > 0
        and then Ada.Containers.Count_Type (Inter) < Smaller;
   end Set_Is_Proper_Intersection;

   function Setcontains (Set, Values : Int_Vector) return Boolean is
     (Set_Is_Subset (Set, Values));

   function Setcontainsany (Set, Values : Int_Vector) return Boolean is
   begin
      for V of Values loop
         if Contains (Set, V) then
            return True;
         end if;
      end loop;
      return False;
   end Setcontainsany;
end Math_Prime_Util.Vec;
