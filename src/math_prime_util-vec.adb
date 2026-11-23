with Ada.Containers;
with Ada.Containers.Indefinite_Ordered_Sets;
with Ada.Containers.Indefinite_Vectors;

package body Math_Prime_Util.Vec is

   package Big_Sets is new Ada.Containers.Indefinite_Ordered_Sets
     (Element_Type => Big_Integer);

   package Acc_Vecs is new Ada.Containers.Indefinite_Vectors
     (Index_Type => Positive, Element_Type => Big_Integer);

   procedure Sort_Ascending is new Ada.Containers.Generic_Array_Sort
     (Index_Type => Positive,
      Element_Type => Big_Integer,
      Array_Type => Int_Vector);

   function Greater (Left, Right : Big_Integer) return Boolean is
     (Left > Right);

   procedure Sort_Descending is new Ada.Containers.Generic_Array_Sort
     (Index_Type => Positive,
      Element_Type => Big_Integer,
      Array_Type => Int_Vector,
      "<" => Greater);

   function Copy (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector (1 .. Items'Length);
   begin
      for I in Items'Range loop
         Result (I - Items'First + 1) := Items (I);
      end loop;
      return Result;
   end Copy;

   function Contains (Items : Int_Vector; Value : Big_Integer)
     return Boolean is
   begin
      for V of Items loop
         if V = Value then
            return True;
         end if;
      end loop;
      return False;
   end Contains;

   function Occurrences (Items : Int_Vector; Value : Big_Integer)
     return Natural is
      Count : Natural := 0;
   begin
      for V of Items loop
         if V = Value then
            Count := Count + 1;
         end if;
      end loop;
      return Count;
   end Occurrences;

   function From_Acc (Acc : Acc_Vecs.Vector) return Int_Vector is
      Result : Int_Vector (1 .. Natural (Acc.Length));
      Index : Natural := 0;
   begin
      for V of Acc loop
         Index := Index + 1;
         Result (Index) := V;
      end loop;
      return Result;
   end From_Acc;

   function Element_At
     (Items : Int_Vector; Raw : Big_Integer) return Big_Integer
   is
      Zero_Based : Big_Integer;
   begin
      if Raw >= 0 then
         Zero_Based := Raw;
      else
         Zero_Based := To_Big_Integer (Items'Length) + Raw;
      end if;
      if Zero_Based < 0
        or else Zero_Based >= To_Big_Integer (Items'Length)
      then
         raise Constraint_Error with "vecextract index";
      end if;
      return Items (Items'First + To_Integer (Zero_Based));
   end Element_At;

   function Vecsum (Items : Int_Vector) return Big_Integer is
      Total : Big_Integer := 0;
   begin
      for V of Items loop
         Total := Total + V;
      end loop;
      return Total;
   end Vecsum;

   function Vecprod (Items : Int_Vector) return Big_Integer is
      Product : Big_Integer := 1;
   begin
      for V of Items loop
         Product := Product * V;
      end loop;
      return Product;
   end Vecprod;

   function Vecmin (Items : Int_Vector) return Big_Integer is
      Best : Big_Integer;
   begin
      if Items'Length = 0 then
         raise Constraint_Error with "vecmin";
      end if;
      Best := Items (Items'First);
      for V of Items loop
         if V < Best then
            Best := V;
         end if;
      end loop;
      return Best;
   end Vecmin;

   function Vecmax (Items : Int_Vector) return Big_Integer is
      Best : Big_Integer;
   begin
      if Items'Length = 0 then
         raise Constraint_Error with "vecmax";
      end if;
      Best := Items (Items'First);
      for V of Items loop
         if V > Best then
            Best := V;
         end if;
      end loop;
      return Best;
   end Vecmax;

   function Vecprefixsum (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector (1 .. Items'Length);
      Total : Big_Integer := 0;
      Index : Natural := 0;
   begin
      for V of Items loop
         Total := Total + V;
         Index := Index + 1;
         Result (Index) := Total;
      end loop;
      return Result;
   end Vecprefixsum;

   function Vecuniq (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector (1 .. Items'Length);
      Count : Natural := 0;
   begin
      for I in Items'Range loop
         if not Contains (Result (1 .. Count), Items (I)) then
            Count := Count + 1;
            Result (Count) := Items (I);
         end if;
      end loop;
      return Result (1 .. Count);
   end Vecuniq;

   function Vecsingleton (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector (1 .. Items'Length);
      Count : Natural := 0;
   begin
      for I in Items'Range loop
         if Occurrences (Items, Items (I)) = 1 then
            Count := Count + 1;
            Result (Count) := Items (I);
         end if;
      end loop;
      return Result (1 .. Count);
   end Vecsingleton;

   function Vecfreq (Items : Int_Vector) return Int_Vector is
      Sorted : constant Int_Vector := Vecsort (Items);
      Runs : Natural := 0;
   begin
      if Sorted'Length = 0 then
         return Sorted;
      end if;
      Runs := 1;
      for I in 2 .. Sorted'Last loop
         if Sorted (I) /= Sorted (I - 1) then
            Runs := Runs + 1;
         end if;
      end loop;
      declare
         Result : Int_Vector (1 .. Runs * 2);
         Pos : Positive := 1;
         Start : Positive := 1;
      begin
         for I in 2 .. Sorted'Last loop
            if Sorted (I) /= Sorted (I - 1) then
               Result (Pos) := Sorted (Start);
               Result (Pos + 1) := To_Big_Integer (I - Start);
               Pos := Pos + 2;
               Start := I;
            end if;
         end loop;
         Result (Pos) := Sorted (Start);
         Result (Pos + 1) :=
           To_Big_Integer (Sorted'Last - Start + 1);
         return Result;
      end;
   end Vecfreq;

   function Vecsort (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector := Copy (Items);
   begin
      Sort_Ascending (Result);
      return Result;
   end Vecsort;

   function Vecrsort (Items : Int_Vector) return Int_Vector is
      Result : Int_Vector := Copy (Items);
   begin
      Sort_Descending (Result);
      return Result;
   end Vecrsort;

   function Vecsorti (Items : Int_Vector) return Int_Vector is
     (Vecsort (Items));

   function Vecrsorti (Items : Int_Vector) return Int_Vector is
     (Vecrsort (Items));

   function Vecmex (Items : Int_Vector) return Big_Integer is
      Seen : array (0 .. Items'Length) of Boolean := (others => False);
   begin
      for V of Items loop
         if V < 0 then
            raise Constraint_Error with "vecmex";
         end if;
         if V < To_Big_Integer (Items'Length) then
            Seen (To_Integer (V)) := True;
         end if;
      end loop;
      for I in 0 .. Items'Length - 1 loop
         if not Seen (I) then
            return To_Big_Integer (I);
         end if;
      end loop;
      return To_Big_Integer (Items'Length);
   end Vecmex;

   function Vecpmex (Items : Int_Vector) return Big_Integer is
      Seen : array (1 .. Items'Length + 1) of Boolean :=
        (others => False);
   begin
      for V of Items loop
         if V <= 0 then
            raise Constraint_Error with "vecpmex";
         end if;
         if V <= To_Big_Integer (Items'Length) then
            Seen (To_Integer (V)) := True;
         end if;
      end loop;
      for I in 1 .. Items'Length loop
         if not Seen (I) then
            return To_Big_Integer (I);
         end if;
      end loop;
      return To_Big_Integer (Items'Length + 1);
   end Vecpmex;

   function Toset (Items : Int_Vector) return Int_Vector is
      Sorted : Int_Vector := Copy (Items);
      Count : Natural := 0;
   begin
      Sort_Ascending (Sorted);
      if Sorted'Length = 0 then
         return Sorted;
      end if;
      Count := 1;
      for I in 2 .. Sorted'Last loop
         if Sorted (I) /= Sorted (Count) then
            Count := Count + 1;
            Sorted (Count) := Sorted (I);
         end if;
      end loop;
      return Sorted (1 .. Count);
   end Toset;

   function Is_Sidon_Set (Items : Int_Vector) return Boolean is
      S : constant Int_Vector := Toset (Items);
      Sums : Big_Sets.Set;
   begin
      for V of S loop
         if V < 0 then
            return False;
         end if;
      end loop;
      for I in S'Range loop
         for J in S'First .. I loop
            declare
               Sum : constant Big_Integer := S (I) + S (J);
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

   function Is_Sumfree_Set (Items : Int_Vector) return Boolean is
      S : constant Int_Vector := Toset (Items);
   begin
      for I in S'Range loop
         for J in S'First .. I loop
            if Contains (S, S (I) + S (J)) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Sumset (Left, Right : Int_Vector) return Int_Vector is
      Acc : Acc_Vecs.Vector;
   begin
      if Left'Length = 0 or else Right'Length = 0 then
         return From_Acc (Acc);
      end if;
      for X of Left loop
         for Y of Right loop
            Acc.Append (X + Y);
         end loop;
      end loop;
      return Toset (From_Acc (Acc));
   end Sumset;

   function Sumset (Items : Int_Vector) return Int_Vector is
     (Sumset (Items, Items));

   function Vecequal (Left, Right : Int_Vector) return Boolean is
   begin
      if Left'Length /= Right'Length then
         return False;
      end if;
      for Offset in 0 .. Left'Length - 1 loop
         if Left (Left'First + Offset) /= Right (Right'First + Offset)
         then
            return False;
         end if;
      end loop;
      return True;
   end Vecequal;

   function Vecextract
     (Items : Int_Vector; Mask : Big_Integer) return Int_Vector
   is
      Acc : Acc_Vecs.Vector;
      Rest : Big_Integer := Mask;
      Pos : Natural := 0;
   begin
      if Mask < 0 then
         raise Constraint_Error with "vecextract mask";
      end if;
      while Rest > 0 loop
         if Rest mod 2 = 1 then
            if Pos >= Items'Length then
               raise Constraint_Error with "vecextract index";
            end if;
            Acc.Append (Items (Items'First + Pos));
         end if;
         Rest := Rest / 2;
         Pos := Pos + 1;
      end loop;
      return From_Acc (Acc);
   end Vecextract;

   function Vecextract
     (Items : Int_Vector; Indexes : Int_Vector) return Int_Vector
   is
      Result : Int_Vector (1 .. Indexes'Length);
      Index : Natural := 0;
   begin
      for Raw of Indexes loop
         Index := Index + 1;
         Result (Index) := Element_At (Items, Raw);
      end loop;
      return Result;
   end Vecextract;

   function Setunion (Left, Right : Int_Vector) return Int_Vector is
     (Toset (Left & Right));

   function Setintersect (Left, Right : Int_Vector) return Int_Vector is
      SA : constant Int_Vector := Toset (Left);
      SB : constant Int_Vector := Toset (Right);
      Result : Int_Vector (1 .. SA'Length);
      Count : Natural := 0;
   begin
      for V of SA loop
         if Contains (SB, V) then
            Count := Count + 1;
            Result (Count) := V;
         end if;
      end loop;
      return Result (1 .. Count);
   end Setintersect;

   function Setminus (Left, Right : Int_Vector) return Int_Vector is
      SA : constant Int_Vector := Toset (Left);
      SB : constant Int_Vector := Toset (Right);
      Result : Int_Vector (1 .. SA'Length);
      Count : Natural := 0;
   begin
      for V of SA loop
         if not Contains (SB, V) then
            Count := Count + 1;
            Result (Count) := V;
         end if;
      end loop;
      return Result (1 .. Count);
   end Setminus;

   function Setdelta (Left, Right : Int_Vector) return Int_Vector is
     (Setunion (Setminus (Left, Right), Setminus (Right, Left)));

   function Set_Is_Disjoint (Left, Right : Int_Vector) return Boolean is
     (Setintersect (Left, Right)'Length = 0);

   function Set_Is_Equal (Left, Right : Int_Vector) return Boolean is
      SA : constant Int_Vector := Toset (Left);
      SB : constant Int_Vector := Toset (Right);
   begin
      if SA'Length /= SB'Length then
         return False;
      end if;
      for I in SA'Range loop
         if SA (I) /= SB (I) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Equal;

   function Set_Is_Subset (Left, Right : Int_Vector) return Boolean is
      SA : constant Int_Vector := Toset (Left);
   begin
      for V of Right loop
         if not Contains (SA, V) then
            return False;
         end if;
      end loop;
      return True;
   end Set_Is_Subset;

   function Set_Is_Proper_Subset (Left, Right : Int_Vector)
     return Boolean is
   begin
      return Set_Is_Subset (Left, Right)
        and then Toset (Left)'Length > Toset (Right)'Length;
   end Set_Is_Proper_Subset;

   function Set_Is_Superset (Left, Right : Int_Vector) return Boolean is
     (Set_Is_Subset (Right, Left));

   function Set_Is_Proper_Superset (Left, Right : Int_Vector)
     return Boolean is
     (Set_Is_Proper_Subset (Right, Left));

   function Set_Is_Proper_Intersection (Left, Right : Int_Vector)
     return Boolean
   is
      SA : constant Int_Vector := Toset (Left);
      SB : constant Int_Vector := Toset (Right);
      Inter : constant Int_Vector := Setintersect (SA, SB);
      Min_Size : constant Natural :=
        (if SA'Length < SB'Length then SA'Length else SB'Length);
   begin
      return Inter'Length > 0 and then Inter'Length < Min_Size;
   end Set_Is_Proper_Intersection;

   function Setinsert (Left, Right : Int_Vector) return Int_Vector is
     (Setunion (Left, Right));

   function Setremove (Left, Right : Int_Vector) return Int_Vector is
     (Setminus (Left, Right));

   function Setinvert (Left, Right : Int_Vector) return Int_Vector is
     (Setdelta (Left, Right));

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
