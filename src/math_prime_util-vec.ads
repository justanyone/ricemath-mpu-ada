with Ada.Numerics.Big_Numbers.Big_Integers;

--  Vector and set operations from MPU 0.75.
--  sort.c orders integer arrays. xs_set.c and ds_iset.h implement the
--  set algebra, membership, Sidon and sum-free tests, and sumset.
--  Values are unbounded integers so the bigint rows of vec.tsv are exact.
--  The public sequence is an array, not a container instance, so a test
--  built with different check flags still links against the library.
--  A negative index in Vecextract counts from the end, as Perl does.
--  An index outside the array raises Undefined_Element (MPU undef).
--  A negative extract mask raises Constraint_Error (MPU croak).
package Math_Prime_Util.Vec with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;

   type Int_Array is array (Positive range <>) of Big_Integer;

   --  Defined is False when MPU returns undef. Value is then zero.
   type Optional_Big is record
      Defined : Boolean := False;
      Value : Big_Integer := To_Big_Integer (0);
   end record;

   --  XS.xs vecextract: a selected index is outside the array.
   Undefined_Element : exception;

   --  XS.xs: vecsum. Sum of the integers. An empty list sums to 0.
   function Vecsum (Items : Int_Array) return Big_Integer
     with Pre => True,
          Post => (if Items'Length = 0 then Vecsum'Result = 0);

   --  XS.xs: vecprod. Product of the integers. An empty list is 1.
   function Vecprod (Items : Int_Array) return Big_Integer
     with Pre => True,
          Post => (if Items'Length = 0 then Vecprod'Result = 1);

   --  XS.xs: vecmin. Smallest integer, or undefined when empty.
   function Vecmin (Items : Int_Array) return Optional_Big
     with Pre => True,
          Post => (if Items'Length = 0 then not Vecmin'Result.Defined
                   else Vecmin'Result.Defined
                     and then (for all V of Items =>
                                 Vecmin'Result.Value <= V)
                     and then (for some V of Items =>
                                 V = Vecmin'Result.Value));

   --  XS.xs: vecmax. Largest integer, or undefined when empty.
   function Vecmax (Items : Int_Array) return Optional_Big
     with Pre => True,
          Post => (if Items'Length = 0 then not Vecmax'Result.Defined
                   else Vecmax'Result.Defined
                     and then (for all V of Items =>
                                 Vecmax'Result.Value >= V)
                     and then (for some V of Items =>
                                 V = Vecmax'Result.Value));

   --  XS.xs: vecprefixsum. Running sums, one per input element.
   function Vecprefixsum (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Vecprefixsum'Result'Length = Items'Length;

   --  XS.xs: vecuniq, using ds_iset.h iset_add.
   --  First occurrence of each value, in input order.
   function Vecuniq (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Vecuniq'Result'Length <= Items'Length;

   --  XS.xs: vecsingleton. Values that occur exactly once, in order.
   function Vecsingleton (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Vecsingleton'Result'Length <= Items'Length;

   --  XS.xs: vecfreq, after sort.c. Pairs of value then count.
   --  Pairs are in increasing numeric order.
   function Vecfreq (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Vecfreq'Result'Length mod 2 = 0;

   --  sort.c: sort_iv_array / sort_uv_array. Nondecreasing copy.
   function Vecsort (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Vecsort'Result'Length = Items'Length
            and then (Vecsort'Result'Length < 2
              or else (for all I in Vecsort'Result'First ..
                         Vecsort'Result'Last - 1 =>
                         Vecsort'Result (I) <= Vecsort'Result (I + 1)));

   --  sort.c: sort then reverse. Nonincreasing copy.
   function Vecrsort (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Vecrsort'Result'Length = Items'Length
            and then (Vecrsort'Result'Length < 2
              or else (for all I in Vecrsort'Result'First ..
                         Vecrsort'Result'Last - 1 =>
                         Vecrsort'Result (I) >= Vecrsort'Result (I + 1)));

   --  sort.c: vecsorti. Sort Items in place, nondecreasing.
   procedure Vecsorti (Items : in out Int_Array)
     with Pre => True, Post => True;

   --  sort.c: vecrsorti. Sort Items in place, nonincreasing.
   procedure Vecrsorti (Items : in out Int_Array)
     with Pre => True, Post => True;

   --  XS.xs: vecmex. Least missing nonnegative integer.
   --  A negative element raises Constraint_Error.
   function Vecmex (Items : Int_Array) return Big_Integer
     with Pre => True,
          Post => Vecmex'Result >= 0;

   --  XS.xs: vecpmex. Least missing positive integer.
   --  An element that is not positive raises Constraint_Error.
   function Vecpmex (Items : Int_Array) return Big_Integer
     with Pre => True,
          Post => Vecpmex'Result >= 1;

   --  PP.pm: toset, ordered by sort.c. Sorted values, no duplicates.
   function Toset (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => Toset'Result'Length <= Items'Length;

   --  xs_set.c: xs_is_sidon_set. True when every element is
   --  nonnegative and the sums a_i + a_j for i <= j are unique.
   function Is_Sidon_Set (Items : Int_Array) return Boolean
     with Pre => True,
          Post => (if Items'Length = 0 then Is_Sidon_Set'Result);

   --  xs_set.c: xs_is_sumfree_set. True when no sum of two
   --  elements, including twice one element, lies in the set.
   function Is_Sumfree_Set (Items : Int_Array) return Boolean
     with Pre => True,
          Post => (if Items'Length = 0 then Is_Sumfree_Set'Result);

   --  xs_set.c: sumset of a list with itself. Result is a set.
   function Sumset (Items : Int_Array) return Int_Array
     with Pre => True,
          Post => (if Items'Length = 0 then Sumset'Result'Length = 0);

   --  xs_set.c: sumset of two lists. An empty side yields an empty set.
   function Sumset (Left, Right : Int_Array) return Int_Array
     with Pre => True,
          Post => (if Left'Length = 0 or else Right'Length = 0 then
                     Sumset'Result'Length = 0);

   --  XS.xs: vecequal. Same length and the same integers in order.
   function Vecequal (Left, Right : Int_Array) return Boolean
     with Pre => True,
          Post => (if Left'Length = 0 and then Right'Length = 0 then
                     Vecequal'Result);

   --  XS.xs: vecextract mask form. Bit i selects index i.
   --  A negative mask raises Constraint_Error.
   --  An index past the end raises Undefined_Element.
   function Vecextract (Items : Int_Array; Mask : Big_Integer)
      return Int_Array
     with Pre => True, Post => True;

   --  XS.xs: vecextract index-list form. Indexes are zero-based.
   --  A negative index counts from the end.
   --  An index outside the array raises Undefined_Element.
   function Vecextract (Items, Indexes : Int_Array) return Int_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_UNION. Sorted set of both inputs.
   function Setunion (Left, Right : Int_Array) return Int_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_INTERSECT. Sorted common elements.
   function Setintersect (Left, Right : Int_Array) return Int_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_MINUS. Sorted Left without Right.
   function Setminus (Left, Right : Int_Array) return Int_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_DELTA. Sorted symmetric difference.
   function Setdelta (Left, Right : Int_Array) return Int_Array
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_DISJOINT. True when no element is shared.
   --  An empty list is disjoint from every list.
   function Set_Is_Disjoint (Left, Right : Int_Array) return Boolean
     with Pre => True,
          Post => (if Left'Length = 0 or else Right'Length = 0 then
                     Set_Is_Disjoint'Result);

   --  xs_set.c: SET_REL_EQUAL. Same length and the same elements.
   function Set_Is_Equal (Left, Right : Int_Array) return Boolean
     with Pre => True,
          Post => (if Left'Length /= Right'Length then
                     not Set_Is_Equal'Result);

   --  xs_set.c: SET_REL_SUBSET. True when every element of Right
   --  is an element of Left (Mathematica SubsetQ).
   function Set_Is_Subset (Left, Right : Int_Array) return Boolean
     with Pre => True,
          Post => (if Right'Length = 0 then Set_Is_Subset'Result);

   --  xs_set.c: SET_REL_PROPER_SUBSET. Subset and Left is longer.
   function Set_Is_Proper_Subset (Left, Right : Int_Array)
      return Boolean
     with Pre => True,
          Post => (if Left'Length <= Right'Length then
                     not Set_Is_Proper_Subset'Result);

   --  xs_set.c: SET_REL_SUPERSET. True when Left is contained in Right.
   function Set_Is_Superset (Left, Right : Int_Array) return Boolean
     with Pre => True,
          Post => (if Left'Length = 0 then Set_Is_Superset'Result);

   --  xs_set.c: SET_REL_PROPER_SUPERSET. Superset and Right is longer.
   function Set_Is_Proper_Superset (Left, Right : Int_Array)
      return Boolean
     with Pre => True,
          Post => (if Right'Length <= Left'Length then
                     not Set_Is_Proper_Superset'Result);

   --  xs_set.c: SET_REL_PROPER_INTERSECTION.
   --  The sets overlap and neither contains the other.
   function Set_Is_Proper_Intersection (Left, Right : Int_Array)
      return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: is_in_set. True when every value is in Items.
   --  An empty value list is contained in every set.
   function Setcontains (Items, Values : Int_Array) return Boolean
     with Pre => True,
          Post => (if Values'Length = 0 then Setcontains'Result);

   --  xs_set.c: setcontainsany. True when any value is in Items.
   --  An empty value list shares nothing.
   function Setcontainsany (Items, Values : Int_Array) return Boolean
     with Pre => True,
          Post => (if Values'Length = 0 then not Setcontainsany'Result);

   --  xs_set.c: ins_into_set. Sorted union of Items and Values.
   --  Count is how many elements were added. Items must already be a set.
   function Setinsert
     (Items, Values : Int_Array; Count : out Integer) return Int_Array
     with Pre => True,
          Post => Count >= 0;

   --  xs_set.c: del_from_set. Sorted Items without Values.
   --  Count is how many elements were removed.
   function Setremove
     (Items, Values : Int_Array; Count : out Integer) return Int_Array
     with Pre => True,
          Post => Count >= 0;

   --  xs_set.c: setinvert. Toggle each value in the set Items.
   --  Count is the change in length, which may be negative.
   function Setinvert
     (Items, Values : Int_Array; Count : out Integer) return Int_Array
     with Pre => True, Post => True;
end Math_Prime_Util.Vec;
