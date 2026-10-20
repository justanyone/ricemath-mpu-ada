with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Lucky-number sieves and estimates from MPU 0.75.
package Math_Prime_Util.Families is
   use type U64;
   package Lucky_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

   --  lucky_numbers.c: lucky_sieve_range. Inclusive interval; reversed is empty.
   --  Storage_Error propagates when the sieve cannot fit in memory.
   function Lucky_Numbers (Low, High : U64) return Lucky_Vectors.Vector
     with Pre => True,
          Post => (for all V of Lucky_Numbers'Result =>
                     V >= Low and then V <= High and then V mod 2 = 1);
   --  lucky_numbers.c: lucky_sieve64. Lucky numbers through High inclusive.
   function Lucky_Numbers (High : U64) return Lucky_Vectors.Vector
     with Pre => True,
          Post => (for all V of Lucky_Numbers'Result => V <= High);
   --  lucky_numbers.c: is_lucky. Test membership in the lucky sieve.
   function Is_Lucky (N : U64) return Boolean
     with Pre => True,
          Post => (if Is_Lucky'Result then N mod 2 = 1);
   --  lucky_numbers.c: lucky_count. Count lucky numbers through N inclusive.
   function Lucky_Count (N : U64) return U64
     with Pre => True, Post => Lucky_Count'Result <= N;
   --  lucky_numbers.c: lucky_count_approx. Invert the nth estimate.
   function Lucky_Count_Approx (N : U64) return U64
     with Pre => True, Post => Lucky_Count_Approx'Result <= N;
   --  lucky_numbers.c: lucky_count_lower. Empirical lower count bound.
   function Lucky_Count_Lower (N : U64) return U64
     with Pre => True, Post => Lucky_Count_Lower'Result <= N;
   --  lucky_numbers.c: lucky_count_upper. Empirical upper count bound.
   function Lucky_Count_Upper (N : U64) return U64
     with Pre => True, Post => Lucky_Count_Upper'Result <= N;
   --  lucky_numbers.c: nth_lucky. One-based index; zero is undefined.
   --  Storage_Error propagates when the backward sieve cannot fit.
   function Nth_Lucky (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky'Result.Defined = (N /= 0);
   --  lucky_numbers.c: nth_lucky_approx. Saturates at the native maximum.
   function Nth_Lucky_Approx (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky_Approx'Result.Defined = (N /= 0);
   --  lucky_numbers.c: nth_lucky_lower. Empirical lower value bound.
   function Nth_Lucky_Lower (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky_Lower'Result.Defined = (N /= 0);
   --  lucky_numbers.c: nth_lucky_upper. Empirical upper value bound.
   function Nth_Lucky_Upper (N : U64) return Int.Optional_U64
     with Pre => True, Post => Nth_Lucky_Upper'Result.Defined = (N /= 0);
end Math_Prime_Util.Families;
