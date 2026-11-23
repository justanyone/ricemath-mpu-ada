with Interfaces;

--  MPU 0.75 chacha.c and csprng.c, using caller-owned state.
package Math_Prime_Util.Random with SPARK_Mode => On is
   use type U64;
   subtype Byte is Interfaces.Unsigned_8;
   subtype Word is Interfaces.Unsigned_32;
   type Byte_Array is array (Natural range <>) of Byte
     with Volatile_Components;
   type Generator is limited private;

   --  Whether a seed has been supplied. A new generator cannot emit bytes.
   function Is_Seeded (G : Generator) return Boolean;

   --  Seed from bytes; short seeds use MPU's PCG expansion and are insecure.
   --  At least 16 unpredictable bytes are needed for a secure seed.
   procedure Csrand (G : out Generator; Seed : Byte_Array)
     with Post => Is_Seeded (G);

   --  Seed from the operating system. Entropy failure raises Entropy_Error.
   procedure Csrand (G : out Generator)
     with Post => Is_Seeded (G);
   Entropy_Error : exception;

   --  Fill Data with successive stream bytes (including empty arrays).
   procedure Random_Bytes (G : in out Generator; Data : out Byte_Array)
     with Pre => Is_Seeded (G);

   --  Draw a 32-bit unsigned integer, stored in a U64.
   procedure Irand (G : in out Generator; Value : out U64)
     with Pre => Is_Seeded (G), Post => Value <= 16#FFFF_FFFF#;

   --  Draw an unsigned integer with Bits bits; zero bits consumes no bytes.
   procedure Urandomb
     (G : in out Generator; Bits : Natural; Value : out U64)
     with Pre => Is_Seeded (G) and then Bits <= 64,
          Post => (if Bits < 64 then Value < 2 ** Bits);

   --  Draw uniformly below Modulus; zero or one returns zero without a draw.
   procedure Urandomm
     (G : in out Generator; Modulus : U64; Value : out U64)
     with Pre => Is_Seeded (G),
          Post => (if Modulus <= 1 then Value = 0 else Value < Modulus);

   --  Draw uniformly in the inclusive interval Low .. High.
   --  An inverted interval violates the precondition.
   procedure Urandomr
     (G : in out Generator; Low, High : U64; Value : out U64)
     with Pre => Is_Seeded (G) and then Low <= High,
          Post => Value in Low .. High;

private
   type State_Array is array (Natural range 0 .. 15) of Word;
   type Generator is limited record
      State : State_Array := [others => 0];
      Buffer : Byte_Array (0 .. 1023) := [others => 0];
      Position : Natural range 0 .. 1024 := 1024;
      Seeded : Boolean := False;
   end record;
end Math_Prime_Util.Random;
