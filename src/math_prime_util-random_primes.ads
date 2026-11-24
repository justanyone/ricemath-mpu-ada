with Math_Prime_Util.Int;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Random;

--  Native random primes from random_prime.c and RandomPrimes.pm (MPU 0.75).
--  The caller owns and seeds the generator. Sizes beyond U64 require bigint.
package Math_Prime_Util.Random_Primes with SPARK_Mode => On is
   use type U64;
   use Math_Prime_Util.Random;

   type U64_Array is array (Natural range <>) of U64;

   --  util.c: randperm(N,K). Min(N,K) distinct indices in 0 .. N-1.
   procedure Randperm
     (G : in out Generator; N, K : U64; Values : out U64_Array)
     with Pre => Is_Seeded (G)
       and then U64 (Values'Length) = U64'Min (N, K),
          Post => (for all V of Values => V < N);
   --  util.c: randperm(N,N). Full permutation, including the empty case.
   procedure Randperm
     (G : in out Generator; N : U64; Values : out U64_Array)
     with Pre => Is_Seeded (G) and then U64 (Values'Length) = N,
          Post => (for all V of Values => V < N);
   --  XS.xs: shuffle. Forward Fisher-Yates; empty arrays use no bytes.
   generic
      type Element_Type is private;
      type Element_Array is array (Natural range <>) of Element_Type;
   procedure Shuffle (G : in out Generator; Values : in out Element_Array)
     with Pre => Is_Seeded (G);
   --  XS.xs / PP.pm: vecsample. Min(K,Values'Length) ordered elements.
   generic
      type Element_Type is private;
      type Element_Array is array (Natural range <>) of Element_Type;
   procedure Vecsample
     (G : in out Generator; K : U64; Values : Element_Array;
      Sample : out Element_Array)
     with Pre => Is_Seeded (G) and then U64 (Sample'Length) =
       U64'Min (K, U64 (Values'Length));
   --  util.c: random_factored_integer (fast native factor path). Uniform
   --  integer in 1 .. N and its sorted prime factors; N=0 returns 0, empty.
   procedure Random_Factored_Integer
     (G : in out Generator; N : U64; Value : out U64;
      Factors : out Factor.Factor_List)
     with Pre => Is_Seeded (G),
          Post => (if N = 0 then Value = 0 and then Factors.Count = 0
                   else Value in 1 .. N);
   --  random_prime.c: is_mr_random, XS.xs: miller_rabin_random.
   --  K positive random strong tests; small inputs use native primality.
   procedure Miller_Rabin_Random
     (G : in out Generator; N : U64; K : U64 := 1;
      Value : out Boolean)
     with Pre => Is_Seeded (G) and then K > 0,
          Post => (if N < 2 then not Value);
   --  RandomPrimes.pm: random_strong_prime. Requires Bits >= 128;
   --  raises Constraint_Error because no strong prime fits U64.
   procedure Random_Strong_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits >= 128;
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
   --  Prime with Digit_Count decimal digits (1 .. 19 in the C tier).
   procedure Random_Ndigit_Prime
     (G : in out Generator; Digit_Count : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Digit_Count in 1 .. 19,
          Post => Value >= 10 ** (Digit_Count - 1)
            and then Value < 10 ** Digit_Count;
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
   --  XS.xs native Shawe-Taylor entry point: deterministic n-bit generation.
   --  Bits in 2 .. 64; invalid sizes fail the precondition.
   procedure Random_Shawe_Taylor_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Value >= 2 ** (Bits - 1)
            and then (if Bits < 64 then Value < 2 ** Bits);
   --  A native certificate is the prime itself: deterministic Is_Prime
   --  verifies it without a probabilistic assumption or a bigint proof chain.
   type Prime_Certificate is record
      N : U64;
   end record;
   --  Verify a native certificate; composites (including 0 and 1) fail.
   function Verify_Certificate (Certificate : Prime_Certificate) return Boolean
     with Pre => True,
          Post => (if Certificate.N < 2 then not Verify_Certificate'Result);
   --  Native Maurer prime and its deterministic certificate; Bits in 2 .. 64.
   procedure Random_Maurer_Prime_With_Cert
     (G : in out Generator; Bits : Natural; Value : out U64;
      Certificate : out Prime_Certificate)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Certificate.N = Value
            and then Verify_Certificate (Certificate);
   --  Native proven prime and its certificate; Bits in 2 .. 64.
   procedure Random_Proven_Prime_With_Cert
     (G : in out Generator; Bits : Natural; Value : out U64;
      Certificate : out Prime_Certificate)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Certificate.N = Value
            and then Verify_Certificate (Certificate);
   --  RandomPrimes.pm Shawe-Taylor recursion with SHA-256, 512-bit seed.
   --  Bits in 2 .. 64; Generation_Error means the retry limit expired.
   procedure Random_Shawe_Taylor_Prime_With_Cert
     (G : in out Generator; Bits : Natural; Value : out U64;
      Certificate : out Prime_Certificate)
     with Pre => Is_Seeded (G) and then Bits in 2 .. 64,
          Post => Certificate.N = Value
            and then Verify_Certificate (Certificate);
   Generation_Error : exception;
end Math_Prime_Util.Random_Primes;
