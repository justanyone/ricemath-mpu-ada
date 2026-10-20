package body Math_Prime_Util.Vec is
   type I128 is range -(2 ** 127) .. 2 ** 127 - 1;

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
      R : Vector (S'Range);
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
      R : Vector (S'Range);
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
      R : Vector (1 .. A'Length);
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
      R : Vector (1 .. A'Length);
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

   function Missing (A : Vector; Start : I64) return I64 is
      M : I64 := Start;
   begin
      while (for some V of A => V = M) loop
         M := M + 1;
      end loop;
      return M;
   end Missing;

   function Vecmex (A : Vector) return I64 is (Missing (A, 0));
   function Vecpmex (A : Vector) return I64 is (Missing (A, 1));

   function Vecequal (A, B : Vector) return Boolean is (A = B);

   type Set_Operation is (Union_Op, Intersect_Op, Minus_Op, Delta_Op);

   function Merge (A, B : Vector; Op : Set_Operation) return Vector is
      R : Vector (1 .. A'Length + B'Length);
      I : Natural := A'First;
      J : Natural := B'First;
      N : Natural := 0;
      V : I64;
      Keep : Boolean;
   begin
      while I <= A'Last or J <= B'Last loop
         if I <= A'Last and then J <= B'Last and then A (I) = B (J)
         then
            V := A (I);
            I := I + 1;
            J := J + 1;
            Keep := Op in Union_Op | Intersect_Op;
         elsif I <= A'Last and then
           (J > B'Last or else A (I) < B (J))
         then
            V := A (I);
            I := I + 1;
            Keep := Op /= Intersect_Op;
         else
            V := B (J);
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

   function Setcontains (A, B : Vector) return Boolean is
     (Setminus (B, A)'Length = 0);

   function Setcontainsany (A, B : Vector) return Boolean is
     (Setintersect (A, B)'Length > 0);

   function Set_Is_Disjoint (A, B : Vector) return Boolean is
     (Setintersect (A, B)'Length = 0);

   function Set_Is_Equal (A, B : Vector) return Boolean is
     (A = B);

   function Set_Is_Subset (A, B : Vector) return Boolean is
     (Setcontains (A, B));

   function Set_Is_Proper_Subset (A, B : Vector) return Boolean is
     (A'Length > B'Length and then Setcontains (A, B));

   function Set_Is_Superset (A, B : Vector) return Boolean is
     (Setcontains (B, A));

   function Set_Is_Proper_Superset (A, B : Vector) return Boolean is
     (A'Length < B'Length and then Setcontains (B, A));

   function Set_Is_Proper_Intersection (A, B : Vector) return Boolean is
     (Setcontainsany (A, B) and then
      not Setcontains (A, B) and then not Setcontains (B, A));

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
   begin
      for I in A'Range loop
         for J in I .. A'Last loop
            if (for some V of A =>
                  I128 (V) = I128 (A (I)) + I128 (A (J)))
            then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end Is_Sumfree_Set;
end Math_Prime_Util.Vec;
