package body Math_Prime_Util.Bit_Positions with SPARK_Mode => On is
   function Bittest (N, Index : U64) return Boolean is
     (Index < 64 and then (N and 2 ** Natural (Index)) /= 0);

   function Bitset (N, Index : U64) return Int.Optional_U64 is
   begin
      if Index >= 64 then
         return (Defined => False);
      end if;
      return (Defined => True, Value => N or 2 ** Natural (Index));
   end Bitset;

   function Bitclear (N, Index : U64) return U64 is
   begin
      if Index >= 64 then
         return N;
      end if;
      return N and not (2 ** Natural (Index));
   end Bitclear;

   function Bitflip (N, Index : U64) return Int.Optional_U64 is
   begin
      if Index >= 64 then
         return (Defined => False);
      end if;
      return (Defined => True, Value => N xor 2 ** Natural (Index));
   end Bitflip;

   function Bitscan0 (N, Start : U64) return U64 is
   begin
      if Start >= 64 then
         return Start;
      end if;
      for I in Start .. 63 loop
         pragma Loop_Invariant
           (for all J in Start .. I - 1 => Bittest (N, J));
         if not Bittest (N, I) then
            return I;
         end if;
      end loop;
      return 64;
   end Bitscan0;

   function Bitscan1 (N, Start : U64) return Int.Optional_U64 is
   begin
      if Start >= 64 then
         return (Defined => False);
      end if;
      for I in Start .. 63 loop
         pragma Loop_Invariant
           (for all J in Start .. I - 1 => not Bittest (N, J));
         if Bittest (N, I) then
            return (Defined => True, Value => I);
         end if;
      end loop;
      return (Defined => False);
   end Bitscan1;
end Math_Prime_Util.Bit_Positions;
