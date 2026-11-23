with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Goldbach partitions from MPU 0.75 goldbach.c.
package Math_Prime_Util.Goldbach with SPARK_Mode => On is
   use type U64;
   package Pair_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  goldbach.c: minimal_goldbach_pair.
   --  Least prime P such that N - P is prime. Undefined when no pair
   --  exists, including every N below 4. No exceptions.
   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N < 4 then
                     not Minimal_Goldbach_Pair'Result.Defined);

   --  goldbach.c: goldbach_pair_count.
   --  Count unordered prime pairs that sum to N. The count is zero
   --  when N is below 4. No exceptions.
   function Goldbach_Pair_Count (N : U64) return U64
     with Pre => True,
          Post => (if N < 4 then Goldbach_Pair_Count'Result = 0);

   --  goldbach.c: goldbach_pairs.
   --  Smaller prime of each unordered pair, in ascending order.
   --  Empty when no pair exists, including every N below 4.
   --  Storage_Error may propagate when the pair list cannot fit.
   function Goldbach_Pairs (N : U64) return Pair_Vectors.Vector
     with Pre => True,
          Post => (if N < 4 then Goldbach_Pairs'Result.Is_Empty);
end Math_Prime_Util.Goldbach;
