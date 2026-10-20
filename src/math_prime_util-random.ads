with Interfaces;

--  MPU 0.75 random stream. Strings contain raw bytes, not text.
--  Calls share one protected stream. Reseeding replaces that stream.
package Math_Prime_Util.Random is
   --  Seed with bytes; short seeds use PCG expansion. Extra bytes are ignored.
   --  C: csprng.c, csprng_seed; chacha.c, chacha_seed.
   procedure Csrand (Seed : String)
     with Pre => True, Post => True;
   --  Seed from 40 OS bytes. OS failures raise Ada.IO_Exceptions.Device_Error.
   --  C: entropy.c, get_entropy_bytes; csprng.c, csprng_seed.
   procedure Csrand
     with Pre => True, Post => True;
   --  Set the repeatable integer seed (not suitable for secrets).
   --  C: csprng.c, csprng_srand.
   procedure Srand (Seed : U64)
     with Pre => True, Post => True;
   --  Return a 32-bit integer. C: csprng.c, irand32.
   function Irand return Interfaces.Unsigned_32
     with Pre => True, Post => True;
   --  Return a 32-bit integer. C: chacha.c, chacha_irand32.
   function Irand32 return Interfaces.Unsigned_32
     with Pre => True, Post => True;
   --  Return a 64-bit integer, high word first.
   --  C: chacha.c, chacha_irand64.
   function Irand64 return U64
     with Pre => True, Post => True;
   --  Return a real in [0, Limit). Limit must be positive and finite.
   --  C: csprng.c, drand64, and XS.xs, rand.
   function Drand (Limit : Long_Float := 1.0) return Long_Float
     with Pre => Limit > 0.0 and then Limit <= Long_Float'Last,
          Post => Drand'Result >= 0.0 and then Drand'Result < Limit;
   --  Return a real in [0, 1). C: csprng.c, drand64.
   function Rand return Long_Float
     with Pre => True,
          Post => Rand'Result >= 0.0 and then Rand'Result < 1.0;
   --  Return Count raw stream bytes. C: chacha.c, chacha_rand_bytes.
   function Random_Bytes (Count : Natural) return String
     with Pre => True, Post => Random_Bytes'Result'Length = Count;
   --  Return Count OS bytes; OS failures raise Device_Error.
   --  C: entropy.c, get_entropy_bytes. Uses Linux getrandom, no dependency.
   function Entropy_Bytes (Count : Natural) return String
     with Pre => True, Post => Entropy_Bytes'Result'Length = Count;
   --  Return an unsigned integer with at most Bits bits.
   --  C: csprng.c, urandomb. Bits above 64 violate the precondition.
   function Urandomb (Bits : Natural) return U64
     with Pre => Bits <= 64,
          Post => (if Bits < 64 then Urandomb'Result < 2 ** Bits);
   --  Return a uniform integer in [0, Modulus), or zero for Modulus <= 1.
   --  C: csprng.c, urandomm32 and urandomm64 (OpenBSD rejection method).
   function Urandomm (Modulus : U64) return U64
     with Pre => True,
          Post => (if Modulus <= 1 then Urandomm'Result = 0
                   else Urandomm'Result < Modulus);
   --  Return a uniform integer in the inclusive interval Low .. High.
   --  C: XS.xs, urandomr, using csprng.c, urandomm64.
   function Urandomr (Low, High : U64) return U64
     with Pre => Low <= High,
          Post => Urandomr'Result in Low .. High;
end Math_Prime_Util.Random;
