with Math_Prime_Util.Int;

--  Native 64-bit operations, with zero-based bit positions.
--  MPU 0.75 reference/mpu/TODO lists these names but supplies no C or Perl
--  implementation. Implemented directly in Ada; all U64 inputs are valid.
package Math_Prime_Util.Bit_Positions with SPARK_Mode => On is
   use type U64;

   --  reference/mpu/TODO: bittest. Native bit test; False for Index >= 64.
   --  No errors.
   function Bittest (N, Index : U64) return Boolean
     with Pre => True,
          Post => Bittest'Result =
            (Index < 64 and then (N and 2 ** Natural (Index)) /= 0);

   --  reference/mpu/TODO: bitset. Native set; undefined for Index >= 64.
   --  No errors.
   function Bitset (N, Index : U64) return Int.Optional_U64
     with Pre => True,
          Post => Bitset'Result.Defined = (Index < 64)
            and then (if Bitset'Result.Defined then
                         Bitset'Result.Value =
                           (N or 2 ** Natural (Index)));

   --  reference/mpu/TODO: bitclear. Native clear; N for Index >= 64.
   --  No errors.
   function Bitclear (N, Index : U64) return U64
     with Pre => True,
          Post => Bitclear'Result =
            (if Index < 64 then N and not (2 ** Natural (Index)) else N);

   --  reference/mpu/TODO: bitflip. Native flip; undefined for Index >= 64.
   --  No errors.
   function Bitflip (N, Index : U64) return Int.Optional_U64
     with Pre => True,
          Post => Bitflip'Result.Defined = (Index < 64)
            and then (if Bitflip'Result.Defined then
                         Bitflip'Result.Value =
                           (N xor 2 ** Natural (Index)));

   --  reference/mpu/TODO: bitscan0. Native lowest zero position >= Start.
   --  Returns Start for Start >= 64, or 64 if no native zero remains.
   --  No errors.
   function Bitscan0 (N, Start : U64) return U64
     with Pre => True,
          Post => (if Start >= 64 then Bitscan0'Result = Start else
                     Bitscan0'Result in Start .. 64
                     and then not Bittest (N, Bitscan0'Result)
                     and then (for all I in Start .. 63 =>
                       (if I < Bitscan0'Result then Bittest (N, I))));

   --  reference/mpu/TODO: bitscan1. Native lowest one position >= Start.
   --  Undefined if none remains or Start >= 64. No errors.
   function Bitscan1 (N, Start : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Bitscan1'Result.Defined then
                     Bitscan1'Result.Value in Start .. 63
                     and then Bittest (N, Bitscan1'Result.Value)
                     and then (for all I in Start .. 63 =>
                       (if I < Bitscan1'Result.Value then
                          not Bittest (N, I)))
                   else (for all I in Start .. 63 => not Bittest (N, I)));
end Math_Prime_Util.Bit_Positions;
