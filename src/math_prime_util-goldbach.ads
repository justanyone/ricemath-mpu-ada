with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Goldbach partitions from MPU 0.75 goldbach.c.
package Math_Prime_Util.Goldbach is
   use type U64;
   package Pair_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);
   pragma Elaborate_Body (Pair_Vectors);

   --  Return the least prime p such that N-p is prime; undefined if absent.
   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64
     with Pre => True, Post => True;
   --  Count unordered prime pairs whose sum is N.
   function Goldbach_Pair_Count (N : U64) return U64
     with Pre => True, Post => (if N < 4 then Goldbach_Pair_Count'Result = 0);
   --  Return smaller primes of unordered pairs in ascending order.
   function Goldbach_Pairs (N : U64) return Pair_Vectors.Vector
     with Pre => True, Post => True;
end Math_Prime_Util.Goldbach;
