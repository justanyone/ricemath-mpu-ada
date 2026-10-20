with Ada.Numerics.Long_Elementary_Functions;

package body Math_Prime_Util.Families is
   use Ada.Numerics.Long_Elementary_Functions;
   use Lucky_Vectors;
   subtype F64 is Long_Float;
   Max_Lucky : constant U64 := 18_446_744_073_709_551_517;
   Small : constant array (Natural range 0 .. 47) of U64 :=
     (1, 3, 7, 9, 13, 15, 21, 25, 31, 33, 37, 43, 49, 51, 63, 67,
      69, 73, 75, 79, 87, 93, 99, 105, 111, 115, 127, 129, 133, 135,
      141, 151, 159, 163, 169, 171, 189, 193, 195, 201, 205, 211,
      219, 223, 231, 235, 237, 241);
   Mask : constant array (Natural range 0 .. 64) of Boolean :=
     (True, True, False, True, True, False, True, True, False,
      True, True, False, True, True, False, True, True, False,
      False, False, False, True, True, False, True, True, False,
      False, False, False, True, True, False, True, True, False,
      True, True, False, False, False, False, True, True, False,
      True, True, False, True, True, False, True, True, False,
      True, True, False, False, False, False, False, False, False,
      True, True);

   function Trunc (X : F64) return U64 is
     (U64 (F64'Floor (X)));

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
   function Sieve (N : U64) return Vector is
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
   end Sieve;

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

   function Simple_Lower (N : U64) return U64 is
   begin
      if N <= 9_000 then
         return Trunc (1.028 * F64 (N) / Log (F64 (N)) - 1.0);
      end if;
      return Trunc (0.99 * F64 (Simple_Approx (N)));
   end Simple_Lower;

   type Estimate_Kind is (Approx, Lower, Upper);
   function Estimate (N : U64; Kind : Estimate_Kind) return U64 is
     (case Kind is
         when Approx => Nth_Lucky_Approx (N).Value,
         when Lower => Nth_Lucky_Lower (N).Value,
         when Upper => Nth_Lucky_Upper (N).Value);

   --  inverse_interpolate.c: inverse_interpolate, zero threshold.
   function Invert (Low, High, N : U64; Kind : Estimate_Kind) return U64 is
      Lo : U64 := Low;
      Hi : U64 := High;
      Mid, Rlo, Rhi, Rmid : U64;
      Iteration : Natural := 0;

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
      Count : U64 := N / 2 + N mod 2;
      V : constant Vector := Sieve (1 + Lucky_Count_Upper (N));
   begin
      for J in 1 .. V.Last_Index loop
         exit when V.Element (J) > Count;
         Count := Count - Count / V.Element (J);
      end loop;
      return Count;
   end Lucky_Count;

   function Lucky_Count (Low, High : U64) return U64 is
   begin
      if Low > High then
         return 0;
      end if;
      return Lucky_Count (High) -
        (if Low = 0 then 0 else Lucky_Count (Low - 1));
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
      Start : Natural := 1;
      Limit : U64 := 600;
      Factor : U64 := 6;
   begin
      if N mod 2 = 0 or else N mod 6 = 5
        or else not Mask (Natural (N mod 63)) or else N > Max_Lucky
      then
         return False;
      end if;
      loop
         declare
            V : constant Vector := Sieve (Limit);
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
         Limit := Limit * Factor;
         Factor := Factor + 1;
      end loop;
   end Is_Lucky;
end Math_Prime_Util.Families;
