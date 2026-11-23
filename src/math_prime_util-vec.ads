with Ada.Numerics.Big_Numbers.Big_Integers;

--  Vector and set operations from Math::Prime::Util 0.75.
--  sort.c supplies the numeric order. xs_set.c and ds_iset.h supply
--  the set relations. Values are unbounded integers, so results past
--  2^64 stay exact. An empty minimum or a bad index is Constraint_Error
--  (MPU returns undef). A negative mex argument is Constraint_Error
--  (MPU croaks).
package Math_Prime_Util.Vec with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;

   --  Integer elements have no physical unit.
   type Int_Vector is array (Positive range <>) of Big_Integer;

   --  XS.xs: vecsum. Sum of the elements. The empty sum is 0.
   function Vecsum (Items : Int_Vector) return Big_Integer
     with Pre => True,
          Post => (if Items'Length = 0 then Vecsum'Result = 0 else True);

   --  XS.xs: vecprod. Product of the elements. The empty product is 1.
   function Vecprod (Items : Int_Vector) return Big_Integer
     with Pre => True,
          Post => (if Items'Length = 0 then Vecprod'Result = 1
                   elsif (for some V of Items => V = 0)
                   then Vecprod'Result = 0 else True);

   --  XS.xs: vecmin. Least element. An empty vector raises
   --  Constraint_Error.
   function Vecmin (Items : Int_Vector) return Big_Integer
     with Pre => Items'Length > 0,
          Post => (for some V of Items => V = Vecmin'Result)
            and then (for all V of Items => Vecmin'Result <= V);

   --  XS.xs: vecmax. Greatest element. An empty vector raises
   --  Constraint_Error.
   function Vecmax (Items : Int_Vector) return Big_Integer
     with Pre => Items'Length > 0,
          Post => (for some V of Items => V = Vecmax'Result)
            and then (for all V of Items => Vecmax'Result >= V);

   --  XS.xs: vecprefixsum. Running totals, one per element.
   function Vecprefixsum (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecprefixsum'Result'Length = Items'Length;

   --  XS.xs: vecuniq, using ds_iset.c iset_add. First occurrence of
   --  each value, in input order.
   function Vecuniq (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecuniq'Result'Length <= Items'Length;

   --  XS.xs: vecsingleton. Values that occur once, in input order.
   function Vecsingleton (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecsingleton'Result'Length <= Items'Length;

   --  XS.xs: vecfreq, ordered by sort.c. Flat pairs of value then count,
   --  sorted by value.
   function Vecfreq (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecfreq'Result'Length mod 2 = 0;

   --  sort.c: sort_uv_array and sort_iv_array. Ascending numeric order.
   function Vecsort (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecsort'Result'Length = Items'Length
            and then (for all I in Vecsort'Result'First ..
                        Vecsort'Result'Last - 1 =>
                        Vecsort'Result (I) <= Vecsort'Result (I + 1));

   --  XS.xs: vecrsort. Descending numeric order.
   function Vecrsort (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecrsort'Result'Length = Items'Length
            and then (for all I in Vecrsort'Result'First ..
                        Vecrsort'Result'Last - 1 =>
                        Vecrsort'Result (I) >= Vecrsort'Result (I + 1));

   --  XS.xs: vecsorti. The vector after an in-place ascending sort.
   function Vecsorti (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecsorti'Result = Vecsort (Items);

   --  XS.xs: vecrsorti. The vector after an in-place descending sort.
   function Vecrsorti (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecrsorti'Result = Vecrsort (Items);

   --  XS.xs: vecmex. Smallest missing nonnegative integer. A negative
   --  element raises Constraint_Error. The empty vector returns 0.
   function Vecmex (Items : Int_Vector) return Big_Integer
     with Pre => True,
          Post => Vecmex'Result >= 0;

   --  XS.xs: vecpmex. Smallest missing positive integer. A nonpositive
   --  element raises Constraint_Error. The empty vector returns 1.
   function Vecpmex (Items : Int_Vector) return Big_Integer
     with Pre => True,
          Post => Vecpmex'Result >= 1;

   --  XS.xs: toset. Sorted values with duplicates removed.
   function Toset (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => (for all I in Toset'Result'First ..
                     Toset'Result'Last - 1 =>
                     Toset'Result (I) < Toset'Result (I + 1));

   --  xs_set.c: xs_is_sidon_set. True when every sum of two elements,
   --  including twice an element, is unique, and no element is negative.
   function Is_Sidon_Set (Items : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: xs_is_sumfree_set. True when no sum of two elements,
   --  including twice an element, is itself an element.
   function Is_Sumfree_Set (Items : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  PP.pm: sumset. Sorted unique sums of one element from each vector.
   --  An empty side yields an empty vector.
   function Sumset (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => (for all I in Sumset'Result'First ..
                     Sumset'Result'Last - 1 =>
                     Sumset'Result (I) < Sumset'Result (I + 1));

   --  PP.pm: sumset of one vector with itself.
   function Sumset (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Sumset'Result = Sumset (Items, Items);

   --  XS.xs: vecequal. Same length and the same elements in order.
   function Vecequal (Left, Right : Int_Vector) return Boolean
     with Pre => True,
          Post => (if Left'Length /= Right'Length
                   then not Vecequal'Result else True);

   --  XS.xs: vecextract. Bits of Mask, from bit 0, select elements.
   --  A negative mask or an index past the vector raises
   --  Constraint_Error.
   function Vecextract
     (Items : Int_Vector; Mask : Big_Integer) return Int_Vector
     with Pre => Mask >= 0,
          Post => Vecextract'Result'Length <= Items'Length;

   --  XS.xs: vecextract index-list form. A negative index counts from
   --  the end. An index outside the vector raises Constraint_Error.
   function Vecextract
     (Items : Int_Vector; Indexes : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecextract'Result'Length = Indexes'Length;

   --  xs_set.c: xs_set_op SET_OP_UNION. Sorted unique elements of either.
   function Setunion (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => (for all I in Setunion'Result'First ..
                     Setunion'Result'Last - 1 =>
                     Setunion'Result (I) < Setunion'Result (I + 1));

   --  xs_set.c: xs_set_op SET_OP_INTERSECT. Sorted unique common elements.
   function Setintersect (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => (for all I in Setintersect'Result'First ..
                     Setintersect'Result'Last - 1 =>
                     Setintersect'Result (I) < Setintersect'Result (I + 1));

   --  xs_set.c: xs_set_op SET_OP_MINUS. Sorted unique elements of Left
   --  that are not in Right.
   function Setminus (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => (for all I in Setminus'Result'First ..
                     Setminus'Result'Last - 1 =>
                     Setminus'Result (I) < Setminus'Result (I + 1));

   --  xs_set.c: xs_set_op SET_OP_DELTA. Sorted unique symmetric difference.
   function Setdelta (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => (for all I in Setdelta'Result'First ..
                     Setdelta'Result'Last - 1 =>
                     Setdelta'Result (I) < Setdelta'Result (I + 1));

   --  xs_set.c: xs_set_relation SET_REL_DISJOINT. No shared element.
   --  Two empty vectors are disjoint.
   function Set_Is_Disjoint (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_relation SET_REL_EQUAL. The same elements.
   function Set_Is_Equal (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_relation SET_REL_SUBSET. Right is a subset of
   --  Left. An empty Right is a subset.
   function Set_Is_Subset (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_relation SET_REL_PROPER_SUBSET. Right is a
   --  subset of Left and Left has more distinct elements.
   function Set_Is_Proper_Subset (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_relation SET_REL_SUPERSET. Left is a subset of
   --  Right.
   function Set_Is_Superset (Left, Right : Int_Vector) return Boolean
     with Pre => True,
          Post => Set_Is_Superset'Result = Set_Is_Subset (Right, Left);

   --  xs_set.c: xs_set_relation SET_REL_PROPER_SUPERSET. Left is a
   --  proper subset of Right.
   function Set_Is_Proper_Superset
     (Left, Right : Int_Vector) return Boolean
     with Pre => True,
          Post => Set_Is_Proper_Superset'Result =
            Set_Is_Proper_Subset (Right, Left);

   --  xs_set.c: xs_set_relation SET_REL_PROPER_INTERSECTION. The
   --  intersection is nonempty and smaller than both sets.
   function Set_Is_Proper_Intersection
     (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: ins_into_set. The set after inserting Right into Left.
   function Setinsert (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Setinsert'Result = Setunion (Left, Right);

   --  xs_set.c: del_from_set. The set after removing Right from Left.
   function Setremove (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Setremove'Result = Setminus (Left, Right);

   --  xs_set.c: symmetric insert-or-delete of Right in Left.
   function Setinvert (Left, Right : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Setinvert'Result = Setdelta (Left, Right);

   --  PP.pm: setcontains. Every element of Values is in Set.
   function Setcontains (Set, Values : Int_Vector) return Boolean
     with Pre => True,
          Post => Setcontains'Result = Set_Is_Subset (Set, Values);

   --  PP.pm: setcontainsany. Some element of Values is in Set.
   function Setcontainsany (Set, Values : Int_Vector) return Boolean
     with Pre => True, Post => True;

end Math_Prime_Util.Vec;
