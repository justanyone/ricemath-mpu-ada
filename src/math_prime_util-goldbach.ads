with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Goldbach representations from Math::Prime::Util 0.75.
package Math_Prime_Util.Goldbach is
   use type U64;
   package Pair_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  goldbach.c: minimal_goldbach_pair. Return the least prime p for which
   --  N-p is prime; undefined when no pair exists.
   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64
     with Pre => True, Post => True;

   --  goldbach.c: goldbach_pair_count. Number of unordered prime pairs summing
   --  to N; values below four have count zero.
   function Goldbach_Pair_Count (N : U64) return U64
     with Pre => True, Post => True;

   --  goldbach.c: goldbach_pairs. Return the smaller prime from each
   --  unordered pair in ascending order; empty when no pair exists.
   function Goldbach_Pairs (N : U64) return Pair_Vectors.Vector
     with Pre => True, Post => True;
end Math_Prime_Util.Goldbach;
