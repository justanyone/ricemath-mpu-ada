with Interfaces;
package Math_Prime_Util.Random with SPARK_Mode => On is
   use type U64;
   subtype Byte is Interfaces.Unsigned_8;
   subtype Word is Interfaces.Unsigned_32;
   --  Volatile components keep seed-wiping stores in generated code.
   type Byte_Array is array (Natural range <>) of Byte
     with Volatile_Components;
   type Generator is limited private;
   --  Whether a seed has been supplied. A new generator cannot emit bytes.
   function Is_Seeded (G : Generator) return Boolean;
   --  Seed bytes; short seeds use insecure PCG. Use >=16 unpredictable bytes.
   procedure Csrand (G : out Generator; Seed : Byte_Array)
     with Post => Is_Seeded (G);
   --  Seed from the operating system. Entropy failure raises Entropy_Error.
   procedure Csrand (G : out Generator) with Post => Is_Seeded (G);
   Entropy_Error : exception;
   --  Fill Data with successive stream bytes (including empty arrays).
   procedure Random_Bytes (G : in out Generator; Data : out Byte_Array)
     with Pre => Is_Seeded (G);
   --  Draw a 32-bit unsigned integer, stored in a U64.
   procedure Irand (G : in out Generator; Value : out U64)
     with Pre => Is_Seeded (G), Post => Value <= 16#FFFF_FFFF#;
   --  XS.xs srand / csprng.c csprng_srand: seed with a native integer.
   --  Returns Seed in Value; this deterministic seed is not secure entropy.
   procedure Srand (G : out Generator; Seed : U64; Value : out U64)
     with Post => Is_Seeded (G) and then Value = Seed;
   --  XS.xs srand: seed from OS entropy and return the native seed.
   --  Uses Entropy_Bytes, including the MPU timer fallback.
   procedure Srand (G : out Generator; Value : out U64)
     with Post => Is_Seeded (G);
   --  csprng.c irand32: draw 32 bits, represented as a U64.
   procedure Irand32 (G : in out Generator; Value : out U64)
     with Pre => Is_Seeded (G), Post => Value <= 16#FFFF_FFFF#;
   --  csprng.c irand64: draw 64 bits, first word in the high half.
   procedure Irand64 (G : in out Generator; Value : out U64)
     with Pre => Is_Seeded (G);
   --  csprng.c drand64 / XS.xs drand: binary64 draw times Scale.
   --  Scale zero means one; negative scales give values in (Scale, 0].
   procedure Drand
     (G : in out Generator; Value : out Long_Float; Scale : Long_Float := 0.0)
     with Pre => Is_Seeded (G),
          Post => (if Scale = 0.0 then Value >= 0.0 and then Value < 1.0
                   elsif Scale > 0.0 then Value >= 0.0 and then Value <= Scale
                   else Value >= Scale and then Value <= 0.0);
   --  XS.xs rand: the same scaled binary64 draw as Drand.
   procedure Rand
     (G : in out Generator; Value : out Long_Float; Scale : Long_Float := 0.0)
     with Pre => Is_Seeded (G),
          Post => (if Scale = 0.0 then Value >= 0.0 and then Value < 1.0
                   elsif Scale > 0.0 then Value >= 0.0 and then Value <= Scale
                   else Value >= Scale and then Value <= 0.0);
   --  entropy.c get_entropy_bytes: fill Data from /dev/urandom, falling
   --  back to /dev/random on open failure, then MPU's clock-mixing method.
   --  Empty arrays consume no entropy; supports arbitrary array bounds.
   procedure Entropy_Bytes (Data : out Byte_Array);
   --  Draw an unsigned integer with Bits bits; zero bits consumes no bytes.
   procedure Urandomb (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits <= 64,
          Post => (if Bits < 64 then Value < 2 ** Bits);
   --  Draw below nonzero Modulus; one returns zero without consuming bytes.
   procedure Urandomm (G : in out Generator; Modulus : U64; Value : out U64)
     with Pre => Is_Seeded (G) and then Modulus > 0,
          Post => (if Modulus = 1 then Value = 0 else Value < Modulus);
   --  Draw in inclusive Low .. High; requires Low <= High.
   procedure Urandomr (G : in out Generator; Low, High : U64; Value : out U64)
     with Pre => Is_Seeded (G) and then Low <= High,
          Post => Value in Low .. High;
private
   subtype State_Index is Natural range 0 .. 15;
   type State_Array is array (State_Index) of Word;
   type Generator is limited record
      State : State_Array := [others => 0];
      Buffer : Byte_Array (0 .. 1023) := [others => 0];
      Position : Natural range 0 .. 1024 := 1024;
      Seeded : Boolean := False;
   end record;
end Math_Prime_Util.Random;
