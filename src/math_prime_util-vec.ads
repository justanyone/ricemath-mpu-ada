with Ada.Containers;
with Ada.Containers.Vectors;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Strings.Unbounded;

--  Vector and set operations from Math::Prime::Util 0.75.
--  sort.c sorts native arrays; xs_set.c and ds_iset.h implement the
--  set algebra. Values that do not fit in a machine word use the same
--  signed decimal arithmetic as strops.c. Callback forms (vecall and
--  the other code-reference scans) are not in this package.
package Math_Prime_Util.Vec with SPARK_Mode => Off is
   use Ada.Numerics.Big_Numbers.Big_Integers;
   use Ada.Strings.Unbounded;
   use type Ada.Containers.Count_Type;

   package Integer_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Big_Integer);
   package Text_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Unbounded_String);

   --  Absent when the list is empty (MPU returns undef, not an error).
   type Optional_Integer is record
      Defined : Boolean := False;
      Value : Big_Integer := 0;
   end record;

   --  Defined is False when a selected index does not exist.
   type Text_Result is record
      Defined : Boolean := False;
      Items : Text_Vectors.Vector;
   end record;

   type Freq_Pair is record
      Value : Big_Integer := 0;
      Count : Natural := 0;
   end record;
   package Freq_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Freq_Pair);

   --  PP.pm / XS.xs vecsum. Sum in integer units. Empty sums to 0.
   function Vecsum (Items : Integer_Vectors.Vector) return Big_Integer
     with Pre => True,
          Post => (if Items.Is_Empty then Vecsum'Result = 0);

   --  PP.pm / XS.xs vecprod. Product in integer units. Empty is 1.
   function Vecprod (Items : Integer_Vectors.Vector) return Big_Integer
     with Pre => True,
          Post => (if Items.Is_Empty then Vecprod'Result = 1);

   --  XS.xs vecmin. Smallest value. Empty is not defined.
   function Vecmin (Items : Integer_Vectors.Vector) return Optional_Integer
     with Pre => True,
          Post => Vecmin'Result.Defined = (not Items.Is_Empty);

   --  XS.xs vecmax. Largest value. Empty is not defined.
   function Vecmax (Items : Integer_Vectors.Vector) return Optional_Integer
     with Pre => True,
          Post => Vecmax'Result.Defined = (not Items.Is_Empty);

   --  PP.pm vecprefixsum. Running totals, one per input element.
   function Vecprefixsum (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => Vecprefixsum'Result.Length = Items.Length;

   --  XS.xs vecuniq. First copy of each value, input order.
   function Vecuniq (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => Vecuniq'Result.Length <= Items.Length;

   --  XS.xs vecsingleton. Values that occur once, input order.
   function Vecsingleton (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => Vecsingleton'Result.Length <= Items.Length;

   --  XS.xs vecfreq. Value and count pairs, sorted by value.
   --  Perl's hash order is not significant (upstream finding 12).
   function Vecfreq (Items : Integer_Vectors.Vector) return Freq_Vectors.Vector
     with Pre => True,
          Post => Vecfreq'Result.Length <= Items.Length;

   --  sort.c sort_uv_array / sort_iv_array via XS.xs vecsort.
   function Vecsort (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => Vecsort'Result.Length = Items.Length;

   --  XS.xs vecrsort. Descending numeric order.
   function Vecrsort (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => Vecrsort'Result.Length = Items.Length;

   --  XS.xs vecsorti. Sorts Items in place, ascending.
   procedure Vecsorti (Items : in out Integer_Vectors.Vector)
     with Pre => True, Post => True;

   --  XS.xs vecrsorti. Sorts Items in place, descending.
   procedure Vecrsorti (Items : in out Integer_Vectors.Vector)
     with Pre => True, Post => True;

   --  XS.xs vecmex. Smallest missing nonnegative integer.
   --  A negative element raises Constraint_Error.
   function Vecmex (Items : Integer_Vectors.Vector) return Big_Integer
     with Pre => (for all E of Items => E >= 0),
          Post => Vecmex'Result >= 0;

   --  XS.xs vecpmex. Smallest missing positive integer.
   --  A non-positive element raises Constraint_Error.
   function Vecpmex (Items : Integer_Vectors.Vector) return Big_Integer
     with Pre => (for all E of Items => E > 0),
          Post => Vecpmex'Result >= 1;

   --  XS.xs vecextract. Bits of Mask select indexes, low bit first.
   --  A negative Mask raises Constraint_Error. A missing index is
   --  not defined.
   function Vecextract
     (Items : Text_Vectors.Vector; Mask : Big_Integer) return Text_Result
     with Pre => True, Post => True;

   --  XS.xs vecextract index-list form. Negative indexes count from
   --  the end, as in Perl. A missing index is not defined.
   function Vecextract
     (Items : Text_Vectors.Vector; Indexes : Integer_Vectors.Vector)
      return Text_Result
     with Pre => True, Post => True;

   --  XS.xs vecequal. Same length and the same values in order.
   function Vecequal
     (Left, Right : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Left.Length /= Right.Length then not Vecequal'Result);

   --  XS.xs toset. Sorted values with duplicates removed.
   function Toset (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => Toset'Result.Length <= Items.Length;

   --  xs_set.c / PP.pm sumset. Sorted unique pairwise sums.
   --  One list is summed with itself. An empty side yields an empty sum.
   function Sumset (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => (if Left.Is_Empty or else Right.Is_Empty then
                     Sumset'Result.Is_Empty);

   --  PP.pm sumset with one list. Equivalent to Sumset (Items, Items).
   function Sumset (Items : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True,
          Post => (if Items.Is_Empty then Sumset'Result.Is_Empty);

   --  xs_set.c setunion. Sorted unique elements of either list.
   function Setunion (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  xs_set.c setintersect. Sorted unique elements of both lists.
   function Setintersect (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  xs_set.c setminus. Sorted unique elements of Left not in Right.
   function Setminus (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  xs_set.c setdelta. Sorted unique elements in exactly one list.
   function Setdelta (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  PP.pm setinsert. Left with the values of Right inserted.
   --  Both sides are treated as sets. The result is sorted.
   function Setinsert (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  PP.pm setremove. Left without any value that occurs in Right.
   function Setremove (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  PP.pm setinvert. Membership of each Right value is toggled.
   function Setinvert (Left, Right : Integer_Vectors.Vector)
      return Integer_Vectors.Vector
     with Pre => True, Post => True;

   --  PP.pm setcontains. True when every Right value is in Left.
   --  An empty Right is contained.
   function Setcontains (Left, Right : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Right.Is_Empty then Setcontains'Result);

   --  PP.pm setcontainsany. True when some Right value is in Left.
   --  An empty side is false.
   function Setcontainsany
     (Left, Right : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Right.Is_Empty or else Left.Is_Empty then
                     not Setcontainsany'Result);

   --  PP.pm set_is_disjoint. No shared value. An empty side is disjoint.
   function Set_Is_Disjoint (Left, Right : Integer_Vectors.Vector)
      return Boolean
     with Pre => True,
          Post => (if Left.Is_Empty or else Right.Is_Empty then
                     Set_Is_Disjoint'Result);

   --  PP.pm set_is_equal. The same values, ignoring order.
   function Set_Is_Equal (Left, Right : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Left.Length /= Right.Length
                   then not Set_Is_Equal'Result);

   --  PP.pm set_is_subset. Every Right value occurs in Left.
   function Set_Is_Subset (Left, Right : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Right.Is_Empty then Set_Is_Subset'Result);

   --  PP.pm set_is_proper_subset. Subset, and Left has more elements.
   function Set_Is_Proper_Subset (Left, Right : Integer_Vectors.Vector)
      return Boolean
     with Pre => True,
          Post => (if Left.Length <= Right.Length then
                     not Set_Is_Proper_Subset'Result);

   --  PP.pm set_is_superset. Every Left value occurs in Right.
   function Set_Is_Superset (Left, Right : Integer_Vectors.Vector)
      return Boolean
     with Pre => True,
          Post => (if Left.Is_Empty then Set_Is_Superset'Result);

   --  PP.pm set_is_proper_superset. Superset, and Right has more elements.
   function Set_Is_Proper_Superset (Left, Right : Integer_Vectors.Vector)
      return Boolean
     with Pre => True,
          Post => (if Right.Length <= Left.Length then
                     not Set_Is_Proper_Superset'Result);

   --  PP.pm set_is_proper_intersection. The overlap is nonempty and
   --  smaller than both lists.
   function Set_Is_Proper_Intersection (Left, Right : Integer_Vectors.Vector)
      return Boolean
     with Pre => True, Post => True;

   --  xs_set.c is_sidon_set. Pairwise sums x+y with x >= y are unique.
   --  A negative value makes the result false. An empty list is Sidon.
   function Is_Sidon_Set (Items : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Items.Is_Empty then Is_Sidon_Set'Result);

   --  xs_set.c is_sumfree_set. No pairwise sum x+y with x >= y is itself
   --  a member. An empty list is sum-free.
   function Is_Sumfree_Set (Items : Integer_Vectors.Vector) return Boolean
     with Pre => True,
          Post => (if Items.Is_Empty then Is_Sumfree_Set'Result);
end Math_Prime_Util.Vec;
