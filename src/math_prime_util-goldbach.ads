with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

--  Goldbach partitions from MPU 0.75 goldbach.c.
package Math_Prime_Util.Goldbach is
   use type U64;

   --  goldbach.c: minimal_goldbach_pair.
   --  Least prime p such that N - p is prime. Undefined when no pair exists.
   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N < 4 then
                     not Minimal_Goldbach_Pair'Result.Defined);

   --  goldbach.c: goldbach_pair_count.
   --  Count unordered prime pairs whose sum is N.
   function Goldbach_Pair_Count (N : U64) return U64
     with Pre => True,
          Post => (if N < 4 then Goldbach_Pair_Count'Result = 0);

   --  goldbach.c: goldbach_pairs.
   --  Smaller prime of each unordered pair, in ascending order.
   function Goldbach_Pairs (N : U64) return Sieve.Prime_Vectors.Vector
     with Pre => True,
          Post => (if N < 4 then Goldbach_Pairs'Result.Is_Empty);
end Math_Prime_Util.Goldbach;
