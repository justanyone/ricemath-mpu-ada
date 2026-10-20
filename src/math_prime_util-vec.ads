--  Signed integer vectors and sorted sets from MPU 0.75.
package Math_Prime_Util.Vec with SPARK_Mode => On is
   type I64 is range -(2 ** 63) .. 2 ** 63 - 1;
   type Vector is array (Positive range <>) of I64;

   --  True when A is strictly increasing; empty sets are valid.
   function Is_Set (A : Vector) return Boolean
     with Pre => True,
          Post => (if A'Length < 2 then Is_Set'Result);

   --  sort.c: insertionsort_iv. Ascending copy; no errors.
   function Vecsort (A : Vector) return Vector
     with Pre => True,
          Post => Vecsort'Result'Length = A'Length;

   --  sort.c: insertionsort_iv. Descending copy; no errors.
   function Vecrsort (A : Vector) return Vector
     with Pre => True,
          Post => Vecrsort'Result'Length = A'Length;

   --  sort.c: insertionsort_iv. Integer sort; no errors.
   function Vecsorti (A : Vector) return Vector
     with Pre => True,
          Post => Vecsorti'Result'Length = A'Length;

   --  sort.c: insertionsort_iv. Integer sort; no errors.
   function Vecrsorti (A : Vector) return Vector
     with Pre => True,
          Post => Vecrsorti'Result'Length = A'Length;

   --  sort.c: sort_dedup_uv_array. Sorted unique copy.
   function Toset (A : Vector) return Vector
     with Pre => True,
          Post => Is_Set (Toset'Result);

   --  ds_iset.h: iset_add/iset_contains. Retain input order.
   function Vecuniq (A : Vector) return Vector
     with Pre => True,
          Post => Vecuniq'Result'Length <= A'Length;

   --  ds_iset.h: iset_add/iset_contains. Retain input order.
   function Vecsingleton (A : Vector) return Vector
     with Pre => True,
          Post => Vecsingleton'Result'Length <= A'Length;

   --  ds_iset.h: iset_contains. First missing nonnegative integer.
   function Vecmex (A : Vector) return I64
     with Pre => True,
          Post => Vecmex'Result >= 0;

   --  ds_iset.h: iset_contains. First missing nonnegative integer.
   function Vecpmex (A : Vector) return I64
     with Pre => True,
          Post => Vecpmex'Result >= 1;

   --  sort.c: signed comparison. Ordered equality; no errors.
   function Vecequal (A, B : Vector) return Boolean
     with Pre => True,
          Post => (if A'Length /= B'Length then not Vecequal'Result);

   --  xs_set.c: set_arrayref_from_sv_merge. Sorted set result.
   function Setunion (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setunion'Result);

   --  xs_set.c: set_arrayref_from_sv_merge. Sorted set result.
   function Setintersect (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setintersect'Result);

   --  xs_set.c: set_arrayref_from_sv_merge. Sorted set result.
   function Setminus (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setminus'Result);

   --  xs_set.c: set_arrayref_from_sv_merge. Sorted set result.
   function Setdelta (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setdelta'Result);

   --  xs_set.c: ins_into_set/del_from_set. Return changed set.
   function Setinsert (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setinsert'Result);

   --  xs_set.c: ins_into_set/del_from_set. Return changed set.
   function Setremove (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setremove'Result);

   --  xs_set.c: ins_into_set/del_from_set. Return changed set.
   function Setinvert (A, B : Vector) return Vector
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => Is_Set (Setinvert'Result);

   --  xs_set.c: is_in_set. Test all/any values in B.
   function Setcontains (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => (if B'Length = 0 then Setcontains'Result);

   --  xs_set.c: is_in_set. Test all/any values in B.
   function Setcontainsany (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => (if B'Length = 0 then not Setcontainsany'Result);

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Disjoint (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Equal (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Subset (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Proper_Subset (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Superset (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Proper_Superset (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_set_relation. B is compared against A.
   function Set_Is_Proper_Intersection (A, B : Vector) return Boolean
     with Pre => Is_Set (A) and then Is_Set (B),
          Post => True;

   --  xs_set.c: xs_is_sidon_set. Wide sums avoid overflow.
   function Is_Sidon_Set (A : Vector) return Boolean
     with Pre => Is_Set (A),
          Post => (if A'Length = 0 then Is_Sidon_Set'Result);

   --  xs_set.c: xs_is_sumfree_set. Wide sums avoid overflow.
   function Is_Sumfree_Set (A : Vector) return Boolean
     with Pre => Is_Set (A),
          Post => (if A'Length = 0 then Is_Sumfree_Set'Result);

end Math_Prime_Util.Vec;
