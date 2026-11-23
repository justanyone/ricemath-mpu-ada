with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Long_Elementary_Functions;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Powers with SPARK_Mode => Off is
   use Ada.Numerics.Long_Elementary_Functions;
   use type Int.Optional_U64;

   Max_Prime : constant U64 := 18_446_744_073_709_551_557;
   Max_Prime_Index : constant U64 := 425_656_284_035_217_743;
   Max_Perfect_Pow : constant U64 := 18_446_744_065_119_617_025;
   Max_Perfect_Index : constant U64 := 4_297_615_581;

   --  perfect_powers.c: _moebius, exponents 0 .. 64.
   Moebius : constant array (0 .. 64) of Integer :=
     [0, 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1,
      0, -1, 0, -1, 0, 1, 1, -1, 0, 0, 1, 0, 0, -1, -1, -1,
      0, 1, 1, 1, 0, -1, 1, 1, 0, -1, -1, -1, 0, 0, 1, -1,
      0, 0, 0, 1, 0, -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0, 0];

   function Log2_Floor (N : U128) return Natural is
      X : U128 := N;
      C : Natural := 0;
   begin
      while X > 1 loop
         X := X / 2;
         C := C + 1;
      end loop;
      return C;
   end Log2_Floor;

   procedure Power
     (Base : U128; Exp : Natural; Value : out U128; Ok : out Boolean)
   is
      Result : U128 := 1;
      B : U128 := Base;
      E : Natural := Exp;
   begin
      while E > 0 loop
         if E mod 2 = 1 then
            if B /= 0 and then Result > U128'Last / B then
               Value := 0;
               Ok := False;
               return;
            end if;
            Result := Result * B;
         end if;
         E := E / 2;
         if E > 0 then
            if B /= 0 and then B > U128'Last / B then
               Value := 0;
               Ok := False;
               return;
            end if;
            B := B * B;
         end if;
      end loop;
      Value := Result;
      Ok := True;
   end Power;

   --  Floor K-th root. K >= 2. Exact for every value that fits in U128.
   function Root (N : U128; K : Positive) return U128 is
      Lo : U128 := 0;
      Hi : U128 := 2 ** 64 - 1;
      Mid, P : U128;
      Ok : Boolean;
   begin
      if K = 1 or else N <= 1 then
         return N;
      end if;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         Power (Mid, K, P, Ok);
         if not Ok or else P > N then
            Hi := Mid - 1;
         else
            Lo := Mid;
         end if;
      end loop;
      return Lo;
   end Root;

   function To_Signed (N : U128) return Int.I128 is
     (Int.I128 (N));

   function Magnitude (N : Int.I128) return U128 is
     (if N >= 0 then U128 (N) else U128 (-N));

   function Max_Exponent (N : U128) return Natural is
      Log2 : Natural;
      R, P : U128;
      Ok : Boolean;
   begin
      if N <= 1 then
         return 0;
      end if;
      Log2 := Log2_Floor (N);
      for K in reverse 2 .. Log2 loop
         R := Root (N, K);
         Power (R, K, P, Ok);
         if Ok and then P = N then
            return K;
         end if;
      end loop;
      return 0;
   end Max_Exponent;

   function Prime_Power (N : U64) return Prime_Factor is
      M : U64;
      Power : Natural;
      Exp : U64;
      Root_N : U64;
   begin
      if N < 2 then
         return (Found => False);
      end if;
      if (N and 1) = 0 then
         if (N and (N - 1)) /= 0 then
            return (Found => False);
         end if;
         Power := 0;
         M := N;
         while (M and 1) = 0 loop
            M := M / 2;
            Power := Power + 1;
         end loop;
         return (True, Power, 2);
      end if;
      for D in U64 range 3 .. 7 loop
         if D = 3 or else D = 5 or else D = 7 then
            if N mod D = 0 then
               M := N;
               Power := 0;
               while M > 1 and then M mod D = 0 loop
                  M := M / D;
                  Power := Power + 1;
               end loop;
               if M /= 1 then
                  return (Found => False);
               end if;
               return (True, Power, D);
            end if;
         end if;
      end loop;
      if Primality.Is_Prob_Prime (N) /= 0 then
         return (True, 1, N);
      end if;
      Exp := Int.Is_Power_Exp (N);
      if Exp > 1 then
         Root_N := Int.Rootint (N, Exp);
         if Primality.Is_Prob_Prime (Root_N) /= 0 then
            return (True, Natural (Exp), Root_N);
         end if;
      end if;
      return (Found => False);
   end Prime_Power;

   function Is_Prime_Power (N : U64) return Natural is
      Info : constant Prime_Factor := Prime_Power (N);
   begin
      return (if Info.Found then Info.Exponent else 0);
   end Is_Prime_Power;

   function Next_Prime_Power (N : U64) return U128 is
      Bit, I : U64;
   begin
      if N < 2 then
         return 2;
      elsif N >= Max_Prime then
         return 2 ** 64;
      end if;
      Bit := 2 ** Natural (Int.Logint (N, 2));
      I := N + 1 + (N and 1);
      while (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return U128 (I);
         end if;
         if I > U64'Last - 2 then
            return 2 ** 64;
         end if;
         I := I + 2;
      end loop;
      return U128 (I - 1);
   end Next_Prime_Power;

   function Prev_Prime_Power (N : U64) return Int.Optional_U64 is
      M, Bit, I : U64;
   begin
      if N <= 2 then
         return (Defined => False);
      end if;
      M := N - 1;
      Bit := 2 ** Natural (Int.Logint (M, 2));
      I := M - (if (M and 1) = 0 then 1 else 0);
      while (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return (True, I);
         end if;
         if I < 2 then
            exit;
         end if;
         I := I - 2;
      end loop;
      return (True, I + 1);
   end Prev_Prime_Power;

   procedure Sort_Values (V : in out Power_Vectors.Vector) is
      type Item_Array is array (Positive range <>) of U64;
      N : constant Natural := Natural (V.Length);
      A : Item_Array (1 .. N);
      Key : U64;
      J : Positive;
   begin
      if N <= 1 then
         return;
      end if;
      for I in A'Range loop
         A (I) := V.Element (V.First_Index + I - 1);
      end loop;
      for I in 2 .. N loop
         Key := A (I);
         J := I;
         while J > 1 and then A (J - 1) > Key loop
            A (J) := A (J - 1);
            J := J - 1;
         end loop;
         A (J) := Key;
      end loop;
      for I in A'Range loop
         V.Replace_Element (V.First_Index + I - 1, A (I));
      end loop;
   end Sort_Values;

   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector is
      Result, Powers : Power_Vectors.Vector;
      Limit : U64;
      Log2 : U64;
      Value : Int.Optional_U64;
      Scan : U64;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      Scan := (if High < 7_929_856 then 10
               else Int.Sqrtint (High) / 256);
      if High - Low < Scan then
         for N in Low .. High loop
            if Is_Prime_Power (N) /= 0 then
               Result.Append (N);
            end if;
         end loop;
         return Result;
      end if;
      Log2 := Int.Logint (High, 2);
      for K in U64 range 2 .. Log2 loop
         Limit := Int.Rootint (High, K);
         for P of Math_Prime_Util.Sieve.Primes (Limit) loop
            Value := Int.Powint (P, K);
            if Value.Defined and then Value.Value >= Low
              and then Value.Value <= High
            then
               Powers.Append (Value.Value);
            end if;
         end loop;
      end loop;
      Sort_Values (Powers);
      declare
         Primes : constant Sieve.Prime_Vectors.Vector :=
           Sieve.Primes (Low, High);
         Ip : Natural := Primes.First_Index;
         Iw : Natural := Powers.First_Index;
         Take_Prime : Boolean;
      begin
         while Ip <= Primes.Last_Index or else Iw <= Powers.Last_Index
         loop
            if Iw > Powers.Last_Index then
               Take_Prime := True;
            elsif Ip > Primes.Last_Index then
               Take_Prime := False;
            else
               Take_Prime := Primes.Element (Ip) < Powers.Element (Iw);
            end if;
            if Take_Prime then
               Result.Append (Primes.Element (Ip));
               Ip := Ip + 1;
            else
               Result.Append (Powers.Element (Iw));
               Iw := Iw + 1;
            end if;
         end loop;
      end;
      return Result;
   end Prime_Powers;

   function Prime_Powers (High : U64) return Power_Vectors.Vector is
     (Prime_Powers (0, High));

   type Bound is (Exact, Lower, Upper, Approx);

   function Bounded_Pi (N : U64; Kind : Bound) return U64 is
   begin
      case Kind is
         when Exact => return Count.Prime_Count (N);
         when Lower => return Count.Prime_Count_Lower (N);
         when Upper => return Count.Prime_Count_Upper (N);
         when Approx => return Count.Prime_Count_Approx (N);
      end case;
   end Bounded_Pi;

   function Power_Sum (High : U64; Kind : Bound) return U64 is
      Total : U128;
      Log2 : U64;
   begin
      if High <= 5 then
         return (if High = 0 then 0 else High - 1);
      end if;
      Total := U128 (Bounded_Pi (High, Kind));
      Log2 := Int.Logint (High, 2);
      for K in U64 range 2 .. Log2 loop
         Total := Total
           + U128 (Bounded_Pi (Int.Rootint (High, K), Kind));
      end loop;
      return U64 (Total);
   end Power_Sum;

   function Prime_Power_Count (High : U64) return U64 is
     (Power_Sum (High, Exact));

   function Prime_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else High < Low then
         return 0;
      end if;
      return Prime_Power_Count (High)
        - (if Low <= 2 then 0 else Prime_Power_Count (Low - 1));
   end Prime_Power_Count;

   function Prime_Power_Count_Lower (High : U64) return U64 is
     (Power_Sum (High, Lower));

   function Prime_Power_Count_Upper (High : U64) return U64 is
     (Power_Sum (High, Upper));

   function Prime_Power_Count_Approx (High : U64) return U64 is
     (Power_Sum (High, Approx));

   type Count_Fn is not null access function (X : U64) return U64;

   --  inverse_interpolate.c: inverse_interpolate, threshold zero.
   function Inverse (Low, High, Target : U64; Value : Count_Fn)
      return U64
   is
      package Ef is new Ada.Numerics.Generic_Elementary_Functions
        (Long_Float);
      Lo : U64 := Low;
      Hi : U64 := High;
      Mid, Rlo, Rhi, Rmid : U64;
      Iteration : Natural := 0;

      function Linear return U64 is
         Move : U64;
         D : Long_Float;
      begin
         if Target = Rlo then
            return Lo + 1;
         elsif Target = Rhi or else Rhi = Rlo then
            return Hi - 1;
         end if;
         D := Long_Float (Target - Rlo) * Long_Float (Hi - Lo)
           / Long_Float (Rhi - Rlo) + 0.5;
         Move := (if D >= Long_Float (Hi - Lo) then Hi - Lo
                  else U64 (Long_Float'Floor (D)));
         return (if Move = 0 then Lo + 1
                 elsif Move >= Hi - Lo then Hi - 1
                 else Lo + Move);
      end Linear;
   begin
      if Lo >= Hi then
         return Hi;
      end if;
      Mid := Lo + (Hi - Lo) / 2;
      Rmid := Value (Mid);
      if Rmid >= Target then
         Hi := Mid;
         Rhi := Rmid;
         Rlo := Value (Lo);
         if Rlo = Target then
            return Lo;
         end if;
      else
         Lo := Mid;
         Rlo := Rmid;
         Rhi := Value (Hi);
      end if;
      if Hi - Lo <= 1 then
         return (if Rlo = Target
                 or else (Rlo < Target and then Rhi > Target)
                 then Lo else Hi);
      end if;
      Mid := Linear;
      while Hi - Lo > 1 and then Rhi > Target loop
         Iteration := Iteration + 1;
         if Mid <= Lo or else Mid >= Hi then
            Mid := Lo + (Hi - Lo) / 2;
         end if;
         Rmid := Value (Mid);
         if Rmid >= Target then
            Hi := Mid;
            Rhi := Rmid;
         else
            Lo := Mid;
            Rlo := Rmid;
         end if;
         exit when Rhi = Target or else Hi - Lo <= 1;
         Mid := Linear;
         if Iteration mod 6 = 0 then
            declare
               Close : constant U64 :=
                 U64 (Long_Float'Floor
                   (0.003 * Long_Float (Hi - Lo) + 1.0));
            begin
               if Lo + Close > Mid then
                  Mid := Lo + Close;
               elsif Hi > Close and then Hi - Close < Mid then
                  Mid := Hi - Close;
               end if;
            end;
         end if;
         Mid := U64'Max (Lo + 1, U64'Min (Hi - 1, Mid));
      end loop;
      if Rlo = Target then
         return Lo;
      elsif Hi - Lo <= 1 then
         return (if Rlo < Target and then Rhi > Target then Lo else Hi);
      end if;
      while Hi - Lo > 8 loop
         declare
            X1 : U64 := Lo + (Hi - Lo) / 2;
            R1 : U64 := Value (X1);
            D0 : constant Long_Float := Long_Float (Target - Rlo);
            D1 : constant Long_Float :=
              Long_Float ((if R1 >= Target then R1 - Target
                           else Target - R1));
            D2 : constant Long_Float := Long_Float (Rhi - Target + 1);
            Sign : constant Long_Float :=
              (if R1 >= Target then 1.0 else -1.0);
            Den : constant Long_Float := D1 * D1 + D0 * D2;
            Pos : Long_Float;
            Move : U64;
            X3 : U64;
            R3, Temp : U64;
         begin
            if Den <= 0.0 then
               if R1 >= Target then
                  Hi := X1;
                  Rhi := R1;
               else
                  Lo := X1;
                  Rlo := R1;
               end if;
            else
               Pos := Sign * Long_Float (X1 - Lo) * D1 / Ef.Sqrt (Den);
               Move := U64 (Long_Float'Floor (abs Pos + 0.5));
               if Pos >= 0.0 then
                  X3 := (if Move >= X1 then Lo else X1 - Move);
               else
                  X3 := (if X1 > U64'Last - Move then Hi else X1 + Move);
               end if;
               if X3 >= Hi or else X3 <= Lo or else X3 = X1 then
                  if R1 >= Target then
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
                  if R1 >= Target then
                     Hi := X1;
                     Rhi := R1;
                  elsif R3 >= Target then
                     Lo := X1;
                     Rlo := R1;
                     Hi := X3;
                     Rhi := R3;
                  else
                     Lo := X3;
                     Rlo := R3;
                  end if;
               end if;
            end if;
         end;
      end loop;
      while Hi - Lo > 1 loop
         Mid := Lo + (Hi - Lo) / 2;
         if Value (Mid) < Target then
            Lo := Mid;
         else
            Hi := Mid;
         end if;
      end loop;
      return Hi;
   end Inverse;

   function Simple_Lower (N : U64) return U64 is
      V : Long_Float;
   begin
      if N <= 100 then
         return N + 1;
      end if;
      V := 0.98 * Long_Float (Count.Nth_Prime_Lower (N)) - 400.0;
      if V <= 2.0 then
         return 2;
      elsif V >= Long_Float (Max_Prime) then
         return Max_Prime;
      end if;
      return U64 (Long_Float'Floor (V));
   end Simple_Lower;

   function Small_Nth (N : U64) return U64 is
     (N + 1 + N / 5);

   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64 is
      Lo, Hi : U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      elsif N > Max_Prime_Index then
         return (True, Max_Prime);
      end if;
      Lo := Simple_Lower (N);
      Hi := Count.Nth_Prime_Upper (N);
      if Lo > Hi then
         Lo := Hi;
      end if;
      return (True, Inverse (Lo, Hi, N, Prime_Power_Count_Upper'Access));
   end Nth_Prime_Power_Lower;

   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64 is
      Lo, Hi : U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      elsif N > Max_Prime_Index then
         return (True, Max_Prime);
      end if;
      Lo := Simple_Lower (N);
      Hi := Count.Nth_Prime_Upper (N);
      if Lo > Hi then
         Lo := Hi;
      end if;
      return (True, Inverse (Lo, Hi, N, Prime_Power_Count_Lower'Access));
   end Nth_Prime_Power_Upper;

   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64 is
      Lo, Hi : U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      elsif N > Max_Prime_Index then
         return (True, Max_Prime);
      end if;
      Lo := Simple_Lower (N);
      Hi := Count.Nth_Prime_Upper (N);
      if Lo > Hi then
         Lo := Hi;
      end if;
      return (True,
        Inverse (Lo, Hi, N, Prime_Power_Count_Approx'Access));
   end Nth_Prime_Power_Approx;

   function Nth_Prime_Power (N : U64) return Int.Optional_U64 is
      Tol : constant U64 := 800;
      Guess, Count_N, Adjust, Approx_N, Approx_C : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Closed : Boolean := False;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      elsif N > Max_Prime_Index then
         return (True, Max_Prime);
      end if;
      Approx_N := Nth_Prime_Power_Approx (N).Value;
      Guess := Approx_N;
      Count_N := 0;
      for Step in 2 .. 19 loop
         Count_N := Prime_Power_Count (Guess);
         if N = Count_N
           or else (N > Count_N and then N - Count_N < Tol)
           or else (Count_N > N and then Count_N - N < Tol)
         then
            Closed := True;
            exit;
         end if;
         Approx_C := Nth_Prime_Power_Approx (Count_N).Value;
         if Count_N <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_N >= N and then Guess < Maxg then
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
            declare
               Span : constant U64 := Maxg - Ming;
               Step_Tol : constant U64 := Tol - 1;
               Below : constant Boolean := Guess <= Ming;
            begin
               if Span <= 1 then
                  Guess := (if Below then Maxg else Ming);
               elsif Step_Tol >= Span then
                  Guess := Ming + Span / 2;
               elsif Below then
                  Guess := Ming + Step_Tol;
               else
                  Guess := Maxg - Step_Tol;
               end if;
            end;
         end if;
         pragma Unreferenced (Step);
      end loop;
      if not Closed then
         Count_N := Prime_Power_Count (Guess);
      end if;
      if Count_N < N then
         while Count_N < N loop
            Guess := Guess + 1;
            while Is_Prime_Power (Guess) = 0 loop
               Guess := Guess + 1;
            end loop;
            Count_N := Count_N + 1;
         end loop;
      else
         while Is_Prime_Power (Guess) = 0 loop
            Guess := Guess - 1;
         end loop;
         while Count_N > N loop
            Guess := Guess - 1;
            while Is_Prime_Power (Guess) = 0 loop
               Guess := Guess - 1;
            end loop;
            Count_N := Count_N - 1;
         end loop;
      end if;
      return (True, Guess);
   end Nth_Prime_Power;

   --  perfect_powers.c: _next_perfect_power. Odd_Only selects exponent 3,5,...
   function Next_Mag (N : U128; Odd_Only : Boolean) return U128 is
      Kinit : constant Positive := (if Odd_Only then 3 else 2);
      Kinc : constant Positive := (if Odd_Only then 2 else 1);
      K : Positive;
      Log2 : Natural;
      R, C, Best : U128 := 0;
      Ok : Boolean;
      Have : Boolean := False;
   begin
      if N = 0 then
         return 1;
      elsif N = 1 then
         return (if Odd_Only then 8 else 4);
      end if;
      Log2 := Log2_Floor (N);
      R := Root (N, Kinit) + 1;
      Power (R, Kinit, Best, Ok);
      Have := Ok and then Best > N;
      if not Have then
         Best := U128'Last;
      end if;
      K := Kinit + Kinc;
      while K <= Log2 + 1 loop
         R := Root (N, K) + 1;
         Power (R, K, C, Ok);
         if Ok and then C > N and then C < Best then
            Best := C;
         end if;
         K := K + Kinc;
      end loop;
      if Best = U128'Last then
         return 0;
      end if;
      return Best;
   end Next_Mag;

   --  perfect_powers.c: _prev_perfect_power.
   function Prev_Mag (N : U128; Odd_Only : Boolean) return U128 is
      Kinit : constant Positive := (if Odd_Only then 3 else 2);
      Kinc : constant Positive := (if Odd_Only then 2 else 1);
      K : Positive;
      Log2 : Natural;
      R, C, Best : U128;
      Ok : Boolean;
   begin
      if N <= 4 then
         return (if N > 1 then 1 else 0);
      elsif N <= 8 then
         return (if Odd_Only then 1 else 4);
      end if;
      Log2 := Log2_Floor (N);
      Best := 8;
      K := Kinit;
      while K <= Log2 loop
         R := Root (N, K);
         Power (R, K, C, Ok);
         if Ok and then C >= N and then R > 0 then
            Power (R - 1, K, C, Ok);
         end if;
         if Ok and then C > Best and then C < N then
            Best := C;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Prev_Mag;

   function Is_Perfect_Power (N : Int.I128) return Boolean is
      K : Natural;
   begin
      if N < -1 then
         K := Max_Exponent (Magnitude (N));
         return K > 2 and then (K and (K - 1)) /= 0;
      elsif N <= 1 then
         return True;
      end if;
      return Max_Exponent (Magnitude (N)) > 1;
   end Is_Perfect_Power;

   function Next_Perfect_Power (N : Int.I128) return Optional_I128 is
   begin
      if N >= 0 then
         return (True, To_Signed (Next_Mag (Magnitude (N), False)));
      end if;
      return (True, -To_Signed (Prev_Mag (Magnitude (N), True)));
   end Next_Perfect_Power;

   function Prev_Perfect_Power (N : Int.I128) return Optional_I128 is
   begin
      if N = 0 then
         return (True, -1);
      elsif N > 0 then
         return (True, To_Signed (Prev_Mag (Magnitude (N), False)));
      end if;
      return (True, -To_Signed (Next_Mag (Magnitude (N), True)));
   end Prev_Perfect_Power;

   function Perfect_Power_Count (High : U64) return U64 is
      Sum : Int.I128 := 1;
      Log2 : Natural;
      R : U64;
   begin
      if High < 8 then
         return (if High >= 4 then 2 elsif High >= 1 then 1 else 0);
      end if;
      Log2 := Natural (Int.Logint (High, 2));
      for K in 2 .. Log2 loop
         if Moebius (K) /= 0 then
            R := Int.Rootint (High, U64 (K));
            Sum := Sum - Int.I128 (Moebius (K)) * Int.I128 (R - 1);
         end if;
      end loop;
      return U64 (Sum);
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

   type Estimate is (Lower, Upper, Approx);

   --  perfect_powers.c: nth_perfect_power_lower/upper/approx double series.
   function Perfect_Estimate (N : U64; Kind : Estimate) return U64 is
      X : constant Long_Float := Long_Float (N);
      PP : Long_Float;
   begin
      PP := X * X
        + (13.0 / 3.0) * X ** (4.0 / 3.0)
        + (32.0 / 15.0) * X ** (16.0 / 15.0);
      PP := PP - 2.0 * X ** (5.0 / 3.0) - 2.0 * X ** (7.0 / 5.0)
        - 2.0 * X ** (9.0 / 7.0) + 2.0 * X ** (12.0 / 10.0);
      case Kind is
         when Lower =>
            PP := PP - 2.0 * X ** (13.0 / 11.0)
              - 2.0 * X ** (15.0 / 13.0);
            PP := PP + 5.5;
         when Upper =>
            PP := PP + 2.0 * X ** (16.0 / 14.0);
            PP := PP - 3.5;
         when Approx =>
            PP := PP - 2.0 * X ** (13.0 / 11.0)
              - 2.0 * X ** (15.0 / 13.0)
              + 2.0 * X ** (16.0 / 14.0)
              + 2.0 * X ** (17.0 / 15.0);
            PP := PP - 0.48 * X ** (19.0 / 17.0);
            PP := PP - 1.5;
      end case;
      if PP >= Long_Float (U64'Last) then
         return U64'Last;
      elsif PP <= 0.0 then
         return 0;
      end if;
      return U64 (Long_Float'Floor (PP));
   end Perfect_Estimate;

   function Nth_Perfect_Power_Lower (N : U64) return Optional_I128 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 1 then
         return (True, Int.I128 (N));
      elsif N >= Max_Perfect_Index then
         return (True, Int.I128 (Max_Perfect_Pow));
      end if;
      return (True, Int.I128 (Perfect_Estimate (N, Lower)));
   end Nth_Perfect_Power_Lower;

   function Nth_Perfect_Power_Upper (N : U64) return Optional_I128 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 1 then
         return (True, Int.I128 (N));
      elsif N >= Max_Perfect_Index then
         return (True, Int.I128 (Max_Perfect_Pow));
      end if;
      return (True, Int.I128 (Perfect_Estimate (N, Upper)));
   end Nth_Perfect_Power_Upper;

   function Nth_Perfect_Power_Approx (N : U64) return Optional_I128 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 1 then
         return (True, Int.I128 (N));
      elsif N >= Max_Perfect_Index then
         return (True, Int.I128 (Max_Perfect_Pow));
      end if;
      return (True, Int.I128 (Perfect_Estimate (N, Approx)));
   end Nth_Perfect_Power_Approx;

   function Nth_Perfect_Power (N : U64) return Optional_I128 is
      Tol : constant U64 := 1_000;
      Guess, Count_N, Adjust, Approx_N, Approx_C : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Closed : Boolean := False;
      Step_N : U128;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 1 then
         return (True, Int.I128 (N));
      elsif N >= Max_Perfect_Index then
         return (True, Int.I128 (Max_Perfect_Pow));
      end if;
      Approx_N := U64 (Nth_Perfect_Power_Approx (N).Value);
      Guess := Approx_N;
      Count_N := 0;
      for Step in 2 .. 19 loop
         Count_N := Perfect_Power_Count (Guess);
         if N = Count_N
           or else (N > Count_N and then N - Count_N < Tol)
           or else (Count_N > N and then Count_N - N < Tol)
         then
            Closed := True;
            exit;
         end if;
         Approx_C := U64 (Nth_Perfect_Power_Approx (Count_N).Value);
         if Count_N <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_N >= N and then Guess < Maxg then
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
            declare
               Span : constant U64 := Maxg - Ming;
               Step_Tol : constant U64 := Tol - 1;
               Below : constant Boolean := Guess <= Ming;
            begin
               if Span <= 1 then
                  Guess := (if Below then Maxg else Ming);
               elsif Step_Tol >= Span then
                  Guess := Ming + Span / 2;
               elsif Below then
                  Guess := Ming + Step_Tol;
               else
                  Guess := Maxg - Step_Tol;
               end if;
            end;
         end if;
         pragma Unreferenced (Step);
      end loop;
      if not Closed then
         Count_N := Perfect_Power_Count (Guess);
      end if;
      if Guess > Max_Perfect_Pow then
         Guess := Max_Perfect_Pow;
      end if;
      if Count_N >= N then
         Step_N := Prev_Mag (U128 (Guess) + 1, False);
         Guess := U64 (Step_N);
         while Count_N > N loop
            Step_N := Prev_Mag (U128 (Guess), False);
            Guess := U64 (Step_N);
            Count_N := Count_N - 1;
         end loop;
      else
         while Count_N < N loop
            Step_N := Next_Mag (U128 (Guess), False);
            Guess := U64 (Step_N);
            Count_N := Count_N + 1;
         end loop;
      end if;
      return (True, Int.I128 (Guess));
   end Nth_Perfect_Power;
end Math_Prime_Util.Powers;
