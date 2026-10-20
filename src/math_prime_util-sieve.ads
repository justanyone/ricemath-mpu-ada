with Ada.Containers.Vectors;
with Math_Prime_Util.Int;

--  Native mod-30 sieve from Math::Prime::Util 0.75.
package Math_Prime_Util.Sieve is
   use type U64;
   package Prime_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => U64);

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
