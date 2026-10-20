with Ada.IO_Exceptions;
with Interfaces.C;
with System;
with Math_Prime_Util.Random_Core;

package body Math_Prime_Util.Random is
   use Interfaces;
   use type Interfaces.C.long;
   use Math_Prime_Util.Random_Core;

   function Getrandom
     (Buffer : System.Address; Length : Interfaces.C.size_t;
      Flags : Interfaces.C.unsigned) return Interfaces.C.long
     with Import, Convention => C, External_Name => "getrandom";

   procedure Wipe (Buffer : System.Address; Length : Interfaces.C.size_t)
     with Import, Convention => C, External_Name => "explicit_bzero";

   function Entropy_Bytes (Count : Natural) return String is
      Result : String (1 .. Count);
      Done : Natural := 0;
      Got : Interfaces.C.long;
   begin
      while Done < Count loop
         Got := Getrandom (Result (Done + 1)'Address,
                           Interfaces.C.size_t (Count - Done), 0);
         if Got <= 0 or else Got > Interfaces.C.long (Count - Done) then
            raise Ada.IO_Exceptions.Device_Error with "getrandom failed";
         end if;
         Done := Done + Natural (Got);
      end loop;
      return Result;
   end Entropy_Bytes;

   protected Generator is
      procedure Seed (Data : String);
      procedure Bytes (Data : out String);
      procedure Integer32 (Value : out U32);
      procedure Integer64 (Value : out U64);
      procedure Real_Value (Value : out Long_Float);
      procedure Bounded (Modulus : U64; Value : out U64);
   private
      State : Words := [others => 0];
      Buffer : String (1 .. 64) := [others => Character'Val (0)];
      Position : Natural range 0 .. 64 := 64;
      procedure Refill;
   end Generator;

   protected body Generator is
      procedure Seed (Data : String) is
         Key : String (1 .. 40) := [others => Character'Val (0)];
      begin
         Expand_Seed (Data, Key);
         State (0 .. 3) :=
           [16#6170_7865#, 16#3320_646E#, 16#7962_2D32#, 16#6B20_6574#];
         for I in 0 .. 7 loop
            State (I + 4) := Load (Key, 4 * I);
         end loop;
         State (12) := 0; State (13) := 0;
         State (14) := Load (Key, 32); State (15) := Load (Key, 36);
         Position := 64;
         Buffer := [others => Character'Val (0)];
         Wipe (Key'Address, 40);
      end Seed;

      procedure Refill is
      begin
         Block (State, Buffer);
         Position := 0;
      end Refill;

      procedure Bytes (Data : out String) is
      begin
         for I in Data'Range loop
            if Position = 64 then
               Refill;
            end if;
            Data (I) := Buffer (Position + 1);
            Position := Position + 1;
         end loop;
      end Bytes;

      procedure Integer32 (Value : out U32) is
         Data : String (1 .. 4);
      begin
         Bytes (Data);
         Value := Load (Data, 0);
      end Integer32;

      procedure Integer64 (Value : out U64) is
         A, B : U32;
      begin
         Integer32 (A); Integer32 (B);
         Value := Shift_Left (U64 (A), 32) or U64 (B);
      end Integer64;

      procedure Real_Value (Value : out Long_Float) is
         A : U64;
      begin
         loop
            Integer64 (A);
            Value := Long_Float (A) * 2.0 ** (-64);
            exit when Value < 1.0;
         end loop;
      end Real_Value;

      procedure Bounded (Modulus : U64; Value : out U64) is
         R32, Minimum32 : U32;
         Minimum : U64;
      begin
         if Modulus <= 1 then
            Value := 0;
         elsif Modulus <= 16#FFFF_FFFF# then
            Minimum32 := (-U32 (Modulus)) mod U32 (Modulus);
            loop
               Integer32 (R32);
               exit when R32 >= Minimum32;
            end loop;
            Value := U64 (R32 mod U32 (Modulus));
         elsif Modulus = 2 ** 32 then
            Integer32 (R32); Value := U64 (R32);
         else
            Minimum := (-Modulus) mod Modulus;
            loop
               Integer64 (Value);
               exit when Value >= Minimum;
            end loop;
            Value := Value mod Modulus;
         end if;
      end Bounded;
   end Generator;

   procedure Csrand (Seed : String) is
   begin
      Generator.Seed (Seed);
   end Csrand;

   procedure Csrand is
   begin
      Csrand (Entropy_Bytes (40));
   end Csrand;

   procedure Srand (Seed : U64) is
      Data : String (1 .. 8);
   begin
      Store (Data, 0, U32 (Seed and 16#FFFF_FFFF#));
      Store (Data, 4, U32 (Shift_Right (Seed, 32)));
      Csrand (Data (1 .. (if Seed <= 16#FFFF_FFFF# then 4 else 8)));
   end Srand;

   function Irand32 return U32 is
      Value : U32;
   begin
      Generator.Integer32 (Value);
      return Value;
   end Irand32;

   function Irand return U32 is (Irand32);

   function Irand64 return U64 is
      Value : U64;
   begin
      Generator.Integer64 (Value);
      return Value;
   end Irand64;

   function Drand (Limit : Long_Float := 1.0) return Long_Float is
      Value : Long_Float;
   begin
      Generator.Real_Value (Value);
      Value := Value * Limit;
      if Limit > 0.0 and then Value >= Limit then
         return Long_Float'Adjacent (Limit, 0.0);
      end if;
      if Limit < 0.0 and then Value <= Limit then
         return Long_Float'Adjacent (Limit, 0.0);
      end if;
      return Value;
   end Drand;

   function Rand return Long_Float is (Drand);

   function Random_Bytes (Count : Natural) return String is
      Result : String (1 .. Count);
   begin
      Generator.Bytes (Result);
      return Result;
   end Random_Bytes;

   function Urandomb (Bits : Natural) return U64 is
   begin
      if Bits > 64 then
         raise Constraint_Error with "urandomb exceeds 64 bits";
      end if;
      if Bits = 0 then
         return 0;
      elsif Bits <= 32 then
         return U64 (Shift_Right (Irand32, 32 - Bits));
      else
         return Shift_Right (Irand64, 64 - Bits);
      end if;
   end Urandomb;

   function Urandomm (Modulus : U64) return U64 is
      Value : U64;
   begin
      if Modulus = 0 then
         raise Constraint_Error with "urandomm requires positive modulus";
      end if;
      Generator.Bounded (Modulus, Value);
      return Value;
   end Urandomm;

   function Urandomr (Low, High : U64) return U64 is
   begin
      if Low > High then
         raise Constraint_Error with "urandomr requires ordered bounds";
      end if;
      if Low = 0 and then High = U64'Last then
         return Irand64;
      end if;
      return Low + Urandomm (High - Low + 1);
   end Urandomr;
begin
   Csrand;
end Math_Prime_Util.Random;
