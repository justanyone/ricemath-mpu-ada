with Ada.Containers.Vectors;

--  Arithmetic functions translated from MPU 0.75.
package Math_Prime_Util.Arith is
   package U64_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  inverse_sigma0.c: inverse_sigma0_list. Inclusive range; reversed ranges
   --  and k = 0 return an empty vector.
   function Inverse_Sigma0 (K, Low, High : U64) return U64_Vectors.Vector
     with Pre => True,
          Post => (for all N of Inverse_Sigma0'Result =>
                     N >= Low and then N <= High);

   --  inverse_sigma0.c: inverse_sigma0_count. Inclusive range; returns zero
   --  for reversed ranges and k = 0.
   function Inverse_Sigma0_Count (K, Low, High : U64) return U64
     with Pre => True, Post => Inverse_Sigma0_Count'Result <= High;
end Math_Prime_Util.Arith;
