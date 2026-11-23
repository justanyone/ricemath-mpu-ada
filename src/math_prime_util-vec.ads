with Math_Prime_Util.Int;

--  Integer vectors and sets from MPU 0.75 sort.c, xs_set.c and XS.xs.
--  Indices in returned vectors start at one; search indices are zero based.
--  Arithmetic is checked: results outside I128 raise Constraint_Error.
package Math_Prime_Util.Vec with SPARK_Mode => On is
   subtype I128 is Math_Prime_Util.Int.I128;
   use type I128;
   type Integer_Array is array (Positive range <>) of I128;
   type Optional_Value (Defined : Boolean := False) is record
      case Defined is
         when True => Value : I128;
         when False => null;
      end case;
   end record;
   type Optional_Array is array (Positive range <>) of Optional_Value;

   --  Sum in integer units; empty input gives zero; overflow raises.
   function Vecsum (A : Integer_Array) return I128
     with Post => (if A'Length = 0 then Vecsum'Result = 0);
   --  Product in integer units; empty input gives one; overflow raises.
   function Vecprod (A : Integer_Array) return I128
     with Post => (if A'Length = 0 then Vecprod'Result = 1);
   --  Minimum value, undefined for empty input.
   function Vecmin (A : Integer_Array) return Optional_Value
     with Post => Vecmin'Result.Defined = (A'Length > 0);
   --  Maximum value, undefined for empty input.
   function Vecmax (A : Integer_Array) return Optional_Value
     with Post => Vecmax'Result.Defined = (A'Length > 0);
   --  Inclusive prefix sums in input order; overflow raises.
   function Vecprefixsum (A : Integer_Array) return Integer_Array
     with Post => Vecprefixsum'Result'Length = A'Length;
   --  Stable unique values, using integer equality.
   function Vecuniq (A : Integer_Array) return Integer_Array
     with Post => Vecuniq'Result'Length <= A'Length;
   --  Values appearing exactly once, in input order.
   function Vecsingleton (A : Integer_Array) return Integer_Array
     with Post => Vecsingleton'Result'Length <= A'Length;
   --  Sorted alternating value/count pairs; counts are in occurrences.
   function Vecfreq (A : Integer_Array) return Integer_Array
     with Pre => A'Length <= Natural'Last / 2;
   --  Ascending integer sort; no error cases.
   function Vecsort (A : Integer_Array) return Integer_Array
     with Post => Vecsort'Result'Length = A'Length;
   --  Descending integer sort; no error cases.
   function Vecrsort (A : Integer_Array) return Integer_Array
     with Post => Vecrsort'Result'Length = A'Length;
   --  Sort A in ascending order in place.
   procedure Vecsorti (A : in out Integer_Array);
   --  Sort A in descending order in place.
   procedure Vecrsorti (A : in out Integer_Array);
   --  Least excluded nonnegative integer; negative inputs raise.
   function Vecmex (A : Integer_Array) return I128
     with Pre => (for all V of A => V >= 0),
          Post => Vecmex'Result in 0 .. I128 (A'Length);
   --  Least excluded positive integer; nonpositive inputs raise.
   function Vecpmex (A : Integer_Array) return I128
     with Pre => (for all V of A => V > 0),
          Post => Vecpmex'Result in 1 .. I128 (A'Length) + 1;
   --  Elementwise integer equality, independent of array lower bounds.
   function Vecequal (A, B : Integer_Array) return Boolean;
   --  Extract set bits of a 128-bit mask, in increasing position order.
   --  Bits beyond A produce undefined values; use unsigned masks.
   function Vecextract (A : Integer_Array; Mask : U128)
      return Optional_Array with Post => Vecextract'Result'Length <= 128;
   --  Extract zero-based indices; negative indices count from the end.
   --  Out-of-range positions produce undefined values.
   function Vecextract (A, Indices : Integer_Array) return Optional_Array
     with Post => Vecextract'Result'Length = Indices'Length;
   --  Numerically sorted, deduplicated integer set.
   function Toset (A : Integer_Array) return Integer_Array
     with Post => Toset'Result'Length <= A'Length;
   --  Union of arbitrary integer lists, in set form.
   function Setunion (A, B : Integer_Array) return Integer_Array
     with Pre => A'Length <= Natural'Last - B'Length;
   --  Intersection of arbitrary integer lists, in set form.
   function Setintersect (A, B : Integer_Array) return Integer_Array;
   --  A minus B, in set form.
   function Setminus (A, B : Integer_Array) return Integer_Array;
   --  Symmetric difference, in set form.
   function Setdelta (A, B : Integer_Array) return Integer_Array
     with Pre => A'Length <= Natural'Last - B'Length;
   --  Whether every value in B belongs to A; empty B is contained.
   function Setcontains (A, B : Integer_Array) return Boolean;
   --  Whether at least one value in B belongs to A.
   function Setcontainsany (A, B : Integer_Array) return Boolean;
   --  Whether the intersection is empty.
   function Set_Is_Disjoint (A, B : Integer_Array) return Boolean;
   --  Whether the sets contain the same values.
   function Set_Is_Equal (A, B : Integer_Array) return Boolean;
   --  MPU convention: whether B is a subset of A.
   function Set_Is_Subset (A, B : Integer_Array) return Boolean;
   --  MPU convention: whether B is a strict subset of A.
   function Set_Is_Proper_Subset (A, B : Integer_Array) return Boolean;
   --  MPU convention: whether B is a superset of A.
   function Set_Is_Superset (A, B : Integer_Array) return Boolean;
   --  MPU convention: whether B is a strict superset of A.
   function Set_Is_Proper_Superset (A, B : Integer_Array) return Boolean;
   --  Nonempty intersection strictly smaller than both sets.
   function Set_Is_Proper_Intersection (A, B : Integer_Array) return Boolean;
   --  Insert B into A; use union for the resulting set.
   --  Returns the number of newly inserted values.
   function Setinsert (A, B : Integer_Array) return Natural;
   --  Remove B from A; use minus for the resulting set.
   --  Returns the number of removed values.
   function Setremove (A, B : Integer_Array) return Natural;
   --  Toggle B in A; use delta for the resulting set.
   --  Returns inserted count minus removed count.
   function Setinvert (A, B : Integer_Array) return Integer;
   --  Insert into a capacity buffer whose first Last elements form A.
   --  Count is the inserted count; insufficient capacity raises before
   --  writing.
   procedure Setinsert
     (A : in out Integer_Array; Last : in out Natural;
      B : Integer_Array; Count : out Integer)
     with Pre => Last <= A'Length, Post => Last <= A'Length;
   --  Remove values from the first Last elements; Count is removed count.
   procedure Setremove
     (A : in out Integer_Array; Last : in out Natural;
      B : Integer_Array; Count : out Integer)
     with Pre => Last <= A'Length, Post => Last <= Last'Old;
   --  Toggle values in the first Last elements; Count is inserted minus
   --  removed.
   --  Insufficient capacity raises before writing.
   procedure Setinvert
     (A : in out Integer_Array; Last : in out Natural;
      B : Integer_Array; Count : out Integer)
     with Pre => Last <= A'Length, Post => Last <= A'Length;
   --  Sorted pair sums. Overflow raises.
   function Sumset (A, B : Integer_Array) return Integer_Array
     with Pre => (B'Length = 0 or else
                    A'Length <= Natural'Last / B'Length);
   --  Sorted pair sums A+A; overflow raises.
   function Sumset (A : Integer_Array) return Integer_Array
     with Pre => (A'Length = 0 or else
                    A'Length <= Natural'Last / A'Length);
   --  Unique nonnegative pair sums (including equal pairs); negatives fail.
   function Is_Sidon_Set (A : Integer_Array) return Boolean;
   --  Whether no pair sum belongs to A; signed inputs are permitted.
   function Is_Sumfree_Set (A : Integer_Array) return Boolean;

   --  Whether the predicate holds for every value; empty input is true.
   generic
      with function Predicate (V : I128) return Boolean;
   function Vecall (A : Integer_Array) return Boolean;

   --  Whether the predicate holds for some value; empty input is false.
   generic
      with function Predicate (V : I128) return Boolean;
   function Vecany (A : Integer_Array) return Boolean;

   --  Whether the predicate holds for no value; empty input is true.
   generic
      with function Predicate (V : I128) return Boolean;
   function Vecnone (A : Integer_Array) return Boolean;

   --  Whether the predicate fails for some value; empty input is false.
   generic
      with function Predicate (V : I128) return Boolean;
   function Vecnotall (A : Integer_Array) return Boolean;

   --  First matching value, undefined if no value matches.
   generic
      with function Predicate (V : I128) return Boolean;
   function Vecfirst (A : Integer_Array) return Optional_Value;

   --  Zero-based index of the first match, or minus one.
   generic
      with function Predicate (V : I128) return Boolean;
   function Vecfirstidx (A : Integer_Array) return I128;

   --  Left fold; empty input is undefined; callback exceptions propagate.
   generic
      with function Operation (A, B : I128) return I128;
   function Vecreduce (A : Integer_Array) return Optional_Value;

   --  Scalar callback for consecutive overlapping pairs; empty for <2 items.
   generic
      with function Operation (A, B : I128) return I128;
   function Vecslide (A : Integer_Array) return Integer_Array;

   --  Flatten results for corresponding pairs. Ignore unmatched tails.
   generic
      with function Operation (A, B : I128) return Integer_Array;
   function Vecpairwise (A, B : Integer_Array) return Integer_Array;

   --  Flatten complete windows; step and size are positive element counts.
   generic
      with function Operation (A : Integer_Array) return Integer_Array;
   function Vecwindow (A : Integer_Array; Step, Size : Positive)
      return Integer_Array;

   --  Sorted distinct callback results over the Cartesian product.
   --  With Self True, ignore B and evaluate pairs i<=j of sorted A.
   generic
      with function Operation (A, B : I128) return I128;
   function Setbinop
     (A, B : Integer_Array; Self : Boolean := False) return Integer_Array
     with Pre => (if Self then
                    A'Length = 0 or else
                      A'Length <= Natural'Last / A'Length
                  else B'Length = 0 or else
                    A'Length <= Natural'Last / B'Length);

   --  Sample without replacement, preserving input order, in element units.
   --  Draw must return a uniform integer in 1..Upper; bad draws raise.
   --  K>=length returns the entire list. RNG state belongs to the caller.
   generic
      with function Draw (Upper : Positive) return Positive;
   function Vecsample (A : Integer_Array; K : Natural) return Integer_Array
     with Post => Vecsample'Result'Length = Natural'Min (A'Length, K);
end Math_Prime_Util.Vec;
