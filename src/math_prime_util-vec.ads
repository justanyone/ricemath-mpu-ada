with Ada.Containers.Vectors;
with Ada.Numerics.Big_Numbers.Big_Integers;
with Ada.Strings.Unbounded;

--  Vector and set operations from Math::Prime::Util 0.75.
--  sort.c supplies the ordered integer arrays. xs_set.c and ds_iset.h
--  supply the set relations, set algebra, and integer-set membership.
--  Results are canonical decimal integers. An empty vecmin or vecmax,
--  a negative vecextract mask, a negative vecmex value, and a
--  non-positive vecpmex value raise Constraint_Error.
package Math_Prime_Util.Vec with SPARK_Mode => Off is
   package BI renames Ada.Numerics.Big_Numbers.Big_Integers;
   use type BI.Big_Integer;
   use type Ada.Containers.Count_Type;
   use type Ada.Strings.Unbounded.Unbounded_String;
   package Int_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => BI.Big_Integer);
   subtype Int_Vector is Int_Vectors.Vector;
   package String_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive,
      Element_Type => Ada.Strings.Unbounded.Unbounded_String);

   --  One vecextract element. Missing is an MPU undef index.
   type Extract_Element is record
      Missing : Boolean := True;
      Text : Ada.Strings.Unbounded.Unbounded_String;
   end record;
   package Extract_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Extract_Element);

   --  XS.xs vecsum. Sum of the integers. Empty sum is 0.
   function Vecsum (Items : Int_Vector) return BI.Big_Integer
     with Pre => True,
          Post => (if Items.Is_Empty then Vecsum'Result = 0);

   --  XS.xs vecprod. Product of the integers. Empty product is 1.
   function Vecprod (Items : Int_Vector) return BI.Big_Integer
     with Pre => True,
          Post => (if Items.Is_Empty then Vecprod'Result = 1);

   --  XS.xs vecmin. Least integer. Empty input raises Constraint_Error.
   function Vecmin (Items : Int_Vector) return BI.Big_Integer
     with Pre => not Items.Is_Empty, Post => True;

   --  XS.xs vecmax. Greatest integer. Empty input raises Constraint_Error.
   function Vecmax (Items : Int_Vector) return BI.Big_Integer
     with Pre => not Items.Is_Empty, Post => True;

   --  XS.xs vecprefixsum. Running sums, in input order.
   function Vecprefixsum (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecprefixsum'Result.Length = Items.Length;

   --  XS.xs vecuniq. First occurrence of each value, input order.
   function Vecuniq (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecuniq'Result.Length <= Items.Length;

   --  XS.xs vecsingleton. Values that occur once, input order.
   function Vecsingleton (Items : Int_Vector) return Int_Vector
     with Pre => True,
          Post => Vecsingleton'Result.Length <= Items.Length;

   --  XS.xs vecfreq. Pairs (value, count) sorted by value.
   --  Perl hash order is not part of the result.
   function Vecfreq (Items : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  sort.c sort_iv_array via XS.xs vecsort. Ascending copy.
   function Vecsort (Items : Int_Vector) return Int_Vector
     with Pre => True, Post => Vecsort'Result.Length = Items.Length;

   --  sort.c sort_iv_array via XS.xs vecrsort. Descending copy.
   function Vecrsort (Items : Int_Vector) return Int_Vector
     with Pre => True, Post => Vecrsort'Result.Length = Items.Length;

   --  sort.c sort_iv_array via XS.xs vecsorti. Ascending, in place.
   procedure Vecsorti (Items : in out Int_Vector)
     with Pre => True, Post => True;

   --  sort.c sort_iv_array via XS.xs vecrsorti. Descending, in place.
   procedure Vecrsorti (Items : in out Int_Vector)
     with Pre => True, Post => True;

   --  XS.xs vecmex. Least missing nonnegative below the length.
   --  A negative value raises Constraint_Error. Values at or above
   --  the length are ignored.
   function Vecmex (Items : Int_Vector) return BI.Big_Integer
     with Pre => True, Post => Vecmex'Result >= 0;

   --  XS.xs vecpmex. Least missing positive at most the length.
   --  A non-positive value raises Constraint_Error.
   function Vecpmex (Items : Int_Vector) return BI.Big_Integer
     with Pre => True, Post => Vecpmex'Result >= 1;

   --  XS.xs toset. Sorted unique copy. ds_iset.h membership.
   function Toset (Items : Int_Vector) return Int_Vector
     with Pre => True, Post => Toset'Result.Length <= Items.Length;

   --  xs_set.c xs_is_sidon_set. Nonnegative, pairwise sums unique.
   function Is_Sidon_Set (Items : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c xs_is_sumfree_set. No pairwise sum is a member.
   function Is_Sumfree_Set (Items : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c sumset. Sorted unique pairwise sums. Empty if either is.
   function Sumset (Left, Right : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  xs_set.c sumset of a list with itself.
   function Sumset (Items : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  XS.xs vecequal. Same length and the same integers in order.
   function Vecequal (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  XS.xs vecextract. Bits of Mask select 0-based indexes.
   --  A negative mask raises Constraint_Error. A bit past the end
   --  yields a missing element.
   function Vecextract
     (Items : String_Vectors.Vector; Mask : BI.Big_Integer)
      return Extract_Vectors.Vector
     with Pre => Mask >= 0, Post => True;

   --  XS.xs vecextract index form. Indexes are 0-based.
   --  A negative index counts from the end. An outside index is missing.
   function Vecextract
     (Items : String_Vectors.Vector; Indexes : Int_Vector)
      return Extract_Vectors.Vector
     with Pre => True, Post => Vecextract'Result.Length = Indexes.Length;

   --  xs_set.c xs_set_op SET_OP_UNION. Sorted unique union.
   function Setunion (Left, Right : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  xs_set.c xs_set_op SET_OP_INTERSECT. Sorted unique intersection.
   function Setintersect (Left, Right : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  xs_set.c xs_set_op SET_OP_MINUS. Sorted unique difference.
   function Setminus (Left, Right : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  xs_set.c xs_set_op SET_OP_DELTA. Sorted unique symmetric difference.
   function Setdelta (Left, Right : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  XS.xs setinsert. Setunion of a set and the inserted values.
   function Setinsert (Set, Values : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  XS.xs setremove. Setminus of a set and the removed values.
   function Setremove (Set, Values : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  XS.xs setinvert. Symmetric difference, sorted and unique.
   function Setinvert (Set, Values : Int_Vector) return Int_Vector
     with Pre => True, Post => True;

   --  XS.xs setcontains. Every value is in the set. Empty values is true.
   function Setcontains (Set, Values : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  XS.xs setcontainsany. Some value is in the set. Empty values is false.
   function Setcontainsany (Set, Values : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_DISJOINT. No shared element. An empty side is true.
   function Set_Is_Disjoint (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_EQUAL. Same length and the same elements.
   function Set_Is_Equal (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_SUBSET. Right is a subset of Left.
   function Set_Is_Subset (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_PROPER_SUBSET. Right is a proper subset of Left.
   function Set_Is_Proper_Subset (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_SUPERSET. Left is a subset of Right.
   function Set_Is_Superset (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_PROPER_SUPERSET. Left is a proper subset of Right.
   function Set_Is_Proper_Superset (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;

   --  xs_set.c SET_REL_PROPER_INTERSECTION. Overlap, and each side has
   --  an element the other lacks.
   function Set_Is_Proper_Intersection
     (Left, Right : Int_Vector) return Boolean
     with Pre => True, Post => True;
end Math_Prime_Util.Vec;
