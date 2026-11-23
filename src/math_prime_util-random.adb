with Interfaces.C;
with System;
package body Math_Prime_Util.Random with SPARK_Mode => On is
   use Interfaces;
   function Is_Seeded (G : Generator) return Boolean is (G.Seeded);
   function Load (Data : Byte_Array; Offset : Natural) return Word
     with Pre => Offset <= Data'Length and then Data'Length - Offset >= 4;
   function Load (Data : Byte_Array; Offset : Natural) return Word is
     (Word (Data (Data'First + Offset))
      or Shift_Left (Word (Data (Data'First + Offset + 1)), 8)
      or Shift_Left (Word (Data (Data'First + Offset + 2)), 16)
      or Shift_Left (Word (Data (Data'First + Offset + 3)), 24));
   procedure Store (Data : in out Byte_Array; Offset : Natural; V : Word)
     with Pre => Offset <= Data'Length and then Data'Length - Offset >= 4;
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
         Increment := Shift_Left (Load (Key, 4), 1) or 1;
         State := (Increment + Load (Key, 0)) * 747_796_405 + Increment;
         State := (State xor Load (Key, 8)) * 747_796_405 + Increment;
         State := (State xor Load (Key, 12)) * 747_796_405 + Increment;
         for I in (Seed'Length + 3) / 4 .. 9 loop
            Store (Key, 4 * I, Output);
            State := State * 747_796_405 + Increment;
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
      for I in Key'Range loop
         Key (I) := 0;
      end loop;
   end Csrand;
   --  entropy.c: get_entropy_bytes; libc getentropy fills all 40 bytes.
   procedure Csrand (G : out Generator) with SPARK_Mode => Off is
      use type Interfaces.C.int;
      function Getentropy (Buffer : System.Address; Size : Interfaces.C.size_t)
        return Interfaces.C.int
        with Import, Convention => C, External_Name => "getentropy";
      Seed : aliased Byte_Array (0 .. 39);
   begin
      if Getentropy (Seed'Address, 40) /= 0 then
         raise Entropy_Error with "operating-system entropy unavailable";
      end if;
      Csrand (G, Seed);
      for I in Seed'Range loop
         Seed (I) := 0;
      end loop;
   end Csrand;
   --  chacha.c: QUARTERROUND, chacha_core, increment_chacha_counter.
   procedure Refill (G : in out Generator);
   procedure Refill (G : in out Generator) is
      X : State_Array;
      procedure Quarter (A, B, C, D : State_Index);
      procedure Quarter (A, B, C, D : State_Index) is
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
   procedure Srand (G : out Generator; Seed : U64; Value : out U64) is
      Data : Byte_Array (0 .. 7);
      Size : constant Positive := (if Seed <= 16#FFFF_FFFF# then 4 else 8);
   begin
      for I in Data'Range loop
         Data (I) := Byte (Shift_Right (Seed, 8 * I) and 255);
      end loop;
      Csrand (G, Data (0 .. Size - 1));
      Value := Seed;
      for I in Data'Range loop
         Data (I) := 0;
      end loop;
   end Srand;
   procedure Srand (G : out Generator; Value : out U64) is
      Data : Byte_Array (0 .. 7);
      Seed : U64 := 0;
   begin
      Entropy_Bytes (Data);
      for I in Data'Range loop
         Seed := Seed or Shift_Left (U64 (Data (I)), 8 * I);
         Data (I) := 0;
      end loop;
      Srand (G, Seed, Value);
   end Srand;
   procedure Irand32 (G : in out Generator; Value : out U64) is
   begin
      Irand (G, Value);
   end Irand32;
   procedure Irand64 (G : in out Generator; Value : out U64) is
      Low : U64;
   begin
      Irand (G, Value);
      Irand (G, Low);
      Value := Shift_Left (Value, 32) or Low;
   end Irand64;
   procedure Drand
     (G : in out Generator; Value : out Long_Float; Scale : Long_Float := 0.0)
   is
      Bits : U64;
   begin
      loop
         Irand64 (G, Bits);
         Value := Long_Float (Bits) * 2.0 ** (-64);
         exit when Value < 1.0;
      end loop;
      if Scale /= 0.0 then
         Value := Value * Scale;
      end if;
   end Drand;
   procedure Rand
     (G : in out Generator; Value : out Long_Float; Scale : Long_Float := 0.0)
   is
   begin
      Drand (G, Value, Scale);
   end Rand;
   procedure Entropy_Bytes (Data : out Byte_Array)
     with SPARK_Mode => Off
   is
      use type Interfaces.C.int;
      use type Interfaces.C.long;
      function Open (Name : Interfaces.C.char_array; Flags : Interfaces.C.int)
        return Interfaces.C.int
        with Import, Convention => C, External_Name => "open";
      function Read
        (Fd : Interfaces.C.int; Buffer : System.Address;
         Size : Interfaces.C.size_t) return Interfaces.C.long
        with Import, Convention => C, External_Name => "read";
      function Close (Fd : Interfaces.C.int) return Interfaces.C.int
        with Import, Convention => C, External_Name => "close";
      function Clock return Interfaces.C.long
        with Import, Convention => C, External_Name => "clock";
      --  entropy.c timer_mix8 and mix32, using process CPU clock ticks.
      function Mix8 (Initial : Word) return Word is
         Acc : Word := Initial;
         A : Word := 0;
         Tick : Interfaces.C.long;
         Mixed : Word;
      begin
         for Bit in 1 .. 8 loop
            Tick := Clock;
            while Tick = Clock loop
               A := A xor 1;
            end loop;
            Acc := Shift_Left (Acc, 1) or A;
         end loop;
         Mixed := (Shift_Right (Acc, Natural (Shift_Right (Acc, 28)) + 4)
                   xor Acc) * 277_803_737;
         return Shift_Right (Mixed, 22) xor Mixed;
      end Mix8;
      Fd, Closed : Interfaces.C.int;
      Got : Interfaces.C.long := 0;
      Acc : Word := 0;
   begin
      if Data'Length = 0 then
         return;
      end if;
      Fd := Open (Interfaces.C.To_C ("/dev/urandom"), 0);
      if Fd < 0 then
         Fd := Open (Interfaces.C.To_C ("/dev/random"), 0);
      end if;
      if Fd >= 0 then
         Got := Read (Fd, Data'Address, Interfaces.C.size_t (Data'Length));
         Closed := Close (Fd);
         if Got = Interfaces.C.long (Data'Length) and then Closed = 0 then
            return;
         end if;
      end if;
      for I in 1 .. 4 loop
         Acc := Mix8 (Acc);
      end loop;
      for I in Data'Range loop
         Acc := Mix8 (Mix8 (Acc));
         Data (I) := Byte (Shift_Right (Acc, 24));
      end loop;
   end Entropy_Bytes;
   procedure Urandomb
     (G : in out Generator; Bits : Natural; Value : out U64) is
      Low : U64;
   begin
      if Bits = 0 then
         Value := 0;
      elsif Bits <= 32 then
         Irand (G, Value);
         Value := Shift_Right (Value, 32 - Bits);
      else
         --  chacha_irand64 puts the first draw in the high word.
         Irand (G, Value);
         Irand (G, Low);
         Value := Shift_Right (Shift_Left (Value, 32) or Low, 64 - Bits);
      end if;
   end Urandomb;
   --  csprng.c: urandomm32/64 (PREFER_LEMIRE = 0).
   procedure Urandomm (G : in out Generator; Modulus : U64; Value : out U64) is
      Minimum : U64;
   begin
      if Modulus <= 1 then
         Value := 0;
         return;
      end if;
      Minimum := (if Modulus < 2 ** 32
        then U64 ((-Word (Modulus)) mod Word (Modulus))
        else (-Modulus) mod Modulus);
      loop
         Urandomb (G, (if Modulus <= 2 ** 32 then 32 else 64), Value);
         exit when Value >= Minimum;
      end loop;
      Value := Value mod Modulus;
   end Urandomm;
   procedure Urandomr
     (G : in out Generator; Low, High : U64; Value : out U64) is
   begin
      if Low = 0 and then High = U64'Last then
         Urandomb (G, 64, Value);
      else
         Urandomm (G, High - Low + 1, Value);
         Value := Low + Value;
      end if;
   end Urandomr;
end Math_Prime_Util.Random;
