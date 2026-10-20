with Ada.Containers.Vectors;

package body Math_Prime_Util.Vec is
   use type U64;
   use type U128;

   function Is_Set (A : Vector) return Boolean is
   begin
      for I in A'Range loop
         if I > A'First and then A (I - 1) >= A (I) then
            return False;
         end if;
      end loop;
      return True;
   end Is_Set;

   function Vecsort (A : Vector) return Vector is
      R : Vector (1 .. A'Length) := A;
      J : Positive;
      V : I64;
   begin
      for I in 2 .. R'Last loop
         V := R (I);
         J := I;
         while J > 1 and then R (J - 1) > V loop
            R (J) := R (J - 1);
            J := J - 1;
         end loop;
         R (J) := V;
      end loop;
      return R;
   end Vecsort;

   function Vecrsort (A : Vector) return Vector is
      S : constant Vector := Vecsort (A);
      R : Vector (S'Range) := [others => 0];
   begin
      for I in R'Range loop
         R (I) := S (S'Last - I + 1);
      end loop;
      return R;
   end Vecrsort;

   function Vecsorti (A : Vector) return Vector is (Vecsort (A));
   function Vecrsorti (A : Vector) return Vector is (Vecrsort (A));

   function Toset (A : Vector) return Vector is
      S : constant Vector := Vecsort (A);
      R : Vector (S'Range) := [others => 0];
      N : Natural := 0;
   begin
      for V of S loop
         if N = 0 or else R (N) /= V then
            N := N + 1;
            R (N) := V;
         end if;
      end loop;
      return R (1 .. N);
   end Toset;

   function Vecuniq (A : Vector) return Vector is
      R : Vector (1 .. A'Length) := [others => 0];
      N : Natural := 0;
   begin
      for V of A loop
         if not (for some I in 1 .. N => R (I) = V) then
            N := N + 1;
            R (N) := V;
         end if;
      end loop;
      return R (1 .. N);
   end Vecuniq;

   function Vecsingleton (A : Vector) return Vector is
      R : Vector (1 .. A'Length) := [others => 0];
      N, Count : Natural := 0;
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

   function Missing (A : Vector; Start : I64) return I64;

   function Missing (A : Vector; Start : I64) return I64 is
      Seen : array (1 .. A'Length) of Boolean := [others => False];
      Offset : I128;
   begin
      for V of A loop
         if V < Start then
            raise Constraint_Error with "invalid MEX input";
         end if;
         Offset := I128 (V) - I128 (Start);
         if Offset < I128 (A'Length) then
            Seen (Natural (Offset) + 1) := True;
         end if;
      end loop;
      for I in Seen'Range loop
         if not Seen (I) then
            return Start + I64 (I - 1);
         end if;
      end loop;
      return Start + I64 (A'Length);
   end Missing;

   function Vecmex (A : Vector) return I64 is (Missing (A, 0));
   function Vecpmex (A : Vector) return I64 is (Missing (A, 1));

   function Vecequal (A, B : Vector) return Boolean is (A = B);

   type Set_Operation is (Union_Op, Intersect_Op, Minus_Op, Delta_Op);

   function Merge (A, B : Vector; Op : Set_Operation) return Vector;

   function Merge (A, B : Vector; Op : Set_Operation) return Vector is
      R : Vector (1 .. A'Length + B'Length);
      I : Natural := 0;
      J : Natural := 0;
      N : Natural := 0;
      V : I64;
      Keep : Boolean;
   begin
      if not Is_Set (A) or else not Is_Set (B) then
         raise Constraint_Error with "set inputs must be sorted and unique";
      end if;
      while I < A'Length or J < B'Length loop
         if I < A'Length and then J < B'Length and then A (A'First + I) = B (B'First + J)
         then
            V := A (A'First + I);
            I := I + 1;
            J := J + 1;
            Keep := Op in Union_Op | Intersect_Op;
         elsif I < A'Length and then
           (J >= B'Length or else A (A'First + I) < B (B'First + J))
         then
            V := A (A'First + I);
            I := I + 1;
            Keep := Op /= Intersect_Op;
         else
            V := B (B'First + J);
            J := J + 1;
            Keep := Op in Union_Op | Delta_Op;
         end if;
         if Keep then
            N := N + 1;
            R (N) := V;
         end if;
      end loop;
      return R (1 .. N);
   end Merge;

   function Setunion (A, B : Vector) return Vector is
     (Merge (A, B, Union_Op));

   function Setintersect (A, B : Vector) return Vector is
     (Merge (A, B, Intersect_Op));

   function Setminus (A, B : Vector) return Vector is
     (Merge (A, B, Minus_Op));

   function Setdelta (A, B : Vector) return Vector is
     (Merge (A, B, Delta_Op));

   function Setinsert (A, B : Vector) return Vector is
     (Setunion (A, B));

   function Setremove (A, B : Vector) return Vector is
     (Setminus (A, B));

   function Setinvert (A, B : Vector) return Vector is
     (Setdelta (A, B));

   --  xs_set.c: xs_set_relation. Count a merge intersection without
   --  allocating a result. Offsets permit arrays ending at Positive'Last.
   function Intersection_Count (A, B : Vector) return Natural;

   function Intersection_Count (A, B : Vector) return Natural is
      I, J, Count : Natural := 0;
   begin
      while I < A'Length and then J < B'Length loop
         if A (A'First + I) = B (B'First + J) then
            Count := Count + 1;
            I := I + 1;
            J := J + 1;
         elsif A (A'First + I) < B (B'First + J) then
            I := I + 1;
         else
            J := J + 1;
         end if;
      end loop;
      return Count;
   end Intersection_Count;

   function Setcontains (A, B : Vector) return Boolean is
     (A'Length >= B'Length and then
      Intersection_Count (A, B) = B'Length);

   function Setcontainsany (A, B : Vector) return Boolean is
     (Intersection_Count (A, B) > 0);

   function Set_Is_Disjoint (A, B : Vector) return Boolean is
     (Intersection_Count (A, B) = 0);

   function Set_Is_Equal (A, B : Vector) return Boolean is
     (A = B);

   function Set_Is_Subset (A, B : Vector) return Boolean is
     (Setcontains (A, B));

   function Set_Is_Proper_Subset (A, B : Vector) return Boolean is
     (A'Length > B'Length and then Setcontains (A, B));

   function Set_Is_Superset (A, B : Vector) return Boolean is
     (Setcontains (A => B, B => A));

   function Set_Is_Proper_Superset (A, B : Vector) return Boolean is
     (A'Length < B'Length and then Setcontains (A => B, B => A));

   function Set_Is_Proper_Intersection (A, B : Vector) return Boolean is
      Count : constant Natural := Intersection_Count (A, B);
   begin
      return Count > 0 and then Count < A'Length and then Count < B'Length;
   end Set_Is_Proper_Intersection;

   function Is_Sidon_Set (A : Vector) return Boolean is
   begin
      if (for some V of A => V < 0) then
         return False;
      end if;
      for I in A'Range loop
         for J in I .. A'Last loop
            for K in A'First .. I loop
               for L in K .. A'Last loop
                  if (K /= I or L /= J) and then
                    I128 (A (I)) + I128 (A (J)) =
                    I128 (A (K)) + I128 (A (L))
                  then
                     return False;
                  end if;
               end loop;
            end loop;
         end loop;
      end loop;
      return True;
   end Is_Sidon_Set;

   function Is_Sumfree_Set (A : Vector) return Boolean is
      Low, High, Mid : Natural;
      Sum : I128;
   begin
      --  xs_set.c: xs_is_sumfree_set. Test each unordered pair sum by
      --  binary search in the sorted input, using wide sums at I64 edges.
      for I in A'Range loop
         for J in I .. A'Last loop
            Sum := I128 (A (I)) + I128 (A (J));
            Low := 0;
            High := A'Length;
            while Low < High loop
               Mid := Low + (High - Low) / 2;
               if I128 (A (A'First + Mid)) < Sum then
                  Low := Mid + 1;
               elsif I128 (A (A'First + Mid)) > Sum then
                  High := Mid;
               else
                  return False;
               end if;
            end loop;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;
   function Vecsum (A : Unsigned_Vector) return U128 is
      R : U128 := 0;
   begin
      for V of A loop
         R := R + U128 (V);
      end loop;
      return R;
   end Vecsum;

   function Vecsum (A : Vector) return I128 is
      R : I128 := 0;
   begin
      for V of A loop
         R := R + I128 (V);
      end loop;
      return R;
   end Vecsum;

   function Vecprod (A : Vector) return I128 is
      R : I128 := 1;
   begin
      --  A zero annihilates even a product whose intermediate value is large.
      if (for some V of A => V = 0) then
         return 0;
      end if;
      for V of A loop
         R := R * I128 (V);
      end loop;
      return R;
   end Vecprod;

   function Vecprefixsum (A : Vector) return Wide_Vector is
      R : Wide_Vector (1 .. A'Length);
      Total : I128 := 0;
   begin
      for I in R'Range loop
         Total := Total + I128 (A (A'First + (I - 1)));
         R (I) := Total;
      end loop;
      return R;
   end Vecprefixsum;

   function Vecmin (A : Vector) return Optional_Integer is
      R : Optional_Integer;
   begin
      for V of A loop
         if not R.Present or else V < R.Value then
            R := (Present => True, Value => V);
         end if;
      end loop;
      return R;
   end Vecmin;

   function Vecmax (A : Vector) return Optional_Integer is
      R : Optional_Integer;
   begin
      for V of A loop
         if not R.Present or else V > R.Value then
            R := (Present => True, Value => V);
         end if;
      end loop;
      return R;
   end Vecmax;

   function Vecsum (A : Wide_Vector) return I128 is
      R : I128 := 0;
   begin
      for V of A loop
         R := R + V;
      end loop;
      return R;
   end Vecsum;

   function Vecprod (A : Wide_Vector) return I128 is
      R : I128 := 1;
   begin
      if (for some V of A => V = 0) then
         return 0;
      end if;
      for V of A loop
         R := R * V;
      end loop;
      return R;
   end Vecprod;

   function Vecprefixsum (A : Wide_Vector) return Wide_Vector is
      R : Wide_Vector (A'Range);
      Total : I128 := 0;
   begin
      for I in A'Range loop
         Total := Total + A (I);
         R (I) := Total;
      end loop;
      return R;
   end Vecprefixsum;

   function Vecmin (A : Wide_Vector) return Optional_Wide_Integer is
      R : Optional_Wide_Integer;
   begin
      for V of A loop
         if not R.Present or else V < R.Value then
            R := (True, V);
         end if;
      end loop;
      return R;
   end Vecmin;

   function Vecmax (A : Wide_Vector) return Optional_Wide_Integer is
      R : Optional_Wide_Integer;
   begin
      for V of A loop
         if not R.Present or else V > R.Value then
            R := (True, V);
         end if;
      end loop;
      return R;
   end Vecmax;

   function Vecreduce
     (A : Vector; Op : not null access function (L, R : I64) return I64)
      return Optional_Integer
   is
      R : Optional_Integer;
   begin
      for V of A loop
         if R.Present then
            R.Value := Op (R.Value, V);
         else
            R := (Present => True, Value => V);
         end if;
      end loop;
      return R;
   end Vecreduce;

   function Vecany
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
   is
   begin
      for V of A loop
         if Test (V) then
            return True;
         end if;
      end loop;
      return False;
   end Vecany;

   function Vecall
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
   is
   begin
      for V of A loop
         if not Test (V) then
            return False;
         end if;
      end loop;
      return True;
   end Vecall;

   function Vecnone
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
   is
   begin
      for V of A loop
         if Test (V) then
            return False;
         end if;
      end loop;
      return True;
   end Vecnone;

   function Vecnotall
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
   is
   begin
      for V of A loop
         if not Test (V) then
            return True;
         end if;
      end loop;
      return False;
   end Vecnotall;

   function Vecfirst
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Optional_Integer
   is
   begin
      for V of A loop
         if Test (V) then
            return (Present => True, Value => V);
         end if;
      end loop;
      return (Present => False);
   end Vecfirst;

   function Vecfirstidx
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return I64
   is
   begin
      for I in A'Range loop
         if Test (A (I)) then
            return I64 (I - A'First);
         end if;
      end loop;
      return -1;
   end Vecfirstidx;

   function Vecextract (A, Indices : Vector) return Optional_Vector is
      R : Optional_Vector (1 .. Indices'Length);
      J : I128;
   begin
      for I in R'Range loop
         J := I128 (Indices (Indices'First + (I - 1)));
         if J < 0 then
            J := J + I128 (A'Length);
         end if;
         if J >= 0 and then J < I128 (A'Length) then
            R (I) := (True, A (A'First + Natural (J)));
         end if;
      end loop;
      return R;
   end Vecextract;

   function Vecextract (A : Vector; Mask : U128) return Optional_Vector is
      R : Optional_Vector (1 .. 128);
      Bits : U128 := Mask;
      N : Natural := 0;
      I : Natural := 0;
   begin
      while Bits /= 0 loop
         if Bits mod 2 = 1 then
            N := N + 1;
            if I < A'Length then
               R (N) := (True, A (A'First + I));
            end if;
         end if;
         Bits := Bits / 2;
         I := I + 1;
      end loop;
      return R (1 .. N);
   end Vecextract;

   function Vecfreq (A : Vector) return Vector is
      S : constant Vector := Vecsort (A);
      R : Vector (1 .. A'Length * 2);
      N : Natural := 0;
   begin
      for V of S loop
         if N > 0 and then R (N - 1) = V then
            R (N) := R (N) + 1;
         else
            R (N + 1) := V;
            R (N + 2) := 1;
            N := N + 2;
         end if;
      end loop;
      return R (1 .. N);
   end Vecfreq;

   function Vecslide
     (A : Vector; Op : not null access function (L, R : I64) return I64)
      return Vector
   is
      R : Vector (1 .. Natural'Max (A'Length, 1) - 1);
   begin
      for I in R'Range loop
         R (I) := Op (A (A'First + (I - 1)), A (A'First + I));
      end loop;
      return R;
   end Vecslide;

   function Vecpairwise
     (A, B : Vector; Op : not null access function (L, R : I64) return I64)
      return Vector
   is
      R : Vector (1 .. Natural'Min (A'Length, B'Length));
   begin
      for I in R'Range loop
         R (I) := Op (A (A'First + (I - 1)), B (B'First + (I - 1)));
      end loop;
      return R;
   end Vecpairwise;

   function Vecwindow
     (A : Vector; Step, Size : Positive;
      Op : not null access function (Window : Vector) return I64)
      return Vector
   is
      N : constant Natural :=
        (if A'Length < Size then 0 else (A'Length - Size) / Step + 1);
      R : Vector (1 .. N);
      J : Natural;
   begin
      for I in R'Range loop
         J := A'First + (I - 1) * Step;
         R (I) := Op (A (J .. J + (Size - 1)));
      end loop;
      return R;
   end Vecwindow;

   function Vecpairwise
     (A, B : Vector;
      Op : not null access function (L, R : I64) return Vector)
      return Vector
   is
      package Lists is new Ada.Containers.Vectors (Positive, I64);
      Result : Lists.Vector;
   begin
      for I in 1 .. Natural'Min (A'Length, B'Length) loop
         declare
            Part : constant Vector :=
              Op (A (A'First + (I - 1)), B (B'First + (I - 1)));
         begin
            for V of Part loop
               Result.Append (V);
            end loop;
         end;
      end loop;
      return R : Vector (1 .. Natural (Result.Length)) do
         for I in R'Range loop
            R (I) := Result (I);
         end loop;
      end return;
   end Vecpairwise;

   function Vecwindow
     (A : Vector; Step, Size : Positive;
      Op : not null access function (Window : Vector) return Vector)
      return Vector
   is
      package Lists is new Ada.Containers.Vectors (Positive, I64);
      Result : Lists.Vector;
      N : constant Natural :=
        (if A'Length < Size then 0 else (A'Length - Size) / Step + 1);
      J : Natural;
   begin
      for I in 1 .. N loop
         J := A'First + (I - 1) * Step;
         declare
            Part : constant Vector := Op (A (J .. J + (Size - 1)));
         begin
            for V of Part loop
               Result.Append (V);
            end loop;
         end;
      end loop;
      return R : Vector (1 .. Natural (Result.Length)) do
         for I in R'Range loop
            R (I) := Result (I);
         end loop;
      end return;
   end Vecwindow;

   function Setbinop
     (A, B : Vector; Op : not null access function (L, R : I64) return I64)
      return Vector
   is
      R : Vector (1 .. A'Length * B'Length);
      N : Natural := 0;
   begin
      for V of A loop
         for W of B loop
            N := N + 1;
            R (N) := Op (V, W);
         end loop;
      end loop;
      return Toset (R);
   end Setbinop;

   function Sumset (A, B : Vector) return Vector is
      R : Vector (1 .. A'Length * B'Length);
      N : Natural := 0;
   begin
      for V of A loop
         for W of B loop
            N := N + 1;
            R (N) := I64 (I128 (V) + I128 (W));
         end loop;
      end loop;
      return Toset (R);
   end Sumset;

   function Sumset (A : Vector) return Vector is (Sumset (A, A));
end Math_Prime_Util.Vec;
