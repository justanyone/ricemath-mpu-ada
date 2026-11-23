with Ada.Numerics.Long_Elementary_Functions;
with Interfaces;
with Math_Prime_Util.Sieve;
with Math_Prime_Util.Count;

package body Math_Prime_Util.Families is
   use Ada.Numerics.Long_Elementary_Functions;
   use Lucky_Vectors;
   subtype F64 is Long_Float;
   Max_Lucky : constant U64 := 18_446_744_073_709_551_517;
   Small : constant array (Natural range 0 .. 47) of U64 :=
     [1, 3, 7, 9, 13, 15, 21, 25, 31, 33, 37, 43, 49, 51, 63, 67,
      69, 73, 75, 79, 87, 93, 99, 105, 111, 115, 127, 129, 133, 135,
      141, 151, 159, 163, 169, 171, 189, 193, 195, 201, 205, 211,
      219, 223, 231, 235, 237, 241];
   Mask : constant array (Natural range 0 .. 64) of Boolean :=
     [True, True, False, True, True, False, True, True, False,
      True, True, False, True, True, False, True, True, False,
      False, False, False, True, True, False, True, True, False,
      False, False, False, True, True, False, True, True, False,
      True, True, False, False, False, False, True, True, False,
      True, True, False, True, True, False, True, True, False,
      True, True, False, False, False, False, False, False, False,
      True, True];

   function Trunc (X : F64) return U64;
   function Trunc (X : F64) return U64 is
     (U64 (F64'Floor (X)));

   function Small_Count (N : U64) return U64;
   function Small_Count (N : U64) return U64 is
      C : U64 := 0;
   begin
      for V of Small loop
         exit when V > N;
         C := C + 1;
      end loop;
      return C;
   end Small_Count;

   --  _small_lucky_sieve32: prefilter through 13, then compact deletions.
   function Small_Sieve (N : U64) return Vector;
   function Small_Sieve (N : U64) return Vector is
      V : Vector;
      I : U64 := 1;
      C13 : Natural := 0;
      Level : Natural := 5;
      Size, Skip, Dest, Source, Count : Natural;
   begin
      if N < 259 then
         for X of Small loop
            exit when X > N;
            V.Append (X);
         end loop;
         return V;
      end if;
      while I <= N loop
         if I mod 6 /= 5 and then Mask (Natural (I mod 63)) then
            C13 := C13 + 1;
            if C13 = 13 then
               C13 := 0;
            else
               V.Append (I);
            end if;
         end if;
         exit when N - I < 2;
         I := I + 2;
      end loop;
      Size := Natural (V.Length);
      while Level < Size and then V.Element (Level) - 1 < U64 (Size)
      loop
         Skip := Natural (V.Element (Level)) - 1;
         exit when 2 * (Skip + 1) > Size;
         Dest := Skip;
         Source := Skip + 1;
         while Source < Size loop
            Count := Natural'Min (Skip, Size - Source);
            for J in 0 .. Count - 1 loop
               V.Replace_Element (Dest + J, V.Element (Source + J));
            end loop;
            Dest := Dest + Count;
            Source := Source + Skip + 1;
         end loop;
         Size := Dest;
         Level := Level + 1;
      end loop;
      if Level < Size and then V.Element (Level) - 1 < U64 (Size) then
         Skip := Natural (V.Element (Level));
         Dest := Skip - 1;
         while Skip < Size loop
            Count := Natural'Min
              (Natural (V.Element (Level + 1) - V.Element (Level)),
               Size - Skip);
            for J in 0 .. Count - 1 loop
               V.Replace_Element (Dest + J, V.Element (Skip + J));
            end loop;
            Dest := Dest + Count;
            Skip := Skip + Count + 1;
            Level := Level + 1;
         end loop;
         Size := Dest;
      end if;
      V.Set_Length (Ada.Containers.Count_Type (Size));
      return V;
   end Small_Sieve;

   --  _bitmask126_sieve and ds_bitmask126.h: 32 bits per 126 integers.
   --  Count levels group 8 words, then 16 blocks, then groups of 8.
   function Bitmask_Sieve (N : U64) return Vector;
   function Bitmask_Sieve (N : U64) return Vector is
      use type Interfaces.Unsigned_32;
      subtype Word is Interfaces.Unsigned_32;
      package Word_Vectors is new Ada.Containers.Vectors
        (Index_Type => Natural, Element_Type => Word);
      Data : Word_Vectors.Vector;
      Tree : array (Natural range 0 .. 14) of Vector;
      Offset : constant array (Natural range 0 .. 31) of U64 :=
        [1, 3, 7, 9, 13, 15, 21, 25, 31, 33, 37, 43, 45, 49, 51, 55,
         63, 67, 69, 73, 75, 79, 85, 87, 93, 97, 99, 105, 109, 111,
         115, 117];
      Mask5 : constant array (Natural range 0 .. 25) of Word :=
        [2334495963, 2261929142, 1169344621, 2204739155, 2727961910,
         1639207725, 3513561243, 2430232978, 1754683725, 3630970059,
         3025873062, 1278646881, 3658323539, 3055177010, 1830209833,
         3406669457, 3054200212, 1837519692, 1531293898, 650340770,
         757258597, 2606838995, 2530306226, 1169218145, 3408442969,
         11572];
      Counts : array (Small'Range) of Natural := [others => 0];
      Words : constant Natural :=
        Natural (N / 126 + (if N mod 126 /= 0 then 1 else 0));
      Top : Natural := 2;
      Size : U64 := 0;
      I : U64 := 1;
      M : Natural := 0;
      Last : Natural := 5;
      Level, Skip, Index : U64;
      W, Bit, K, Width : Natural;
      Keep : Boolean;
      Result : Vector;

      function Fanout (L : Natural) return Natural;
      function Fanout (L : Natural) return Natural is
        (if L = 2 then 16 else 8);

      procedure Update (Wi : Natural; Adding : Boolean);
      procedure Update (Wi : Natural; Adding : Boolean) is
         J : Natural := Wi;
         Value : U64;
      begin
         for L in 0 .. Top loop
            Value := Tree (L).Element (J);
            Tree (L).Replace_Element
              (J, (if Adding then Value + 1 else Value - 1));
            J := J / Fanout (L + 1);
         end loop;
         Size := (if Adding then Size + 1 else Size - 1);
      end Update;

      procedure Find (Rank : U64; Wi, Bi : out Natural);
      procedure Find (Rank : U64; Wi, Bi : out Natural) is
         R : U64 := Rank;
         J : Natural := 0;
      begin
         for L in reverse 0 .. Top loop
            while R >= Tree (L).Element (J) loop
               R := R - Tree (L).Element (J);
               J := J + 1;
            end loop;
            if L > 0 then
               J := J * Fanout (L);
            end if;
         end loop;
         Wi := J;
         Bi := 0;
         loop
            if (Data.Element (Wi) and Interfaces.Shift_Left (1, Bi)) /= 0
            then
               exit when R = 0;
               R := R - 1;
            end if;
            Bi := Bi + 1;
         end loop;
      end Find;
   begin
      Data.Append (0, Ada.Containers.Count_Type (Words));
      Tree (0).Append (0, Ada.Containers.Count_Type (Words));
      Width := Words;
      for L in 1 .. 14 loop
         Width := (Width + Fanout (L) - 1) / Fanout (L);
         Tree (L).Append (0, Ada.Containers.Count_Type (Width));
         if L >= 2 and then (Width + 7) / 8 < 3 then
            Top := L;
            exit;
         end if;
      end loop;
      while Small (Last) <
        (if N <= 200_000_000 then 21 elsif N <= 2 ** 32 - 1 then 25 else 87)
      loop
         Last := Last + 1;
      end loop;
      while I <= N loop
         if (Mask5 (M / 32) and
             Interfaces.Shift_Left (1, M mod 32)) /= 0
         then
            Keep := True;
            for L in 5 .. Last loop
               Counts (L) := Counts (L) + 1;
               if Counts (L) = Natural (Small (L)) then
                  Counts (L) := 0;
                  Keep := False;
                  exit;
               end if;
            end loop;
            if Keep then
               W := Natural (I / 126);
               K := Natural (I mod 126);
               Bit := 0;
               while Offset (Bit) /= U64 (K) loop
                  Bit := Bit + 1;
               end loop;
               Data.Replace_Element
                 (W, Data.Element (W) or Interfaces.Shift_Left (1, Bit));
               Update (W, True);
            end if;
         end if;
         exit when N - I < 2;
         I := I + 2;
         M := (M + 1) mod 819;
      end loop;
      Level := U64 (Last + 1);
      while Level < Size loop
         Find (Level, W, Bit);
         Skip := U64 (W) * 126 + Offset (Bit) - 1;
         exit when Skip >= Size;
         Index := Skip;
         while Index < Size loop
            Find (Index, W, Bit);
            Data.Replace_Element
              (W, Data.Element (W) and not Interfaces.Shift_Left (1, Bit));
            Update (W, False);
            Index := Index + Skip;
         end loop;
         Level := Level + 1;
      end loop;
      Result.Reserve_Capacity (Ada.Containers.Count_Type (Size));
      for J in Data.First_Index .. Data.Last_Index loop
         for B in 0 .. 31 loop
            if (Data.Element (J) and Interfaces.Shift_Left (1, B)) /= 0
            then
               Result.Append (U64 (J) * 126 + Offset (B));
            end if;
         end loop;
      end loop;
      return Result;
   end Bitmask_Sieve;

   function Sieve (N : U64) return Vector;
   function Sieve (N : U64) return Vector is
     (if N <= 240_000 then Small_Sieve (N) else Bitmask_Sieve (N));

   function Lucky_Numbers (Low, High : U64) return Vector is
      V : Vector;
   begin
      if Low > High then
         return V;
      end if;
      declare
         All_Values : constant Vector := Sieve (High);
      begin
         for J in All_Values.First_Index .. All_Values.Last_Index loop
            if All_Values.Element (J) >= Low then
               V.Append (All_Values.Element (J));
            end if;
         end loop;
      end;
      return V;
   end Lucky_Numbers;

   function Lucky_Numbers (High : U64) return Vector is
     (Lucky_Numbers (0, High));

   function Nth_Lucky_Approx (N : U64) return Int.Optional_U64 is
      Fn, Ln, Ll, L2, Corr, Est : F64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 48 then
         return (True, Small (Natural (N - 1)));
      end if;
      Fn := F64 (N);
      Ln := Log (Fn);
      Ll := Log (Ln);
      L2 := Ll * Ll;
      if N <= 65_536 then
         if N >= 16_384 then
            Corr := 0.25427076035 + 0.00883698771 * (L2 - 5.16445809103);
         elsif N >= 2_048 then
            Corr := 0.24513311782 + 0.00880360023 * (L2 - 4.12651426090);
         elsif N >= 256 then
            Corr := 0.25585213066 - 0.00898952075 * (L2 - 2.93412446098);
         else
            Corr := 0.38691439589 - 0.12050840608 * (L2 - 1.84654667704);
         end if;
         Est := Fn * (Ln + 0.5 * Ll + Corr * L2) + 0.5;
      else
         if N >= 1_099_511_627_776 then
            Corr := -0.05012215934 - 0.00139445216 * (L2 - 11.03811938314);
         elsif N >= 68_719_476_736 then
            Corr := -0.04904974983 - 0.00155649126 * (L2 - 10.34912771904);
         elsif N >= 4_294_967_296 then
            Corr := -0.04770894029 - 0.00180229750 * (L2 - 9.60518309351);
         elsif N >= 67_108_864 then
            Corr := -0.04484819198 - 0.00229977135 * (L2 - 8.36125581665);
         elsif N >= 1_048_576 then
            Corr := -0.03971615189 - 0.00354309756 * (L2 - 6.91279440604);
         else
            Corr := -0.03240114452 - 0.00651036735 * (L2 - 5.78920076332);
         end if;
         Est := Fn * (Ln + (0.5 + Corr) * L2) + 0.5;
      end if;
      return (True, (if Est >= F64 (Max_Lucky) then Max_Lucky
                     else Trunc (Est)));
   end Nth_Lucky_Approx;

   function Nth_Lucky_Upper (N : U64) return Int.Optional_U64 is
      Est : F64;
      Corr : constant F64 :=
        (if N <= 1_000 then 1.01 elsif N <= 8_200 then 1.005 else 1.001);
   begin
      if N <= 48 then
         return Nth_Lucky_Approx (N);
      end if;
      Est := Corr * F64 (Nth_Lucky_Approx (N).Value) + 0.5;
      return (True, (if Est >= F64 (Max_Lucky) then Max_Lucky
                     else Trunc (Est)));
   end Nth_Lucky_Upper;

   function Nth_Lucky_Lower (N : U64) return Int.Optional_U64 is
      Corr : constant F64 :=
        (if N <= 122 then 0.95 elsif N <= 4_096 then 0.97
         elsif N <= 115_000 then 0.998 else 0.999);
   begin
      if N <= 48 then
         return Nth_Lucky_Approx (N);
      end if;
      return (True, Trunc (Corr * F64 (Nth_Lucky_Approx (N).Value)));
   end Nth_Lucky_Lower;

   function Simple_Approx (N : U64) return U64;
   function Simple_Approx (N : U64) return U64 is
      X : constant F64 := F64 (N);
      L : constant F64 := Log (X);
      C : F64;
   begin
      if N <= 10_000 then
         C := 1.03591;
      elsif N <= 1_000_000 then
         C := 0.99575;
      elsif N <= 10_000_000 then
         C := 1.03523 - L / 305.0;
      elsif N <= 100_000_000 then
         C := 1.03432 - L / 304.0;
      elsif N <= 4_000_000_000 then
         C := 1.03613 - L / (100.0 * Log (L));
      else
         C := 1.03654 - L / (100.0 * Log (L));
      end if;
      return Trunc (C * X / L);
   end Simple_Approx;

   function Simple_Upper (N : U64) return U64;
   function Simple_Upper (N : U64) return U64 is
      X : constant F64 := F64 (N);
      L : constant F64 := Log (X);
      A : F64;
   begin
      if N <= 7_000 then
         return Trunc (5.0 + 1.039 * X / L);
      end if;
      A := (if N < 10_017_000 then
              0.58003 - 3.00E-9 * (X - 7_000.0) else 0.55);
      return Trunc (X / (1.065 * L - A - 3.1 / L - 2.85 / (L * L)));
   end Simple_Upper;

   function Simple_Lower (N : U64) return U64;
   function Simple_Lower (N : U64) return U64 is
   begin
      if N <= 9_000 then
         return Trunc (1.028 * F64 (N) / Log (F64 (N)) - 1.0);
      end if;
      return Trunc (0.99 * F64 (Simple_Approx (N)));
   end Simple_Lower;

   type Estimate_Kind is (Approx, Lower, Upper);
   function Estimate (N : U64; Kind : Estimate_Kind) return U64;
   function Estimate (N : U64; Kind : Estimate_Kind) return U64 is
     (case Kind is
         when Approx => Nth_Lucky_Approx (N).Value,
         when Lower => Nth_Lucky_Lower (N).Value,
         when Upper => Nth_Lucky_Upper (N).Value);

   --  inverse_interpolate.c: inverse_interpolate, zero threshold.
   function Invert (Low, High, N : U64; Kind : Estimate_Kind) return U64;
   function Invert (Low, High, N : U64; Kind : Estimate_Kind) return U64 is
      Lo : U64 := Low;
      Hi : U64 := High;
      Mid, Rlo, Rhi, Rmid : U64;
      Iteration : Natural := 0;

      function Linear return U64;
      function Linear return U64 is
         Move : U64;
         D : F64;
      begin
         if N = Rlo then
            return Lo + 1;
         elsif N = Rhi then
            return Hi - 1;
         end if;
         D := F64 (N - Rlo) * F64 (Hi - Lo) / F64 (Rhi - Rlo) + 0.5;
         Move := (if D >= F64 (Hi - Lo) then Hi - Lo else Trunc (D));
         return (if Move = 0 then Lo + 1
                 elsif Move >= Hi - Lo then Hi - 1 else Lo + Move);
      end Linear;
   begin
      Mid := Lo + (Hi - Lo) / 2;
      Rmid := Estimate (Mid, Kind);
      if Rmid >= N then
         Hi := Mid;
         Rhi := Rmid;
         Rlo := Estimate (Lo, Kind);
         if Rlo = N then
            return Lo;
         end if;
      else
         Lo := Mid;
         Rlo := Rmid;
         Rhi := Estimate (Hi, Kind);
      end if;
      if Hi - Lo <= 1 then
         return (if Rlo = N or else (Rlo < N and then Rhi > N)
                 then Lo else Hi);
      end if;
      Mid := Linear;
      while Hi - Lo > 1 and then Rhi > N loop
         Iteration := Iteration + 1;
         Rmid := Estimate (Mid, Kind);
         if Rmid >= N then
            Hi := Mid;
            Rhi := Rmid;
         else
            Lo := Mid;
            Rlo := Rmid;
         end if;
         exit when Rhi = N or else Hi - Lo <= 1;
         Mid := Linear;
         if Iteration mod 6 = 0 then
            declare
               Close : constant U64 :=
                 Trunc (0.003 * F64 (Hi - Lo) + 1.0);
            begin
               if Lo + Close > Mid then
                  Mid := Lo + Close;
               elsif Hi - Close < Mid then
                  Mid := Hi - Close;
               end if;
            end;
         end if;
         Mid := U64'Max (Lo + 1, U64'Min (Hi - 1, Mid));
      end loop;
      if Rlo = N then
         return Lo;
      elsif Hi - Lo <= 1 then
         return (if Rlo < N and then Rhi > N then Lo else Hi);
      end if;
      --  Ridder refinement, followed by the reference binary finish.
      while Hi - Lo > 8 loop
         declare
            X1 : U64 := Lo + (Hi - Lo) / 2;
            R1 : U64 := Estimate (X1, Kind);
            D0 : constant F64 := F64 (N - Rlo);
            D1 : constant F64 :=
              F64 ((if R1 >= N then R1 - N else N - R1));
            D2 : constant F64 := F64 (Rhi - N + 1);
            Sign : constant F64 := (if R1 >= N then 1.0 else -1.0);
            Pos : constant F64 := Sign * F64 (X1 - Lo) * D1 /
              Sqrt (D1 * D1 + D0 * D2);
            Move : constant U64 := Trunc (abs Pos + 0.5);
            X3 : U64 := (if Pos >= 0.0 then X1 - Move else X1 + Move);
            R3, Temp : U64;
         begin
            if X3 >= Hi or else X3 <= Lo or else X3 = X1 then
               if R1 >= N then
                  Hi := X1;
                  Rhi := R1;
               else
                  Lo := X1;
                  Rlo := R1;
               end if;
            else
               R3 := Estimate (X3, Kind);
               if R1 > R3 then
                  Temp := X1;
                  X1 := X3;
                  X3 := Temp;
                  Temp := R1;
                  R1 := R3;
                  R3 := Temp;
               end if;
               if R1 >= N then
                  Hi := X1;
                  Rhi := R1;
               elsif R3 >= N then
                  Lo := X1;
                  Rlo := R1;
                  Hi := X3;
                  Rhi := R3;
               else
                  Lo := X3;
                  Rlo := R3;
               end if;
            end if;
         end;
      end loop;
      while Hi - Lo > 1 loop
         Mid := Lo + (Hi - Lo) / 2;
         if Estimate (Mid, Kind) < N then
            Lo := Mid;
         else
            Hi := Mid;
         end if;
      end loop;
      return Hi;
   end Invert;

   function Lucky_Count_Approx (N : U64) return U64 is
   begin
      if N < 48 then
         return Small_Count (N);
      end if;
      return Invert (Simple_Lower (N), Simple_Upper (N), N, Approx);
   end Lucky_Count_Approx;

   function Lucky_Count_Lower (N : U64) return U64 is
   begin
      if N < 48 then
         return Small_Count (N);
      elsif N < 9_000 then
         return Simple_Lower (N);
      end if;
      return Invert (Simple_Lower (N), Simple_Upper (N), N, Upper);
   end Lucky_Count_Lower;

   function Lucky_Count_Upper (N : U64) return U64 is
   begin
      if N < 48 then
         return Small_Count (N);
      elsif N < 40_000_000 or else N > 18_428_297_000_000_000_000 then
         return Simple_Upper (N);
      end if;
      return Invert
        (Simple_Lower (N), 1 + Trunc (F64 (Simple_Upper (N)) * 1.001),
         N, Lower);
   end Lucky_Count_Upper;

   function Lucky_Count (N : U64) return U64 is
     (Lucky_Count (0, N));

   function Lucky_Count (Low, High : U64) return U64 is
      Hi : U64 := High;
      Lo : U64 := Low;
      Hi_Count, Lo_Count : U64;
   begin
      if Hi < Lo then
         return 0;
      elsif Hi < 48 then
         return Small_Count (Hi) -
           (if Lo = 0 then 0 else Small_Count (Lo - 1));
      end if;
      Lo := Lo - Lo mod 2;
      if Hi = U64'Last then
         Hi := Hi - 1;
      end if;
      Hi := Hi + Hi mod 2;
      Hi_Count := Hi / 2;
      Lo_Count := Lo / 2;
      declare
         V : constant Vector := Sieve (1 + Lucky_Count_Upper (Hi));
      begin
         for J in 1 .. V.Last_Index loop
            if V.Element (J) <= Lo then
               Lo_Count := Lo_Count - Lo_Count / V.Element (J);
            end if;
            exit when V.Element (J) > Hi_Count;
            Hi_Count := Hi_Count - Hi_Count / V.Element (J);
         end loop;
      end;
      return Hi_Count - Lo_Count;
   end Lucky_Count;

   function Nth_Lucky (N : U64) return Int.Optional_U64 is
      K : U64;
   begin
      if N <= 48 then
         return Nth_Lucky_Approx (N);
      end if;
      declare
         V : constant Vector := Sieve (N);
      begin
         K := N - 1;
         for J in reverse 1 .. V.Last_Index loop
            K := K + K / (V.Element (J) - 1);
         end loop;
      end;
      return (True, 2 * K + 1);
   end Nth_Lucky;

   function Is_Lucky (N : U64) return Boolean is
      Pos : U64 := N / 2 + 1;
      Start : Natural := 48;
      Limit : U64 := 600;
      Factor : U64 := 6;
      Max_Limit : U64;
   begin
      if N mod 2 = 0 or else N mod 6 = 5
        or else not Mask (Natural (N mod 63)) or else N > Max_Lucky
      then
         return False;
      elsif N < 45 then
         return True;
      end if;
      for J in 1 .. Small'Last loop
         if Pos < Small (J) then
            return True;
         elsif Pos mod Small (J) = 0 then
            return False;
         end if;
         Pos := Pos - Pos / Small (J);
      end loop;
      Max_Limit := 1 + Lucky_Count_Upper (N);
      loop
         declare
            V : constant Vector := Sieve
              ((if Limit < Max_Limit / 3 then Limit else Max_Limit));
         begin
            for J in Start .. V.Last_Index loop
               if Pos < V.Element (J) then
                  return True;
               elsif Pos mod V.Element (J) = 0 then
                  return False;
               end if;
               Pos := Pos - Pos / V.Element (J);
            end loop;
            Start := Natural (V.Length);
         end;
         if Limit >= Max_Limit / 3 then
            return True;
         end if;
         Limit := Limit * Factor;
         Factor := Factor + 1;
      end loop;
   end Is_Lucky;
   Max_Almost_Count : constant array (Natural range 0 .. 63) of U64 :=
     [
      1, 425656284035217743, 1701748900850019777, 3167597434038354478,
      3787884015050788482, 3378907169603895030, 2466706950238087748, 1571012171387856192,
      913164427599983727, 499840874923678341, 263157990621533964, 135128109904869290,
      68283616225825256, 34151861008771016, 16967424859951587, 8393048221327186,
      4139595949113890, 2037655246635364, 1001591348315641, 491808604962296,
      241293656953012, 118304122014405, 57968649799947, 28388662714236,
      13895161400556, 6797526392535, 3323560145881, 1624109166018,
      793189260998, 387148515886, 188844769357, 92054377509,
      44841620426, 21827124353, 10616326552, 5159281045,
      2505087309, 1215204383, 588891145, 285076316,
      137840686, 66567488, 32103728, 15460810,
      7433670, 3567978, 1709640, 817053,
      389954, 185387, 87993, 41604,
      19611, 9184, 4283, 2001,
      914, 421, 187, 84,
      37, 15, 7, 2];
   Max_Almost_Offset : constant array (Natural range 0 .. 63) of U64 :=
     [
      U64'Last - 1, 58, 14, 2,
      4, 3, 17, 0,
      1, 195, 51, 127,
      63, 767, 1535, 511,
      255, 15, 8191, 1023,
      83967, 16383, 111615, 557055,
      2097151, 524287, 65535, 1048575,
      6553599, 33554431, 4194303, 671088639,
      16777215, 536870911, 2684354559, 2147483647,
      25769803775, 4294967295, 268435455, 206158430207,
      137438953471, 17179869183, 68719476735, 2199023255551,
      5428838662143, 21990232555519, 4398046511103, 1099511627775,
      100055558127615, 10995116277759, 17592186044415, 545357767376895,
      70368744177663, 1125899906842623, 10133099161583615, 9007199254740991,
      24769797950537727, 4503599627370495, 144115188075855871, 72057594037927935,
      432345564227567615, 288230376151711743, 1152921504606846975, 
      4611686018427387903];
   Upper_20 : constant array (Natural range 0 .. 12) of F64 :=
     [
      0.0, 0.0, 1.006, 0.7385,
      0.6830, 0.5940, 0.3596, 0.2227,
      0.1439, 0.09785, 0.07016, 0.05303,
      0.04202];
   Upper_32 : constant array (Natural range 0 .. 20) of F64 :=
     [
      0.0, 0.0, 1.013, 0.8094,
      0.7485, 0.6467, 0.3984, 0.2464,
      0.1572, 0.1049, 0.07364, 0.05452,
      0.04266, 0.03542, 0.03082, 0.02798,
      0.02642, 0.02585, 0.02615, 0.02808,
      0.03054];
   Upper_64 : constant array (Natural range 0 .. 40) of F64 :=
     [
      0.0, 0.0, 1.028, 1.028,
      1.3043, 0.72208, 0.46609, 0.29340,
      0.18571, 0.12063, 0.0815, 0.0575,
      0.0427, 0.03490, 0.03007, 0.02710,
      0.02554, 0.02504, 0.02554, 0.02699,
      0.02954, 0.03294, 0.03779, 0.04453,
      0.05393, 0.06703, 0.08543, 0.1117,
      0.1494, 0.205, 0.287, 0.410,
      0.60, 0.90, 1.36, 2.12,
      3.35, 5.38, 8.83, 14.75,
      25.07];
   Lower_20 : constant array (Natural range 0 .. 12) of F64 :=
     [
      0.0, 0.0, 0.8197, 0.8418,
      0.5242, 0.5154, 0.3053, 0.1901,
      0.1253, 0.0892, 0.06551, 0.05082,
      0.04101];
   Lower_32 : constant array (Natural range 0 .. 20) of F64 :=
     [
      0.0, 0.0, 1.004, 0.7383,
      0.6828, 0.5939, 0.3594, 0.2222,
      0.1438, 0.09754, 0.06981, 0.05245,
      0.04151, 0.03461, 0.03006, 0.02709,
      0.02553, 0.02502, 0.02552, 0.02697,
      0.02945];
   Lower_64 : constant array (Natural range 0 .. 40) of F64 :=
     [
      0.0, 0.0, 1.011, 0.8093,
      0.7484, 0.6465, 0.3982, 0.2463,
      0.1571, 0.1048, 0.07363, 0.0545,
      0.0422, 0.0331, 0.0270, 0.0232,
      0.0208, 0.0194, 0.0190, 0.0193,
      0.0203, 0.0222, 0.0252, 0.0295,
      0.0356, 0.0444, 0.0570, 0.0753,
      0.102, 0.14, 0.20, 0.297,
      0.44, 0.68, 1.07, 1.71,
      2.8, 4.7, 8.0, 13.89,
      23.98];
   First_Three : constant array (Natural range 0 .. 49) of U64 :=
     [
      1, 2, 3, 5,
      8, 14, 23, 39,
      64, 103, 169, 269,
      427, 676, 1065, 1669,
      2628, 4104, 6414, 10023,
      15608, 24281, 37733, 58503,
      90616, 140187, 216625, 334527,
      516126, 795632, 1225641, 1886570,
      2901796, 4460359, 6851532, 10518476,
      16138642, 24748319, 37932129, 58110457,
      88981343, 136192537, 208364721, 318653143,
      487128905, 744398307, 1137129971, 1736461477,
      2650785552, 4045250962];

   --  almost_primes.c: _genkap, _cs; omega_primes.c:
   --  _omega_prime_gen_rec and _omega_prime_count_rec2. Enumerate ordered
   --  prime factorizations once; count the last prime with pi rather than
   --  materializing it. All state belongs to this call.
   procedure Factor_Family
     (K : Natural; Low, High : U64; Distinct, Listing : Boolean;
      Values : out Family_Vectors.Vector; Total : out U64);

   procedure Factor_Family
     (K : Natural; Low, High : U64; Distinct, Listing : Boolean;
      Values : out Family_Vectors.Vector; Total : out U64)
   is
      Cache_High : constant U64 := U64'Min (High, 1_000_000);
      Pr : constant Math_Prime_Util.Sieve.Prime_Vectors.Vector :=
        Math_Prime_Util.Sieve.Primes (Cache_High);
      package Sorting is new Family_Vectors.Generic_Sorting;

      function Pi (N : U64) return U64;
      function Pi (N : U64) return U64 is
         L : Natural := 0;
         H : Natural := Natural (Pr.Length);
         M : Natural;
      begin
         if N > Cache_High then
            return Count.Prime_Count (N);
         end if;
         while L < H loop
            M := L + (H - L) / 2;
            if Pr.Element (M) <= N then
               L := M + 1;
            else
               H := M;
            end if;
         end loop;
         return U64 (L);
      end Pi;

      function Next (P : U64) return U64;
      function Next (P : U64) return U64 is
         I : constant U64 := Pi (P);
         R : Int.Optional_U64;
      begin
         if I < U64 (Pr.Length) then
            return Pr.Element (Natural (I));
         end if;
         R := Math_Prime_Util.Sieve.Next_Prime (P);
         return (if R.Defined then R.Value else 0);
      end Next;

      --  Minimum possible product of the remaining ordered factors.
      function Fits (Left : Positive; P, Limit : U64) return Boolean;
      function Fits (Left : Positive; P, Limit : U64) return Boolean is
         Product : U64 := 1;
         Q : U64 := P;
      begin
         for I in 1 .. Left loop
            if Q = 0 or else Q > Limit / Product then
               return False;
            end if;
            Product := Product * Q;
            if Distinct and then I < Left then
               Q := Next (Q);
            end if;
         end loop;
         return True;
      end Fits;

      procedure Last (M, P : U64);
      procedure Last (M, P : U64) is
         Upper : constant U64 := High / M;
         Lower : constant U64 := Low / M + (if Low mod M = 0 then 0 else 1);
         E : Positive := 1;
         A, B : U64;
         Power : Int.Optional_U64;
      begin
         loop
            B := Int.Rootint (Upper, U64 (E));
            exit when B < P;
            A := U64'Max (P, Int.Crootint (Lower, U64 (E)));
            if A <= B then
               if Listing then
                  for Q of Math_Prime_Util.Sieve.Primes (A, B) loop
                     Power := Int.Powint (Q, U64 (E));
                     if Power.Defined then
                        Values.Append (M * Power.Value);
                        Total := Total + 1;
                     end if;
                  end loop;
               else
                  Total := Total + Pi (B) - Pi (A - 1);
               end if;
            end if;
            exit when not Distinct or else E = 63;
            E := E + 1;
         end loop;
      end Last;

      procedure Recurse (Left : Positive; M, Start : U64);
      procedure Recurse (Left : Positive; M, Start : U64) is
         P : U64 := Start;
         T, Next_P : U64;
      begin
         if Left = 1 then
            Last (M, Start);
            return;
         end if;
         while Fits (Left, P, High / M) loop
            Next_P := (if Distinct then Next (P) else P);
            T := M * P;
            loop
               exit when not Fits (Left - 1, Next_P, High / T);
               Recurse (Left - 1, T, Next_P);
               exit when not Distinct or else T > High / P;
               T := T * P;
            end loop;
            P := Next (P);
            exit when P = 0;
         end loop;
      end Recurse;
   begin
      Values.Clear;
      Total := 0;
      if Low > High or else High = 0 then
         return;
      elsif K = 0 then
         if Low <= 1 then
            Total := 1;
            if Listing then
               Values.Append (1);
            end if;
         end if;
      elsif K < 64 and then (not Distinct or else K < 16) then
         Recurse (K, 1, 2);
         if Listing then
            Sorting.Sort (Values);
         end if;
      end if;
   end Factor_Family;

   --  almost_primes.c: range_almost_prime_sieve; omega_primes.c:
   --  sieve_omega_primes. Bounded segments track residual factors and
   --  avoid recursive work below a narrow interval's lower endpoint.
   function Factor_Range (K : Natural; Low, High : U64; Distinct : Boolean)
      return Family_Vectors.Vector;
   function Factor_Range (K : Natural; Low, High : U64; Distinct : Boolean)
      return Family_Vectors.Vector
   is
      Values : Family_Vectors.Vector;
      Total : U64;
   begin
      if Low > High or else High = 0 then
         return Values;
      end if;
      if K = 0 or else K >= 64 or else (Distinct and then K >= 16)
        or else High < 100_000_000 or else High - Low > 5_000_000
        or else (Distinct and then K >= 8)
      then
         Factor_Family (K, Low, High, Distinct, True, Values, Total);
         return Values;
      end if;
      declare
         subtype Index is Natural range 0 .. Natural (High - Low);
         type Residual_Array is array (Index) of U64;
         type Count_Array is array (Index) of Natural range 0 .. 64;
         Residual : Residual_Array;
         Counts : Count_Array := [others => 0];
         Offset : U64;
      begin
         for I in Index loop
            Residual (I) := Low + U64 (I);
         end loop;
         for P of Math_Prime_Util.Sieve.Primes (Int.Sqrtint (High)) loop
            Offset := (if Low mod P = 0 then 0 else P - Low mod P);
            while Offset <= High - Low loop
               declare
                  I : constant Index := Index (Offset);
               begin
                  if Residual (I) > 1 then
                     Counts (I) := Counts (I) + 1;
                     Residual (I) := Residual (I) / P;
                     while Residual (I) mod P = 0 loop
                        if not Distinct then
                           Counts (I) := Counts (I) + 1;
                        end if;
                        Residual (I) := Residual (I) / P;
                     end loop;
                  end if;
               end;
               exit when P > High - Low - Offset;
               Offset := Offset + P;
            end loop;
         end loop;
         for I in Index loop
            if Residual (I) > 1 then
               Counts (I) := Counts (I) + 1;
            end if;
            if Low + U64 (I) >= 1 and then Counts (I) = K then
               Values.Append (Low + U64 (I));
            end if;
         end loop;
      end;
      return Values;
   end Factor_Range;

   function Almost_Primes (K : Natural; Low, High : U64)
      return Family_Vectors.Vector is
     (Factor_Range (K, Low, High, False));

   function Almost_Primes (K : Natural; High : U64)
      return Family_Vectors.Vector is (Almost_Primes (K, 1, High));

   function Omega_Primes (K : Natural; Low, High : U64)
      return Family_Vectors.Vector is
     (Factor_Range (K, Low, High, True));

   function Omega_Primes (K : Natural; High : U64)
      return Family_Vectors.Vector is (Omega_Primes (K, 1, High));

   function Family_Count (K : Natural; High : U64; Distinct : Boolean)
      return U64;
   function Family_Count (K : Natural; High : U64; Distinct : Boolean)
      return U64 is
      Values : Family_Vectors.Vector;
      Total : U64;
   begin
      Factor_Family (K, 1, High, Distinct, False, Values, Total);
      return Total;
   end Family_Count;

   function Almost_Prime_Count (K : Natural; High : U64) return U64 is
     (Family_Count (K, High, False));

   function Omega_Prime_Count (K : Natural; High : U64) return U64 is
     (Family_Count (K, High, True));

   function Almost_Prime_Count (K : Natural; Low, High : U64) return U64 is
   begin
      if Low > High then
         return 0;
      elsif High - Low <= 100_000 then
         return U64 (Almost_Primes (K, Low, High).Length);
      end if;
      return Almost_Prime_Count (K, High) -
        (if Low <= 1 then 0 else Almost_Prime_Count (K, Low - 1));
   end Almost_Prime_Count;

   function Omega_Prime_Count (K : Natural; Low, High : U64) return U64 is
   begin
      if Low > High then
         return 0;
      elsif High - Low <= 100_000 then
         return U64 (Omega_Primes (K, Low, High).Length);
      end if;
      return Omega_Prime_Count (K, High) -
        (if Low <= 1 then 0 else Omega_Prime_Count (K, Low - 1));
   end Omega_Prime_Count;

   function Family_Nth (K : Natural; N : U64; Distinct : Boolean)
      return Int.Optional_U64;
   function Family_Nth (K : Natural; N : U64; Distinct : Boolean)
      return Int.Optional_U64 is
      Low : U64 := 1;
      High : U64 := 2;
      Mid : U64;
   begin
      if N = 0 or else K >= 64 or else (Distinct and then K >= 16) then
         return (Defined => False);
      elsif K = 0 then
         return (if N = 1 then (True, 1) else (Defined => False));
      elsif not Distinct and then K = 1 then
         return (True, Count.Nth_Prime (N));
      end if;
      while Family_Count (K, High, Distinct) < N loop
         Low := High + 1;
         if High > U64'Last / 2 then
            High := U64'Last;
            if Family_Count (K, High, Distinct) < N then
               return (Defined => False);
            end if;
            exit;
         end if;
         High := High * 2;
      end loop;
      while Low < High loop
         Mid := Low + (High - Low) / 2;
         if Family_Count (K, Mid, Distinct) < N then
            Low := Mid + 1;
         else
            High := Mid;
         end if;
      end loop;
      return (True, Low);
   end Family_Nth;

   function Nth_Almost_Prime (K : Natural; N : U64)
      return Int.Optional_U64 is (Family_Nth (K, N, False));

   function Nth_Omega_Prime (K : Natural; N : U64)
      return Int.Optional_U64 is (Family_Nth (K, N, True));
   --  almost_primes.c: reduce_prime_count_factor. Remove mandatory twos
   --  until an all-odd factorization can fit in the remaining bound.
   procedure Reduce_Count (K : in out Natural; N : in out U64)
     with SPARK_Mode => On;
   procedure Reduce_Count (K : in out Natural; N : in out U64) is
      P : Int.Optional_U64;
   begin
      while K > 1 loop
         P := Int.Powint (3, U64 (K));
         exit when P.Defined and then N >= P.Value;
         K := K - 1;
         N := N / 2;
      end loop;
   end Reduce_Count;

   procedure Almost_Bounds (Factors : Natural; High : U64;
                            Lower, Upper : out U64);
   procedure Almost_Bounds (Factors : Natural; High : U64;
                            Lower, Upper : out U64)
   is
      K : Natural := Factors;
      N : U64 := High;
      X, L, LL, LP, ML, MU, BL, BU, Weight : F64;
      Maximum : U64;
   begin
      Lower := 0;
      Upper := 0;
      if K >= 64 or else N < 2 ** K then
         return;
      end if;
      Reduce_Count (K, N);
      if K = 0 then
         Lower := (if N >= 1 then 1 else 0);
         Upper := Lower;
         return;
      elsif K = 1 then
         Lower := Count.Prime_Count_Lower (N);
         Upper := Count.Prime_Count_Upper (N);
         return;
      elsif N < 3 * 2 ** (K - 1) then
         Lower := 1;
         Upper := 1;
         return;
      elsif N < 9 * 2 ** (K - 2) then
         Lower := 2;
         Upper := 2;
         return;
      elsif N < 10 * 2 ** (K - 2) then
         Lower := 3;
         Upper := 3;
         return;
      end if;
      Maximum := Max_Almost_Count (K);
      if N >= U64'Last - Max_Almost_Offset (K) then
         Lower := Maximum;
         Upper := Maximum;
         return;
      end if;
      X := F64 (N);
      L := Log (X);
      LL := Log (L);
      LP := LL + 0.26153;
      if N <= 1_048_575 then
         ML := Lower_20 (K);
         MU := Upper_20 (K);
      elsif N <= 4_294_967_295 then
         ML := Lower_32 (K);
         MU := Upper_32 (K);
      else
         ML := Lower_64 (K);
         MU := Upper_64 (K);
      end if;
      if K = 2 then
         BL := X * (LL + 0.261536) / L;
         BU := BL;
         if X >= 1.0E12 then
            BL := X * (LL + 0.1769) / L * (1.0 + 0.4232 / L);
            ML := 1.0;
         end if;
      elsif K = 3 then
         BU := X * (LP * LP + 1.055852) / (2.0 * L);
         BL := X * LL * LL / (2.0 * L);
         if N < 638 then
            ML := 0.8418;
         elsif N <= 1_926 then
            Weight := (X - 638.0) / (1_926.0 - 638.0);
            ML := (1.0 - Weight) * 0.8939 + Weight * 0.9233;
         elsif N <= 500_194 then
            Weight := (X - 1_927.0) / (500_194.0 - 1_927.0);
            ML := (1.0 - Weight) * 0.9233 + Weight;
         elsif N <= 3_184_393_786 then
            Weight := (X - 500_194.0) / (3_184_393_786.0 - 500_194.0);
            ML := (1.0 - Weight) + Weight * 1.039;
         else
            ML := 1.0004;
         end if;
         if N > 4_294_967_295 then
            MU := 0.8711;
         end if;
      elsif K = 4 then
         BL := X * LP * LP * LP / (6.0 * L);
         BU := BL;
         if X > 1.0E12 then
            BU := BU + 0.511977 * X *
              (Log (Log (X / 4.0)) + 0.261536) / L;
         end if;
         if N > 4_294_967_295 then
            MU := 0.780;
         end if;
         if X > 1.0E12 then
            MU := 0.6921;
         end if;
      else
         BL := X / L;
         LP := LL + (Log (F64 (K)) * Log (Log (F64 (K))) - 0.504377);
         for I in 1 .. K - 1 loop
            BL := BL * (LP / F64 (I));
         end loop;
         BU := BL;
      end if;
      BL := BL * ML;
      BU := BU * MU;
      Lower := (if BL >= F64 (Maximum) then Maximum else Trunc (BL));
      Upper := (if BU >= F64 (Maximum) then Maximum else Trunc (BU + 1.0));
   end Almost_Bounds;

   function Almost_Prime_Count_Lower (K : Natural; N : U64) return U64 is
      L, U : U64;
   begin
      if K = 2 and then N < 256 then
         return Almost_Prime_Count (K, N);
      end if;
      Almost_Bounds (K, N, L, U);
      return L;
   end Almost_Prime_Count_Lower;

   function Almost_Prime_Count_Upper (K : Natural; N : U64) return U64 is
      L, U : U64;
   begin
      if K = 2 and then N < 256 then
         return Almost_Prime_Count (K, N);
      end if;
      Almost_Bounds (K, N, L, U);
      return U;
   end Almost_Prime_Count_Upper;

   --  semi_primes.c: semiprime_count_approx. Truncated Crisan/Erban series.
   function Semi_Approx (N : U64) return U64;
   function Semi_Approx (N : U64) return U64 is
      C : constant array (Natural range 0 .. 18) of F64 :=
        [0.26149721284764278375, -2.0710850628855780875,
         -7.6972777412176108802, -35.345660320564161516,
         -206.71503925406509339, -1511.1997871316530251,
         -13546.323682845914021, -146229.10675883565523,
         -1867579.6280076650637, -27733045.258413542557,
         -470983423.57703294361, -9011500983.75, -191744069149.4,
         -4487573459710.5, -114472069580579.8, -3158610502077135.6,
         -93682567786528911.9, -2970838770257639695.3,
         -100274471240063911725.1];
      Cross : constant array (Natural range 0 .. 14) of F64 :=
        [632.0, 9385.0, 136411.0, 4610076.0, 66358000.0, 440590000.0,
         2557200000.0, 53032001000.0, 1151076796431.0, 20416501389724.0,
         165815501587300.0, 953038830319448.0, 20019396133340433.0,
         192558867109258424.0, 1757883874953032448.0];
      Minimum : constant array (Natural range 0 .. 15) of F64 :=
        [82.0, 195.0, 2485.0, 31446.0, 906319.0, 11741185.0,
         72840337.0, 398702652.0, 7538564737.0, 150382042176.0,
         2482510001499.0, 19204997230933.0, 106211451717048.0,
         2094735089989940.0, 19282342825922188.0, 168996486318315136.0];
      L : Natural := 3;
      Log_N, LL, Series, Den, Fact, Estimate : F64;
   begin
      if N <= 623 then
         return Almost_Prime_Count (2, N);
      end if;
      Log_N := Log (F64 (N));
      LL := Log (Log_N);
      while L <= 17 and then F64 (N) >= Cross (L - 3) loop
         L := L + 1;
      end loop;
      Series := 0.0;
      Den := 1.0;
      Fact := 1.0;
      for I in 1 .. L loop
         if I > 1 then
            Fact := Fact * F64 (I - 1);
         end if;
         Series := Series + Fact * (LL / Den);
         Series := Series + C (I - 1) / Den;
         Den := Den * Log_N;
      end loop;
      Estimate := (F64 (N) / Log_N) * Series + 0.5;
      if Estimate >= F64 (Max_Almost_Count (2)) then
         return Max_Almost_Count (2);
      end if;
      return U64'Max (Trunc (Estimate), Trunc (Minimum (L - 3)));
   end Semi_Approx;

   function Almost_Prime_Count_Approx (K : Natural; N : U64) return U64 is
      Factors : Natural := K;
      High : U64 := N;
      L, U : U64;
      X, Log_X, LL, A, S, Estimate : F64;
      Small_Three : constant array (Natural range 0 .. 18) of U64 :=
        [27, 28, 30, 42, 44, 45, 50, 52, 63, 66, 68, 70, 75, 76, 78,
         92, 98, 99, 102];
      Small_Count : U64 := 4;
   begin
      if K = 0 then
         return (if N >= 1 then 1 else 0);
      elsif K >= 64 or else N < 2 ** K then
         return 0;
      end if;
      Reduce_Count (Factors, High);
      if Factors = 1 then
         return Count.Prime_Count_Approx (High);
      elsif Factors = 2 then
         return Semi_Approx (High);
      elsif High < 3 * 2 ** (Factors - 1) then
         return 1;
      elsif High < 9 * 2 ** (Factors - 2) then
         return 2;
      elsif High < 10 * 2 ** (Factors - 2) then
         return 3;
      elsif Factors = 3 and then High < 102 then
         for V of Small_Three loop
            exit when High < V;
            Small_Count := Small_Count + 1;
         end loop;
         return Small_Count;
      end if;
      Almost_Bounds (Factors, High, L, U);
      if Factors = 3 then
         X := F64 (High);
         Log_X := Log (X);
         LL := Log (Log_X);
         if X <= 638.0 then
            S := 1.554688; A := 0.865814;
         elsif X <= 1544.0 then
            S := 1.050000; A := 0.822256;
         elsif X <= 1927.0 then
            S := 0.625000; A := 0.791747;
         elsif X <= 486586.0 then
            S := 2.865611; A := 1.004090;
         elsif X <= 1913680.0 then
            S := 2.790963; A := 0.999618;
         elsif X <= 22347532.0 then
            S := 2.719238; A := 0.995635;
         elsif X <= 2.95E8 then
            S := 2.584473; A := 0.988802;
         elsif X <= 4.20E9 then
            S := 2.457108; A := 0.983098;
         elsif X <= 7.07E10 then
            S := 2.352818; A := 0.978931;
         elsif X <= 1.36E12 then
            S := 2.269745; A := 0.975953;
         elsif X <= 4.1E13 then
            S := 2.203002; A := 0.973796;
         elsif X <= 9.2E14 then
            S := 2.148463; A := 0.972213;
         else
            S := 2.119279; A := 0.971438;
         end if;
         Estimate := 0.5 * A * X * ((LL + 0.26153) * (LL + 0.26153)) /
           (Log_X + S) + 0.5;
         return U64'Min (U, U64'Max (L, Trunc (Estimate)));
      end if;
      return Trunc (F64 (L) + F64 (U - L) *
                      (if Factors > 11 then 0.20 else 0.76));
   end Almost_Prime_Count_Approx;

   function Almost_Estimate_Nth (K : Natural; N : U64; Kind : Natural)
      return Int.Optional_U64;
   function Almost_Estimate_Nth (K : Natural; N : U64; Kind : Natural)
      return Int.Optional_U64
   is
      R : Natural := 0;
      Low, High, Mid, C : U64;
      Reduced : Int.Optional_U64;
      Semi : constant array (Natural range 1 .. 7) of U64 :=
        [4, 6, 9, 10, 14, 15, 21];
      Triple : constant array (Natural range 1 .. 7) of U64 :=
        [8, 12, 18, 20, 27, 28, 30];
   begin
      if N = 0 or else K >= 64 then
         return (Defined => False);
      elsif K = 0 then
         return (if N = 1 then (True, 1) else (Defined => False));
      elsif N > Max_Almost_Count (K) then
         return (Defined => False);
      elsif N = Max_Almost_Count (K) then
         return (True, U64'Last - Max_Almost_Offset (K));
      elsif K = 1 then
         return (True, (case Kind is
                   when 0 => Count.Nth_Prime_Lower (N),
                   when 1 => Count.Nth_Prime_Upper (N),
                   when others => Count.Nth_Prime_Approx (N)));
      elsif N < 8 then
         return (True, (if K = 2 then Semi (Natural (N)) else
                          Triple (Natural (N)) * 2 ** (K - 3)));
      elsif K = 2 and then N <= 220 then
         return Nth_Almost_Prime (K, N);
      end if;
      if Kind /= 2 then
         if K > 49 then
            if N < First_Three (49) then
               R := K - 48;
            end if;
         end if;
         while K - R <= 49 and then N < First_Three (K - R) loop
            R := R + 1;
         end loop;
         if R > 0 then
            Reduced := Almost_Estimate_Nth (K - R, N, Kind);
            if not Reduced.Defined or else Reduced.Value > U64'Last / 2 ** R
            then
               return (Defined => False);
            end if;
            return (True, Reduced.Value * 2 ** R);
         end if;
      end if;
      Low := (if Kind = 0 then 3 * 2 ** K else 5 * 2 ** K);
      if Kind = 2 then
         Reduced := Almost_Estimate_Nth (K, N, 0);
         Low := Reduced.Value;
      end if;
      High := Low;
      loop
         C := (case Kind is
                 when 0 => Almost_Prime_Count_Upper (K, High),
                 when 1 => Almost_Prime_Count_Lower (K, High),
                 when others => Almost_Prime_Count_Approx (K, High));
         exit when C >= N;
         if High = U64'Last then
            return (Defined => False);
         end if;
         High := (if High > U64'Last / 2 then U64'Last else High * 2);
      end loop;
      while Low < High loop
         Mid := Low + (High - Low) / 2;
         C := (case Kind is
                 when 0 => Almost_Prime_Count_Upper (K, Mid),
                 when 1 => Almost_Prime_Count_Lower (K, Mid),
                 when others => Almost_Prime_Count_Approx (K, Mid));
         if C < N then
            Low := Mid + 1;
         else
            High := Mid;
         end if;
      end loop;
      --  MPU's inverse interpolation returns the lower neighboring integer
      --  when the count estimate skips over the requested index.
      C := (case Kind is
              when 0 => Almost_Prime_Count_Upper (K, Low),
              when 1 => Almost_Prime_Count_Lower (K, Low),
              when others => Almost_Prime_Count_Approx (K, Low));
      if C > N then
         Low := Low - 1;
      end if;
      return (True, Low);
   end Almost_Estimate_Nth;

   function Nth_Almost_Prime_Lower (K : Natural; N : U64)
      return Int.Optional_U64 is (Almost_Estimate_Nth (K, N, 0));
   function Nth_Almost_Prime_Upper (K : Natural; N : U64)
      return Int.Optional_U64 is (Almost_Estimate_Nth (K, N, 1));
   function Nth_Almost_Prime_Approx (K : Natural; N : U64)
      return Int.Optional_U64 is (Almost_Estimate_Nth (K, N, 2));
end Math_Prime_Util.Families;
