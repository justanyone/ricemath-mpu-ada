with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Long_Elementary_Functions;
with Interfaces;
with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Powers is
   use type U128;
   use type Int.Optional_U64;
   package Prime_Sieve renames Math_Prime_Util.Sieve;
   subtype F64 is Long_Float;

   --  perfect_powers.c: _moebius, exponents 0 .. 64.
   Moebius : constant array (Natural range 0 .. 64) of Integer :=
     [0, 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1,
      0, -1, 0, -1, 0, 1, 1, -1, 0, 0, 1, 0, 0, -1, -1, -1,
      0, 1, 1, 1, 0, -1, 1, 1, 0, -1, -1, -1, 0, 0, 1, -1,
      0, 0, 0, 1, 0, -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0, 0];

   function Trunc (X : F64) return U64 is
     (U64 (F64'Floor (X)));

   function High_Bit (N : U64) return U64 is
     (Interfaces.Shift_Left (U64'(1), Natural (Int.Logint (N, 2))));

   function Log2 (N : U128) return Natural is
      Count_Bits : Natural := 0;
      Rest : U128 := N;
   begin
      if N > 0 and then N <= U128 (U64'Last) then
         return Natural (Int.Logint (U64 (N), 2));
      end if;
      while Rest > 1 loop
         Rest := Rest / 2;
         Count_Bits := Count_Bits + 1;
      end loop;
      return Count_Bits;
   end Log2;

   function Multiply (Left, Right : U128; Product : out U128)
      return Boolean is
   begin
      if Left /= 0 and then Right > U128'Last / Left then
         Product := 0;
         return False;
      end if;
      Product := Left * Right;
      return True;
   end Multiply;

   function Power (Base : U128; Exponent : Natural; Value : out U128)
      return Boolean is
      Acc : U128 := 1;
      Next : U128;
   begin
      Value := 1;
      for Step in 1 .. Exponent loop
         if not Multiply (Acc, Base, Next) then
            Value := 0;
            return False;
         end if;
         Acc := Next;
      end loop;
      Value := Acc;
      return True;
   end Power;

   function Root (N : U128; K : Positive) return U128 is
      Lo : U128 := 1;
      Hi : U128;
      Mid, Powered : U128;
   begin
      if K = 1 or else N <= 1 then
         return N;
      elsif N <= U128 (U64'Last) then
         return U128 (Int.Rootint (U64 (N), U64 (K)));
      end if;
      Hi := U128 (U64'Last);
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         if Power (Mid, K, Powered) and then Powered <= N then
            Lo := Mid;
         else
            Hi := Mid - 1;
         end if;
      end loop;
      return Lo;
   end Root;

   function Exponent (N : U128) return Natural is
      Base, Powered : U128;
   begin
      if N < 2 then
         return 0;
      elsif (N and (N - 1)) = 0 then
         return Log2 (N);
      elsif N <= U128 (U64'Last) then
         return Natural (Int.Is_Power_Exp (U64 (N)));
      end if;
      for K in reverse 2 .. Log2 (N) loop
         Base := Root (N, K);
         if Power (Base, K, Powered) and then Powered = N then
            return K;
         end if;
      end loop;
      return 0;
   end Exponent;

   function Power_Of_Two (K : Natural) return Boolean is
      Rest : Natural := K;
   begin
      if Rest = 0 then
         return False;
      end if;
      while Rest mod 2 = 0 loop
         Rest := Rest / 2;
      end loop;
      return Rest = 1;
   end Power_Of_Two;

   procedure Decompose
     (N : U64; Exponent : out U64; Prime : out U64);

   procedure Decompose
     (N : U64; Exponent : out U64; Prime : out U64) is

      procedure Take
        (Factor : U64; Hit : out Boolean; Power_K : out U64) is
         Rest : U64 := N;
         Count_K : U64 := 0;
      begin
         Hit := False;
         Power_K := 0;
         if N mod Factor /= 0 then
            return;
         end if;
         while Rest mod Factor = 0 loop
            Rest := Rest / Factor;
            Count_K := Count_K + 1;
         end loop;
         if Rest = 1 then
            Hit := True;
            Power_K := Count_K;
         end if;
      end Take;

      Hit : Boolean;
      Power_K, Whole : U64;
   begin
      Exponent := 0;
      Prime := 0;
      if N < 2 then
         return;
      elsif (N and 1) = 0 then
         if (N and (N - 1)) = 0 then
            Exponent := Int.Logint (N, 2);
            Prime := 2;
         end if;
         return;
      end if;
      for Factor in U64'(3) .. 7 loop
         if Factor = 3 or else Factor = 5 or else Factor = 7 then
            Take (Factor, Hit, Power_K);
            if Hit then
               Exponent := Power_K;
               Prime := Factor;
               return;
            elsif N mod Factor = 0 then
               return;
            end if;
         end if;
      end loop;
      if Primality.Is_Prime (N) = 2 then
         Exponent := 1;
         Prime := N;
         return;
      end if;
      Whole := Int.Is_Power_Exp (N);
      if Whole > 1 then
         Prime := Int.Rootint (N, Whole);
         if Primality.Is_Prime (Prime) = 2 then
            Exponent := Whole;
            return;
         end if;
      end if;
      Prime := 0;
   end Decompose;

   function Is_Prime_Power (N : U64) return U64 is
      Exponent, Prime : U64;
   begin
      Decompose (N, Exponent, Prime);
      return Exponent;
   end Is_Prime_Power;

   function Is_Prime_Power (N : U64; Root : out U64) return U64 is
      Exponent : U64;
   begin
      Decompose (N, Exponent, Root);
      return Exponent;
   end Is_Prime_Power;

   function Next_Prime_Power (N : U64) return Int.Optional_U64 is
      Bit, Cursor : U64;
   begin
      if N < 2 then
         return (Defined => True, Value => 2);
      elsif N >= Max_Prime then
         return (Defined => False);
      end if;
      Bit := High_Bit (N);
      Cursor := N + 1 + (N and 1);
      while (Cursor and Bit) /= 0 loop
         if Is_Prime_Power (Cursor) /= 0 then
            return (Defined => True, Value => Cursor);
         end if;
         Cursor := Cursor + 2;
      end loop;
      return (Defined => True, Value => Cursor - 1);
   end Next_Prime_Power;

   function Prev_Prime_Power (N : U64) return Int.Optional_U64 is
      Bit, Cursor, Start : U64;
   begin
      if N <= 2 then
         return (Defined => False);
      end if;
      Start := N - 1;
      Bit := High_Bit (Start);
      if (Start and 1) = 0 then
         Cursor := Start - 1;
      else
         Cursor := Start;
      end if;
      while (Cursor and Bit) /= 0 loop
         if Is_Prime_Power (Cursor) /= 0 then
            return (Defined => True, Value => Cursor);
         end if;
         Cursor := Cursor - 2;
      end loop;
      return (Defined => True, Value => Cursor + 1);
   end Prev_Prime_Power;

   function One_Count (High : U64; Kind : Natural) return U64 is
   begin
      case Kind is
         when 0 =>
            return Count.Prime_Count (High);
         when 1 =>
            return Count.Prime_Count_Lower (High);
         when 2 =>
            return Count.Prime_Count_Upper (High);
         when others =>
            return Count.Prime_Count_Approx (High);
      end case;
   end One_Count;

   function Sum_Counts (High : U64; Kind : Natural) return U64 is
      Total, Log_N : U64;
   begin
      if High <= 5 then
         return (if High = 0 then 0 else High - 1);
      end if;
      Log_N := Int.Logint (High, 2);
      Total := One_Count (High, Kind);
      for K in U64'(2) .. Log_N loop
         Total := Total + One_Count (Int.Rootint (High, K), Kind);
      end loop;
      return Total;
   end Sum_Counts;

   function Prime_Power_Count (High : U64) return U64 is
     (Sum_Counts (High, 0));

   function Prime_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else Low > High then
         return 0;
      elsif Low <= 2 then
         return Prime_Power_Count (High);
      end if;
      return Prime_Power_Count (High) - Prime_Power_Count (Low - 1);
   end Prime_Power_Count;

   function Prime_Power_Count_Lower (High : U64) return U64 is
     (Sum_Counts (High, 1));

   function Prime_Power_Count_Upper (High : U64) return U64 is
     (Sum_Counts (High, 2));

   function Prime_Power_Count_Approx (High : U64) return U64 is
     (Sum_Counts (High, 3));

   --  inverse_interpolate.c: inverse_interpolate, zero threshold.
   generic
      type Wide is digits <>;
      with function Value (X : U64) return U64;
   function Inverse (Low, High, N : U64) return U64;
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
      while Hi - Lo > 8 loop
         declare
            X1 : U64 := Lo + (Hi - Lo) / 2;
            R1 : U64 := Value (X1);
            D0 : constant F64 := F64 (N - Rlo);
            D1 : constant F64 :=
              F64 ((if R1 >= N then R1 - N else N - R1));
            D2 : constant F64 := F64 (Rhi - N + 1);
            Sign : constant F64 := (if R1 >= N then 1.0 else -1.0);
            Pos : constant Wide :=
              Wide (Sign * F64 (X1 - Lo) * D1) /
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

   function Upper_At (X : U64) return U64 is
     (Prime_Power_Count_Upper (X));
   function Lower_At (X : U64) return U64 is
     (Prime_Power_Count_Lower (X));
   function Approx_At (X : U64) return U64 is
     (Prime_Power_Count_Approx (X));
   function Invert_Upper is new Inverse (Long_Long_Float, Upper_At);
   function Invert_Lower is new Inverse (Long_Long_Float, Lower_At);
   function Invert_Approx is new Inverse (Long_Long_Float, Approx_At);

   function Small_Nth (N : U64) return U64 is
     (N + 1 + N / 5);

   function Simple_Lower (N : U64) return U64 is
      Estimate : F64;
   begin
      if N <= 100 then
         return N + 1;
      end if;
      Estimate :=
        0.98 * F64 (Count.Nth_Prime_Lower (N)) - 400.0;
      if Estimate <= 0.0 then
         return 0;
      end if;
      return U64 (F64'Floor (Estimate));
   end Simple_Lower;

   function Bracket (N : U64) return U64 is
      Lo : U64 := Simple_Lower (N);
      Hi : constant U64 := Count.Nth_Prime_Upper (N);
   begin
      if Lo > Hi then
         Lo := Hi;
      end if;
      return Lo;
   end Bracket;

   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (Defined => True, Value => Small_Nth (N));
      end if;
      return (Defined => True,
              Value => Invert_Upper (Bracket (N), Count.Nth_Prime_Upper (N),
                                     N));
   end Nth_Prime_Power_Lower;

   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (Defined => True, Value => Small_Nth (N));
      end if;
      return (Defined => True,
              Value => Invert_Lower (Bracket (N), Count.Nth_Prime_Upper (N),
                                     N));
   end Nth_Prime_Power_Upper;

   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (Defined => True, Value => Small_Nth (N));
      end if;
      return (Defined => True,
              Value => Invert_Approx (Bracket (N), Count.Nth_Prime_Upper (N),
                                      N));
   end Nth_Prime_Power_Approx;

   function Member (N : U64) return Boolean is
     (Is_Prime_Power (N) /= 0);

   type Guess_Count is record
      Guess : U64;
      Count_At : U64;
   end record;

   --  inverse_interpolate.c: interpolate_with_approx.
   function Interpolate_Prime (N, Tol : U64) return Guess_Count is
      Approx_N : constant U64 := Nth_Prime_Power_Approx (N).Value;
      Guess : U64 := Approx_N;
      Count_At, Approx_Count, Adjust, Span, Step : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Gn : Natural := 2;
      Settled : Boolean := False;
   begin
      Count_At := Prime_Power_Count (Guess);
      while Gn < 20 loop
         if N = Count_At
           or else (N > Count_At and then N - Count_At < Tol)
           or else (N < Count_At and then Count_At - N < Tol)
         then
            Settled := True;
            exit;
         end if;
         Approx_Count := Nth_Prime_Power_Approx (Count_At).Value;
         if Count_At <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_At >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_N >= Approx_Count then
            Adjust := Approx_N - Approx_Count;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Approx_Count - Approx_N;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := (if Tol > 1 then Tol - 1 else 1);
            if Span <= 1 then
               Guess := (if Guess <= Ming then Maxg else Ming);
            elsif Step >= Span then
               Guess := Ming + Span / 2;
            elsif Guess <= Ming then
               Guess := Ming + Step;
            else
               Guess := Maxg - Step;
            end if;
         end if;
         Count_At := Prime_Power_Count (Guess);
         Gn := Gn + 1;
      end loop;
      if not Settled and then Gn = 20 then
         Count_At := Prime_Power_Count (Guess);
      end if;
      if Count_At < N then
         while Count_At < N loop
            Guess := Guess + 1;
            while not Member (Guess) loop
               Guess := Guess + 1;
            end loop;
            Count_At := Count_At + 1;
         end loop;
      elsif Count_At >= N then
         while not Member (Guess) loop
            Guess := Guess - 1;
         end loop;
         while Count_At > N loop
            Guess := Guess - 1;
            while not Member (Guess) loop
               Guess := Guess - 1;
            end loop;
            Count_At := Count_At - 1;
         end loop;
      end if;
      return (Guess => Guess, Count_At => Count_At);
   end Interpolate_Prime;

   function Nth_Prime_Power (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (Defined => True, Value => Small_Nth (N));
      end if;
      return (Defined => True, Value => Interpolate_Prime (N, 800).Guess);
   end Nth_Prime_Power;

   function Magnitude (N : Int.I128) return U128 is
   begin
      if N >= 0 then
         return U128 (N);
      elsif N = Int.I128'First then
         return 2 ** 127;
      end if;
      return U128 (-N);
   end Magnitude;

   function To_Signed (N : U128) return Int.I128 is
   begin
      if N > U128 (Int.I128'Last) then
         raise Constraint_Error;
      end if;
      return Int.I128 (N);
   end To_Signed;

   function Next_Positive (N : U128; Odd_Only : Boolean) return U128 is
      K_Init : constant Natural := (if Odd_Only then 3 else 2);
      K_Inc : constant Natural := (if Odd_Only then 2 else 1);
      Log_N : Natural;
      K : Natural;
      Best, Candidate, Base : U128;
   begin
      if N = 0 then
         return 1;
      elsif N = 1 then
         return (if Odd_Only then 8 else 4);
      end if;
      Log_N := Log2 (N);
      Base := Root (N, K_Init) + 1;
      if not Power (Base, K_Init, Best) then
         raise Constraint_Error;
      end if;
      K := K_Init + K_Inc;
      while K <= Log_N + 1 loop
         Base := Root (N, K) + 1;
         if Power (Base, K, Candidate)
           and then Candidate > N
           and then Candidate < Best
         then
            Best := Candidate;
         end if;
         K := K + K_Inc;
      end loop;
      return Best;
   end Next_Positive;

   function Prev_Positive (N : U128; Odd_Only : Boolean) return U128 is
      K_Init : constant Natural := (if Odd_Only then 3 else 2);
      K_Inc : constant Natural := (if Odd_Only then 2 else 1);
      Log_N, K : Natural;
      Best, Candidate, Base : U128;
   begin
      if N <= 4 then
         if N <= 1 then
            return 0;
         end if;
         return 1;
      elsif N <= 8 then
         return (if Odd_Only then 1 else 4);
      end if;
      Log_N := Log2 (N);
      Best := 8;
      K := K_Init;
      while K <= Log_N loop
         Base := Root (N, K);
         if Power (Base, K, Candidate) then
            if Candidate >= N and then Base >= 1 then
               if not Power (Base - 1, K, Candidate) then
                  Candidate := 0;
               end if;
            end if;
            if Candidate > Best and then Candidate < N then
               Best := Candidate;
            end if;
         end if;
         K := K + K_Inc;
      end loop;
      return Best;
   end Prev_Positive;

   function Is_Perfect_Power (N : Int.I128) return Boolean is
      K : Natural;
   begin
      if N >= -1 and then N <= 1 then
         return True;
      elsif N = Int.I128'First then
         return True;
      end if;
      K := Exponent (Magnitude (N));
      if N < 0 then
         return K > 2 and then not Power_Of_Two (K);
      end if;
      return K > 1;
   end Is_Perfect_Power;

   function Next_Perfect_Power (N : Int.I128) return Int.I128 is
   begin
      if N < 1 and then N >= -4 then
         if N >= 0 then
            return 1;
         elsif N < -1 then
            return -1;
         end if;
         return 0;
      elsif N < 0 then
         return -To_Signed (Prev_Positive (Magnitude (N), True));
      end if;
      return To_Signed (Next_Positive (U128 (N), False));
   end Next_Perfect_Power;

   function Prev_Perfect_Power (N : Int.I128) return Int.I128 is
   begin
      if N <= 4 and then N >= 0 then
         if N = 0 then
            return -1;
         elsif N = 1 then
            return 0;
         end if;
         return 1;
      elsif N < 0 then
         return -To_Signed (Next_Positive (Magnitude (N), True));
      end if;
      return To_Signed (Prev_Positive (U128 (N), False));
   end Prev_Perfect_Power;

   function Perfect_Power_Count (High : U64) return U64 is
      Total : Int.I128 := 1;
      Log_N : Natural;
      Term : Int.I128;
   begin
      if High < 8 then
         return (if High >= 1 then 1 else 0) + (if High >= 4 then 1 else 0);
      end if;
      Log_N := Natural (Int.Logint (High, 2));
      for K in 2 .. Log_N loop
         if Moebius (K) /= 0 then
            Term := Int.I128 (Int.Rootint (High, U64 (K))) - 1;
            Total := Total - Int.I128 (Moebius (K)) * Term;
         end if;
      end loop;
      return U64 (Total);
   end Perfect_Power_Count;

   function Perfect_Power_Count (Low, High : U64) return U64 is
   begin
      if High = 0 or else Low > High then
         return 0;
      elsif Low <= 1 then
         return Perfect_Power_Count (High);
      end if;
      return Perfect_Power_Count (High) - Perfect_Power_Count (Low - 1);
   end Perfect_Power_Count;

   function Perfect_Power_Count_Lower (High : U64) return U64 is
     (Perfect_Power_Count (High));

   function Perfect_Power_Count_Upper (High : U64) return U64 is
     (Perfect_Power_Count (High));

   function Perfect_Power_Count_Approx (High : U64) return U64 is
     (Perfect_Power_Count (High));

   function Real_Pow (N : U64; Exponent : F64) return F64 is
     (Ada.Numerics.Long_Elementary_Functions."**" (F64 (N), Exponent));

   function Bound_Value (N : U64; Kind : Natural) return Int.I128 is
      PP : F64;
   begin
      PP := Real_Pow (N, 2.0)
        + (13.0 / 3.0) * Real_Pow (N, 4.0 / 3.0)
        + (32.0 / 15.0) * Real_Pow (N, 16.0 / 15.0);
      PP := PP - 2.0 * Real_Pow (N, 5.0 / 3.0)
        - 2.0 * Real_Pow (N, 7.0 / 5.0)
        - 2.0 * Real_Pow (N, 9.0 / 7.0)
        + 2.0 * Real_Pow (N, 12.0 / 10.0);
      if Kind = 0 then
         PP := PP - 2.0 * Real_Pow (N, 13.0 / 11.0)
           - 2.0 * Real_Pow (N, 15.0 / 13.0)
           + 2.0 * Real_Pow (N, 16.0 / 14.0)
           + 2.0 * Real_Pow (N, 17.0 / 15.0)
           - 0.48 * Real_Pow (N, 19.0 / 17.0) - 1.5;
      elsif Kind = 1 then
         PP := PP - 2.0 * Real_Pow (N, 13.0 / 11.0)
           - 2.0 * Real_Pow (N, 15.0 / 13.0) + 5.5;
      else
         PP := PP + 2.0 * Real_Pow (N, 16.0 / 14.0) - 3.5;
      end if;
      if PP >= 2.0 ** 64 then
         return Int.I128 (U64'Last);
      elsif PP <= 0.0 then
         return 0;
      end if;
      return Int.I128 (F64'Floor (PP));
   end Bound_Value;

   function Some_Bound (N : U64; Kind : Natural) return Optional_I128 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (Defined => True, Value => 1);
      elsif N >= Max_Perfect_Index then
         return (Defined => True, Value => Int.I128 (Max_Perfect_Power));
      end if;
      return (Defined => True, Value => Bound_Value (N, Kind));
   end Some_Bound;

   function Nth_Perfect_Power_Lower (N : U64) return Optional_I128 is
     (Some_Bound (N, 1));

   function Nth_Perfect_Power_Upper (N : U64) return Optional_I128 is
     (Some_Bound (N, 2));

   function Nth_Perfect_Power_Approx (N : U64) return Optional_I128 is
     (Some_Bound (N, 0));

   function Approx_U64 (N : U64) return U64 is
      Value : constant Optional_I128 := Nth_Perfect_Power_Approx (N);
   begin
      if not Value.Defined or else Value.Value <= 0 then
         return 0;
      elsif Value.Value >= Int.I128 (U64'Last) then
         return U64'Last;
      end if;
      return U64 (Value.Value);
   end Approx_U64;

   function As_U64 (N : Int.I128) return U64 is
   begin
      if N <= 0 then
         return 0;
      elsif N >= Int.I128 (U64'Last) then
         return U64'Last;
      end if;
      return U64 (N);
   end As_U64;

   function Nth_Perfect_Power (N : U64) return Optional_I128 is
      Guess : U64 := Approx_U64 (N);
      Count_At, Adjust, Span, Step, Approx_N, Approx_Count : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Gn : Natural := 2;
      Settled : Boolean := False;
      Signed : Int.I128;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (Defined => True, Value => 1);
      elsif N >= Max_Perfect_Index then
         return (Defined => True, Value => Int.I128 (Max_Perfect_Power));
      end if;
      Approx_N := Guess;
      Count_At := Perfect_Power_Count (Guess);
      while Gn < 20 loop
         if N = Count_At
           or else (N > Count_At and then N - Count_At < 1000)
           or else (N < Count_At and then Count_At - N < 1000)
         then
            Settled := True;
            exit;
         end if;
         Approx_Count := Approx_U64 (Count_At);
         if Count_At <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_At >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_N >= Approx_Count then
            Adjust := Approx_N - Approx_Count;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Approx_Count - Approx_N;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := 999;
            if Span <= 1 then
               Guess := (if Guess <= Ming then Maxg else Ming);
            elsif Step >= Span then
               Guess := Ming + Span / 2;
            elsif Guess <= Ming then
               Guess := Ming + Step;
            else
               Guess := Maxg - Step;
            end if;
         end if;
         Count_At := Perfect_Power_Count (Guess);
         Gn := Gn + 1;
      end loop;
      if not Settled and then Gn = 20 then
         Count_At := Perfect_Power_Count (Guess);
      end if;
      if Guess > Max_Perfect_Power then
         Guess := Max_Perfect_Power;
      end if;
      if Count_At >= N then
         Signed := Prev_Perfect_Power (Int.I128 (Guess) + 1);
         Guess := As_U64 (Signed);
         while Count_At > N loop
            Signed := Prev_Perfect_Power (Int.I128 (Guess));
            Guess := As_U64 (Signed);
            Count_At := Count_At - 1;
         end loop;
      else
         while Count_At < N loop
            Signed := Next_Perfect_Power (Int.I128 (Guess));
            Guess := As_U64 (Signed);
            Count_At := Count_At + 1;
         end loop;
      end if;
      return (Defined => True, Value => Int.I128 (Guess));
   end Nth_Perfect_Power;

   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector is
      package Sorting is new Power_Vectors.Generic_Sorting;
      Result : Power_Vectors.Vector;
      Span, Limit, Cursor, Log_N, Root_N : U64;
      Packed : Int.Optional_U64;
      Primes : Prime_Sieve.Prime_Vectors.Vector;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      Span := High - Low;
      if High < 7_929_856 then
         Limit := 10;
      else
         Limit := Int.Sqrtint (High) / 256;
      end if;
      if Span < Limit then
         Cursor := Low;
         loop
            if Is_Prime_Power (Cursor) /= 0 then
               Result.Append (Cursor);
            end if;
            exit when Cursor = High;
            Cursor := Cursor + 1;
         end loop;
         return Result;
      end if;
      Log_N := Int.Logint (High, 2);
      for K in U64'(2) .. Log_N loop
         Root_N := Int.Rootint (High, K);
         Primes := Prime_Sieve.Primes (Root_N);
         for I in Primes.First_Index .. Primes.Last_Index loop
            Packed := Int.Powint (Primes.Element (I), K);
            if Packed.Defined
              and then Packed.Value >= Low
              and then Packed.Value <= High
            then
               Result.Append (Packed.Value);
            end if;
         end loop;
      end loop;
      Primes := Prime_Sieve.Primes (Low, High);
      for I in Primes.First_Index .. Primes.Last_Index loop
         Result.Append (Primes.Element (I));
      end loop;
      Sorting.Sort (Result);
      return Result;
   end Prime_Powers;

   function Prime_Powers (High : U64) return Power_Vectors.Vector is
     (Prime_Powers (0, High));
end Math_Prime_Util.Powers;
