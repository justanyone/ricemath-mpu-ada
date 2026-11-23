with Math_Prime_Util.Count;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Long_Elementary_Functions;
with Interfaces;

package body Math_Prime_Util.Families is
   package Prime_Sieve renames Math_Prime_Util.Sieve;
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

   function Trunc (X : F64) return U64 with SPARK_Mode => On;
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
   generic
      type Wide is digits <>;
      with function Value (X : U64) return U64;
   function Inverse (Low, High, N : U64) return U64
     with Pre => Low <= High,
          Post => Inverse'Result in Low .. High;
   function Inverse (Low, High, N : U64) return U64 is
      package Ef is new Ada.Numerics.Generic_Elementary_Functions (Wide);
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
      Rmid := Value (Mid);
      if Rmid >= N then
         Hi := Mid;
         Rhi := Rmid;
         Rlo := Value (Lo);
         if Rlo = N then
            return Lo;
         end if;
      else
         Lo := Mid;
         Rlo := Rmid;
         Rhi := Value (Hi);
      end if;
      if Hi - Lo <= 1 then
         return (if Rlo = N or else (Rlo < N and then Rhi > N)
                 then Lo else Hi);
      end if;
      Mid := Linear;
      while Hi - Lo > 1 and then Rhi > N loop
         Iteration := Iteration + 1;
         Rmid := Value (Mid);
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
            R1 : U64 := Value (X1);
            D0 : constant F64 := F64 (N - Rlo);
            D1 : constant F64 :=
              F64 ((if R1 >= N then R1 - N else N - R1));
            D2 : constant F64 := F64 (Rhi - N + 1);
            Sign : constant F64 := (if R1 >= N then 1.0 else -1.0);
            Pos : constant Wide := Wide (Sign * F64 (X1 - Lo) * D1) /
              Ef.Sqrt (Wide (D1 * D1 + D0 * D2));
            Move : constant U64 := U64 (Wide'Floor (abs Pos + 0.5));
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
               R3 := Value (X3);
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
         if Value (Mid) < N then
            Lo := Mid;
         else
            Hi := Mid;
         end if;
      end loop;
      return Hi;
   end Inverse;

   function Approx_Value (N : U64) return U64 is (Estimate (N, Approx));
   function Lower_Value (N : U64) return U64 is (Estimate (N, Lower));
   function Upper_Value (N : U64) return U64 is (Estimate (N, Upper));
   function Invert_Approx is new Inverse (F64, Approx_Value);
   function Invert_Lower is new Inverse (F64, Lower_Value);
   function Invert_Upper is new Inverse (F64, Upper_Value);

   function Lucky_Count_Approx (N : U64) return U64 is
   begin
      if N < 48 then
         return Small_Count (N);
      end if;
      return Invert_Approx (Simple_Lower (N), Simple_Upper (N), N);
   end Lucky_Count_Approx;

   function Lucky_Count_Lower (N : U64) return U64 is
   begin
      if N < 48 then
         return Small_Count (N);
      elsif N < 9_000 then
         return Simple_Lower (N);
      end if;
      return Invert_Upper (Simple_Lower (N), Simple_Upper (N), N);
   end Lucky_Count_Lower;

   function Lucky_Count_Upper (N : U64) return U64 is
   begin
      if N < 48 then
         return Small_Count (N);
      elsif N < 40_000_000 or else N > 18_428_297_000_000_000_000 then
         return Simple_Upper (N);
      end if;
      return Invert_Lower
        (Simple_Lower (N), 1 + Trunc (F64 (Simple_Upper (N)) * 1.001),
         N);
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
   use type Primality.Prime_Result;
   subtype Ram_Wide is Long_Long_Float;
   package Ram_Ef is new Ada.Numerics.Generic_Elementary_Functions (Ram_Wide);
   use Ram_Ef;
   Ram_Small : constant array (Positive range 1 .. 23) of U64 :=
     [2, 11, 17, 29, 41, 47, 59, 67, 71, 97, 101, 107, 127,
      149, 151, 167, 179, 181, 227, 229, 233, 239, 241];

   function Ram_Small_Count (N : U64) return U64;
   function Ram_Small_Count (N : U64) return U64 is
      R : U64 := 0;
   begin
      for P of Ram_Small loop
         exit when P > N;
         R := R + 1;
      end loop;
      return R;
   end Ram_Small_Count;

   --  prime_counts.c: ramanujan_axler returns double after wide arithmetic.
   function Axler (N : U64; C, D : Ram_Wide) return U64;
   function Axler (N : U64; C, D : Ram_Wide) return U64 is
      X : constant Ram_Wide := Ram_Wide (N);
      L : constant Ram_Wide := Log (X);
      LL : constant Ram_Wide := Log (L);
      L2 : constant Ram_Wide := Log (2.0);
      C1 : constant Ram_Wide := 2.0 * L2 * L2 + L2 + C;
      C2 : constant Ram_Wide := L2 ** 3 + 2.0 * L2 * L2 + D;
      U : constant Ram_Wide :=
        (L2 * L * LL * LL - C1 * L * LL + C2 * L - L2 * L2 * LL
         + L2 ** 3 + L2 * L2) /
        (L ** 4 + L ** 3 * LL - L ** 3 * L2 - L * L * L2);
      R : constant Long_Float := Long_Float
        (2.0 * X * (1.0 + L2 / L - (L2 * LL - L2 * L2 - L2) / (L * L) + U));
   begin
      return U64 (Long_Float'Floor (R));
   end Axler;

   type Bound_Kind is (Lower, Upper);
   type Coefficient is record
      Last : U64;
      C, D : Ram_Wide;
   end record;
   type Coefficients is array (Positive range <>) of Coefficient;
   --  ramanujan_primes.c: nth_ramanujan_prime_lower/upper breakpoints.
   Lower_Coefficients : constant Coefficients :=
     [(188, 4.2720, 0.340), (1244, -0.2179, -6.179),
      (2983, 0.1446, -4.8693), (14302, -0.3570, -5.1154),
      (34815, -1.5770, -7.5332), (76399, 1.472, 0.0126),
      (280815, 1.472, 0.5132), (915886, 1.472, 0.9967),
      (4000000, 1.472, 1.5004), (16000000, 1.472, 1.7184),
      (64000000, 1.472, 1.9860), (128000000, 1.472, 2.1352),
      (256000000, 1.472, 2.1658), (384000000, 1.472, 2.1999),
      (512000000, 1.472, 2.2047), (640000000, 1.472, 2.2324),
      (14888378285, 1.472, 2.2385), (467037926604, 1.472, 2.29),
      (2778491401197, 1.472, 2.31), (10656144781918, 1.472, 2.315),
      (63698770351741, 1.472, 2.317), (U64'Last, 1.472, 2.319)];
   Upper_Coefficients : constant Coefficients :=
     [(167, -4.7691, -6.2682), (2289, -0.9315, -0.5635),
      (5224, -0.5318, -0.0710), (12580, 0.1212, 0.7973),
      (18174, 0.0, 0.3548), (82882, 0.0, -0.2450),
      (316313, 0.0, -0.6384), (1000000, 0.0, -0.9353),
      (4000000, 0.0, -1.1271), (16000000, 0.0, -1.4152),
      (64000000, 0.0, -1.6671), (128000000, 0.0, -1.8855),
      (256000000, 0.0, -1.9325), (384000000, 0.0, -2.0190),
      (512000000, 0.0, -2.0310), (3999654659, 0.0, -2.0884),
      (84086679236, 0.0, -2.235), (514808375201, 0.0, -2.435),
      (3594243587299, 0.0, -2.535), (28330126673435, 0.0, -2.635),
      (117462814829787, 0.0, -2.735), (U64'Last, 0.0, -2.8)];

   function Nth_Bound (N : U64; Kind : Bound_Kind) return Int.Optional_U64;
   function Nth_Bound (N : U64; Kind : Bound_Kind) return Int.Optional_U64 is
      Table : constant Coefficients :=
        (if Kind = Lower then Lower_Coefficients else Upper_Coefficients);
      R : U64 := 0;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 23 then
         return (Defined => True, Value => Ram_Small (Positive (N)));
      end if;
      for Row of Table loop
         if N <= Row.Last then
            R := Axler (N, Row.C, Row.D);
            exit;
         end if;
      end loop;
      return (Defined => True, Value =>
        (if R > 425_656_284_035_217_743 then 0
         elsif Kind = Lower then Count.Nth_Prime_Lower (R)
         else Count.Nth_Prime_Upper (R)));
   end Nth_Bound;

   function Nth_Ramanujan_Prime_Lower (N : U64) return Int.Optional_U64 is
     (Nth_Bound (N, Lower));
   function Nth_Ramanujan_Prime_Upper (N : U64) return Int.Optional_U64 is
     (Nth_Bound (N, Upper));

   function Ram_Upper_Value (N : U64) return U64 is
     (if N = 0 then 0 else Nth_Ramanujan_Prime_Upper (N).Value);
   function Ram_Lower_Value (N : U64) return U64 is
     (if N = 0 then 0 else Nth_Ramanujan_Prime_Lower (N).Value);
   function Ram_Invert_Upper is new Inverse (Ram_Wide, Ram_Upper_Value);
   function Ram_Invert_Lower is new Inverse (Ram_Wide, Ram_Lower_Value);

   function Ram_Count_Bound (N : U64; Kind : Bound_Kind) return U64;
   function Ram_Count_Bound (N : U64; Kind : Bound_Kind) return U64 is
      Lo : constant U64 := Count.Prime_Count_Lower (N) / 3;
      Hi : constant U64 := Count.Prime_Count_Upper (N) / 2;
   begin
      if N <= 241 then
         return Ram_Small_Count (N);
      elsif Kind = Lower then
         return (if Ram_Upper_Value (Lo) > N or else Ram_Upper_Value (Hi) < N
                 then Lo else Ram_Invert_Upper (Lo, Hi, N));
      else
         return (if Ram_Lower_Value (Lo) > N then Lo
                 elsif Ram_Lower_Value (Hi) < N then Hi
                 else Ram_Invert_Lower (Lo, Hi, N));
      end if;
   end Ram_Count_Bound;
   function Ramanujan_Prime_Count_Lower (N : U64) return U64 is
     (Ram_Count_Bound (N, Lower));
   function Ramanujan_Prime_Count_Upper (N : U64) return U64 is
     (Ram_Count_Bound (N, Upper));

   function Ramanujan_Prime_Count_Approx (N : U64) return U64 is
   begin
      if N <= 241 then
         return Ram_Small_Count (N);
      end if;
      return Count.Prime_Count_Approx (N) - Count.Prime_Count_Approx (N / 2);
   end Ramanujan_Prime_Count_Approx;

   function Ram_Invert_Approx is new Inverse
     (Ram_Wide, Ramanujan_Prime_Count_Approx);
   function Nth_Ramanujan_Prime_Approx (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 23 then
         return (Defined => True, Value => Ram_Small (Positive (N)));
      end if;
      return (Defined => True, Value => Ram_Invert_Approx
        (Ram_Lower_Value (N) - 1, Ram_Upper_Value (N), N));
   end Nth_Ramanujan_Prime_Approx;

   --  ramanujan_primes.c: n_range_ramanujan_primes, Noe's algorithm.
   --  Containers isolate allocation from the SPARK arithmetic routines.
   function Index_Range (First, Last : U64)
      return Prime_Sieve.Prime_Vectors.Vector
     with SPARK_Mode => Off;
   function Index_Range (First, Last : U64)
      return Prime_Sieve.Prime_Vectors.Vector
   is
      subtype Vector is Prime_Sieve.Prime_Vectors.Vector;
      Lo : constant U64 := U64'Max (1, First);
      Result : Vector;
      Start, Stop, S : U64;
   begin
      if Lo > Last then
         return Result;
      end if;
      Result.Set_Length (Ada.Containers.Count_Type (Last - Lo + 1));
      for I in Lo .. U64'Min (Last, 23) loop
         Result.Replace_Element (Natural (I - Lo), Ram_Small (Positive (I)));
      end loop;
      if Last <= 23 then
         return Result;
      end if;
      Start := U64'Max (15, Ram_Lower_Value (Lo) - 1);
      Stop := Ram_Upper_Value (Last) + 1;
      S := Count.Prime_Count (Start - 1) -
        Count.Prime_Count ((Start - 1) / 2);
      declare
         Half : constant Vector :=
           Prime_Sieve.Primes ((Start + 1) / 2, (Stop + 1) / 2);
         Qi : Natural := 0;
      begin
         --  Noe's count falls at twice a prime and rises at a prime.
         --  The last rise to each index is its Ramanujan prime.
         for P of Prime_Sieve.Primes (Start, Stop) loop
            while Qi < Natural (Half.Length) and then
              Half.Element (Qi) * 2 < P
            loop
               S := S - 1;
               Qi := Qi + 1;
            end loop;
            S := S + 1;
            if S >= Lo and then S <= Last then
               Result.Replace_Element (Natural (S - Lo), P);
            end if;
         end loop;
      end;
      return Result;
   end Index_Range;

   function Nth_Ramanujan_Prime (N : U64) return Int.Optional_U64
     with SPARK_Mode => Off
   is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (Defined => True, Value => Index_Range (N, N).First_Element);
   end Nth_Ramanujan_Prime;

   function Ramanujan_Prime_Count (N : U64) return U64
     with SPARK_Mode => Off
   is
      V : U64;
      Window : U64 := 20;
      First : U64;
   begin
      if N <= 241 then
         return Ram_Small_Count (N);
      end if;
      V := Count.Prime_Count (N) - Count.Prime_Count (N / 2);
      if N > 1_000_000_000 then
         Window := 320;
      end if;
      loop
         First := (if V <= Window then 1 else V - Window);
         declare
            Ps : constant Prime_Sieve.Prime_Vectors.Vector :=
              Index_Range (First, V + Window);
         begin
            if Ps.First_Element < N and then Ps.Last_Element > N then
               for I in Ps.First_Index + 1 .. Ps.Last_Index loop
                  if Ps.Element (I) > N then
                     return First + U64 (I) - 1;
                  end if;
               end loop;
            end if;
         end;
         Window := Window * 2;
      end loop;
   end Ramanujan_Prime_Count;

   function Ramanujan_Prime_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else High < Low then
         return 0;
      end if;
      return Ramanujan_Prime_Count (High) -
        (if Low <= 2 then 0 else Ramanujan_Prime_Count (Low - 1));
   end Ramanujan_Prime_Count;

   function Is_Ramanujan_Prime (N : U64) return Boolean is
   begin
      if Primality.Is_Prime (N) = 0 then
         return False;
      elsif N <= 241 then
         return (for some P of Ram_Small => P = N);
      end if;
      return Nth_Ramanujan_Prime (Ramanujan_Prime_Count (N)).Value = N;
   end Is_Ramanujan_Prime;

   function Ramanujan_Primes (Low, High : U64)
      return Prime_Sieve.Prime_Vectors.Vector
     with SPARK_Mode => Off
   is
      Result : Prime_Sieve.Prime_Vectors.Vector;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      declare
         Ps : constant Prime_Sieve.Prime_Vectors.Vector := Index_Range
           (Ramanujan_Prime_Count_Lower (Low),
            Ramanujan_Prime_Count_Upper (High));
      begin
         for P of Ps loop
            if P >= Low and then P <= High then
               Result.Append (P);
            end if;
         end loop;
      end;
      return Result;
   end Ramanujan_Primes;

   function Ramanujan_Primes (High : U64)
      return Prime_Sieve.Prime_Vectors.Vector
     is (Ramanujan_Primes (0, High)) with SPARK_Mode => Off;

   Max_Twin : constant U64 := 18_446_744_073_709_550_771;
   Max_Twin_Index : constant U64 := 12_975_810_317_986_308;
   Max_Semi : constant U64 := 18_446_744_073_709_551_601;
   Max_Semi_Index : constant U64 := 1_701_748_900_850_019_777;
   Window : constant U64 := 1_000_000;
   Twin_Steps : constant array (Natural range <>) of U64 :=
     [58980, 48427, 45485, 43861, 42348,
      41457, 40908, 39984, 39640, 39222,
      373059, 353109, 341253, 332437, 326131,
      320567, 315883, 312511, 309244, 2963535,
      2822103, 2734294, 2673728, 2626243, 2585752,
      2554015, 2527034, 2501469, 24096420, 23046519,
      22401089, 21946975, 21590715, 21300632, 21060884,
      20854501, 20665634, 199708605, 191801047, 186932018,
      183404596, 180694619, 178477447, 176604059, 174989299,
      173597482, 1682185723, 1620989842, 1583071291, 1555660927,
      1534349481, 1517031854, 1502382532, 1489745250, 1478662752,
      14364197903, 13879821868, 13578563641, 13361034187, 13191416949,
      13053013447, 12936030624, 12835090276, 12746487898, 124078078589,
      120182602778, 117753842540, 115995331742, 114622738809, 113499818125,
      112551549250, 111732637241, 111012321565, 1082549061370, 1050759497170,
      1030883829367, 1016473645857, 1005206830409, 995980796683, 988183329733,
      981441437376, 975508027029, 9527651328494, 9264843314051, 9100153493509,
      8980561036751, 8886953365929, 8810223086411, 8745329823109,
      8689179566509,
      8639748641098, 84499489470819, 82302056642520, 80922166953330,
      79918799449753,
      79132610984280, 78487688897426, 77941865286827, 77469296499217,
      77053075040105,
      754527610498466, 735967887462370, 724291736697048];

   function Twin_Primes (Low, High : U64) return Family_Vectors.Vector
     with SPARK_Mode => Off
   is
      Result : Family_Vectors.Vector;
      Last : constant U64 := U64'Min (High, Max_Twin);
      Lo, Hi, Previous : U64;
   begin
      if Low > Last then
         return Result;
      end if;
      Lo := Low;
      loop
         Hi := Lo + U64'Min (Last - Lo, Window - 1);
         Previous := 0;
         for P of Math_Prime_Util.Sieve.Primes (Lo, Hi + 2) loop
            if Previous >= 3 and then Previous >= Lo and then
               Previous <= Hi
              and then P - Previous = 2
            then
               Result.Append (Previous);
            end if;
            Previous := P;
         end loop;
         exit when Hi = Last;
         Lo := Hi + 1;
      end loop;
      return Result;
   end Twin_Primes;

   function Twin_Primes (High : U64) return Family_Vectors.Vector is
     (Twin_Primes (0, High)) with SPARK_Mode => Off;

   function Twin_Prime_Count (Low, High : U64) return U64
     with SPARK_Mode => Off
   is
      Last : constant U64 := U64'Min (High, Max_Twin);
      Lo : U64 := Low;
      Hi, Sum : U64 := 0;
      Base : U64 := 10_000_000;
      Step : Natural := 0;
   begin
      if Lo > Last then
         return 0;
      end if;
      --  twin_prime_count_range: consume MPU's disjoint decade steps.
      if Lo <= 3 then
         for E in 0 .. 11 loop
            for M in U64 range 1 .. (if E = 11 then 4 else 9) loop
               exit when Last < M * Base;
               Sum := Sum + Twin_Steps (Step);
               Step := Step + 1;
               Lo := M * Base;
            end loop;
            exit when Last < Base or else E = 11;
            Base := Base * 10;
         end loop;
      end if;
      loop
         Hi := Lo + U64'Min (Last - Lo, Window - 1);
         Sum := Sum + U64 (Twin_Primes (Lo, Hi).Length);
         exit when Hi = Last;
         Lo := Hi + 1;
      end loop;
      return Sum;
   end Twin_Prime_Count;

   function Twin_Prime_Count (High : U64) return U64 is
     (Twin_Prime_Count (0, High))
     with SPARK_Mode => Off;

   subtype Wide is Long_Long_Float;
   package Wef is new Ada.Numerics.Generic_Elementary_Functions (Wide);

   --  real.c: positive Ei series, preserving C long-double evaluation.
   function Ei (X : Wide) return Wide with SPARK_Mode => On;
   function Ei (X : Wide) return Wide is
      Term : Wide := X;
      Sum : Wide := 0.577215664901532860606512090082402431
        + Wef.Log (X);
      Old : Wide;
   begin
      for K in 1 .. 1_000 loop
         Old := Sum;
         Sum := Sum + Term / Wide (K);
         exit when Sum = Old;
         Term := Term * X / Wide (K + 1);
      end loop;
      return Sum;
   end Ei;

   function Twin_Prime_Count_Approx (N : U64) return U64 is
      X : constant Wide := Wide (N);
      L, Li2, Fm : Wide;
   begin
      if N < 2_000 then
         return Twin_Prime_Count (N);
      end if;
      L := Wef.Log (X);
      --  Ei is an NV (double) API in MPU, including its argument.
      Li2 := Wide (F64 (Ei (Wide (F64 (L)))))
        + 2.8853900817779268147198494
        - X / L;
      if N < 32_000_000 then
         if N < 4_000 then
            Fm := 0.2952;
         elsif N < 8_000 then
            Fm := 0.3102;
         elsif N < 16_000 then
            Fm := 0.3090;
         elsif N < 32_000 then
            Fm := 0.3096;
         elsif N < 64_000 then
            Fm := 0.3097;
         elsif N < 128_000 then
            Fm := 0.3094;
         elsif N < 256_000 then
            Fm := 0.3099;
         elsif N < 600_000 then
            Fm := 0.3098 + (X - 256_000.0) *
              (0.3056 - 0.3098) / (600_000.0 - 256_000.0);
         elsif N < 1_000_000 then
            Fm := 0.3062 + (X - 600_000.0) *
              (0.3042 - 0.3062) / (1_000_000.0 - 600_000.0);
         elsif N < 4_000_000 then
            Fm := 0.3067 + (X - 1_000_000.0) *
              (0.3041 - 0.3067) / (4_000_000.0 - 1_000_000.0);
         elsif N < 16_000_000 then
            Fm := 0.3041 + (X - 4_000_000.0) *
              (0.2983 - 0.3041) / (16_000_000.0 - 4_000_000.0);
         else
            Fm := 0.2983 + (X - 16_000_000.0) *
              (0.2961 - 0.2983) / (32_000_000.0 - 16_000_000.0);
         end if;
         Li2 := Li2 * Fm * Wef.Log (12.0 + L);
      end if;
      return U64 (Wide'Floor
        (1.32032363169373914785562422 * Li2 + 0.5));
   end Twin_Prime_Count_Approx;

   --  inverse_interpolate: binary refinement of a monotone estimate.
   --  Return the first x with f(x) = N, or the lower side of a jump.
   function Inverse_Estimate (Low, High, N : U64; Twin : Boolean)
      return U64 with SPARK_Mode => On;
   function Inverse_Estimate (Low, High, N : U64; Twin : Boolean)
      return U64 is
      Lo : U64 := Low;
      Hi : U64 := High;
      Mid, R : U64;
      function Value (X : U64) return U64 is
        (if Twin then Twin_Prime_Count_Approx (X)
         else
            Semiprime_Count_Approx (X));
   begin
      if Value (Lo) = N then
         return Lo;
      end if;
      while Hi - Lo > 1 loop
         Mid := Lo + (Hi - Lo) / 2;
         R := Value (Mid);
         if R >= N then
            Hi := Mid;
         else
            Lo := Mid;
         end if;
      end loop;
      return (if Value (Hi) > N then Lo else Hi);
   end Inverse_Estimate;

   function Nth_Twin_Prime_Approx (N : U64) return Int.Optional_U64 is
      X : constant F64 := F64 (N);
      V, Dlo, Dhi : F64;
      Lo, Hi : U64;
   begin
      if N < 6 then
         return Nth_Twin_Prime (N);
      elsif N >= Max_Twin_Index then
         return (True, Max_Twin);
      end if;
      V := X * Log (X) * Log (X);
      Dlo := 0.9 * V;
      Dhi := (if N >= 10 ** 16 then 1.04 * V
              elsif N >= 10 ** 13 then
                 1.10 * V
              elsif N >= 10 ** 7 then
                 1.31 * V
              elsif N >= 1_200 then
                 1.70 * V else 2.30 * V + 5.0);
      Lo := (if Dlo >= F64 (Max_Twin) then Max_Twin else Trunc (Dlo));
      Hi := (if Dhi >= F64 (Max_Twin) then Max_Twin else Trunc (Dhi));
      if Lo >= Hi or else Twin_Prime_Count_Approx (Hi) < N then
         return (True, Max_Twin);
      end if;
      return (True, Inverse_Estimate (Lo, Hi, N, True));
   end Nth_Twin_Prime_Approx;

   function Nth_Twin_Prime (N : U64) return Int.Optional_U64
     with SPARK_Mode => Off
   is
      Small_Twins : constant array (Positive range 1 .. 5) of U64 :=
        [3, 5, 11, 17, 29];
      Lo : U64 := 0;
      Hi, C : U64 := 0;
      Bound : U64;
   begin
      if N = 0 or else N > Max_Twin_Index then
         return (Defined => False);
      elsif N <= 5 then
         return (True, Small_Twins (Positive (N)));
      end if;
      Bound := Nth_Twin_Prime_Approx (N).Value;
      Bound := Bound + U64'Min (Max_Twin - Bound, Bound / 10 + 800);
      loop
         Hi := Lo + U64'Min (Bound - Lo, Window - 1);
         declare
            V : constant Family_Vectors.Vector := Twin_Primes (Lo, Hi);
         begin
            if U64 (V.Length) >= N - C then
               return (True, V.Element (Natural (N - C - 1)));
            end if;
            C := C + U64 (V.Length);
         end;
         exit when Hi = Max_Twin;
         Lo := Hi + 1;
         if Lo > Bound then
            Bound := Bound + U64'Min (Max_Twin - Bound, Window);
         end if;
      end loop;
      return (Defined => False);
   end Nth_Twin_Prime;

   --  semi_primes.c: _range_semiprime_count_iterate, using a bounded
   --  trial membership test in place of factor.c: is_semiprime.
   --  A composite with at least three prime factors has one <= cbrt (N).
   function Semi_Member (N : U64) return Boolean
     with SPARK_Mode => On, Pre => N >= 4;
   function Semi_Member (N : U64) return Boolean is
      Limit : constant U64 := Int.Rootint (N, 3);
      D : U64 := 3;
   begin
      if N mod 2 = 0 then
         return Primality.Is_Prime (N / 2) /= 0;
      elsif Primality.Is_Prime (N) /= 0 then
         return False;
      end if;
      while D <= Limit loop
         if N mod D = 0 then
            --  The first divisor is prime. Its cofactor must be prime.
            return Primality.Is_Prime (N / D) /= 0;
         end if;
         D := D + 2;
      end loop;
      return True;
   end Semi_Member;

   --  range_semiprime_sieve: count factors from p*p, then from 2*p*p.
   --  Saturating at two is sufficient: only entries equal to one survive.
   function Semi_Window (Low, High : U64) return Family_Vectors.Vector
     with SPARK_Mode => Off;
   function Semi_Window (Low, High : U64) return Family_Vectors.Vector
     with SPARK_Mode => Off
   is
      type Marker is range 0 .. 2;
      type Marker_Array is array (Natural range <>) of Marker;
      Marks : Marker_Array (0 .. Natural (High - Low)) := [others => 0];
      Result : Family_Vectors.Vector;
      procedure Mark (Start, Stride : U64);
      procedure Mark (Start, Stride : U64) is
         J : U64 := Start;
         R : U64;
      begin
         if J < Low then
            R := Low mod Stride;
            J := Low;
            if R /= 0 then
               if Stride - R > High - Low then
                  return;
               end if;
               J := Low + Stride - R;
            end if;
         end if;
         while J <= High loop
            Marks (Natural (J - Low)) :=
              Marker'Min (2, Marks (Natural (J - Low)) + 1);
            exit when High - J < Stride;
            J := J + Stride;
         end loop;
      end Mark;
   begin
      --  Avoid a square-root-sized prime list for small native ranges.
      if High - Low < 100 and then High > 1_000_000_000 then
         for N in Low .. High loop
            if Semi_Member (N) then
               Result.Append (N);
            end if;
         end loop;
         return Result;
      end if;
      for P of Math_Prime_Util.Sieve.Primes (Int.Sqrtint (High)) loop
         Mark (P * P, P);
         if P * P <= High / 2 then
            Mark (2 * P * P, P * P);
         end if;
      end loop;
      for I in Marks'Range loop
         if Marks (I) = 1 then
            Result.Append (Low + U64 (I));
         end if;
      end loop;
      return Result;
   end Semi_Window;

   function Semi_Primes (Low, High : U64) return Family_Vectors.Vector
     with SPARK_Mode => Off
   is
      Lo : U64 := U64'Min (Max_Semi, U64'Max (4, Low));
      Last : constant U64 := U64'Min (High, Max_Semi);
      Hi : U64;
      Result : Family_Vectors.Vector;
   begin
      if Low > Last or else Lo > Last then
         return Result;
      end if;
      loop
         Hi := Lo + U64'Min (Last - Lo, Window - 1);
         Result.Append (Semi_Window (Lo, Hi));
         exit when Hi = Last;
         Lo := Hi + 1;
      end loop;
      return Result;
   end Semi_Primes;

   function Semi_Primes (High : U64) return Family_Vectors.Vector is
     (Semi_Primes (0, High)) with SPARK_Mode => Off;

   function Semiprime_Count (High : U64) return U64
     with SPARK_Mode => Off
   is
      Sum, Index : U64 := 0;
   begin
      for P of Math_Prime_Util.Sieve.Primes (Int.Sqrtint (High)) loop
         Sum := Sum + Count.Prime_Count (High / P) - Index;
         Index := Index + 1;
      end loop;
      return Sum;
   end Semiprime_Count;

   function Semiprime_Count (Low, High : U64) return U64
     with SPARK_Mode => Off
   is
      Lo : U64 := U64'Max (4, Low);
      Last : constant U64 := U64'Min (High, Max_Semi);
      Hi, Sum : U64 := 0;
   begin
      if Low > Last or else Lo > Last then
         return 0;
      end if;
      if High <= 40_000_000_000_000 and then Low <= 4 then
         return Semiprime_Count (High);
      end if;
      loop
         Hi := Lo + U64'Min (Last - Lo, Window - 1);
         Sum := Sum + U64 (Semi_Window (Lo, Hi).Length);
         exit when Hi = Last;
         Lo := Hi + 1;
      end loop;
      return Sum;
   end Semiprime_Count;

   function Semiprime_Count_Approx (N : U64) return U64 is
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
         2557200000.0, 53032001000.0, 1151076796431.0,
         20416501389724.0, 165815501587300.0, 953038830319448.0,
         20019396133340433.0, 192558867109258424.0,
         1757883874953032448.0];
      Min_Count : constant array (Natural range 0 .. 15) of U64 :=
        [82, 195, 2485, 31446, 906319, 11741185, 72840337, 398702652,
         7538564737, 150382042176, 2482510001499, 19204997230933,
         106211451717048, 2094735089989940, 19282342825922188,
         168996486318315136];
      X : constant F64 := F64 (N);
      L : Natural := 3;
      Logn, Loglogn, Value : F64;
      Series : F64 := 0.0;
      Den, Fact : F64 := 1.0;
      Res : U64;
   begin
      if N <= 623 then
         return Semiprime_Count (N);
      end if;
      Logn := Log (X);
      Loglogn := Log (Logn);
      while L <= 17 and then X >= Cross (L - 3) loop
         L := L + 1;
      end loop;
      for I in 1 .. L loop
         Series := Series + Fact * (Loglogn / Den);
         Series := Series + C (I - 1) / Den;
         Den := Den * Logn;
         Fact := Fact * F64 (I);
      end loop;
      Value := (X / Logn) * Series;
      --  C evaluates the final +0.5L in extended precision.
      Res := U64 (Long_Long_Float'Floor (Long_Long_Float (Value) + 0.5));
      return U64'Min (Max_Semi_Index, U64'Max (Res, Min_Count (L - 3)));
   end Semiprime_Count_Approx;

   function Nth_Semiprime_Approx (N : U64) return Int.Optional_U64
     with SPARK_Mode => Off
   is
      X : constant F64 := F64 (N);
      L1, L2, L3, L4, El, Em, Eh, Factor, Blend, Est : F64;
      Lo, Hi : U64;
   begin
      if N = 0 or else N > Max_Semi_Index then
         return (Defined => False);
      elsif N = Max_Semi_Index then
         return (True, Max_Semi);
      elsif N <= 190 then
         declare
            V : constant Family_Vectors.Vector := Semi_Primes (623);
         begin
            return (True, V.Element (Natural (N - 1)));
         end;
      end if;
      L1 := Log (X);
      L2 := Log (L1);
      L3 := Log (L2);
      L4 := Log (L3);
      El := 1.000 - 0.00018216088 * L1 + 0.18099609886 * L2
        - 0.51962474356 * L3 - 0.01136143381 * L4;
      Em := 0.968 - 0.00073297945 * L1 + 0.09731690314 * L2
        - 0.25212500749 * L3 - 0.01366795346 * L4;
      Eh := 0.968 - 0.00008034109 * L1 + 0.01522628393 * L2
        - 0.04020257367 * L3 - 0.01266447175 * L4;
      if N <= 2 ** 26 then
         Factor := El;
      elsif N < 2 ** 27 then
         Blend := (X - 67108864.0) / 67108864.0;
         Factor := (1.0 - Blend) * El + Blend * Em;
      elsif L1 <= 31.88477030575 then
         Factor := Em;
      elsif L1 < 32.57791748632 then
         Blend := (X - 70368744177664.0) / 70368744177664.0;
         Factor := (1.0 - Blend) * Em + Blend * Eh;
      else
         Factor := Eh;
      end if;
      Est := Factor * X * L1 / L2;
      if Est >= F64 (Max_Semi) then
         return (True, Max_Semi);
      end if;
      Lo := Trunc (0.979 * Est - 5.0);
      Hi := (if 1.03 * Est >= F64 (Max_Semi) then Max_Semi
             else
                Trunc (1.03 * Est));
      return (True, Inverse_Estimate (Lo, Hi, N, False));
   end Nth_Semiprime_Approx;

   function Nth_Semiprime (N : U64) return Int.Optional_U64
     with SPARK_Mode => Off
   is
      Guess, C, Lo, Hi : U64;
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      if N <= 190 then
         return Nth_Semiprime_Approx (N);
      end if;
      Guess := Nth_Semiprime_Approx (N).Value;
      C := Semiprime_Count (Guess);
      if C < N then
         Lo := Guess + 1;
         loop
            Hi := Lo + Window - 1;
            declare
               V : constant Family_Vectors.Vector := Semi_Primes (Lo, Hi);
            begin
               if U64 (V.Length) >= N - C then
                  return (True, V.Element (Natural (N - C - 1)));
               end if;
               C := C + U64 (V.Length);
            end;
            Lo := Hi + 1;
         end loop;
      else
         Hi := Guess;
         loop
            Lo := (if Hi >= Window then Hi - Window + 1 else 4);
            declare
               V : constant Family_Vectors.Vector := Semi_Primes (Lo, Hi);
            begin
               if C - U64 (V.Length) < N then
                  return (True, V.Element
                    (Natural (N - (C - U64 (V.Length)) - 1)));
               end if;
               C := C - U64 (V.Length);
            end;
            Hi := Lo - 1;
         end loop;
      end if;
   end Nth_Semiprime;
   --  powerfree.c: range Mobius values, using an Eratosthenes sieve.
   --  Two marks an untouched prime candidate; final values are -1, 0, 1.
   type Mu_Value is range -2 .. 2 with Size => 8;
   package Mu_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Mu_Value);
   package Mertens_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Integer);
   package Wide_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Int.I128);
   use type Int.I128;
   use type U128;

   function Mobius_Table (Limit : U64) return Mu_Vectors.Vector;
   function Mobius_Table (Limit : U64) return Mu_Vectors.Vector is
      M : Mu_Vectors.Vector;
      J, Square : U64;
   begin
      M.Set_Length (Ada.Containers.Count_Type (Limit + 1));
      for I in 0 .. Natural (Limit) loop
         M (I) := 2;
      end loop;
      M (0) := 0;
      if Limit >= 1 then
         M (1) := 1;
      end if;
      for P in U64 range 2 .. Limit loop
         if M (Natural (P)) = 2 then
            J := P;
            while J <= Limit loop
               if M (Natural (J)) = 2 then
                  M (Natural (J)) := -1;
               else
                  M (Natural (J)) := -M (Natural (J));
               end if;
               exit when J > Limit - P;
               J := J + P;
            end loop;
            if P <= Limit / P then
               Square := P * P;
               J := Square;
               while J <= Limit loop
                  M (Natural (J)) := 0;
                  exit when J > Limit - Square;
                  J := J + Square;
               end loop;
            end if;
         end if;
      end loop;
      return M;
   end Mobius_Table;

   function Is_Powerful (N : U64; K : U64 := 2) return Boolean is
      F : Factor.Factor_List;
      I, J : Natural;
   begin
      if N <= 1 then
         return N = 1;
      elsif K <= 1 then
         return True;
      elsif K >= 64 then
         return False;
      end if;
      F := Factor.Factor (N);
      I := 1;
      while I <= F.Count loop
         J := I + 1;
         while J <= F.Count and then F.Value (J) = F.Value (I) loop
            J := J + 1;
         end loop;
         if U64 (J - I) < K then
            return False;
         end if;
         I := J;
      end loop;
      return True;
   end Is_Powerful;

   function Is_Powerfree (N : U64; K : Powerfree_Exponent := 2)
      return Boolean
   is
      F : Factor.Factor_List;
      I, J : Natural;
   begin
      if N <= 1 or else K < 2 then
         return N = 1;
      elsif K >= 64 then
         return True;
      end if;
      F := Factor.Factor (N);
      I := 1;
      while I <= F.Count loop
         J := I + 1;
         while J <= F.Count and then F.Value (J) = F.Value (I) loop
            J := J + 1;
         end loop;
         if U64 (J - I) >= K then
            return False;
         end if;
         I := J;
      end loop;
      return True;
   end Is_Powerfree;

   function Squarefree_Kernel (N : U64) return U64 is
      F : constant Factor.Factor_List := Factor.Factor (N);
      P : U64 := 1;
   begin
      for I in 1 .. F.Count loop
         if I = 1 or else F.Value (I) /= F.Value (I - 1) then
            P := P * F.Value (I);
         end if;
      end loop;
      return P;
   end Squarefree_Kernel;

   function Powerfree_Part (N : U64; K : Powerfree_Exponent := 2)
      return U64
   is
      F : Factor.Factor_List;
      P : U64 := 1;
      I, J : Natural;
   begin
      if N <= 1 or else K < 2 then
         return (if N = 1 then 1 else 0);
      elsif K >= 64 then
         return N;
      end if;
      F := Factor.Factor (N);
      I := 1;
      while I <= F.Count loop
         J := I + 1;
         while J <= F.Count and then F.Value (J) = F.Value (I) loop
            J := J + 1;
         end loop;
         P := P * F.Value (I) ** Natural (U64 (J - I) mod K);
         I := J;
      end loop;
      return P;
   end Powerfree_Part;

   --  powerful.c: _pcr. Canonical decomposition into a K-th power and
   --  pairwise coprime squarefree bases at exponents K+1 .. 2*K-1.
   function Powerful_Rec
     (N, K, Product, R : U64; Mu : Mu_Vectors.Vector) return U64;
   function Powerful_Rec
     (N, K, Product, R : U64; Mu : Mu_Vectors.Vector) return U64
   is
      Limit : constant U64 := Int.Rootint (N / Product, R);
      Sum : U64 := 0;
   begin
      if R = K then
         return Limit;
      end if;
      for I in U64 range 1 .. Limit loop
         if Mu (Natural (I)) /= 0 and then Int.Gcd (Product, I) = 1 then
            Sum := Sum + Powerful_Rec
              (N, K, Product * I ** Natural (R), R - 1, Mu);
         end if;
      end loop;
      return Sum;
   end Powerful_Rec;

   function Powerful_Count (N : U64; K : U64 := 2) return U64 is
   begin
      if N <= 1 or else K <= 1 then
         return N;
      elsif K >= 64 then
         return 1;
      end if;
      declare
         Mu : constant Mu_Vectors.Vector :=
           Mobius_Table (Int.Rootint (N, K + 1));
      begin
         return Powerful_Rec (N, K, 1, 2 * K - 1, Mu);
      end;
   end Powerful_Count;

   function Nth_Powerful (N : U64; K : U64 := 2)
      return Int.Optional_U64
   is
      Power : constant U64 := (if K = 0 then 2 else K);
      Low : U64 := 1;
      High : U64 := N;
      Mid : U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 or else Power = 1 then
         return (True, N);
      elsif Power >= 64 then
         return (Defined => False);
      end if;
      --  Bracket by doubling rather than depending on floating estimates.
      while Powerful_Count (High, Power) < N loop
         if High = U64'Last then
            return (Defined => False);
         end if;
         High := (if High > U64'Last / 2 then U64'Last else High * 2);
      end loop;
      declare
         Mu : constant Mu_Vectors.Vector :=
           Mobius_Table (Int.Rootint (High, Power + 1));
      begin
         while Low < High loop
            Mid := Low + (High - Low) / 2;
            if Powerful_Rec (Mid, Power, 1, 2 * Power - 1, Mu) < N then
               Low := Mid + 1;
            else
               High := Mid;
            end if;
         end loop;
      end;
      return (True, Low);
   end Nth_Powerful;

   function Triangular (N : U64) return U128;
   function Triangular (N : U64) return U128 is
     (U128 (N) * (U128 (N) + 1) / 2);

   function Power_Sum (N, R : U64) return U128;
   function Power_Sum (N, R : U64) return U128 is
      V : constant U128 := U128 (N);
      Sum : U128 := 0;
   begin
      if R = 1 then
         return Triangular (N);
      elsif R = 2 then
         return V * (V + 1) * (2 * V + 1) / 6;
      elsif R = 3 then
         return Triangular (N) ** 2;
      end if;
      for I in U64 range 1 .. N loop
         Sum := Sum + U128 (I) ** Natural (R);
      end loop;
      return Sum;
   end Power_Sum;

   function Powerful_Sum_Rec
     (N, K, Product, R : U64; Mu : Mu_Vectors.Vector) return U128;
   function Powerful_Sum_Rec
     (N, K, Product, R : U64; Mu : Mu_Vectors.Vector) return U128
   is
      Limit : constant U64 := Int.Rootint (N / Product, R);
      Sum : U128 := 0;
   begin
      if R = K then
         return U128 (Product) * Power_Sum (Limit, R);
      end if;
      for I in U64 range 1 .. Limit loop
         if Mu (Natural (I)) /= 0 and then Int.Gcd (Product, I) = 1 then
            Sum := Sum + Powerful_Sum_Rec
              (N, K, Product * I ** Natural (R), R - 1, Mu);
         end if;
      end loop;
      return Sum;
   end Powerful_Sum_Rec;

   function Sumpowerful (N : U64; K : U64 := 2) return U128 is
      Power : constant U64 := (if K = 0 then 2 else K);
   begin
      if N <= 1 then
         return U128 (N);
      elsif Power = 1 then
         return Triangular (N);
      elsif Power >= 64 then
         return 1;
      end if;
      declare
         Mu : constant Mu_Vectors.Vector :=
           Mobius_Table (Int.Rootint (N, Power + 1));
      begin
         return Powerful_Sum_Rec (N, Power, 1, 2 * Power - 1, Mu);
      end;
   end Sumpowerful;

   function Powerful_Numbers (Low, High : U64; K : U64 := 2)
      return Family_Vectors.Vector
   is
      Result : Family_Vectors.Vector;
      procedure Generate (Product, R : U64);
      procedure Generate (Product, R : U64) is
         First : U64 := 1;
         Last : constant U64 := Int.Rootint (High / Product, R);
      begin
         if R = K then
            if Low > Product then
               First := Int.Crootint
                 (Low / Product + (if Low mod Product = 0 then 0 else 1), R);
            end if;
            for I in First .. Last loop
               Result.Append (Product * I ** Natural (R));
            end loop;
         else
            for I in U64 range 1 .. Last loop
               if Int.Gcd (Product, I) = 1 and then Is_Powerfree (I) then
                  Generate (Product * I ** Natural (R), R - 1);
               end if;
            end loop;
         end if;
      end Generate;
      package Sorting is new Family_Vectors.Generic_Sorting;
      V : U64 := U64'Max (Low, 1);
   begin
      if V > High then
         return Result;
      elsif K <= 1 or else High - V < 100 then
         loop
            if Is_Powerful (V, K) then
               Result.Append (V);
            end if;
            exit when V = High;
            V := V + 1;
         end loop;
      elsif K >= 64 then
         if V = 1 then
            Result.Append (U64'(1));
         end if;
      else
         Generate (1, 2 * K - 1);
         Sorting.Sort (Result);
      end if;
      return Result;
   end Powerful_Numbers;

   function Powerful_Numbers (High : U64) return Family_Vectors.Vector is
     (Powerful_Numbers (1, High, 2));

   --  powerfree.c: squarefree_count, the split Mobius/Mertens algorithm.
   --  D <= 50,860,970 on U64, avoiding a sieve through sqrt(U64'Last).
   function Squarefree_Count (N : U64) return U64;
   function Squarefree_Count (N : U64) return U64 is
      I, D, Xi, L : U64;
      Mert : Integer := 0;
      M : Mertens_Vectors.Vector;
      Mx : Wide_Vectors.Vector;
      S1 : Int.I128 := Int.I128 (N);
      Mxi, Mxi_Sum : Int.I128 := 0;
   begin
      if N < 4 then
         return N;
      end if;
      I := Int.Rootint (N, 5);
      D := Int.Sqrtint (N / I);
      M.Set_Length (Ada.Containers.Count_Type (D + 1));
      M (0) := 0;
      declare
         Mu : constant Mu_Vectors.Vector := Mobius_Table (D);
      begin
         for J in U64 range 1 .. D loop
            if J >= 2 and then Mu (Natural (J)) /= 0 then
               S1 := S1 + Int.I128 (Mu (Natural (J))) *
                 Int.I128 (N / (J * J));
            end if;
            Mert := Mert + Integer (Mu (Natural (J)));
            M (Natural (J)) := Mert;
         end loop;
      end;
      Mx.Set_Length (Ada.Containers.Count_Type (I + 1));
      for A in reverse U64 range 1 .. I - 1 loop
         Mxi := 1;
         Xi := Int.Sqrtint (N / A);
         L := Int.Sqrtint (Xi);
         for J in U64 range 1 .. Xi / (L + 1) loop
            Mxi := Mxi - Int.I128 (M (Natural (J))) *
              Int.I128 (Xi / J - Xi / (J + 1));
         end loop;
         for J in U64 range 2 .. L loop
            Mxi := Mxi -
              (if Xi / J <= D then Int.I128 (M (Natural (Xi / J)))
               else Mx (Natural (J * J * A)));
         end loop;
         Mx (Natural (A)) := Mxi;
         Mxi_Sum := Mxi_Sum + Mxi;
      end loop;
      return U64 (S1 + Mxi_Sum - Int.I128 (I - 1) * Int.I128 (Mert));
   end Squarefree_Count;

   function Free_Count
     (N, K : U64; Mu : Mu_Vectors.Vector) return U64;
   function Free_Count
     (N, K : U64; Mu : Mu_Vectors.Vector) return U64
   is
      Sum : Int.I128 := Int.I128 (N);
   begin
      for I in U64 range 2 .. Int.Rootint (N, K) loop
         if Mu (Natural (I)) /= 0 then
            Sum := Sum + Int.I128 (Mu (Natural (I))) *
              Int.I128 (N / I ** Natural (K));
         end if;
      end loop;
      return U64 (Sum);
   end Free_Count;

   function Powerfree_Count (N : U64; K : Powerfree_Exponent := 2)
      return U64
   is
   begin
      if K < 2 then
         return (if N = 0 then 0 else 1);
      elsif K >= 64 or else N < 4 then
         return N;
      elsif K = 2 then
         return Squarefree_Count (N);
      end if;
      return Free_Count (N, K, Mobius_Table (Int.Rootint (N, K)));
   end Powerfree_Count;

   function Powerfree_Sum (N : U64; K : Powerfree_Exponent := 2)
      return U128
   is
      Sum : Int.I128 := Int.I128 (Triangular (N));
   begin
      if K < 2 then
         return (if N = 0 then 0 else 1);
      elsif K >= 64 or else N < 4 then
         return U128 (Sum);
      end if;
      declare
         Mu : constant Mu_Vectors.Vector :=
           Mobius_Table (Int.Rootint (N, K));
         Power : U64;
      begin
         for I in U64 range 2 .. Int.Rootint (N, K) loop
            if Mu (Natural (I)) /= 0 then
               Power := I ** Natural (K);
               Sum := Sum + Int.I128 (Mu (Natural (I))) *
                 Int.I128 (Power) * Int.I128 (Triangular (N / Power));
            end if;
         end loop;
      end;
      return U128 (Sum);
   end Powerfree_Sum;

   function Powerfree_Part_Sum (N : U64; K : Powerfree_Exponent := 2)
      return U128
   is
      Sum : Int.I128 := Int.I128 (Triangular (N));
      P : Int.I128;
      F : Factor.Factor_List;
   begin
      if K < 2 then
         return (if N = 0 then 0 else 1);
      elsif K >= 64 or else N < 4 then
         return U128 (Sum);
      end if;
      for I in U64 range 2 .. Int.Rootint (N, K) loop
         F := Factor.Factor (I);
         P := 1;
         for J in 1 .. F.Count loop
            if J = 1 or else F.Value (J) /= F.Value (J - 1) then
               P := P * (1 - Int.I128 (F.Value (J) ** Natural (K)));
            end if;
         end loop;
         Sum := Sum + P * Int.I128 (Triangular (N / I ** Natural (K)));
      end loop;
      return U128 (Sum);
   end Powerfree_Part_Sum;

   function Nth_Powerfree (N : U64; K : Powerfree_Exponent := 2)
      return Int.Optional_U64
   is
      Low : U64 := N;
      High : U64 := (if N > U64'Last / 2 then U64'Last else 2 * N);
      Mid : U64;
   begin
      if N = 0 or else K < 2 then
         return (Defined => False);
      elsif N < 4 or else K >= 64 then
         return (True, N);
      end if;
      --  Density is >= 1/zeta(2) > 1/2. Reuse the sieve for inversion.
      if K = 2 and then High > 10_000_000_000_000 then
         if Powerfree_Count (High, K) < N then
            return (Defined => False);
         end if;
         while Low < High loop
            Mid := Low + (High - Low) / 2;
            if Powerfree_Count (Mid, K) < N then
               Low := Mid + 1;
            else
               High := Mid;
            end if;
         end loop;
      else
         declare
            Mu : constant Mu_Vectors.Vector :=
              Mobius_Table (Int.Rootint (High, K));
         begin
            if Free_Count (High, K, Mu) < N then
               return (Defined => False);
            end if;
            while Low < High loop
               Mid := Low + (High - Low) / 2;
               if Free_Count (Mid, K, Mu) < N then
                  Low := Mid + 1;
               else
                  High := Mid;
               end if;
            end loop;
         end;
      end if;
      return (True, Low);
   end Nth_Powerfree;
end Math_Prime_Util.Families;
