with Ada.Containers.Indefinite_Vectors;
with Ada.Text_IO;
with Math_Prime_Util.Int;

--  Callback iterators corresponding to MPU 0.75 XS.xs for* routines.
--  All bounds are inclusive and all integer values use the native U64 tier.
--  Callbacks may nest loops; exceptions propagate to the caller.
package Math_Prime_Util.Iter with SPARK_Mode => On is
   use type U64;
   type Loop_Context is limited private;
   type Value_Array is array (Positive range <>) of U64;

   --  XS.xs: lastfor. Request termination after this callback returns.
   --  Pass the context of the loop to stop. An inactive context raises
   --  Constraint_Error, including a default initialized context.
   procedure Lastfor (Context : in out Loop_Context)
     with Pre => True, Post => True;

   --  XS.xs: forprimes. Visit primes in [Low, High], in ascending order.
   --  Reversed bounds produce no callbacks. No storage proportional to High.
   procedure Forprimes
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  Visit primes from 2 through High; same errors as the range overload.
   procedure Forprimes
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forcomposites. Visit composite integers >= 4 in ascending order.
   --  Reversed bounds produce no callbacks, including at U64'Last.
   procedure Forcomposites
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  Visit composites from 4 through High; same errors as range overload.
   procedure Forcomposites
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forfactored. Visit positive integers and their sorted prime
   --  factors with multiplicity. One has an empty factor list; zero is
   --  omitted. Reversed bounds produce no callbacks. Storage_Error may
   --  propagate from recursion when factoring a value.
   procedure Forfactored
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  Visit factored integers from 1 through High; same errors as above.
   procedure Forfactored
     (High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context))
     with Pre => True, Post => True;

   type Prime_Filter is (Any_Part, Prime_Part, Nonprime_Part);
   type Partition_Options is record
      Amin : Natural := 1;
      Amax : Natural := Natural'Last;
      Nmin : Natural := 1;
      Nmax : Natural := Natural'Last;
      Prime : Prime_Filter := Any_Part;
   end record;

   --  XS.xs: forpart. Visit nondecreasing positive partitions of N in
   --  lexical order. N=0 visits the empty partition when Nmin <= 1.
   --  Amin=0 means 1; contradictory bounds give no callbacks.
   --  Storage_Error may propagate when the N-element workspace cannot fit.
   procedure Forpart
     (N : Natural;
      Process : not null access procedure
        (Parts : Value_Array; Context : in out Loop_Context);
      Options : Partition_Options := (others => <>))
     with Pre => True, Post => True;

   --  XS.xs: forcomb. Visit K-element subsets of 0 .. N-1 lexically.
   --  K=0 visits the empty tuple; K>N visits none. Storage_Error may
   --  propagate if the K-element workspace cannot fit.
   procedure Forcomb
     (N, K : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  Visit all subsets by increasing size, then lexical order.
   --  The same workspace errors as the fixed-size overload may propagate.
   procedure Forcomb
     (N : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  XS.xs: forperm. Visit permutations of 0 .. N-1 lexically.
   --  N=0 visits the empty tuple. Storage_Error may propagate when the
   --  N-element workspace cannot fit.
   procedure Forperm
     (N : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
     with Pre => True, Post => True;

   --  PP.pm: _forcompositions (forcomp). Ordered compositions of N,
   --  with the same options and workspace errors as Forpart.
   procedure Forcomp
     (N : Natural;
      Process : not null access procedure
        (Parts : Value_Array; Context : in out Loop_Context);
      Options : Partition_Options := (others => <>));
   --  XS.xs: forderange. Lexical permutations without fixed points.
   --  Zero visits the empty tuple; one visits none. Workspace may fail.
   procedure Forderange
     (N : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context));
   --  PP.pm: formultiperm, _multiset_permutations. Distinct permutations
   --  in decimal-string order; empty visits once. Storage_Error may occur.
   procedure Formultiperm
     (Items : Value_Array;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context));
   package Value_List_Vectors is new Ada.Containers.Indefinite_Vectors
     (Index_Type => Positive, Element_Type => Value_Array);
   --  XS.xs: forsetproduct. Cartesian product, last list changing fastest.
   --  Empty lists visit none; copied workspace may raise Storage_Error.
   procedure Forsetproduct
     (Lists : Value_List_Vectors.Vector;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context));
   type Prime_Object is tagged private;
   --  Util.pm: prime_iterator_object; PrimeIterator.pm: new, rewind.
   --  Start at the first prime >= Start; undefined beyond native primes.
   function Prime_Iterator_Object (Start : U64 := 2) return Prime_Object;
   --  PrimeIterator.pm: value. Current prime, undefined at native overflow.
   function Value (Cursor : Prime_Object) return Int.Optional_U64;
   --  PrimeIterator.pm: next. Advance, remaining undefined at overflow.
   procedure Next (Cursor : in out Prime_Object);
   --  PrimeIterator.pm: prev. Move back, clamped at two. From native
   --  overflow return to the largest native prime. No errors.
   procedure Prev (Cursor : in out Prime_Object);
   --  PrimeIterator.pm: peek. Successor without changing the position.
   function Peek (Cursor : Prime_Object) return Int.Optional_U64;
   --  PrimeIterator.pm: rewind. Reset to the first prime >= Start.
   procedure Rewind (Cursor : in out Prime_Object; Start : U64 := 2);
   --  PrimeIterator.pm: iterate. Return current prime, then advance.
   procedure Iterate
     (Cursor : in out Prime_Object; Result : out Int.Optional_U64)
     with Pre => True,
          Post => (if Result.Defined then Result.Value >= 2);
   --  util.c: print_primes. Inclusive range, decimal prime per line.
   --  Text_IO exceptions propagate; reversed bounds write nothing.
   procedure Print_Primes
     (Low, High : U64; File : Ada.Text_IO.File_Type)
     with SPARK_Mode => Off, Pre => True, Post => True;
   --  Write to standard output; same bounds and errors as above.
   procedure Print_Primes (Low, High : U64)
     with SPARK_Mode => Off, Pre => True, Post => True;
   type Prime_Cursor is private;
   --  PrimeIterator.pm: prime_iterator. Construct an independent cursor
   --  whose first result is the smallest prime >= Start. No errors.
   function Prime_Iterator (Start : U64 := 2) return Prime_Cursor
     with Pre => True, Post => True;

   --  Return the next prime and advance the cursor. Undefined after the
   --  largest native prime; repeated calls remain undefined, without wrap.
   procedure Next
     (Cursor : in out Prime_Cursor; Value : out Int.Optional_U64)
     with Pre => True,
          Post => (if Value.Defined then Value.Value >= 2);

private
   type Loop_Context is limited record
      Active : Boolean := False;
      Stop : Boolean := False;
   end record;
   type Prime_Object is tagged record
      Current : Int.Optional_U64 := (Defined => True, Value => 2);
   end record;
   type Prime_Cursor is record
      Pending : Int.Optional_U64;
   end record;
end Math_Prime_Util.Iter;
