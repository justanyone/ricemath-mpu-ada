with Ada.Numerics.Long_Elementary_Functions;
with Ada.Unchecked_Deallocation;
with Interfaces;
with Math_Prime_Util.Count.Tables;
with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

--  Port of lmo.c (LMO_prime_count) and the segment path in prime_counts.c.
--  prime_count_tables.h supplies the counts below the LMO crossover.
package body Math_Prime_Util.Count.Lmo is
   use Math_Prime_Util;

   --  constants.h: _MPU_LMO_CROSSOVER. Segment sieve wins below this.
   Lmo_Crossover : constant U64 := 66_000_000;

   --  lmo.c: PHI_SIEVE_MULT and the 3*5*7*11 word tile.
   Phi_Words : constant := 1155 * 13;
   Prev_Bytes : constant := 512;

   type U32 is mod 2 ** 32;
   type U16 is mod 2 ** 16;
   type U8 is mod 2 ** 8;
   type Word_Array is array (Natural range <>) of U64;
   type U8_Array is array (Natural range <>) of U8;
   type U16_Array is array (Natural range <>) of U16;
   type U32_Array is array (Natural range <>) of U32;
   type U64_Array is array (Natural range <>) of U64;
   type Prime_Array is array (Natural range <>) of U32;
   type Word_Access is access Word_Array;
   type U8_Access is access U8_Array;
   type U16_Access is access U16_Array;
   type U32_Access is access U32_Array;
   type U64_Access is access U64_Array;
   type Prime_Access is access Prime_Array;

   procedure Free_Word is new Ada.Unchecked_Deallocation
     (Word_Array, Word_Access);
   procedure Free_U8 is new Ada.Unchecked_Deallocation
     (U8_Array, U8_Access);
   procedure Free_U16 is new Ada.Unchecked_Deallocation
     (U16_Array, U16_Access);
   procedure Free_U32 is new Ada.Unchecked_Deallocation
     (U32_Array, U32_Access);
   procedure Free_U64 is new Ada.Unchecked_Deallocation
     (U64_Array, U64_Access);
   procedure Free_Prime is new Ada.Unchecked_Deallocation
     (Prime_Array, Prime_Access);

   --  legendre_phi.c: _s4, phi (x, 4) residues mod 210.
   S4 : constant U8_Array (0 .. 209) := [
     0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 3, 3, 3, 3, 4, 4, 5, 5, 5, 5, 6,
     6, 6, 6, 6, 6, 7, 7, 8, 8, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 11, 11, 11,
     11, 12, 12, 12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 14, 14, 15, 15, 15,
     15, 15, 15, 16, 16, 16, 16, 17, 17, 18, 18, 18, 18, 18, 18, 19, 19, 19,
     19, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22,
     22, 23, 23, 24, 24, 24, 24, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 27,
     27, 27, 27, 28, 28, 28, 28, 28, 28, 29, 29, 29, 29, 30, 30, 30, 30, 30,
     30, 31, 31, 32, 32, 32, 32, 33, 33, 33, 33, 33, 33, 34, 34, 35, 35, 35,
     35, 35, 35, 36, 36, 36, 36, 36, 36, 37, 37, 37, 37, 38, 38, 39, 39, 39,
     39, 40, 40, 40, 40, 40, 40, 41, 41, 42, 42, 42, 42, 42, 42, 43, 43, 43,
     43, 44, 44, 45, 45, 45, 45, 46, 46, 47, 47, 47, 47, 47, 47, 47, 47, 47,
     47, 48];

   --  Heap tables: the prime list and the factor table grow with n^(1/3).
   --  Unchecked_Deallocation is the same pattern Count already uses for the
   --  Lucy arrays whose length is data-dependent.

   function Popcount (Value : U64) return Natural is
      X : U64 := Value;
   begin
      --  lmo.c: bitcount, the 64-bit SWAR count.
      X := X - (Interfaces.Shift_Right (X, 1) and 16#5555_5555_5555_5555#);
      X := (X and 16#3333_3333_3333_3333#)
        + (Interfaces.Shift_Right (X, 2) and 16#3333_3333_3333_3333#);
      X := (X + Interfaces.Shift_Right (X, 4))
        and 16#0F0F_0F0F_0F0F_0F0F#;
      X := X * 16#0101_0101_0101_0101#;
      return Natural (Interfaces.Shift_Right (X, 56));
   end Popcount;

   --  legendre_phi.c: tablephi for a = 6 (tiny_phi_max_a is PHIC).
   function Tiny_Phi (X : U64) return U64 is
      function Phi4 (V : U64) return U64 is
        ((V / 210) * 48 + U64 (S4 (Natural (V mod 210))));
      Xp : constant U64 := X / 11;
      X2 : constant U64 := X / 13;
      X2p : constant U64 := X2 / 11;
   begin
      return Phi4 (X) - Phi4 (Xp) - Phi4 (X2) + Phi4 (X2p);
   end Tiny_Phi;

   function Icbrt (N : U64) return U64 is
      Lo : U64 := 0;
      Hi : U64 := 2_642_245;
      Mid : U64;
   begin
      if N < 2_642_245 then
         Hi := N;
      end if;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         if U128 (Mid) * U128 (Mid) * U128 (Mid) > U128 (N) then
            Hi := Mid - 1;
         else
            Lo := Mid;
         end if;
      end loop;
      return Lo;
   end Icbrt;

   function M_Factor (N : U64) return U64 is
      use Ada.Numerics.Long_Elementary_Functions;
      X : constant Long_Float := Long_Float (N);
      Value : Long_Float;
   begin
      --  lmo.c: M_FACTOR. Alpha from the Oliveira e Silva paper.
      Value := X * (Log (X) / Log (5.2)) * (Log (Log (X)) - 1.4);
      if Value < 1.0 then
         return 1;
      end if;
      return U64 (Long_Float'Floor (Value));
   end M_Factor;

   function Segment_Prime_Count (High : U64) return U64 is
      Count : U64 := 0;
      Low : U64 := 7;
      Added : U64;
   begin
      --  prime_counts.c: segment_prime_count from 2 through High.
      if High < 2 then
         return 0;
      elsif High >= 2 then
         Count := 1;
      end if;
      if High >= 3 then
         Count := 2;
      end if;
      if High >= 5 then
         Count := 3;
      end if;
      if High < 7 then
         return Count;
      end if;
      Tables.Advance (High, Low, Added);
      Count := Count + Added;
      if Low <= High then
         Count := Count + U64 (Sieve.Primes (Low, High).Length);
      end if;
      return Count;
   end Segment_Prime_Count;

   function Prime_Count (N : U64) return U64 is
      function Lmo_Count (Value : U64) return U64;

      function Lmo_Count (Value : U64) return U64 is
         C : constant U32 := 6;
         N2 : constant U64 := Int.Sqrtint (Value);
         N3 : constant U64 := Icbrt (Value);
         M : U64;
         K2, K3, Pi_M, Km : U32;
         Sum1, Sum2 : U64;
         Primes : Prime_Access;
         Factor : U16_Access;
         N_Primes : Natural;
         Smallest : U64;
         Last_Phi : U64;
         Ps_Max, Ps_Start : U32;
         Prev : U8_Array (0 .. Prev_Bytes - 1);
         Sieve_Start, Sieve_End, Least : U64;
         Step7_Max : U32;
         Prime : U32;
         Prime_Index : U32;

         type Sieve_T is record
            Bits : Word_Access;
            Wcount : U8_Access;
            Sums : U32_Access;
            Totals : U64_Access;
            P_Index : U32_Access;
            First_Bit : U32_Access;
            Mult : U8_Access;
            Start : U64 := 0;
            Phi_Total : U64 := 0;
            Size : U32 := 0;
            First_Prime : U32 := 0;
            Last_Prime : U32 := 0;
            Last_Remove : U32 := 0;
         end record;
         S : Sieve_T;

         procedure Clear_Bit (Bit : Natural) is
         begin
            S.Bits (Bit / 64) := S.Bits (Bit / 64)
              and not Interfaces.Shift_Left (U64'(1), Bit mod 64);
         end Clear_Bit;

         procedure Word_Tile (From, To : Natural) is
            Cursor : Natural := From;
            Words : Natural;
         begin
            while Cursor < To loop
               if 2 * Cursor > To then
                  Words := To - Cursor;
               else
                  Words := Cursor;
               end if;
               S.Bits (Cursor .. Cursor + Words - 1) :=
                 S.Bits (0 .. Words - 1);
               Cursor := Cursor + Words;
            end loop;
         end Word_Tile;

         procedure Sieve_Zero (Bit : U32) is
            Index : constant Natural := Natural (Bit / 64);
            Rem : constant Natural := Natural (Bit mod 64);
            Mask : constant U64 := Interfaces.Shift_Left (U64'(1), Rem);
            Was : constant U64 :=
              Interfaces.Shift_Right (S.Bits (Index), Rem) and 1;
         begin
            S.Bits (Index) := S.Bits (Index) and not Mask;
            S.Wcount (Index) := S.Wcount (Index) - U8 (Was);
         end Sieve_Zero;

         function Make_Sums return U32 is
            Words : constant Natural :=
              Natural ((U64 (S.Size) + 127) / 128);
            Running : U32 := 0;
         begin
            S.Sums (0) := 0;
            for I in 0 .. Words - 1 loop
               Running := Running + U32 (S.Wcount (I));
               S.Sums (I + 1) := Running;
            end loop;
            return S.Sums (Words);
         end Make_Sums;

         procedure Remove_Primes (From, Last : U32) is
            Bit_Size : constant U32 := (S.Size + 1) / 2;
            Index : U32 := From;
         begin
            S.Phi_Total := S.Totals (Natural (Last));
            while Index <= Last loop
               if Index >= S.First_Prime and then Index <= S.Last_Prime then
                  Sieve_Zero ((Primes (Natural (Index))
                    - U32 (S.Start mod 2 ** 32) - 1) / 2);
               end if;
               if Index <= S.Last_Remove then
                  declare
                     B : U32 := S.First_Bit (Natural (Index));
                     P : constant U32 := Primes (Natural (Index));
                     Wheel : U8 := S.Mult (Natural (Index));
                  begin
                     if B < Bit_Size then
                        loop
                           case Wheel is
                              when 0 =>
                                 Sieve_Zero (B);
                                 B := B + 3 * P;
                                 Wheel := 1;
                              when 1 =>
                                 Sieve_Zero (B);
                                 B := B + 2 * P;
                                 Wheel := 2;
                              when 2 =>
                                 Sieve_Zero (B);
                                 B := B + P;
                                 Wheel := 3;
                              when 3 =>
                                 Sieve_Zero (B);
                                 B := B + 2 * P;
                                 Wheel := 4;
                              when 4 =>
                                 Sieve_Zero (B);
                                 B := B + P;
                                 Wheel := 5;
                              when 5 =>
                                 Sieve_Zero (B);
                                 B := B + 2 * P;
                                 Wheel := 6;
                              when 6 =>
                                 Sieve_Zero (B);
                                 B := B + 3 * P;
                                 Wheel := 7;
                              when 7 =>
                                 Sieve_Zero (B);
                                 B := B + P;
                                 Wheel := 0;
                           end case;
                           exit when B >= Bit_Size;
                        end loop;
                     end if;
                     S.First_Bit (Natural (Index)) := B - Bit_Size;
                     S.Mult (Natural (Index)) := Wheel;
                  end;
               end if;
               Index := Index + 1;
            end loop;
            S.Totals (Natural (Last)) :=
              S.Totals (Natural (Last)) + U64 (Make_Sums);
         end Remove_Primes;

         function Sieve_Phi (X : U64) return U64 is
            Seg : U64;
            Bits : U32;
            Words : Natural;
            Rem : Natural;
            Partial : U64 := 0;
         begin
            if X < S.Start then
               return S.Phi_Total;
            end if;
            Seg := X - S.Start;
            Bits := U32 ((Seg + 1) / 2);
            Words := Natural (Bits / 64);
            Rem := Natural (Bits mod 64);
            if Rem /= 0 then
               Partial := U64 (Popcount (S.Bits (Words)
                 and not Interfaces.Shift_Left (U64'Last, Rem)));
            end if;
            return S.Phi_Total + U64 (S.Sums (Words)) + Partial;
         end Sieve_Phi;

         procedure Init_Segment
           (Segment_Start : U64; Seg_Size, Start_Prime, Sieve_Last : U32)
         is
            Odds : U32;
            Words : Natural;
            Bit : Natural;
         begin
            S.Start := Segment_Start;
            S.Size := Seg_Size;
            if Segment_Start = 0 then
               S.Last_Prime := 0;
               S.Last_Remove := 0;
            end if;
            S.First_Prime := S.Last_Prime + 1;
            while S.Last_Prime < Sieve_Last loop
               exit when U64 (Primes (Natural (S.Last_Prime + 1)))
                 >= Segment_Start + U64 (Seg_Size);
               S.Last_Prime := S.Last_Prime + 1;
            end loop;
            while S.Last_Remove < Sieve_Last loop
               declare
                  P : constant U64 :=
                    U64 (Primes (Natural (S.Last_Remove + 1)));
               begin
                  exit when P * P >= Segment_Start + U64 (Seg_Size);
                  S.Last_Remove := S.Last_Remove + 1;
                  S.First_Bit (Natural (S.Last_Remove)) :=
                    U32 ((P * P - Segment_Start - 1) / 2);
                  S.Mult (Natural (S.Last_Remove)) :=
                    U8 ((U32 (P mod 30) * 8) / 30);
               end;
            end loop;
            S.Bits (0 .. 2) := (others => U64'Last);
            if Start_Prime >= 3 then
               Bit := 1;
               while Bit < 3 * 64 loop
                  Clear_Bit (Bit);
                  Bit := Bit + 3;
               end loop;
            end if;
            Word_Tile (3, 15);
            if Start_Prime >= 3 then
               Bit := 2;
               while Bit < 15 * 64 loop
                  Clear_Bit (Bit);
                  Bit := Bit + 5;
               end loop;
            end if;
            Word_Tile (15, 105);
            if Start_Prime >= 4 then
               Bit := 3;
               while Bit < 105 * 64 loop
                  Clear_Bit (Bit);
                  Bit := Bit + 7;
               end loop;
            end if;
            Word_Tile (105, 1155);
            if Start_Prime >= 5 then
               Bit := 5;
               while Bit < 1155 * 64 loop
                  Clear_Bit (Bit);
                  Bit := Bit + 11;
               end loop;
            end if;
            Odds := (Seg_Size + 1) / 2;
            Words := Natural ((U64 (Odds) + 63) / 64);
            Word_Tile (1155, Words);
            if Words > 0 and then Odds mod 64 /= 0 then
               S.Bits (Words - 1) := S.Bits (Words - 1) and not
                 Interfaces.Shift_Left (U64'Last, Natural (Odds mod 64));
            end if;
            if Words <= Phi_Words + 1 then
               S.Bits (Words .. Phi_Words + 1) := (others => 0);
               S.Wcount (Words .. Phi_Words + 1) := (others => 0);
            end if;
            if Words > 0 then
               for I in 0 .. Words - 1 loop
                  S.Wcount (I) := U8 (Popcount (S.Bits (I)));
               end loop;
            end if;
            Remove_Primes (6, Start_Prime);
         end Init_Segment;

         procedure Fill_Prev (Start : U32) is
            I : Natural := 2;
            P : U64 := 3;
            J : U64;
            Limit : constant U64 := U64 (Start) + 16 * Prev_Bytes;
         begin
            Prev := (others => 16#FF#);
            while P * P < Limit loop
               if Start = 0 then
                  J := P * P / 2;
               else
                  J := (P - 1) - ((U64 (Start) + (P - 1)) / 2) mod P;
               end if;
               while J < 8 * Prev_Bytes loop
                  declare
                     At : constant Natural := Natural (J / 8);
                     Bit : constant Natural := Natural (J mod 8);
                  begin
                     Prev (At) := Prev (At)
                       and not Interfaces.Shift_Left (U8'(1), Bit);
                  end;
                  J := J + P;
               end loop;
               exit when I >= N_Primes;
               I := I + 1;
               P := U64 (Primes (I));
            end loop;
         end Fill_Prev;

         function Prev_Prime (N : U32) return U32 is
            Arg : U32 := N;
            Bit, Origin : U32;
         begin
            if Arg <= 3 then
               return (if Arg = 3 then 2 else 0);
            end if;
            Arg := Arg - 2;
            Bit := Arg mod (16 * Prev_Bytes);
            Origin := Arg - Bit;
            Bit := Bit / 2;
            loop
               if Origin /= Ps_Start then
                  Fill_Prev (Origin);
                  Ps_Start := Origin;
               end if;
               loop
                  if (Prev (Natural (Bit / 8))
                    and Interfaces.Shift_Left (U8'(1), Natural (Bit mod 8)))
                    /= 0
                  then
                     return Origin + 2 * Bit + 1;
                  end if;
                  exit when Bit = 0;
                  Bit := Bit - 1;
               end loop;
               Origin := Origin - 16 * Prev_Bytes;
               Bit := (16 * Prev_Bytes - 1) / 2;
            end loop;
         end Prev_Prime;

         procedure Add_Phi (Phi : U64; Lpf : U16; Odd_To_Sum2 : Boolean) is
         begin
            if (Lpf and 1) /= 0 then
               if Odd_To_Sum2 then
                  Sum2 := Sum2 + Phi;
               else
                  Sum1 := Sum1 + Phi;
               end if;
            elsif Odd_To_Sum2 then
               Sum1 := Sum1 + Phi;
            else
               Sum2 := Sum2 + Phi;
            end if;
         end Add_Phi;

         procedure Release is
         begin
            Free_Word (S.Bits);
            Free_U8 (S.Wcount);
            Free_U32 (S.Sums);
            Free_U64 (S.Totals);
            Free_U32 (S.P_Index);
            Free_U32 (S.First_Bit);
            Free_U8 (S.Mult);
            Free_U16 (Factor);
            Free_Prime (Primes);
         end Release;

         Listed : Sieve.Prime_Vectors.Vector;
         Table_Limit, Table_Size, Max_Prime_F : U32;
      begin
         if N3 > 500 then
            M := M_Factor (N3);
         else
            M := N3 + N3 / 2;
         end if;
         if M >= N2 then
            M := N2 - 1;
         end if;
         if M < N3 then
            M := N3;
         end if;

         Listed := Sieve.Primes (M + 500);
         N_Primes := Natural (Listed.Length);
         Primes := new Prime_Array (0 .. N_Primes + 3);
         Primes.all := (others => 0);
         declare
            K : Natural := 1;
         begin
            for P of Listed loop
               Primes (K) := U32 (P);
               K := K + 1;
            end loop;
         end;

         Table_Limit := U32 (M) + 338 + 1;
         Table_Size := Table_Limit / 2;
         Max_Prime_F := (Table_Limit - 1) / 3 + 1;
         Factor := new U16_Array (0 .. Natural (Table_Size) - 1);
         Factor (0) := 65_534;
         for I in 1 .. Natural (Table_Size) - 1 loop
            Factor (I) := 65_535;
         end loop;
         for I in 1 .. Natural (Table_Size) - 1 loop
            declare
               P : constant U32 := U32 (I) * 2 + 1;
               Max_F, Fac, Slot : U32;
            begin
               if Factor (I) /= 65_535 then
                  null;
               else
                  if P < 65_535 then
                     Factor (I) := U16 (P);
                  end if;
                  if P < Max_Prime_F then
                     Max_F := (Table_Limit - 1) / P + 1;
                     Fac := 3;
                     while Fac < Max_F loop
                        Slot := (P * Fac) / 2;
                        if Slot < Table_Size then
                           if Factor (Natural (Slot)) = 65_535 then
                              if P < 65_535 then
                                 Factor (Natural (Slot)) := U16 (P);
                              end if;
                           elsif Factor (Natural (Slot)) > 0 then
                              Factor (Natural (Slot)) :=
                                Factor (Natural (Slot)) xor 1;
                           end if;
                        end if;
                        Fac := Fac + 2;
                     end loop;
                     Fac := P;
                     while Fac < Max_F loop
                        Slot := (P * Fac) / 2;
                        if Slot < Table_Size then
                           Factor (Natural (Slot)) := 0;
                        end if;
                        Fac := Fac + 2 * P;
                     end loop;
                  end if;
               end if;
            end;
         end loop;

         declare
            J : U32 := U32 ((M + 1) / 2);
         begin
            while J < Table_Size
              and then Factor (Natural (J)) <= U16 (Primes (Natural (C)))
            loop
               J := J + 1;
            end loop;
            Smallest := 2 * U64 (J) + 1;
         end;
         M := Smallest - 1;
         Pi_M := U32 (Prime_Count (M));
         if Pi_M < C then
            Release;
            return Segment_Prime_Count (Value);
         end if;
         K2 := U32 (Prime_Count (N2));
         K3 := U32 (Prime_Count (N3));
         Km := C;
         while Km < Pi_M
           and then Natural (Km) + 2 <= N_Primes
           and then U64 (Primes (Natural (Km) + 1))
             * U64 (Primes (Natural (Km) + 2)) <= M
         loop
            Km := Km + 1;
         end loop;
         if K3 < Km then
            K3 := Km;
         end if;

         declare
            Sq : constant U64 :=
              U64 (Primes (N_Primes)) * U64 (Primes (N_Primes));
            Limit : constant U64 :=
              Sq - (Sq mod (16 * Prev_Bytes)) - 1;
         begin
            if Limit > 16#FFFF_FFFF# then
               Ps_Max := 16#FFFF_FFFF#;
            else
               Ps_Max := U32 (Limit);
            end if;
         end;
         Ps_Start := 16#FFFF_FFFF#;
         Last_Phi := Value / Smallest + 1;

         S.Bits := new Word_Array (0 .. Phi_Words + 1);
         S.Wcount := new U8_Array (0 .. Phi_Words + 1);
         S.Sums := new U32_Array (0 .. Phi_Words + 1);
         S.Totals := new U64_Array (0 .. Natural (K3) + 1);
         S.P_Index := new U32_Array (0 .. Natural (K3) + 1);
         S.First_Bit := new U32_Array (0 .. Natural (K3) + 1);
         S.Mult := new U8_Array (0 .. Natural (K3) + 1);
         S.Bits.all := (others => 0);
         S.Wcount.all := (others => 0);
         S.Sums.all := (others => 0);
         S.Totals.all := (others => 0);
         S.P_Index.all := (others => 0);
         S.First_Bit.all := (others => 0);
         S.Mult.all := (others => 0);

         Sum1 := (U64 (K2) - 1)
           + U64 (Pi_M - K3 - 1) * U64 (Pi_M - K3) / 2;
         Sum2 := 0;
         declare
            Ends : constant U32 := U32 ((M + 1) / 2);
            K : U32;
            J : U32;
            Lpf : U16;
            Pk : U64;
            Phi : U64;
         begin
            for I in 0 .. Natural (Km) - 1 loop
               S.P_Index (I) := Ends;
            end loop;
            declare
               Last_P : U32 := Pi_M;
               Max_P : U64;
            begin
               K := Km;
               while K < K3 loop
                  Pk := U64 (Primes (Natural (K) + 1));
                  Max_P := Value / (Pk * Pk);
                  while Last_P > K + 1
                    and then U64 (Primes (Natural (Last_P))) > Max_P
                  loop
                     Last_P := Last_P - 1;
                  end loop;
                  S.P_Index (Natural (K)) := Last_P;
                  Sum1 := Sum1 + U64 (Pi_M - Last_P);
                  K := K + 1;
               end loop;
            end;

            for Jx in 0 .. Natural (Ends) - 1 loop
               Lpf := Factor (Jx);
               if Lpf > U16 (Primes (Natural (C))) then
                  Phi := Tiny_Phi (Value / (2 * U64 (Jx) + 1));
                  Add_Phi (Phi, Lpf, True);
               end if;
            end loop;
            if C < Pi_M then
               Pk := U64 (Primes (Natural (C) + 1));
               J := U32 ((1 + M / Pk) / 2);
               while J < Ends loop
                  Lpf := Factor (Natural (J));
                  if U64 (Lpf) > Pk then
                     Phi := Tiny_Phi (Value / (Pk * (2 * U64 (J) + 1)));
                     Add_Phi (Phi, Lpf, False);
                  end if;
                  J := J + 1;
               end loop;
            end if;

            if N2 >= U64 (Ps_Start) then
               Prime := Prev_Prime (Ps_Start);
            else
               Prime := Prev_Prime (U32 (N2 + 1));
            end if;
            Prime_Index := K2 - 1;
            Step7_Max := K3;

            Sieve_Start := 0;
            while Sieve_Start < Last_Phi loop
               declare
                  Span : constant U64 := 2 * 64 * Phi_Words;
               begin
                  if Sieve_Start + Span < Last_Phi then
                     Sieve_End := Sieve_Start + Span;
                  else
                     Sieve_End := Last_Phi;
                  end if;
               end;
               Least := Value / Sieve_End;
               Init_Segment
                 (Sieve_Start, U32 (Sieve_End - Sieve_Start), C, K3);
               K := C + 1;
               while K < Km loop
                  Pk := U64 (Primes (Natural (K) + 1));
                  declare
                     Start_J : U32;
                  begin
                     if Least >= Pk * 16#FFFF_FFFE# then
                        Start_J := 16#FFFF_FFFF#;
                     else
                        Start_J := U32 ((Least / Pk + 1) / 2);
                     end if;
                     Remove_Primes (K, K);
                     J := S.P_Index (Natural (K));
                     if J > 0 then
                        J := J - 1;
                        if J >= Start_J then
                           loop
                              Lpf := Factor (Natural (J));
                              if U64 (Lpf) > Pk then
                                 Phi := Sieve_Phi
                                   (Value / (Pk * (2 * U64 (J) + 1)));
                                 Add_Phi (Phi, Lpf, False);
                              end if;
                              exit when J = Start_J;
                              J := J - 1;
                           end loop;
                        end if;
                        if Start_J < S.P_Index (Natural (K)) then
                           S.P_Index (Natural (K)) := Start_J;
                        end if;
                     end if;
                  end;
                  K := K + 1;
               end loop;
               while K < Step7_Max loop
                  Remove_Primes (K, K);
                  J := S.P_Index (Natural (K));
                  if J >= K + 2 then
                     Pk := U64 (Primes (Natural (K) + 1));
                     declare
                        End_J : U32 := J;
                     begin
                        while End_J > 7
                          and then End_J - 7 >= K + 2
                          and then Pk * U64 (Primes (Natural (End_J - 7)))
                            > Least
                        loop
                           End_J := End_J - 8;
                        end loop;
                        while End_J >= K + 2
                          and then Pk * U64 (Primes (Natural (End_J))) > Least
                        loop
                           End_J := End_J - 1;
                        end loop;
                        while J > End_J loop
                           Sum1 := Sum1 + Sieve_Phi
                             (Value / (Pk * U64 (Primes (Natural (J)))));
                           J := J - 1;
                        end loop;
                        S.P_Index (Natural (K)) := End_J;
                     end;
                  end if;
                  K := K + 1;
               end loop;
               while Step7_Max > Km
                 and then S.P_Index (Natural (Step7_Max - 1))
                   < (Step7_Max - 1) + 2
               loop
                  Step7_Max := Step7_Max - 1;
               end loop;
               Remove_Primes (K, K3);
               while Prime > Least and then Prime_Index >= Pi_M loop
                  Sum1 := Sum1 + U64 (Prime_Index - K3);
                  Sum2 := Sum2 + Sieve_Phi (Value / U64 (Prime));
                  Prime_Index := Prime_Index - 1;
                  Prime := Prev_Prime (Prime);
               end loop;
               Sieve_Start := Sieve_End;
            end loop;
         end;
         Release;
         return Sum1 - Sum2;
      end Lmo_Count;
   begin
      --  lmo.c: small n stays on the table-backed segment sieve.
      if N < Lmo_Crossover or else N < 10_000 then
         return Segment_Prime_Count (N);
      end if;
      return Lmo_Count (N);
   end Prime_Count;
end Math_Prime_Util.Count.Lmo;
