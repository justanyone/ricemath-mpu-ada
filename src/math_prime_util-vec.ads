with Ada.Numerics.Big_Numbers.Big_Integers;

--  Vector and set operations from Math::Prime::Util 0.75.
--  sort.c, xs_set.c, and ds_iset.h supply the native algorithms;
--  XS.xs and PP.pm supply the bigint and list-facing behavior.
--  Values are exact signed integers. Empty min/max are undefined.
--  Domain errors (negative mex input, negative extract mask) raise
--  Constraint_Error.
package Math_Prime_Util.Vec with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;

   type Integer_Array is array (Positive range <>) of Big_Integer;

   --  Undefined when the source list is empty (MPU returns undef).
   type Optional_Big (Defined : Boolean := False) is record
      case Defined is
         when True =>
            Value : Big_Integer;
         when False =>
            null;
      end case;
   end record;

   --  Length < 0 means undef (an index fell outside the source list).
   --  Length 0 is a defined empty list.
   type Sequence (Length : Integer) is record
      Items : Integer_Array (1 .. (if Length > 0 then Length else 0));
   end record;

   type Frequency is record
      Value : Big_Integer;
      Count : Positive;
   end record;
   type Frequency_Array is array (Positive range <>) of Frequency;

   --  Changed is the inserted, removed, or inserted-minus-removed count.
   type Set_Change (Length : Natural) is record
      Changed : Integer;
      Items   : Integer_Array (1 .. Length);
   end record;

   --  XS.xs: vecsum. Sum of the integers. An empty list sums to 0.
   function Vecsum (Items : Integer_Array) return Big_Integer
     with Pre => True,
          Post => (if Items'Length = 0 then Vecsum'Result = 0);

   --  XS.xs: vecprod. Product of the integers. An empty list yields 1.
   function Vecprod (Items : Integer_Array) return Big_Integer
     with Pre => True,
          Post => (if Items'Length = 0 then Vecprod'Result = 1);

   --  XS.xs: vecmin. Smallest value. Empty input is undefined.
   function Vecmin (Items : Integer_Array) return Optional_Big
     with Pre => True,
          Post => Vecmin'Result.Defined = (Items'Length > 0);

   --  XS.xs: vecmax. Largest value. Empty input is undefined.
   function Vecmax (Items : Integer_Array) return Optional_Big
     with Pre => True,
          Post => Vecmax'Result.Defined = (Items'Length > 0);

   --  XS.xs: vecprefixsum. Running sums, one per input element.
   function Vecprefixsum (Items : Integer_Array) return Integer_Array
     with Pre => True,
          Post => Vecprefixsum'Result'Length = Items'Length;

   --  XS.xs: vecuniq, using ds_iset.h iset_add. First-seen order.
   function Vecuniq (Items : Integer_Array) return Integer_Array
     with Pre => True,
          Post => Vecuniq'Result'Length <= Items'Length;

   --  XS.xs: vecsingleton. Values that occur once, in first-seen order.
   function Vecsingleton (Items : Integer_Array) return Integer_Array
     with Pre => True,
          Post => Vecsingleton'Result'Length <= Items'Length;

   --  XS.xs: vecfreq. Value and count pairs, sorted by value ascending.
   function Vecfreq (Items : Integer_Array) return Frequency_Array
     with Pre => True,
          Post => Vecfreq'Result'Length <= Items'Length;

   --  sort.c: sort_uv_array / sort_iv_array. Ascending numeric order.
   function Vecsort (Items : Integer_Array) return Integer_Array
     with Pre => True,
          Post => Vecsort'Result'Length = Items'Length;

   --  sort.c: sort_uv_array / sort_iv_array, then reversed.
   function Vecrsort (Items : Integer_Array) return Integer_Array
     with Pre => True,
          Post => Vecrsort'Result'Length = Items'Length;

   --  XS.xs: vecsorti. Sorts Items in place, ascending.
   procedure Vecsorti (Items : in out Integer_Array)
     with Pre => True, Post => True;

   --  XS.xs: vecrsorti. Sorts Items in place, descending.
   procedure Vecrsorti (Items : in out Integer_Array)
     with Pre => True, Post => True;

   --  XS.xs: vecmex. Smallest missing non-negative integer.
   --  A negative element raises Constraint_Error.
   function Vecmex (Items : Integer_Array) return Big_Integer
     with Pre => True,
          Post => Vecmex'Result >= 0;

   --  XS.xs: vecpmex. Smallest missing positive integer.
   --  A non-positive element raises Constraint_Error.
   function Vecpmex (Items : Integer_Array) return Big_Integer
     with Pre => True,
          Post => Vecpmex'Result >= 1;

   --  xs_set.c / PP.pm: toset. Sorted, duplicates removed.
   function Toset (Items : Integer_Array) return Integer_Array
     with Pre => True,
          Post => Toset'Result'Length <= Items'Length;

   --  PP.pm: vecequal. Same length and the same values in order.
   function Vecequal (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  XS.xs: vecextract. Mask bits select 0-based indexes.
   --  A negative mask raises Constraint_Error.
   --  An index outside Items makes the result undefined (Length < 0).
   function Vecextract
     (Items : Integer_Array; Mask : Big_Integer) return Sequence
     with Pre => True, Post => True;

   --  XS.xs: vecextract index-list form. Negative indexes count from
   --  the end, as in Perl. Out of range yields an undefined result.
   function Vecextract
     (Items : Integer_Array; Indexes : Integer_Array) return Sequence
     with Pre => True, Post => True;

   --  xs_set.c: xs_is_sidon_set. Non-negative, unique pairwise sums.
   function Is_Sidon_Set (Items : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: xs_is_sumfree_set. No pairwise sum lies in the set.
   function Is_Sumfree_Set (Items : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  PP.pm: sumset. Pairwise sums of one set with itself, as a set.
   function Sumset (Items : Integer_Array) return Integer_Array
     with Pre => True, Post => True;

   --  PP.pm: sumset. Pairwise sums of two sets, as a set.
   function Sumset (Left, Right : Integer_Array) return Integer_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_UNION.
   function Setunion (Left, Right : Integer_Array) return Integer_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_INTERSECT.
   function Setintersect (Left, Right : Integer_Array) return Integer_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_MINUS. Elements of Left not in Right.
   function Setminus (Left, Right : Integer_Array) return Integer_Array
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_DELTA. Symmetric difference.
   function Setdelta (Left, Right : Integer_Array) return Integer_Array
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_DISJOINT. No element in common.
   function Set_Is_Disjoint (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_EQUAL. The same elements, any order.
   function Set_Is_Equal (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_SUBSET. Every element of Right is in Left.
   function Set_Is_Subset (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_PROPER_SUBSET. Subset and strictly smaller.
   function Set_Is_Proper_Subset
     (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_SUPERSET. Every element of Left is in Right.
   function Set_Is_Superset (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_PROPER_SUPERSET. Superset and strictly smaller.
   function Set_Is_Proper_Superset
     (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: SET_REL_PROPER_INTERSECTION. Overlap, each side private.
   function Set_Is_Proper_Intersection
     (Left, Right : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: ins_into_set. Insert Values into Set. Changed = added.
   function Setinsert
     (Set, Values : Integer_Array) return Set_Change
     with Pre => True, Post => True;

   --  xs_set.c: del_from_set. Remove Values from Set. Changed = removed.
   function Setremove
     (Set, Values : Integer_Array) return Set_Change
     with Pre => True, Post => True;

   --  xs_set.c: symmetric insert/delete. Changed = added minus removed.
   function Setinvert
     (Set, Values : Integer_Array) return Set_Change
     with Pre => True, Post => True;

   --  PP.pm: setcontains. Every value is in Set. An empty list is true.
   function Setcontains (Set, Values : Integer_Array) return Boolean
     with Pre => True, Post => True;

   --  PP.pm: setcontainsany. Some value is in Set. An empty list is false.
   function Setcontainsany (Set, Values : Integer_Array) return Boolean
     with Pre => True, Post => True;

end Math_Prime_Util.Vec;
