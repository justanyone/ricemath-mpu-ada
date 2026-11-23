with Math_Prime_Util.Int;
with Math_Prime_Util.Random;

--  Native random primes from random_prime.c and RandomPrimes.pm (MPU 0.75).
--  The caller owns and seeds the generator. Sizes beyond U64 require bigint.
package Math_Prime_Util.Random_Primes with SPARK_Mode => On is
   use type U64;
   use Math_Prime_Util.Random;

   --  Uniform prime in inclusive Low .. High; undefined if none exists.
   procedure Random_Prime
     (G : in out Generator; Low, High : U64; Value : out Int.Optional_U64)
     with Pre => Is_Seeded (G),
          Post => (if Value.Defined then Value.Value in Low .. High);
   --  Uniform prime in 2 .. High; undefined if High < 2.
   procedure Random_Prime
     (G : in out Generator; High : U64; Value : out Int.Optional_U64)
     with Pre => Is_Seeded (G),
          Post => (if Value.Defined then Value.Value in 2 .. High);
   --  Prime of exactly Bits bits. Invalid sizes fail the precondition.
   procedure Random_Nbit_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Value >= 2 ** (Bits - 1)
            and then (if Bits < 64 then Value < 2 ** Bits);
   --  Prime of exactly Digits decimal digits (1 .. 19 in the native C tier).
   procedure Random_Ndigit_Prime
     (G : in out Generator; Digits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Digits in 1 .. 19,
          Post => Value >= 10 ** (Digits - 1) and then Value < 10 ** Digits;
   --  Bits-bit safe prime P, for which (P-1)/2 is prime; Bits in 3 .. 64.
   procedure Random_Safe_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 3 .. 64,
          Post => Value >= 2 ** (Bits - 1)
            and then (if Bits < 64 then Value < 2 ** Bits);
   --  Bits-bit product of two primes with evenly split factor bit lengths.
   --  Bits must be in 4 .. 64; repeated factors are allowed.
   procedure Random_Semiprime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 4 .. 64,
          Post => Value >= 2 ** (Bits - 1)
            and then (if Bits < 64 then Value < 2 ** Bits);
   --  Uniform Bits-bit semiprime, with unrestricted factors; Bits in 3 .. 64.
   procedure Random_Unrestricted_Semiprime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 3 .. 64,
          Post => Value >= 2 ** (Bits - 1)
            and then (if Bits < 64 then Value < 2 ** Bits);
   --  Native Maurer path: n-bit generation with deterministic primality.
   procedure Random_Maurer_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Value >= 2 ** (Bits - 1);
   --  Native proven-prime path; deterministic primality proves every result.
   procedure Random_Proven_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Value >= 2 ** (Bits - 1);
   --  Shawe-Taylor generation using SHA-256 and a fresh 512-bit seed.
   --  Bits in 2 .. 64. Generation_Error means the MPU retry limit expired.
   procedure Random_Shawe_Taylor_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Value >= 2 ** (Bits - 1)
            and then (if Bits < 64 then Value < 2 ** Bits);
   Generation_Error : exception;
end Math_Prime_Util.Random_Primes;
