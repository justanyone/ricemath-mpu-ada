--  Signed integer vectors and sorted sets from MPU 0.75.
package Math_Prime_Util.Vec with SPARK_Mode => On is
   use type U128;

   type I128 is range -(2 ** 127) .. 2 ** 127 - 1;
   type Wide_Vector is array (Positive range <>) of I128;
   type Unsigned_Vector is array (Positive range <>) of U64;
   type I64 is range -(2 ** 63) .. 2 ** 63 - 1;
   type Vector is array (Positive range <>) of I64;

   --  True when A is strictly increasing; empty sets are valid.
   function Is_Set (A : Vector) return Boolean
     with Pre => True,
          Post => Is_Set'Result =
            (for all I in A'Range =>
               (if I > A'First then A (I - 1) < A (I)));

   --  sort.c: sort_iv_array, _qs_iv, _radixsort. Ascending copy.
   function Vecsort (A : Vector) return Vector
     with Pre => True,
          Post => Vecsort'Result'Length = A'Length and then
            (for all I in Vecsort'Result'Range =>
               (if I > Vecsort'Result'First then
                  Vecsort'Result (I - 1) <= Vecsort'Result (I)));

   --  sort.c: sort_iv_array, _qs_iv, _radixsort. Descending copy.
   function Vecrsort (A : Vector) return Vector
     with Pre => True,
          Post => Vecrsort'Result'Length = A'Length and then
            (for all I in Vecrsort'Result'Range =>
               (if I > Vecrsort'Result'First then
                  Vecrsort'Result (I - 1) >= Vecrsort'Result (I)));

   --  sort.c: sort_iv_array, _qs_iv, _radixsort. Integer sort; no errors.
   function Vecsorti (A : Vector) return Vector
     with Pre => True,
          Post => Vecsorti'Result'Length = A'Length;

   --  sort.c: sort_iv_array, _qs_iv, _radixsort. Integer sort; no errors.
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

   --  XS.xs: vecmex. Negative inputs raise Constraint_Error.
   function Vecmex (A : Vector) return I64
     with Pre => (for all V of A => V >= 0),
          Post => Vecmex'Result >= 0;

   --  XS.xs: vecpmex. Nonpositive inputs raise Constraint_Error.
   function Vecpmex (A : Vector) return I64
     with Pre => (for all V of A => V > 0),
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

   type Optional_Integer (Present : Boolean := False) is record
      case Present is
         when True => Value : I64;
         when False => null;
      end case;
   end record;

   --  XS.xs: vecsum. Widen unsigned sums to U128 rather than bigint.
   function Vecsum (A : Unsigned_Vector) return U128
     with Pre => True,
          Post => Vecsum'Result <= U128 (A'Length) * U128 (U64'Last);

   --  XS.xs: vecsum. Signed sums use a checked 128-bit accumulator.
   function Vecsum (A : Vector) return I128
     with Pre => True, Post => (if A'Length = 0 then Vecsum'Result = 0);

   --  XS.xs: vecprod. Raise Constraint_Error beyond signed 128 bits.
   function Vecprod (A : Vector) return I128
     with Pre => True, Post => (if A'Length = 0 then Vecprod'Result = 1);

   --  XS.xs: vecprefixsum. Widen each running total to signed 128 bits.
   function Vecprefixsum (A : Vector) return Wide_Vector
     with Pre => True, Post => Vecprefixsum'Result'Length = A'Length;

   --  XS.xs: vecmin/vecmax. Empty input returns an absent value.
   function Vecmin (A : Vector) return Optional_Integer
     with Pre => True, Post => Vecmin'Result.Present = (A'Length > 0);

   --  XS.xs: vecmin/vecmax. Empty input returns an absent value.
   function Vecmax (A : Vector) return Optional_Integer
     with Pre => True, Post => Vecmax'Result.Present = (A'Length > 0);

   type Optional_Wide_Integer (Present : Boolean := False) is record
      case Present is
         when True => Value : I128;
         when False => null;
      end case;
   end record;

   --  XS.xs: vecsum. Full-width inputs, checked signed 128-bit result.
   --  Raise Constraint_Error if an intermediate sum exceeds I128.
   function Vecsum (A : Wide_Vector) return I128
     with Pre => True, Post => (if A'Length = 0 then Vecsum'Result = 0);

   --  XS.xs: vecprod. Full-width inputs; zero annihilates the product.
   --  Raise Constraint_Error if a nonzero intermediate exceeds I128.
   function Vecprod (A : Wide_Vector) return I128
     with Pre => True, Post => (if A'Length = 0 then Vecprod'Result = 1);

   --  XS.xs: vecprefixsum. Full-width running sums, in input order.
   --  Raise Constraint_Error if an intermediate sum exceeds I128.
   function Vecprefixsum (A : Wide_Vector) return Wide_Vector
     with Pre => True, Post => Vecprefixsum'Result'Length = A'Length;

   --  XS.xs: vecmin. Full-width minimum; absent for empty input.
   function Vecmin (A : Wide_Vector) return Optional_Wide_Integer
     with Pre => True, Post => Vecmin'Result.Present = (A'Length > 0);

   --  XS.xs: vecmax. Full-width maximum; absent for empty input.
   function Vecmax (A : Wide_Vector) return Optional_Wide_Integer
     with Pre => True, Post => Vecmax'Result.Present = (A'Length > 0);

   --  XS.xs: vecreduce. Left fold; empty input returns absent.
   function Vecreduce
     (A : Vector; Op : not null access function (L, R : I64) return I64)
      return Optional_Integer
     with Pre => True, Post => Vecreduce'Result.Present = (A'Length > 0);

   --  XS.xs: vecany. Short-circuit predicate evaluation in input order.
   function Vecany
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
     with Pre => True, Post => True;

   --  XS.xs: vecany. Short-circuit predicate evaluation in input order.
   function Vecall
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
     with Pre => True, Post => True;

   --  XS.xs: vecany. Short-circuit predicate evaluation in input order.
   function Vecnone
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
     with Pre => True, Post => True;

   --  XS.xs: vecany. Short-circuit predicate evaluation in input order.
   function Vecnotall
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Boolean
     with Pre => True, Post => True;

   --  XS.xs: vecfirst. First matching value, or absent.
   function Vecfirst
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return Optional_Integer
     with Pre => True, Post => (if A'Length = 0 then
                                not Vecfirst'Result.Present);

   --  XS.xs: vecfirstidx. Zero-based position, or -1 if absent.
   function Vecfirstidx
     (A : Vector; Test : not null access function (V : I64) return Boolean)
      return I64
     with Pre => True, Post => Vecfirstidx'Result >= -1;

   --  XS.xs: vecextract. Set mask bits select zero-based positions.
   --  Positions outside the vector are absent, as with Perl undef.
   type Optional_Vector is array (Positive range <>) of Optional_Integer;
   function Vecextract (A : Vector; Mask : U128) return Optional_Vector
     with Pre => True, Post => Vecextract'Result'Length <= 128;

   --  XS.xs: vecextract. Negative indices count from the end.
   function Vecextract (A, Indices : Vector) return Optional_Vector
     with Pre => True, Post => Vecextract'Result'Length = Indices'Length;

   --  XS.xs: vecfreq. Sorted alternating values and occurrence counts.
   function Vecfreq (A : Vector) return Vector
     with Pre => A'Length <= Natural'Last / 2,
          Post => Vecfreq'Result'Length mod 2 = 0;

   --  XS.xs: vecslide. Apply scalar callback to adjacent pairs.
   function Vecslide
     (A : Vector; Op : not null access function (L, R : I64) return I64)
      return Vector
     with Pre => True,
          Post => Vecslide'Result'Length = Natural'Max (A'Length, 1) - 1;

   --  XS.xs: vecpairwise. Apply scalar callback through the shorter input.
   function Vecpairwise
     (A, B : Vector; Op : not null access function (L, R : I64) return I64)
      return Vector
     with Pre => True,
          Post => Vecpairwise'Result'Length = Natural'Min
                    (A'Length, B'Length);

   --  XS.xs: vecwindow. Apply scalar callback to complete windows only.
   function Vecwindow
     (A : Vector; Step, Size : Positive;
      Op : not null access function (Window : Vector) return I64)
      return Vector
     with Pre => True, Post => Vecwindow'Result'Length <= A'Length;

   --  XS.xs: vecpairwise (G_ARRAY). Concatenate each callback list in
   --  pair order; empty callback lists contribute no elements.
   --  Constraint_Error if the accumulated result exceeds Natural'Last.
   function Vecpairwise
     (A, B : Vector;
      Op : not null access function (L, R : I64) return Vector)
      return Vector
     with SPARK_Mode => Off, Pre => True,
          Post => (if A'Length = 0 or B'Length = 0 then
                     Vecpairwise'Result'Length = 0);

   --  XS.xs: vecwindow (G_ARRAY). Concatenate complete window results
   --  in input order; invoke the closure once per window.
   --  Constraint_Error if the accumulated result exceeds Natural'Last.
   function Vecwindow
     (A : Vector; Step, Size : Positive;
      Op : not null access function (Window : Vector) return Vector)
      return Vector
     with SPARK_Mode => Off, Pre => True,
          Post => (if A'Length < Size then Vecwindow'Result'Length = 0);

   --  XS.xs: setbinop. Callback on each Cartesian pair; sorted unique result.
   function Setbinop
     (A, B : Vector; Op : not null access function (L, R : I64) return I64)
      return Vector
     with Pre => B'Length = 0 or else
                    A'Length <= Natural'Last / B'Length,
          Post => Is_Set (Setbinop'Result);

   --  xs_set.c: type_of_sumset; XS.xs: sumset. Pair sums, sorted unique.
   --  Raise Constraint_Error if a result is outside I64.
   function Sumset (A, B : Vector) return Vector
     with Pre => B'Length = 0 or else
                    A'Length <= Natural'Last / B'Length,
          Post => Is_Set (Sumset'Result);

   --  XS.xs: sumset. One input means its sumset with itself.
   function Sumset (A : Vector) return Vector
     with Pre => A'Length = 0 or else
                    A'Length <= Natural'Last / A'Length,
          Post => Is_Set (Sumset'Result);

end Math_Prime_Util.Vec;
