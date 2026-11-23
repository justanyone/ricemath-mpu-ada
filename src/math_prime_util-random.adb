with Math_Prime_Util.Random_Entropy;

package body Math_Prime_Util.Random with SPARK_Mode => On is
   use Interfaces;

   function Is_Seeded (G : Generator) return Boolean is (G.Seeded);

   function Load (Data : Byte_Array; Offset : Natural) return Word
     with Pre => Offset <= Data'Length and then Data'Length - Offset >= 4
;
   function Load (Data : Byte_Array; Offset : Natural) return Word is
      Result : Word := 0;
   begin
      for I in 0 .. 3 loop
         Result := Result or Shift_Left
           (Word (Data (Data'First + Offset + I)), 8 * I);
      end loop;
      return Result;
   end Load;

   procedure Store (Data : in out Byte_Array; Offset : Natural; V : Word)
     with Pre => Offset <= Data'Length and then Data'Length - Offset >= 4
;
   procedure Store (Data : in out Byte_Array; Offset : Natural; V : Word) is
   begin
      for I in 0 .. 3 loop
         Data (Data'First + Offset + I) :=
           Byte (Shift_Right (V, 8 * I) and 255);
      end loop;
   end Store;

   --  csprng.c: prng_new/prng_next and csprng_seed.
   procedure Csrand (G : out Generator; Seed : Byte_Array) is
      Key : Byte_Array (0 .. 39) := [others => 0];
      State, Increment : Word;
      procedure Advance;
      procedure Advance is
      begin
         State := State * 747_796_405 + Increment;
      end Advance;
      function Output return Word;
      function Output return Word is
         Mixed : constant Word :=
           (Shift_Right (State, Natural (Shift_Right (State, 28)) + 4)
            xor State) * 277_803_737;
      begin
         return Shift_Right (Mixed, 22) xor Mixed;
      end Output;
   begin
      for I in Seed'Range loop
         exit when I - Seed'First >= 40;
         Key (I - Seed'First) := Seed (I);
      end loop;
      if Seed'Length < 40 then
         State := 0;
         Increment := Shift_Left (Load (Key, 4), 1) or 1;
         Advance;
         State := State + Load (Key, 0);
         Advance;
         State := State xor Load (Key, 8);
         Advance;
         State := State xor Load (Key, 12);
         Advance;
         for I in (Seed'Length + 3) / 4 .. 9 loop
            Store (Key, 4 * I, Output);
            Advance;
         end loop;
      end if;
      G.State := [16#6170_7865#, 16#3320_646E#,
                  16#7962_2D32#, 16#6B20_6574#, others => 0];
      for I in 0 .. 7 loop
         G.State (I + 4) := Load (Key, 4 * I);
      end loop;
      G.State (14) := Load (Key, 32);
      G.State (15) := Load (Key, 36);
      G.Buffer := [others => 0];
      G.Position := 1024;
      G.Seeded := True;
      Key := [others => 0];
   end Csrand;

   procedure Csrand (G : out Generator) is
      Seed : Byte_Array (0 .. 39);
   begin
      Random_Entropy.Fill (Seed);
      Csrand (G, Seed);
      Seed := [others => 0];
   end Csrand;

   --  chacha.c: QUARTERROUND, chacha_core, increment_chacha_counter.
   procedure Refill (G : in out Generator);
   procedure Refill (G : in out Generator) is
      X : State_Array;
      procedure Quarter (A, B, C, D : Natural);
      procedure Quarter (A, B, C, D : Natural) is
      begin
         X (A) := X (A) + X (B);
         X (D) := Rotate_Left (X (D) xor X (A), 16);
         X (C) := X (C) + X (D);
         X (B) := Rotate_Left (X (B) xor X (C), 12);
         X (A) := X (A) + X (B);
         X (D) := Rotate_Left (X (D) xor X (A), 8);
         X (C) := X (C) + X (D);
         X (B) := Rotate_Left (X (B) xor X (C), 7);
      end Quarter;
   begin
      for Block in 0 .. 15 loop
         X := G.State;
         for Round in 1 .. 10 loop
            Quarter (0, 4, 8, 12);
            Quarter (1, 5, 9, 13);
            Quarter (2, 6, 10, 14);
            Quarter (3, 7, 11, 15);
            Quarter (0, 5, 10, 15);
            Quarter (1, 6, 11, 12);
            Quarter (2, 7, 8, 13);
            Quarter (3, 4, 9, 14);
         end loop;
         for I in X'Range loop
            Store (G.Buffer, Block * 64 + 4 * I, X (I) + G.State (I));
         end loop;
         G.State (12) := G.State (12) + 1;
         if G.State (12) = 0 then
            G.State (13) := G.State (13) + 1;
         end if;
      end loop;
      G.Position := 0;
   end Refill;

   procedure Random_Bytes (G : in out Generator; Data : out Byte_Array) is
   begin
      for I in Data'Range loop
         if G.Position = 1024 then
            Refill (G);
         end if;
         Data (I) := G.Buffer (G.Position);
         G.Position := G.Position + 1;
      end loop;
   end Random_Bytes;

   procedure Irand (G : in out Generator; Value : out U64) is
      Data : Byte_Array (0 .. 3);
   begin
      Random_Bytes (G, Data);
      Value := U64 (Load (Data, 0));
   end Irand;

   --  chacha_irand64 places the first 32-bit draw in the HIGH word.
   procedure Draw_64 (G : in out Generator; Value : out U64);
   procedure Draw_64 (G : in out Generator; Value : out U64) is
      A, B : U64;
   begin
      Irand (G, A);
      Irand (G, B);
      Value := Shift_Left (A, 32) or B;
   end Draw_64;

   procedure Urandomb
     (G : in out Generator; Bits : Natural; Value : out U64) is
   begin
      if Bits = 0 then
         Value := 0;
      elsif Bits <= 32 then
         Irand (G, Value);
         Value := Shift_Right (Value, 32 - Bits);
      else
         Draw_64 (G, Value);
         Value := Shift_Right (Value, 64 - Bits);
      end if;
   end Urandomb;

   --  csprng.c: urandomm32/64 (PREFER_LEMIRE = 0).
   procedure Urandomm
     (G : in out Generator; Modulus : U64; Value : out U64)
   is
      Minimum : U64;
   begin
      if Modulus <= 1 then
         Value := 0;
         return;
      elsif Modulus <= 16#FFFF_FFFF# then
         Minimum := U64 ((-Word (Modulus)) mod Word (Modulus));
      elsif Modulus = 2 ** 32 then
         Irand (G, Value);
         return;
      else
         Minimum := (-Modulus) mod Modulus;
      end if;
      loop
         if Modulus <= 16#FFFF_FFFF# then
            Irand (G, Value);
         else
            Draw_64 (G, Value);
         end if;
         exit when Value >= Minimum;
      end loop;
      Value := Value mod Modulus;
   end Urandomm;

   procedure Urandomr
     (G : in out Generator; Low, High : U64; Value : out U64) is
   begin
      if Low = 0 and then High = U64'Last then
         Draw_64 (G, Value);
      else
         Urandomm (G, High - Low + 1, Value);
         Value := Low + Value;
      end if;
   end Urandomr;
end Math_Prime_Util.Random;
