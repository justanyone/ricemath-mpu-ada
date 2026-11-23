with Ada.Containers.Indefinite_Holders;
with Ada.Numerics.Long_Elementary_Functions;
with Interfaces;
with Math_Prime_Util.Int;
with Math_Prime_Util.Count.Tables;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Count.Lmo is
   --  Controlled holders own variable-sized scratch arrays. No package state
   --  and no unchecked deallocation: exceptions also release the storage.
   use Ada.Numerics.Long_Elementary_Functions;
   use type Interfaces.Unsigned_16;
   subtype Factor is Interfaces.Unsigned_16;
   type Words is array (Natural range <>) of U64;
   type Factors is array (Natural range <>) of Factor;
   type Naturals is array (Natural range <>) of Natural;
   package Word_Holders is new Ada.Containers.Indefinite_Holders (Words)
     with SPARK_Mode => Off;
   package Factor_Holders is new Ada.Containers.Indefinite_Holders (Factors)
     with SPARK_Mode => Off;
   C : constant := 6;
   Wheel : constant := 30_030;
   Segment_Words : constant := 1155 * 13;
   Segment_Size : constant := Segment_Words * 128;

   function Make_Phi return Naturals;
   function Make_Phi return Naturals is
      Result : Naturals (0 .. Wheel) := [others => 0];
   begin
      for I in 1 .. Wheel loop
         Result (I) := Result (I - 1);
         if I mod 2 /= 0 and then I mod 3 /= 0 and then I mod 5 /= 0
           and then I mod 7 /= 0 and then I mod 11 /= 0 and then I mod 13 /= 0
         then
            Result (I) := Result (I) + 1;
         end if;
      end loop;
      return Result;
   end Make_Phi;
   Phi_Table : constant Naturals := Make_Phi;

   function Tiny_Phi (X : U64) return U64 is
     (X / Wheel * U64 (Phi_Table (Wheel)) +
      U64 (Phi_Table (Natural (X mod Wheel))));

   function Bit_Count (Value : U64) return U64;
   function Bit_Count (Value : U64) return U64 is
      B : U64 := Value;
   begin
      B := B - (Interfaces.Shift_Right (B, 1) and 16#5555_5555_5555_5555#);
      B := (B and 16#3333_3333_3333_3333#) +
        (Interfaces.Shift_Right (B, 2) and 16#3333_3333_3333_3333#);
      B := (B + Interfaces.Shift_Right (B, 4)) and 16#0F0F_0F0F_0F0F_0F0F#;
      return Interfaces.Shift_Right (B * 16#0101_0101_0101_0101#, 56);
   end Bit_Count;

   --  The sieve's primality walk has a checked interface for the kernel.
   function Previous (X : U64) return U64
     with Pre => X > 3, Post => Previous'Result < X;
   function Previous (X : U64) return U64
     with SPARK_Mode => Off
   is
   begin
      return Sieve.Prev_Prime (X).Value;
   end Previous;

   --  lmo.c: LMO_prime_count, Bau steps 4 through 9. The caller owns all
   --  variable-sized storage; the arithmetic kernel stays in SPARK.
   function Compute
     (N, N2, Initial_M : U64; K2, Initial_K3 : Natural;
      Ft : in out Factors; Ps : in out Words) return U64
     with Pre => N >= 66_000_000 and then N2 = Int.Sqrtint (N)
       and then Initial_M >= 1 and then K2 > 0
       and then Ft'First = 0 and then Ps'First = 0
       and then Ft'Last >= 1 and then Ps'Last > Ft'Last,
          Post => Compute'Result <= N;
   function Compute
     (N, N2, Initial_M : U64; K2, Initial_K3 : Natural;
      Ft : in out Factors; Ps : in out Words) return U64
   is
      M : U64 := Initial_M;
      Bound : constant Natural := Ft'Last * 2;
      Last : Natural := 1;
      K3 : Natural := Initial_K3;
      Pi_M, Km, Last_Prime, Prime_Index, Step7_Max : Natural;
      Prime : U64;
      Sum1, Sum2 : U64 := 0;
      Last_Phi : U64;
      Start, Finish, Least : U64 := 0;
      End_Factor : Natural;
   begin
      --  lmo.c: ft_create. Odd entries encode least factor and mu sign.
      Ft (0) := 65534;
      Ps (1) := 2;
      for I in 1 .. Ft'Last loop
         if Ft (I) = 65535 then
            declare
               P : constant Natural := 2 * I + 1;
               J : Natural := 3 * P;
            begin
               Last := Last + 1;
               Ps (Last) := U64 (P);
               if P < 65535 then
                  Ft (I) := Factor (P);
               end if;
               while J <= Bound loop
                  if Ft (J / 2) = 65535 then
                     Ft (J / 2) := Factor (P);
                  elsif Ft (J / 2) /= 0 then
                     Ft (J / 2) := Ft (J / 2) xor 1;
                  end if;
                  J := J + 2 * P;
               end loop;
               if P <= Bound / P then
                  J := P * P;
                  while J <= Bound loop
                     Ft (J / 2) := 0;
                     J := J + 2 * P * P;
                  end loop;
               end if;
            end;
         end if;
      end loop;
      End_Factor := Natural ((M + 1) / 2);
      while Ft (End_Factor) <= 13 loop
         End_Factor := End_Factor + 1;
      end loop;
      M := U64 (2 * End_Factor);
      Pi_M := 0;
      while Ps (Pi_M + 1) <= M loop
         Pi_M := Pi_M + 1;
      end loop;
      Last_Phi := N / (M + 1) + 1;
      Km := C;
      while Km < Pi_M and then Ps (Km + 1) * Ps (Km + 2) <= M loop
         Km := Km + 1;
      end loop;
      K3 := Natural'Max (K3, Km);
      Sum1 := U64 (K2 - 1) +
        U64 (Pi_M - K3 - 1) * U64 (Pi_M - K3) / 2;
      Prime := Previous (N2 + 1);
      Prime_Index := K2 - 1;
      Step7_Max := K3;
      --  Bau steps 4 and 5: ordinary leaves and the first special leaves.
      for J in 0 .. End_Factor - 1 loop
         if Ft (J) > 13 then
            if (Ft (J) and 1) /= 0 then
               Sum2 := Sum2 + Tiny_Phi (N / U64 (2 * J + 1));
            else
               Sum1 := Sum1 + Tiny_Phi (N / U64 (2 * J + 1));
            end if;
         end if;
      end loop;
      for J in Natural ((1 + M / Ps (C + 1)) / 2) .. End_Factor - 1 loop
         if U64 (Ft (J)) > Ps (C + 1) then
            if (Ft (J) and 1) /= 0 then
               Sum1 := Sum1 + Tiny_Phi (N / (Ps (C + 1) * U64 (2 * J + 1)));
            else
               Sum2 := Sum2 + Tiny_Phi (N / (Ps (C + 1) * U64 (2 * J + 1)));
            end if;
         end if;
      end loop;
      declare
         Totals : Words (0 .. K3 + 1) := [others => 0];
         Indices : Naturals (0 .. K3 + 1) := [others => End_Factor];
         Bits : Words (0 .. Segment_Words) := [others => 0];
         Counts : Naturals (0 .. Segment_Words + 1) := [others => 0];
         Word_Counts : Naturals (0 .. Segment_Words) := [others => 0];
         Phi_Total : U64 := 0;
         Size : Natural;

         procedure Clear (B : Natural);
         procedure Clear (B : Natural) is
            W : constant Natural := B / 64;
            Mask : constant U64 := Interfaces.Shift_Left (U64'(1), B mod 64);
         begin
            if (Bits (W) and Mask) /= 0 then
               Bits (W) := Bits (W) and not Mask;
               Word_Counts (W) := Word_Counts (W) - 1;
            end if;
         end Clear;

         procedure Remove (First, Last : Natural);
         procedure Remove (First, Last : Natural) is
            P, V : U64;
         begin
            Phi_Total := Totals (Last);
            for K in First .. Last loop
               P := Ps (K);
               V := Start / P * P;
               if V < Start then
                  V := V + P;
               end if;
               if V mod 2 = 0 then
                  V := V + P;
               end if;
               while V < Finish loop
                  Clear (Natural ((V - Start) / 2));
                  V := V + 2 * P;
               end loop;
            end loop;
            Counts (0) := 0;
            for W in 0 .. (Size + 63) / 64 - 1 loop
               Counts (W + 1) := Counts (W) + Word_Counts (W);
            end loop;
            Totals (Last) := Totals (Last) +
              U64 (Counts ((Size + 63) / 64));
         end Remove;

         function Sieve_Phi (X : U64) return U64;
         function Sieve_Phi (X : U64) return U64 is
            B : constant Natural := Natural ((X - Start + 1) / 2);
            Mask : constant U64 :=
              Interfaces.Shift_Left (U64'(1), B mod 64) - 1;
         begin
            return Phi_Total + U64 (Counts (B / 64)) +
              Bit_Count (Bits (B / 64) and Mask);
         end Sieve_Phi;
      begin
         Last_Prime := Pi_M;
         for K in Km .. K3 - 1 loop
            while Last_Prime > K + 1 and then
              Ps (Last_Prime) > N / (Ps (K + 1) * Ps (K + 1))
            loop
               Last_Prime := Last_Prime - 1;
            end loop;
            Indices (K) := Last_Prime;
            Sum1 := Sum1 + U64 (Pi_M - Last_Prime);
         end loop;
         while Start < Last_Phi loop
            Finish := U64'Min (Start + Segment_Size, Last_Phi);
            Least := N / Finish;
            Size := Natural ((Finish - Start + 1) / 2);
            Bits := [others => 0];
            Word_Counts := [others => 0];
            --  The period divides the full segment length (3*5*7*11).
            for B in 0 .. Size - 1 loop
               declare
                  V : constant U64 := Start + U64 (2 * B + 1);
               begin
                  if V mod 3 /= 0 and then V mod 5 /= 0 and then V mod 7 /= 0
                    and then V mod 11 /= 0 and then V mod 13 /= 0
                  then
                     Bits (B / 64) := Bits (B / 64) or
                       Interfaces.Shift_Left (U64'(1), B mod 64);
                     Word_Counts (B / 64) := Word_Counts (B / 64) + 1;
                  end if;
               end;
            end loop;
            Remove (C + 1, C);
            for K in C + 1 .. Km - 1 loop
               Remove (K, K);
               declare
                  P : constant U64 := Ps (K + 1);
                  First : constant Natural := Natural'Min
                    (End_Factor, Natural (U64'Min
                      (U64 (End_Factor), (Least / P + 1) / 2)));
               begin
                  for J in reverse First .. Indices (K) - 1 loop
                     if U64 (Ft (J)) > P then
                        if (Ft (J) and 1) /= 0 then
                           Sum1 :=
                             Sum1 + Sieve_Phi (N / (P * U64 (2 * J + 1)));
                        else
                           Sum2 :=
                             Sum2 + Sieve_Phi (N / (P * U64 (2 * J + 1)));
                        end if;
                     end if;
                  end loop;
                  Indices (K) := Natural'Min (First, Indices (K));
               end;
            end loop;
            for K in Km .. Step7_Max - 1 loop
               Remove (K, K);
               while Indices (K) >= K + 2 and then
                 Ps (K + 1) * Ps (Indices (K)) > Least
               loop
                  Sum1 := Sum1 + Sieve_Phi
                    (N / (Ps (K + 1) * Ps (Indices (K))));
                  Indices (K) := Indices (K) - 1;
               end loop;
            end loop;
            while Step7_Max > Km and then
              Indices (Step7_Max - 1) < Step7_Max + 1
            loop
               Step7_Max := Step7_Max - 1;
            end loop;
            Remove (Step7_Max, K3);
            while Prime > Least and then Prime_Index >= Pi_M loop
               Sum1 := Sum1 + U64 (Prime_Index - K3);
               Sum2 := Sum2 + Sieve_Phi (N / Prime);
               Prime_Index := Prime_Index - 1;
               Prime := Previous (Prime);
            end loop;
            Start := Finish;
         end loop;
      end;
      return Sum1 - Sum2;
   end Compute;

   function Count (N : U64) return U64
     with SPARK_Mode => Off
   is
      N2 : constant U64 := Int.Sqrtint (N);
      N3 : constant U64 := Int.Rootint (N, 3);
      M : U64;
   begin
      if N < 66_000_000 then
         declare
            Anchor, Value : U64;
         begin
            Tables.Lookup (N, Anchor, Value);
            return Value + U64 (Sieve.Primes (Anchor + 1, N).Length);
         end;
      end if;
      M := (if N3 > 500 then
              U64 (Long_Float (N3) * (Log (Long_Float (N3)) / Log (5.2)) *
                (Log (Log (Long_Float (N3))) - 1.4))
            else N3 + N3 / 2);
      M := U64'Max (N3, U64'Min (M, N2 - 1));
      declare
         Bound : constant Natural := Natural (M) + 839;
         Fh : Factor_Holders.Holder := Factor_Holders.To_Holder
           (Factors'(0 .. Bound / 2 => 65535));
         Ph : Word_Holders.Holder := Word_Holders.To_Holder
           (Words'(0 .. Bound / 2 + 1 => 0));
         Fr : constant Factor_Holders.Reference_Type := Fh.Reference;
         Pr : constant Word_Holders.Reference_Type := Ph.Reference;
         Ft : Factors renames Fr.Element.all;
         Ps : Words renames Pr.Element.all;
      begin
         return Compute (N, N2, M, Natural (Count (N2)),
           Natural (Count (N3)), Ft, Ps);
      end;
   end Count;

end Math_Prime_Util.Count.Lmo;
