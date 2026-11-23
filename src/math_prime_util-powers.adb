with Ada.Numerics.Generic_Elementary_Functions;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Powers with SPARK_Mode => Off is
   use type U128;

   subtype F64 is Long_Float;
   subtype Wide is Long_Long_Float;
   package Fmath is new Ada.Numerics.Generic_Elementary_Functions (F64);
   package Wmath is new Ada.Numerics.Generic_Elementary_Functions (Wide);

   Max_Prime : constant U64 := 18_446_744_073_709_551_557;
   Max_Prime_Idx : constant U64 := 425_656_284_035_217_743;
   Max_Perfect : constant U64 := 18_446_744_065_119_617_025;
   Max_Perfect_Idx : constant U64 := 4_297_615_581;
   Two_64 : constant U128 := U128 (2) ** 64;

   --  perfect_powers.c: _moebius. mu(k) for k in 0 .. 64.
   Mu : constant array (Natural range 0 .. 64) of Integer :=
     [0, 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1,
      0, -1, 0, -1, 0, 1, 1, -1, 0, 0, 1, 0, 0, -1, -1, -1,
      0, 1, 1, 1, 0, -1, 1, 1, 0, -1, -1, -1, 0, 0, 1, -1,
      0, 0, 0, 1, 0, -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0,
      0];

   function Log2_Floor (N : U128) return Natural is
      C : Natural := 0;
      V : U128 := N;
   begin
      if N = 0 then
         return 0;
      end if;
      while V > 1 loop
         V := V / 2;
         C := C + 1;
      end loop;
      return C;
   end Log2_Floor;

   function Log2_U64 (N : U64) return Natural is
     (Log2_Floor (U128 (N)));

   function Ctz (N : U64) return Natural is
      C : Natural := 0;
      V : U64 := N;
   begin
      while V mod 2 = 0 loop
         V := V / 2;
         C := C + 1;
      end loop;
      return C;
   end Ctz;

   function Try_Pow
     (Base : U128; Exp : Natural; Value : out U128) return Boolean
   is
      P : U128 := 1;
      B : U128 := Base;
      E : Natural := Exp;
   begin
      if Exp = 0 then
         Value := 1;
         return True;
      elsif Base = 0 then
         Value := 0;
         return True;
      end if;
      while E > 0 loop
         if E mod 2 = 1 then
            if P > U128'Last / B then
               Value := 0;
               return False;
            end if;
            P := P * B;
         end if;
         E := E / 2;
         if E > 0 then
            if B > U128'Last / B then
               Value := 0;
               return False;
            end if;
            B := B * B;
         end if;
      end loop;
      Value := P;
      return True;
   end Try_Pow;

   function Root_Floor (N : U128; K : Positive) return U128 is
      Lo : U128 := 0;
      Hi, Mid, P : U128;
      E : Natural;
   begin
      if K = 1 or else N <= 1 then
         return N;
      end if;
      E := Log2_Floor (N) / K + 1;
      if E >= 128 then
         Hi := N;
      else
         Hi := U128 (2) ** E;
         if Hi = 0 or else Hi > N then
            Hi := N;
         end if;
      end if;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         if not Try_Pow (Mid, K, P) or else P > N then
            Hi := Mid - 1;
         else
            Lo := Mid;
         end if;
      end loop;
      return Lo;
   end Root_Floor;

   function Power_Of_Two (K : Natural) return Boolean is
      V : Natural := K;
   begin
      if V = 0 then
         return False;
      end if;
      while V mod 2 = 0 loop
         V := V / 2;
      end loop;
      return V = 1;
   end Power_Of_Two;

   function Exponent_Of (N : U128; Root : out U128) return Natural is
      Best : Natural := 0;
      R, P : U128;
   begin
      Root := 0;
      if N <= 1 then
         Root := N;
         return 1;
      end if;
      if N <= U128 (U64'Last) then
         Best := Natural (Int.Is_Power_Exp (U64 (N)));
         if Best = 0 then
            return 0;
         end if;
         Root := U128 (Int.Rootint (U64 (N), U64 (Best)));
         return Best;
      end if;
      for K in 2 .. Log2_Floor (N) loop
         R := Root_Floor (N, K);
         if Try_Pow (R, K, P) and then P = N then
            Best := K;
            Root := R;
         end if;
      end loop;
      return Best;
   end Exponent_Of;

   function Magnitude (N : Int.I128) return U128 is
     (if N >= 0 then U128 (N) else U128 (-(N + 1)) + 1);

   function To_I128 (N : U128) return Int.I128 is
     (Int.I128 (N));

   function Wide (N : Int.I128) return Optional_Wide is
     ((Defined => True, Value => N));

   function Trunc_U64 (X : F64) return U64 is
   begin
      if X <= 0.0 then
         return 0;
      elsif X >= 2.0 ** 64 then
         return U64'Last;
      end if;
      return U64 (F64'Floor (X));
   end Trunc_U64;

   function Trunc_Wide (X : F64) return Int.I128 is
      Limit : constant F64 := 2.0 ** 80;
   begin
      if X <= 0.0 then
         return 0;
      elsif X >= Limit then
         return Int.I128'Last;
      end if;
      return Int.I128 (F64'Floor (X));
   end Trunc_Wide;

   function Divide_Out (N : U64; P : U64) return Prime_Power_Root is
      M : U64 := N;
      Exp : U64 := 0;
   begin
      while M mod P = 0 loop
         M := M / P;
         Exp := Exp + 1;
      end loop;
      if M /= 1 then
         return (0, 0);
      end if;
      return (Exp, P);
   end Divide_Out;

   function Prime_Power_Root (N : U64) return Prime_Power_Root is
      Exp, Root : U64;
   begin
      if N < 2 then
         return (0, 0);
      end if;
      if (N and 1) = 0 then
         if (N and (N - 1)) /= 0 then
            return (0, 0);
         end if;
         return (U64 (Ctz (N)), 2);
      elsif N mod 3 = 0 then
         return Divide_Out (N, 3);
      elsif N mod 5 = 0 then
         return Divide_Out (N, 5);
      elsif N mod 7 = 0 then
         return Divide_Out (N, 7);
      elsif Primality.Is_Prob_Prime (N) /= 0 then
         return (1, N);
      end if;
      Exp := Int.Is_Power_Exp (N);
      if Exp = 0 then
         return (0, 0);
      end if;
      Root := Int.Rootint (N, Exp);
      if Primality.Is_Prob_Prime (Root) /= 0 then
         return (Exp, Root);
      end if;
      return (0, 0);
   end Prime_Power_Root;

   function Is_Prime_Power (N : U64) return U64 is
     (Prime_Power_Root (N).Exponent);

   function Next_Prime_Power (N : U64) return Optional_Wide is
      Bit, I : U64;
   begin
      if N < 2 then
         return Wide (2);
      elsif N >= Max_Prime then
         return Wide (To_I128 (Two_64));
      end if;
      Bit := U64 (2) ** Log2_U64 (N);
      I := N + 1 + (N and 1);
      while (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return Wide (Int.I128 (I));
         end if;
         exit when I > U64'Last - 2;
         I := I + 2;
      end loop;
      if (I and Bit) = 0 then
         return Wide (Int.I128 (I - 1));
      end if;
      return Wide (To_I128 (Two_64));
   end Next_Prime_Power;

   function Prev_Prime_Power (N : U64) return Int.Optional_U64 is
      M, Bit, I : U64;
   begin
      if N <= 2 then
         return (Defined => False);
      end if;
      M := N - 1;
      Bit := U64 (2) ** Log2_U64 (M);
      if (M and 1) = 0 then
         I := M - 1;
      else
         I := M;
      end if;
      while I >= 2 and then (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return (True, I);
         end if;
         I := I - 2;
      end loop;
      return (True, I + 1);
   end Prev_Prime_Power;

   function Less (Left, Right : U64) return Boolean is (Left < Right);

   procedure Sort_Powers (V : in out Power_Vectors.Vector) is
      package Sorting is new Power_Vectors.Generic_Sorting (Less);
   begin
      Sorting.Sort (V);
   end Sort_Powers;

   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector is
      Result : Power_Vectors.Vector;
      Scan : U64;
      I : U64;
      Pow : Int.Optional_U64;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      if High < 7_929_856 then
         Scan := 10;
      else
         Scan := Int.Sqrtint (High) / 256;
      end if;
      if High - Low < Scan then
         I := Low;
         loop
            if Is_Prime_Power (I) /= 0 then
               Result.Append (I);
            end if;
            exit when I = High;
            I := I + 1;
         end loop;
         return Result;
      end if;
      for K in 2 .. Log2_U64 (High) loop
         for P of Sieve.Primes (Int.Rootint (High, U64 (K))) loop
            Pow := Int.Powint (P, U64 (K));
            if Pow.Defined and then Pow.Value >= Low
              and then Pow.Value <= High
            then
               Result.Append (Pow.Value);
            end if;
         end loop;
      end loop;
      for P of Sieve.Primes (Low, High) loop
         Result.Append (P);
      end loop;
      Sort_Powers (Result);
      return Result;
   end Prime_Powers;

   function Prime_Powers (High : U64) return Power_Vectors.Vector is
     (Prime_Powers (0, High));

   function Sum_Counts
     (High : U64; Kind : Natural) return U64
   is
      Sum : U64;
   begin
      if High <= 5 then
         return (if High = 0 then 0 else High - 1);
      end if;
      case Kind is
         when 0 =>
            Sum := Count.Prime_Count (High);
         when 1 =>
            Sum := Count.Prime_Count_Lower (High);
         when 2 =>
            Sum := Count.Prime_Count_Upper (High);
         when others =>
            Sum := Count.Prime_Count_Approx (High);
      end case;
      for K in 2 .. Log2_U64 (High) loop
         declare
            R : constant U64 := Int.Rootint (High, U64 (K));
         begin
            case Kind is
               when 0 =>
                  Sum := Sum + Count.Prime_Count (R);
               when 1 =>
                  Sum := Sum + Count.Prime_Count_Lower (R);
               when 2 =>
                  Sum := Sum + Count.Prime_Count_Upper (R);
               when others =>
                  Sum := Sum + Count.Prime_Count_Approx (R);
            end case;
         end;
      end loop;
      return Sum;
   end Sum_Counts;

   function Prime_Power_Count (High : U64) return U64 is
     (Sum_Counts (High, 0));

   function Prime_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else High < Low then
         return 0;
      end if;
      return Prime_Power_Count (High)
        - (if Low <= 2 then 0 else Prime_Power_Count (Low - 1));
   end Prime_Power_Count;

   function Prime_Power_Count_Lower (High : U64) return U64 is
     (Sum_Counts (High, 1));

   function Prime_Power_Count_Upper (High : U64) return U64 is
     (Sum_Counts (High, 2));

   function Prime_Power_Count_Approx (High : U64) return U64 is
     (Sum_Counts (High, 3));

   type Probe is (Lower, Upper, Approx);

   function Probe_Count (Kind : Probe; X : U64) return U64 is
     (case Kind is
         when Lower => Prime_Power_Count_Lower (X),
         when Upper => Prime_Power_Count_Upper (X),
         when Approx => Prime_Power_Count_Approx (X));

   --  inverse_interpolate.c: _linear_interpolate. Double division.
   function Linear (Lo, Hi, Rlo, Rhi, N : U64) return U64 is
      Rdiff : constant U64 := N - Rlo;
      Rspan : constant U64 := Rhi - Rlo;
      Xspan : constant U64 := Hi - Lo;
      Move : U64;
      Dmove : F64;
   begin
      if N = Rlo then
         return Lo + 1;
      elsif N = Rhi then
         return Hi - 1;
      end if;
      Dmove := F64 (Rdiff) * F64 (Xspan) / F64 (Rspan) + 0.5;
      if Dmove >= F64 (Xspan) then
         Move := Xspan;
      else
         Move := U64 (F64'Floor (Dmove));
      end if;
      if Move = 0 then
         return Lo + 1;
      elsif Move >= Xspan then
         return Hi - 1;
      end if;
      return Lo + Move;
   end Linear;

   function Bracket_End (Lo, Hi, Rlo, Rhi, N : U64) return U64 is
     (if Rlo = N or else (Rlo < N and then Rhi > N) then Lo else Hi);

   --  inverse_interpolate.c: inverse_interpolate, both ends supplied.
   function Inverse
     (Kind : Probe; Bound_Lo, Bound_Hi, N, Threshold : U64) return U64
   is
      Lo : U64 := Bound_Lo;
      Hi : U64 := Bound_Hi;
      Mid, Rlo, Rhi, Rmid : U64;
      X0, X1, X3, Rx1, Rx3, Tmp, Close : U64;
      Iloop : Natural := 1;
      D0, D1, D2, Den, Sgn, Prod : F64;
      Pos : Wide;
      Delta : U64;
   begin
      Mid := Lo + (Hi - Lo) / 2;
      Rmid := Probe_Count (Kind, Mid);
      if Rmid >= N then
         Hi := Mid;
         Rhi := Rmid;
         Rlo := Probe_Count (Kind, Lo);
         if Rlo = N then
            return Lo;
         end if;
      else
         Lo := Mid;
         Rlo := Rmid;
         Rhi := Probe_Count (Kind, Hi);
      end if;
      if Hi - Lo <= 1 then
         return Bracket_End (Lo, Hi, Rlo, Rhi, N);
      end if;

      Mid := Linear (Lo, Hi, Rlo, Rhi, N);
      while Hi - Lo > 1 and then Rhi > N loop
         Rmid := Probe_Count (Kind, Mid);
         if Rmid >= N then
            Hi := Mid;
            Rhi := Rmid;
         else
            Lo := Mid;
            Rlo := Rmid;
         end if;
         exit when Rhi = N or else Hi - Lo <= 1;
         Mid := Linear (Lo, Hi, Rlo, Rhi, N);
         if Iloop mod 6 = 0 then
            Close := Trunc_U64 (0.003 * F64 (Hi - Lo) + 1.0);
            if Close > 0 and then Lo + Close > Mid then
               Mid := Lo + Close;
            elsif Close > 0 and then Hi > Close
              and then Hi - Close < Mid
            then
               Mid := Hi - Close;
            end if;
         end if;
         if Mid <= Lo then
            Mid := Lo + 1;
         elsif Mid >= Hi then
            Mid := Hi - 1;
         end if;
         Iloop := Iloop + 1;
      end loop;
      if Rlo = N then
         return Lo;
      elsif Hi - Lo <= 1 then
         return Bracket_End (Lo, Hi, Rlo, Rhi, N);
      end if;

      while Hi - Lo > 8
        and then (Hi - Lo > Threshold or else Rhi > N)
      loop
         X0 := Lo;
         X1 := Lo + (Hi - Lo) / 2;
         Rx1 := Probe_Count (Kind, X1);
         D0 := F64 (N - Rlo);
         if Rx1 >= N then
            D1 := F64 (Rx1 - N);
         else
            D1 := F64 (N - Rx1);
         end if;
         D2 := F64 (Rhi - N + 1);
         Den := D1 * D1 + D0 * D2;
         Sgn := (if Rx1 >= N then 1.0 else -1.0);
         if Den <= 0.0 then
            X3 := X1;
         else
            Prod := F64 (X1 - X0) * D1;
            Pos := Wide (Sgn * Prod) / Wmath.Sqrt (Wide (Den));
            if Pos >= 0.0 then
               Pos := Pos + 0.5;
               Delta := U64 (Wide'Floor (Pos));
               if Delta >= X1 then
                  X3 := 0;
               else
                  X3 := X1 - Delta;
               end if;
            else
               Pos := -(Pos - 0.5);
               Delta := U64 (Wide'Floor (Pos));
               if Delta > U64'Last - X1 then
                  X3 := U64'Last;
               else
                  X3 := X1 + Delta;
               end if;
            end if;
         end if;
         if X3 >= Hi or else X3 <= Lo or else X3 = X1 then
            if Rx1 >= N then
               Hi := X1;
               Rhi := Rx1;
            else
               Lo := X1;
               Rlo := Rx1;
            end if;
         else
            Rx3 := Probe_Count (Kind, X3);
            if Rx1 > Rx3 then
               Tmp := X1;
               X1 := X3;
               X3 := Tmp;
               Tmp := Rx1;
               Rx1 := Rx3;
               Rx3 := Tmp;
            end if;
            if Rx1 >= N then
               Hi := X1;
               Rhi := Rx1;
            elsif Rx3 >= N then
               Lo := X1;
               Rlo := Rx1;
               Hi := X3;
               Rhi := Rx3;
            else
               Lo := X3;
               Rlo := Rx3;
            end if;
         end if;
         exit when Lo >= Hi;
      end loop;

      while Hi > Lo and then Hi - Lo > 1
        and then (Hi - Lo > Threshold or else Rhi > N)
      loop
         Mid := Lo + (Hi - Lo) / 2;
         if Probe_Count (Kind, Mid) < N then
            Lo := Mid;
         else
            Hi := Mid;
         end if;
      end loop;
      return Hi;
   end Inverse;

   function Simple_Lower (N : U64) return U64 is
      V : F64;
   begin
      if N <= 100 then
         return N + 1;
      end if;
      V := 0.98 * F64 (Count.Nth_Prime_Lower (N)) - 400.0;
      return Trunc_U64 (V);
   end Simple_Lower;

   function Raw_Lower (N : U64) return U64 is
   begin
      if N = 0 then
         return 0;
      elsif N <= 7 then
         return N + 1 + N / 5;
      elsif N > Max_Prime_Idx then
         return Max_Prime;
      end if;
      return Inverse
        (Upper, Simple_Lower (N), Count.Nth_Prime_Upper (N), N, 0);
   end Raw_Lower;

   function Raw_Upper (N : U64) return U64 is
   begin
      if N = 0 then
         return 0;
      elsif N <= 7 then
         return N + 1 + N / 5;
      elsif N > Max_Prime_Idx then
         return Max_Prime;
      end if;
      return Inverse
        (Lower, Simple_Lower (N), Count.Nth_Prime_Upper (N), N, 0);
   end Raw_Upper;

   function Raw_Approx (N : U64) return U64 is
   begin
      if N = 0 then
         return 0;
      elsif N <= 7 then
         return N + 1 + N / 5;
      elsif N > Max_Prime_Idx then
         return Max_Prime;
      end if;
      return Inverse
        (Approx, Simple_Lower (N), Count.Nth_Prime_Upper (N), N, 0);
   end Raw_Approx;

   function Some (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False) else (True, N));

   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64 is
     (Some (Raw_Lower (N)));

   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64 is
     (Some (Raw_Upper (N)));

   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64 is
     (Some (Raw_Approx (N)));

   --  inverse_interpolate.c: interpolate_with_approx, fis = is_prime_power.
   function Raw_Nth (N : U64) return U64 is
      Tol : constant U64 := 800;
      Approx : U64;
      Guess, Count, Ming, Maxg, Adjust, Span, Step : U64;
      Gn : Natural;
      Approx_Count : U64;
      Below : Boolean;
   begin
      if N = 0 then
         return 0;
      elsif N <= 7 then
         return N + 1 + N / 5;
      elsif N > Max_Prime_Idx then
         return Max_Prime;
      end if;
      Approx := Raw_Approx (N);
      Guess := Approx;
      Ming := 0;
      Maxg := U64'Last;
      Count := 0;
      Gn := 2;
      while Gn < 20 loop
         Count := Prime_Power_Count (Guess);
         exit when Count = N
           or else (N > Count and then N - Count < Tol)
           or else (Count > N and then Count - N < Tol);
         Approx_Count := Raw_Approx (Count);
         if Count <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx >= Approx_Count then
            Adjust := Approx - Approx_Count;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Approx_Count - Approx;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := Tol - 1;
            Below := Guess <= Ming;
            if Span <= 1 then
               Guess := (if Below then Maxg else Ming);
            elsif Step >= Span then
               Guess := Ming + Span / 2;
            elsif Below then
               Guess := Ming + Step;
            else
               Guess := Maxg - Step;
            end if;
         end if;
         Gn := Gn + 1;
      end loop;
      if Gn = 20 then
         Count := Prime_Power_Count (Guess);
      end if;
      if Count < N then
         while Count < N loop
            loop
               exit when Guess = U64'Last;
               Guess := Guess + 1;
               exit when Is_Prime_Power (Guess) /= 0;
            end loop;
            Count := Count + 1;
         end loop;
      else
         while Is_Prime_Power (Guess) = 0 loop
            exit when Guess = 0;
            Guess := Guess - 1;
         end loop;
         while Count > N loop
            loop
               exit when Guess <= 2;
               Guess := Guess - 1;
               exit when Is_Prime_Power (Guess) /= 0;
            end loop;
            Count := Count - 1;
         end loop;
      end if;
      return Guess;
   end Raw_Nth;

   function Nth_Prime_Power (N : U64) return Int.Optional_U64 is
     (Some (Raw_Nth (N)));

   function Next_Mag (N : U128; Odd_Only : Boolean) return U128 is
      Kinit, Kinc, K, Lim : Natural;
      Best : U128 := 0;
      Have : Boolean := False;
      R, C : U128;
   begin
      if N = 0 then
         return 1;
      elsif N = 1 then
         return (if Odd_Only then 8 else 4);
      end if;
      Kinit := (if Odd_Only then 3 else 2);
      Kinc := (if Odd_Only then 2 else 1);
      Lim := Log2_Floor (N) + 1;
      K := Kinit;
      while K <= Lim loop
         R := Root_Floor (N, K) + 1;
         if Try_Pow (R, K, C) and then C > N
           and then (not Have or else C < Best)
         then
            Best := C;
            Have := True;
         end if;
         K := K + Kinc;
      end loop;
      return (if Have then Best else 0);
   end Next_Mag;

   function Prev_Mag (N : U128; Odd_Only : Boolean) return U128 is
      Kinit, Kinc, K, Lim : Natural;
      Best : U128 := 8;
      R, C : U128;
   begin
      if N <= 4 then
         if N > 1 then
            return 1;
         else
            return 0;
         end if;
      elsif N <= 8 then
         return (if Odd_Only then 1 else 4);
      end if;
      Kinit := (if Odd_Only then 3 else 2);
      Kinc := (if Odd_Only then 2 else 1);
      Lim := Log2_Floor (N);
      K := Kinit;
      while K <= Lim loop
         R := Root_Floor (N, K);
         if Try_Pow (R, K, C) then
            if C >= N then
               if R = 0 then
                  C := 0;
               else
                  if not Try_Pow (R - 1, K, C) then
                     C := 0;
                  end if;
               end if;
            end if;
            if C > Best and then C < N then
               Best := C;
            end if;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Prev_Mag;

   function Is_Perfect_Power (N : Int.I128) return Boolean is
      Exp : Natural;
      Root : U128;
   begin
      if N >= -1 and then N <= 1 then
         return True;
      end if;
      Exp := Exponent_Of (Magnitude (N), Root);
      if N > 0 then
         return Exp > 1;
      end if;
      return Exp > 2 and then not Power_Of_Two (Exp);
   end Is_Perfect_Power;

   function Next_Perfect_Power (N : Int.I128) return Optional_Wide is
   begin
      if N >= 0 then
         return Wide (To_I128 (Next_Mag (U128 (N), False)));
      end if;
      return Wide (-To_I128 (Prev_Mag (Magnitude (N), True)));
   end Next_Perfect_Power;

   function Prev_Perfect_Power (N : Int.I128) return Optional_Wide is
   begin
      if N = 0 then
         return Wide (-1);
      elsif N > 0 then
         return Wide (To_I128 (Prev_Mag (U128 (N), False)));
      end if;
      return Wide (-To_I128 (Next_Mag (Magnitude (N), True)));
   end Prev_Perfect_Power;

   function Perfect_Power_Count (High : U64) return U64 is
      Acc : Int.I128 := 1;
      Term : U64;
   begin
      if High < 8 then
         return (if High >= 1 then 1 else 0)
           + (if High >= 4 then 1 else 0);
      end if;
      for K in 2 .. Log2_U64 (High) loop
         if Mu (K) /= 0 then
            Term := Int.Rootint (High, U64 (K)) - 1;
            Acc := Acc - Int.I128 (Mu (K)) * Int.I128 (Term);
         end if;
      end loop;
      return U64 (Acc);
   end Perfect_Power_Count;

   function Perfect_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 1 or else High < Low then
         return 0;
      end if;
      return Perfect_Power_Count (High)
        - (if Low <= 1 then 0 else Perfect_Power_Count (Low - 1));
   end Perfect_Power_Count;

   function Perfect_Power_Count_Lower (High : U64) return U64 is
     (Perfect_Power_Count (High));

   function Perfect_Power_Count_Upper (High : U64) return U64 is
     (Perfect_Power_Count (High));

   function Perfect_Power_Count_Approx (High : U64) return U64 is
     (Perfect_Power_Count (High));

   type Series_Kind is (C_Lower, C_Upper, C_Approx, PP_Lower);

   --  perfect_powers.c and PP.pm double series. Cap copies the C cast.
   function Series
     (N : U64; Kind : Series_Kind; Cap : Boolean) return Int.I128
   is
      X : constant F64 := F64 (N);
      Pp : F64;
   begin
      Pp := Fmath."**" (X, 2.0)
        + (13.0 / 3.0) * Fmath."**" (X, 4.0 / 3.0)
        + (32.0 / 15.0) * Fmath."**" (X, 16.0 / 15.0);
      Pp := Pp - 2.0 * Fmath."**" (X, 5.0 / 3.0)
        - 2.0 * Fmath."**" (X, 7.0 / 5.0)
        - 2.0 * Fmath."**" (X, 9.0 / 7.0)
        + 2.0 * Fmath."**" (X, 12.0 / 10.0);
      case Kind is
         when C_Lower | PP_Lower =>
            Pp := Pp - 2.0 * Fmath."**" (X, 13.0 / 11.0)
              - 2.0 * Fmath."**" (X, 15.0 / 13.0);
            Pp := Pp + (if Kind = C_Lower then 5.5 else 1.5);
         when C_Upper =>
            Pp := Pp + 2.0 * Fmath."**" (X, 16.0 / 14.0);
            Pp := Pp - 3.5;
         when C_Approx =>
            Pp := Pp - 2.0 * Fmath."**" (X, 13.0 / 11.0)
              - 2.0 * Fmath."**" (X, 15.0 / 13.0)
              + 2.0 * Fmath."**" (X, 16.0 / 14.0)
              + 2.0 * Fmath."**" (X, 17.0 / 15.0);
            Pp := Pp - 0.48 * Fmath."**" (X, 19.0 / 17.0);
            Pp := Pp - 1.5;
      end case;
      if Cap and then Pp >= 2.0 ** 64 then
         return Int.I128 (U64'Last);
      end if;
      return Trunc_Wide (Pp);
   end Series;

   function C_Bound (N : U64; Kind : Series_Kind) return Int.I128 is
   begin
      if N <= 1 then
         return Int.I128 (N);
      elsif N >= Max_Perfect_Idx then
         return Int.I128 (Max_Perfect);
      end if;
      return Series (N, Kind, True);
   end C_Bound;

   function PP_Bound (N : U64; Kind : Series_Kind) return Int.I128 is
     (Series (N, Kind, False));

   function Nth_Perfect_Power_Lower (N : U64) return Optional_Wide is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N > Max_Perfect_Idx then
         return Wide (PP_Bound (N, PP_Lower));
      end if;
      return Wide (C_Bound (N, C_Lower));
   end Nth_Perfect_Power_Lower;

   function Nth_Perfect_Power_Upper (N : U64) return Optional_Wide is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N > Max_Perfect_Idx then
         return Wide (PP_Bound (N, C_Upper));
      end if;
      return Wide (C_Bound (N, C_Upper));
   end Nth_Perfect_Power_Upper;

   function Nth_Perfect_Power_Approx (N : U64) return Optional_Wide is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N > Max_Perfect_Idx then
         return Wide (PP_Bound (N, C_Approx));
      end if;
      return Wide (C_Bound (N, C_Approx));
   end Nth_Perfect_Power_Approx;

   function Raw_Perfect_Approx (N : U64) return U64 is
      V : constant Int.I128 := C_Bound (N, C_Approx);
   begin
      if V <= 0 then
         return 0;
      elsif V >= Int.I128 (U64'Last) then
         return U64'Last;
      end if;
      return U64 (V);
   end Raw_Perfect_Approx;

   --  perfect_powers.c: nth_perfect_power. Count is exact and cheap.
   function Nth_Perfect_Power (N : U64) return Optional_Wide is
      Tol : constant U64 := 1_000;
      G : U128;
      Count, Guess, Adjust, Ming, Maxg, Span, Step : U64;
      Gn : Natural;
      Approx_N, Approx_C : U64;
      Below : Boolean;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 1 then
         return Wide (Int.I128 (N));
      elsif N >= Max_Perfect_Idx then
         G := U128 (Max_Perfect);
         declare
            Left : U64 := N - Max_Perfect_Idx;
         begin
            while Left > 0 loop
               G := Next_Mag (G, False);
               Left := Left - 1;
            end loop;
         end;
         return Wide (To_I128 (G));
      end if;
      Approx_N := Raw_Perfect_Approx (N);
      Guess := Approx_N;
      Ming := 0;
      Maxg := U64'Last;
      Count := 0;
      Gn := 2;
      while Gn < 20 loop
         Count := Perfect_Power_Count (Guess);
         exit when Count = N
           or else (N > Count and then N - Count < Tol)
           or else (Count > N and then Count - N < Tol);
         Approx_C := Raw_Perfect_Approx (Count);
         if Count <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_N >= Approx_C then
            Adjust := Approx_N - Approx_C;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Approx_C - Approx_N;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := Tol - 1;
            Below := Guess <= Ming;
            if Span <= 1 then
               Guess := (if Below then Maxg else Ming);
            elsif Step >= Span then
               Guess := Ming + Span / 2;
            elsif Below then
               Guess := Ming + Step;
            else
               Guess := Maxg - Step;
            end if;
         end if;
         Gn := Gn + 1;
      end loop;
      if Gn = 20 then
         Count := Perfect_Power_Count (Guess);
      end if;
      if Guess > Max_Perfect then
         Guess := Max_Perfect;
      end if;
      G := U128 (Guess);
      if Count >= N then
         G := Prev_Mag (G + 1, False);
         while Count > N loop
            G := Prev_Mag (G, False);
            Count := Count - 1;
         end loop;
      else
         while Count < N loop
            G := Next_Mag (G, False);
            Count := Count + 1;
         end loop;
      end if;
      return Wide (To_I128 (G));
   end Nth_Perfect_Power;
end Math_Prime_Util.Powers;
