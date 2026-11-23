with Ada.Containers.Vectors;
with Ada.Numerics.Big_Numbers.Big_Integers;

--  Vector and set operations from MPU 0.75.
--  sort.c sorts, xs_set.c applies set algebra, and ds_iset.h dedups.
package Math_Prime_Util.Vec with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;

   package Int_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Big_Integer);
   subtype Int_List is Int_Vectors.Vector;

   --  Defined is False when MPU returns undef.
   type Value_Result is record
      Defined : Boolean := False;
      Value : Big_Integer := To_Big_Integer (0);
   end record;

   --  Defined is False when an extraction selects no element.
   type List_Result is record
      Defined : Boolean := True;
      Items : Int_List;
   end record;

   --  Count is the MPU return value for a mutating set update.
   --  Setinsert counts elements added. Setremove counts elements
   --  removed. Setinvert is the signed change in length.
   type Set_Change is record
      Items : Int_List;
      Count : Integer := 0;
   end record;

   --  XS.xs: vecsum. Exact sum of Items. The empty sum is 0.
   function Vecsum (Items : Int_List) return Big_Integer
     with Pre => True,
          Post => (if Items.Is_Empty then Vecsum'Result = To_Big_Integer (0));

   --  XS.xs: vecprod. Exact product of Items. The empty product is 1.
   function Vecprod (Items : Int_List) return Big_Integer
     with Pre => True,
          Post =>
            (if Items.Is_Empty then Vecprod'Result = To_Big_Integer (1));

   --  XS.xs: vecmin. Least element. Empty input is undefined.
   function Vecmin (Items : Int_List) return Value_Result
     with Pre => True,
          Post => (if Items.Is_Empty then not Vecmin'Result.Defined);

   --  XS.xs: vecmax. Greatest element. Empty input is undefined.
   function Vecmax (Items : Int_List) return Value_Result
     with Pre => True,
          Post => (if Items.Is_Empty then not Vecmax'Result.Defined);

   --  XS.xs: vecprefixsum. Running sum, one entry per input element.
   function Vecprefixsum (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecprefixsum'Result.Length = Items.Length;

   --  XS.xs: vecuniq, via ds_iset.h iset_add. First copy of each value.
   function Vecuniq (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecuniq'Result.Length <= Items.Length;

   --  XS.xs: vecsingleton. Values that occur once, in first-seen order.
   function Vecsingleton (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecsingleton'Result.Length <= Items.Length;

   --  XS.xs: vecfreq. Value then count, sorted by value (sort.c).
   function Vecfreq (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecfreq'Result.Length mod 2 = 0;

   --  sort.c: sort_iv_array and sort_uv_array. Ascending numeric order.
   function Vecsort (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecsort'Result.Length = Items.Length;

   --  sort.c: sort_iv_array. Descending numeric order.
   function Vecrsort (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecrsort'Result.Length = Items.Length;

   --  XS.xs: vecsorti. The list left by the in-place ascending sort.
   function Vecsorti (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecsorti'Result.Length = Items.Length;

   --  XS.xs: vecrsorti. The list left by the in-place descending sort.
   function Vecrsorti (Items : Int_List) return Int_List
     with Pre => True,
          Post => Vecrsorti'Result.Length = Items.Length;

   --  XS.xs: vecmex. Least missing nonnegative integer.
   --  A negative element raises Constraint_Error.
   function Vecmex (Items : Int_List) return Big_Integer
     with Pre => (for all E of Items => E >= To_Big_Integer (0)),
          Post => Vecmex'Result >= To_Big_Integer (0);

   --  XS.xs: vecpmex. Least missing positive integer.
   --  A non-positive element raises Constraint_Error.
   function Vecpmex (Items : Int_List) return Big_Integer
     with Pre => (for all E of Items => E >= To_Big_Integer (1)),
          Post => Vecpmex'Result >= To_Big_Integer (1);

   --  XS.xs: vecextract. Mask bit i selects the 0-based element i.
   --  A negative mask raises Constraint_Error. A mask that selects
   --  only a missing index returns an undefined list.
   function Vecextract
     (Items : Int_List; Mask : Big_Integer) return List_Result
     with Pre => True, Post => True;

   --  XS.xs: vecextract index form. Negative indexes count from the end.
   --  An empty index list is an empty list. A missing first index
   --  returns an undefined list.
   function Vecextract
     (Items : Int_List; Indexes : Int_List) return List_Result
     with Pre => True, Post => True;

   --  XS.xs: vecequal. Same length and the same values in order.
   function Vecequal (Left, Right : Int_List) return Boolean
     with Pre => True, Post => Vecequal'Result = (Left = Right);

   --  XS.xs: toset, via sort.c sort_dedup_uv_array. Sorted unique values.
   function Toset (Items : Int_List) return Int_List
     with Pre => True,
          Post => Toset'Result.Length <= Items.Length;

   --  xs_set.c: xs_is_sidon_set. All pairwise sums x+y with y <= x differ.
   --  A negative element makes the result False.
   function Is_Sidon_Set (Items : Int_List) return Boolean
     with Pre => True,
          Post => (if Items.Is_Empty then Is_Sidon_Set'Result);

   --  xs_set.c: xs_is_sumfree_set. No sum of two elements lies in the set.
   function Is_Sumfree_Set (Items : Int_List) return Boolean
     with Pre => True,
          Post => (if Items.Is_Empty then Is_Sumfree_Set'Result);

   --  XS.xs: sumset of one list with itself. Empty input gives an empty sum.
   function Sumset (Left : Int_List) return Int_List
     with Pre => True,
          Post => (if Left.Is_Empty then Sumset'Result.Is_Empty);

   --  XS.xs: sumset, using xs_set.c type_of_sumset. Sorted unique sums.
   function Sumset (Left, Right : Int_List) return Int_List
     with Pre => True,
          Post =>
            (if Left.Is_Empty or Right.Is_Empty
             then Sumset'Result.Is_Empty);

   --  xs_set.c: xs_set_op SET_OP_UNION. Sorted unique union.
   function Setunion (Left, Right : Int_List) return Int_List
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_INTERSECT. Sorted unique intersection.
   function Setintersect (Left, Right : Int_List) return Int_List
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_MINUS. Sorted unique difference.
   function Setminus (Left, Right : Int_List) return Int_List
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_op SET_OP_DELTA. Sorted unique symmetric difference.
   function Setdelta (Left, Right : Int_List) return Int_List
     with Pre => True, Post => True;

   --  xs_set.c: xs_set_relation SET_REL_DISJOINT. No shared element.
   function Set_Is_Disjoint (Left, Right : Int_List) return Boolean
     with Pre => True,
          Post =>
            (if Left.Is_Empty or Right.Is_Empty then Set_Is_Disjoint'Result);

   --  xs_set.c: xs_set_relation SET_REL_EQUAL. Same length and members.
   function Set_Is_Equal (Left, Right : Int_List) return Boolean
     with Pre => True,
          Post =>
            (if Left.Is_Empty and Right.Is_Empty then Set_Is_Equal'Result);

   --  xs_set.c: xs_set_relation SET_REL_SUBSET. Right is a subset of Left.
   function Set_Is_Subset (Left, Right : Int_List) return Boolean
     with Pre => True,
          Post => (if Right.Is_Empty then Set_Is_Subset'Result);

   --  xs_set.c: SET_REL_PROPER_SUBSET. Right is a proper subset of Left.
   function Set_Is_Proper_Subset (Left, Right : Int_List) return Boolean
     with Pre => True,
          Post =>
            (if not Set_Is_Proper_Subset'Result
             then Left.Length <= Right.Length
               or else not Set_Is_Subset (Left, Right));

   --  xs_set.c: SET_REL_SUPERSET. Left is a subset of Right.
   function Set_Is_Superset (Left, Right : Int_List) return Boolean
     with Pre => True,
          Post => Set_Is_Superset'Result = Set_Is_Subset (Right, Left);

   --  xs_set.c: SET_REL_PROPER_SUPERSET. Left is a proper subset of Right.
   function Set_Is_Proper_Superset (Left, Right : Int_List) return Boolean
     with Pre => True,
          Post =>
            Set_Is_Proper_Superset'Result =
              Set_Is_Proper_Subset (Right, Left);

   --  xs_set.c: SET_REL_PROPER_INTERSECTION. The overlap is nonempty
   --  and smaller than both inputs. Duplicate elements count.
   function Set_Is_Proper_Intersection
     (Left, Right : Int_List) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c: ins_into_set. Set-form Left gains the members of Right.
   function Setinsert (Set, Values : Int_List) return Set_Change
     with Pre => True, Post => Setinsert'Result.Count >= 0;

   --  xs_set.c: del_from_set. Set-form Set loses the members of Values.
   function Setremove (Set, Values : Int_List) return Set_Change
     with Pre => True, Post => Setremove'Result.Count >= 0;

   --  xs_set.c: ins_into_set and del_from_set. Toggle membership.
   function Setinvert (Set, Values : Int_List) return Set_Change
     with Pre => True, Post => True;

   --  xs_set.c: is_in_set. True when every value is in Set.
   --  An empty value list is True.
   function Setcontains (Set, Values : Int_List) return Boolean
     with Pre => True,
          Post => (if Values.Is_Empty then Setcontains'Result);

   --  xs_set.c: is_in_set. True when any value is in Set.
   --  An empty list on either side is False.
   function Setcontainsany (Set, Values : Int_List) return Boolean
     with Pre => True,
          Post =>
            (if Set.Is_Empty or Values.Is_Empty
             then not Setcontainsany'Result);
end Math_Prime_Util.Vec;
