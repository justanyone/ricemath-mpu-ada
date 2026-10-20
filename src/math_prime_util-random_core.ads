with Interfaces;

--  Arithmetic core of MPU's ChaCha stream, isolated from OS I/O.
private package Math_Prime_Util.Random_Core with SPARK_Mode => On is
   subtype U32 is Interfaces.Unsigned_32;
   type Words is array (Natural range 0 .. 15) of U32;
   --  Decode four little-endian bytes. C: chacha.c, U8TO32_LITTLE.
   function Load (Data : String; Offset : Natural) return U32
     with Pre => Data'Length >= 4 and then Offset <= Data'Length - 4,
          Post => True;
   --  Encode four little-endian bytes. C: chacha.c, U32TO8_LITTLE.
   procedure Store (Data : in out String; Offset : Natural; V : U32)
     with Pre => Data'Length >= 4 and then Offset <= Data'Length - 4,
          Post => True;
   --  One ChaCha quarter round. C: chacha.c, QUARTERROUND.
   procedure Quarter (A, B, C, D : in out U32)
     with Pre => True, Post => True;
   --  PCG expansion of short seeds. C: chacha.c, chacha_seed.
   procedure Expand_Seed (Data : String; Key : out String)
     with Pre => Key'First = 1 and then Key'Length = 40,
          Post => True;
   --  Twenty rounds and counter advance. C: chacha.c, chacha_core.
   procedure Block (State : in out Words; Buffer : out String)
     with Pre => Buffer'First = 1 and then Buffer'Length = 64,
          Post => True;
end Math_Prime_Util.Random_Core;
