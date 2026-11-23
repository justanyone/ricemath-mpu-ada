package body Math_Prime_Util.Vec with SPARK_Mode => On is
   use type U128;

   function Has (A : Integer_Array; V : I128) return Boolean;
   function Has (A : Integer_Array; V : I128) return Boolean is
     (for some X of A => X = V);

   function Vecsum (A : Integer_Array) return I128 is
      R : I128 := 0;
   begin
      for V of A loop
         R := R + V;
      end loop;
      return R;
   end Vecsum;

   function Vecprod (A : Integer_Array) return I128 is
      R : I128 := 1;
   begin
      --  A zero anywhere makes the product zero even if an earlier prefix
      --  would overflow (XS.xs: vecprod scans for zero before multiplying).
      if Has (A, 0) then
         return 0;
      end if;
      for V of A loop
         R := R * V;
      end loop;
      return R;
   end Vecprod;

   function Vecmin (A : Integer_Array) return Optional_Value is
      R : I128 := I128'Last;
   begin
      for V of A loop
         R := I128'Min (R, V);
      end loop;
      return (if A'Length = 0 then (Defined => False)
              else (Defined => True, Value => R));
   end Vecmin;

   function Vecmax (A : Integer_Array) return Optional_Value is
      R : I128 := I128'First;
   begin
      for V of A loop
         R := I128'Max (R, V);
      end loop;
      return (if A'Length = 0 then (Defined => False)
              else (Defined => True, Value => R));
   end Vecmax;

   function Vecprefixsum (A : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. A'Length) := [others => 0];
      S : I128 := 0;
      N : Natural := 0;
   begin
      for V of A loop
         S := S + V;
         N := N + 1;
         R (N) := S;
      end loop;
      return R;
   end Vecprefixsum;

   procedure Vecsorti (A : in out Integer_Array) is
      V : I128;
      J : Positive;
   begin
      --  sort.c: sort_iv_array/sort_uv_array. Insertion sort preserves the
      --  integer ordering without interpreting unsigned values as signed.
      for I in A'Range loop
         V := A (I);
         J := I;
         while J > A'First and then A (J - 1) > V loop
            A (J) := A (J - 1);
            J := J - 1;
         end loop;
         A (J) := V;
      end loop;
   end Vecsorti;

   function Vecsort (A : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. A'Length) := A;
   begin
      Vecsorti (R);
      return R;
   end Vecsort;

   function Vecrsort (A : Integer_Array) return Integer_Array is
      S : constant Integer_Array := Vecsort (A);
      R : Integer_Array (S'Range);
   begin
      for I in R'Range loop
         R (I) := S (S'Last - I + 1);
      end loop;
      return R;
   end Vecrsort;

   procedure Vecrsorti (A : in out Integer_Array) is
   begin
      A := Vecrsort (A);
   end Vecrsorti;

   function Vecuniq (A : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. A'Length) := [others => 0];
      N : Natural := 0;
   begin
      for V of A loop
         if not Has (R (1 .. N), V) then
            N := N + 1;
            R (N) := V;
         end if;
      end loop;
      return R (1 .. N);
   end Vecuniq;

   function Vecsingleton (A : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. A'Length) := [others => 0];
      N : Natural := 0;
      Count : Natural;
   begin
      for V of A loop
         Count := 0;
         for W of A loop
            if V = W then
               Count := Count + 1;
            end if;
         end loop;
         if Count = 1 then
            N := N + 1;
            R (N) := V;
         end if;
      end loop;
      return R (1 .. N);
   end Vecsingleton;

   function Vecfreq (A : Integer_Array) return Integer_Array is
      S : constant Integer_Array := Vecsort (A);
      R : Integer_Array (1 .. 2 * A'Length) := [others => 0];
      N : Natural := 0;
   begin
      for V of S loop
         if N = 0 or else R (N - 1) /= V then
            R (N + 1) := V;
            R (N + 2) := 1;
            N := N + 2;
         else
            R (N) := R (N) + 1;
         end if;
      end loop;
      return R (1 .. N);
   end Vecfreq;

   function Vecmex (A : Integer_Array) return I128 is
      Seen : array (0 .. A'Length) of Boolean := [others => False];
   begin
      for V of A loop
         if V <= I128 (A'Length) then
            Seen (Natural (V)) := True;
         end if;
      end loop;
      for I in Seen'Range loop
         if not Seen (I) then
            return I128 (I);
         end if;
      end loop;
      return I128 (A'Length);
   end Vecmex;

   function Vecpmex (A : Integer_Array) return I128 is
      Seen : array (1 .. A'Length) of Boolean := [others => False];
   begin
      for V of A loop
         if V <= I128 (A'Length) then
            Seen (Positive (V)) := True;
         end if;
      end loop;
      for I in Seen'Range loop
         if not Seen (I) then
            return I128 (I);
         end if;
      end loop;
      return I128 (A'Length) + 1;
   end Vecpmex;

   function Vecequal (A, B : Integer_Array) return Boolean is (A = B);

   function Vecextract (A : Integer_Array; Mask : U128)
      return Optional_Array
   is
      R : Optional_Array (1 .. 128);
      Bits : U128 := Mask;
      N, Position : Natural := 0;
   begin
      while Bits > 0 loop
         if Bits mod 2 = 1 then
            N := N + 1;
            if Position < A'Length then
               R (N) := (True, A (A'First + Position));
            else
               R (N) := (Defined => False);
            end if;
         end if;
         Bits := Bits / 2;
         Position := Position + 1;
      end loop;
      return R (1 .. N);
   end Vecextract;

   function Vecextract (A, Indices : Integer_Array) return Optional_Array is
      R : Optional_Array (1 .. Indices'Length);
      N : Natural := 0;
      P : I128;
   begin
      for V of Indices loop
         P := (if V < 0 then I128 (A'Length) + V else V);
         N := N + 1;
         if P in 0 .. I128 (A'Length) - 1 then
            R (N) := (True, A (A'First + Natural (P)));
         else
            R (N) := (Defined => False);
         end if;
      end loop;
      return R;
   end Vecextract;

   function Toset (A : Integer_Array) return Integer_Array is
     (Vecuniq (Vecsort (A)));

   type Set_Operation is (Union_Op, Intersect_Op, Minus_Op, Delta_Op);

   function Combine (A, B : Integer_Array; Op : Set_Operation)
      return Integer_Array;
   function Combine (A, B : Integer_Array; Op : Set_Operation)
      return Integer_Array
   is
      X : constant Integer_Array := Toset (A);
      Y : constant Integer_Array := Toset (B);
      R : Integer_Array
        (1 .. (if Op in Intersect_Op | Minus_Op then X'Length
               else X'Length + Y'Length));
      N : Natural := 0;
   begin
      --  xs_set.c: xs_set_op. Select union/intersection/difference members,
      --  then use sort.c's sort-and-deduplicate invariant for the result.
      for V of X loop
         if (Has (Y, V) and then Op in Union_Op | Intersect_Op)
           or else (not Has (Y, V) and then Op /= Intersect_Op)
         then
            N := N + 1;
            R (N) := V;
         end if;
      end loop;
      if Op in Union_Op | Delta_Op then
         for V of Y loop
            if not Has (X, V) then
               N := N + 1;
               R (N) := V;
            end if;
         end loop;
      end if;
      return Vecsort (R (1 .. N));
   end Combine;

   function Setunion (A, B : Integer_Array) return Integer_Array is
     (Combine (A, B, Union_Op));
   function Setintersect (A, B : Integer_Array) return Integer_Array is
     (Combine (A, B, Intersect_Op));
   function Setminus (A, B : Integer_Array) return Integer_Array is
     (Combine (A, B, Minus_Op));
   function Setdelta (A, B : Integer_Array) return Integer_Array is
     (Combine (A, B, Delta_Op));
   function Setcontains (A, B : Integer_Array) return Boolean is
     (for all V of B => Has (A, V));
   function Setcontainsany (A, B : Integer_Array) return Boolean is
     (for some V of B => Has (A, V));
   function Set_Is_Disjoint (A, B : Integer_Array) return Boolean is
     (not Setcontainsany (A, B));
   function Set_Is_Equal (A, B : Integer_Array) return Boolean is
     (Setcontains (A, B) and then Setcontains (A => B, B => A));
   function Set_Is_Subset (A, B : Integer_Array) return Boolean is
     (Setcontains (A, B));
   function Set_Is_Proper_Subset (A, B : Integer_Array) return Boolean is
     (Setcontains (A, B) and then not Setcontains (A => B, B => A));
   function Set_Is_Superset (A, B : Integer_Array) return Boolean is
     (Setcontains (A => B, B => A));
   function Set_Is_Proper_Superset (A, B : Integer_Array) return Boolean is
     (Setcontains (A => B, B => A) and then not Setcontains (A, B));
   function Set_Is_Proper_Intersection (A, B : Integer_Array) return Boolean is
     (Setcontainsany (A, B) and then not Setcontains (A, B)
      and then not Setcontains (A => B, B => A));
   function Setinsert (A, B : Integer_Array) return Natural is
     (Setminus (A => B, B => A)'Length);
   function Setremove (A, B : Integer_Array) return Natural is
     (Setintersect (A, B)'Length);
   function Setinvert (A, B : Integer_Array) return Integer is
     (Setinsert (A, B) - Setremove (A, B));

   function Sumset (A, B : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. A'Length * B'Length) := [others => 0];
      N : Natural := 0;
   begin
      --  XS.xs: sumset, ds_iset.h: iset_add. Deduplicate pair sums.
      for V of A loop
         for W of B loop
            N := N + 1;
            R (N) := V + W;
         end loop;
      end loop;
      return Toset (R);
   end Sumset;

   function Sumset (A : Integer_Array) return Integer_Array is
     (Sumset (A, A));

   function Is_Sidon_Set (A : Integer_Array) return Boolean is
      S : constant Integer_Array := Toset (A);
      R : Integer_Array (1 .. S'Length * S'Length) := [others => 0];
      N : Natural := 0;
      V : I128;
   begin
      if (for some X of S => X < 0) then
         return False;
      end if;
      for I in S'Range loop
         for J in I .. S'Last loop
            V := S (I) + S (J);
            if Has (R (1 .. N), V) then
               return False;
            end if;
            N := N + 1;
            R (N) := V;
         end loop;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (A : Integer_Array) return Boolean is
   begin
      for V of A loop
         for W of A loop
            if Has (A, V + W) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;

   function Vecall (A : Integer_Array) return Boolean is
     (for all V of A => Predicate (V));

   function Vecany (A : Integer_Array) return Boolean is
     (for some V of A => Predicate (V));

   function Vecnone (A : Integer_Array) return Boolean is
     (for all V of A => not Predicate (V));

   function Vecnotall (A : Integer_Array) return Boolean is
     (for some V of A => not Predicate (V));

   function Vecfirst (A : Integer_Array) return Optional_Value is
   begin
      for V of A loop
         if Predicate (V) then
            return (True, V);
         end if;
      end loop;
      return (Defined => False);
   end Vecfirst;

   function Vecfirstidx (A : Integer_Array) return I128 is
   begin
      for I in A'Range loop
         if Predicate (A (I)) then
            return I128 (I - A'First);
         end if;
      end loop;
      return -1;
   end Vecfirstidx;

   function Vecreduce (A : Integer_Array) return Optional_Value is
      R : I128;
   begin
      if A'Length = 0 then
         return (Defined => False);
      end if;
      R := A (A'First);
      for I in A'Range loop
         if I > A'First then
            R := Operation (R, A (I));
         end if;
      end loop;
      return (True, R);
   end Vecreduce;

   function Vecslide (A : Integer_Array) return Integer_Array is
      R : Integer_Array (1 .. Natural'Max (1, A'Length) - 1) := [others => 0];
   begin
      for I in R'Range loop
         R (I) := Operation (A (A'First + I - 1), A (A'First + I));
      end loop;
      return R;
   end Vecslide;

   function Vecpairwise (A, B : Integer_Array) return Integer_Array is
      N : constant Natural := Natural'Min (A'Length, B'Length);
      function Tail (Offset : Natural) return Integer_Array;
      function Tail (Offset : Natural) return Integer_Array is
      begin
         if Offset = N then
            return [];
         end if;
         declare
            Part : constant Integer_Array :=
              Operation (A (A'First + Offset), B (B'First + Offset));
         begin
            return Part & Tail (Offset + 1);
         end;
      end Tail;
   begin
      return Tail (0);
   end Vecpairwise;

   function Vecwindow (A : Integer_Array; Step, Size : Positive)
      return Integer_Array
   is
      function Tail (Offset : Natural) return Integer_Array;
      function Tail (Offset : Natural) return Integer_Array is
      begin
         if Size > A'Length - Offset then
            return [];
         end if;
         declare
            Part : constant Integer_Array := Operation
              (A (A'First + Offset .. A'First + Offset + Size - 1));
         begin
            if Step > A'Length - Offset then
               return Part;
            end if;
            return Part & Tail (Offset + Step);
         end;
      end Tail;
   begin
      return Tail (0);
   end Vecwindow;

   function Setbinop (A, B : Integer_Array) return Integer_Array is
      X : constant Integer_Array := Toset (A);
      Y : constant Integer_Array := Toset (B);
      R : Integer_Array (1 .. X'Length * Y'Length) := [others => 0];
      N : Natural := 0;
   begin
      for V of X loop
         for W of Y loop
            N := N + 1;
            R (N) := Operation (V, W);
         end loop;
      end loop;
      return Toset (R);
   end Setbinop;

   function Vecsample (A : Integer_Array; K : Natural) return Integer_Array is
      R : Integer_Array (1 .. Natural'Min (K, A'Length)) := [others => 0];
      N : Natural := 0;
      Remaining : Natural := A'Length;
      Pick : Positive;
   begin
      --  XS.xs: vecsample, ordered selection without replacement.
      for V of A loop
         exit when N = R'Length;
         Pick := Draw (Remaining);
         if Pick > Remaining then
            raise Constraint_Error with "sample draw outside range";
         end if;
         if Pick <= R'Length - N then
            N := N + 1;
            R (N) := V;
         end if;
         Remaining := Remaining - 1;
      end loop;
      return R;
   end Vecsample;
end Math_Prime_Util.Vec;
