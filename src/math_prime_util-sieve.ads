with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Native mod-30 sieve from Math::Prime::Util 0.75.
package Math_Prime_Util.Sieve is
   use type U64;
   package Prime_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  GNAT 16 needs the reference operations emitted for client iteration.
   pragma No_Inline (Prime_Vectors.Reference);
   pragma No_Inline (Prime_Vectors.Constant_Reference);

   --  sieve.c: range_prime_sieve, sieve_segment. Inclusive bounds.
   --  Reversed bounds return an empty vector. Storage_Error may propagate.
   function Primes (Low, High : U64) return Prime_Vectors.Vector
     with Pre => True,
          Post => (for all P of Primes'Result =>
                     P >= Low and P <= High and P >= 2);

   --  sieve.c: range_prime_sieve. Primes from 2 through High, inclusive.
   function Primes (High : U64) return Prime_Vectors.Vector
     with Pre => True,
          Post => (for all P of Primes'Result => P >= 2 and P <= High);

   --  util.c: next_prime. Strict successor; zero at native overflow.
   function Next_Prime (N : U64) return U64
     with Pre => True,
          Post => Next_Prime'Result = 0 or else Next_Prime'Result > N;

   --  util.c: prev_prime. Strict predecessor; zero for N <= 2.
   function Prev_Prime (N : U64) return U64
     with Pre => True,
          Post => Prev_Prime'Result = 0 or else Prev_Prime'Result < N;

   --  sieve.c: range_partial_sieve; XS.xs: sieve_range.
   --  Return offsets in [Start, Start + Width), sieved through Depth.
   --  The interval must fit U64; zero width returns an empty vector.
   function Sieve_Range (Start, Width, Depth : U64)
      return Prime_Vectors.Vector
     with Pre => Width = 0 or else Start <= U64'Last - (Width - 1),
          Post => (for all I of Sieve_Range'Result => I < Width);

   type Cluster_Offsets is array (Positive range <>) of U64;
   --  sieve_cluster.c: sieve_cluster_simple, is_admissible, is_cluster.
   --  Zero is implicit. Offsets must be even and strictly increasing.
   --  A leading zero is allowed. Overflowing members cannot form a cluster.
   function Sieve_Prime_Cluster
     (Low, High : U64; Offsets : Cluster_Offsets)
      return Prime_Vectors.Vector
     with Pre => Offsets'Length <= 98
       and then (for all I in Offsets'Range =>
         Offsets (I) <= 2 ** 32 - 1 and then Offsets (I) mod 2 = 0
         and then (I = Offsets'First or else
                     Offsets (I) > Offsets (I - 1))),
          Post => (for all P of Sieve_Prime_Cluster'Result =>
                     P >= Low and then P <= High);

   --  cache.c: get_prime_cache, _erase_and_fill_prime_cache.
   --  Retain sieving data through N; repeated requests do not shrink it.
   --  Storage_Error may propagate if the requested cache cannot fit.
   procedure Prime_Precalc (N : U64)
     with Pre => True, Post => True;

   --  cache.c: prime_memfree. Release retained storage; safe to repeat.
   procedure Prime_Memfree
     with Pre => True, Post => True;

   --  Sum sieve.c: range_prime_sieve results over inclusive bounds.
   --  Undefined on U64 overflow. MPU sum_primes optimizations are pending.
   function Sum_Primes (Low, High : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Low > High then Sum_Primes'Result.Defined
                   and then Sum_Primes'Result.Value = 0);
end Math_Prime_Util.Sieve;
