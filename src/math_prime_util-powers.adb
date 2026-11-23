with Ada.Containers;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Powers with SPARK_Mode => Off is
   use type U128;
   use type Int.I128;

   function C_Pow (Base, Exp : Long_Float) return Long_Float
     with Import, Convention => C, External_Name => "pow";
   function C_Sqrtl (X : Long_Long_Float) return Long_Long_Float
     with Import, Convention => C, External_Name => "sqrtl";

   --  perfect_powers.c: _moebius, indices 0 .. 64.
   Mu : constant array (Natural range 0 .. 64) of Integer :=
     [0, 1, -1, -1, 0, -1, 1, -1, 0, 0,
      1, -1, 0, -1, 1, 1, 0, -1, 0, -1,
      0, 1, 1, -1, 0, 0, 1, 0, 0, -1,
      -1, -1, 0, 1, 1, 1, 0, -1, 1, 1,
      0, -1, -1, -1, 0, 0, 1, -1, 0, 0,
      0, 1, 0, -1, 0, 1, 0, 1, 1, -1,
      0, -1, 1, 0, 0];

   type Estimate is (Lower, Upper, Approx);
   type Bound_Kind is (Low_B, Up_B, Ap_B);

   function Log2_Floor (N : U128) return Natural is
      C : Natural := 0;
      M : U128 := N;
   begin
      while M > 1 loop
         M := M / 2;
         C := C + 1;
      end loop;
      return C;
   end Log2_Floor;

   function Pow_Le (Base : U128; Exp : Positive; Limit : U128)
      return Boolean
   is
      Acc : U128 := 1;
      B : U128 := Base;
      E : Natural := Exp;
   begin
      if Base <= 1 then
         return True;
      end if;
      while E > 0 loop
         if E mod 2 = 1 then
            if Acc > U128'Last / B or else Acc * B > Limit then
               return False;
            end if;
            Acc := Acc * B;
         end if;
         E := E / 2;
         if E > 0 then
            if B > U128'Last / B then
               return False;
            end if;
            B := B * B;
         end if;
      end loop;
      return Acc <= Limit;
   end Pow_Le;

   function U_Pow (Base : U128; Exp : Natural; Ok : out Boolean)
      return U128
   is
      Acc : U128 := 1;
      B : U128 := Base;
      E : Natural := Exp;
   begin
      Ok := True;
      while E > 0 loop
         if E mod 2 = 1 then
            if B /= 0 and then Acc > U128'Last / B then
               Ok := False;
               return 0;
            end if;
            Acc := Acc * B;
         end if;
         E := E / 2;
         if E > 0 then
            if B > U128'Last / B then
               Ok := False;
               return 0;
            end if;
            B := B * B;
         end if;
      end loop;
      return Acc;
   end U_Pow;

   function U_Root (N : U128; K : Positive) return U128 is
      Lo : U128 := 0;
      Hi : U128;
      Mid : U128;
   begin
      if N <= 1 or else K = 1 then
         return (if K = 1 then N elsif N = 0 then 0 else 1);
      elsif K >= 128 then
         return 1;
      elsif N <= U128 (U64'Last) then
         return U128 (Int.Rootint (U64 (N), U64 (K)));
      end if;
      Hi := 2 ** 64;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         if Pow_Le (Mid, K, N) then
            Lo := Mid;
         else
            Hi := Mid - 1;
         end if;
      end loop;
      return Lo;
   end U_Root;

   function Largest_Exponent (N : U128) return Natural is
      R, P : U128;
      Ok : Boolean;
   begin
      if N <= 1 then
         return 0;
      elsif N <= U128 (U64'Last) then
         return Natural (Int.Is_Power_Exp (U64 (N)));
      end if;
      for K in reverse 2 .. Log2_Floor (N) loop
         R := U_Root (N, K);
         P := U_Pow (R, K, Ok);
         if Ok and then P = N then
            return K;
         end if;
      end loop;
      return 0;
   end Largest_Exponent;

   function Magnitude (N : Int.I128) return U128 is
   begin
      if N >= 0 then
         return U128 (N);
      elsif N = Int.I128'First then
         return 2 ** 127;
      else
         return U128 (-N);
      end if;
   end Magnitude;

   function To_I128 (N : U128) return Int.I128 is
   begin
      if N > U128 (Int.I128'Last) then
         raise Constraint_Error with "perfect power exceeds I128";
      end if;
      return Int.I128 (N);
   end To_I128;

   function Prime_Power (N : U64) return Prime_Power_Factors is
      M : U64 := N;
      E : U64 := 0;
      Root : U64;
      Facs : constant array (1 .. 3) of U64 := [3, 5, 7];
   begin
      if N < 2 then
         return (0, 0);
      elsif N mod 2 = 0 then
         if (N and (N - 1)) /= 0 then
            return (0, 0);
         end if;
         return (Int.Logint (N, 2), 2);
      end if;
      for Fac of Facs loop
         if N mod Fac = 0 then
            while M mod Fac = 0 loop
               M := M / Fac;
               E := E + 1;
            end loop;
            if M /= 1 then
               return (0, 0);
            end if;
            return (E, Fac);
         end if;
      end loop;
      if Primality.Is_Prob_Prime (N) /= 0 then
         return (1, N);
      end if;
      E := Int.Is_Power_Exp (N);
      if E > 1 then
         Root := Int.Rootint (N, E);
         if Primality.Is_Prob_Prime (Root) /= 0 then
            return (E, Root);
         end if;
      end if;
      return (0, 0);
   end Prime_Power;

   function Is_Prime_Power (N : U64) return U64 is
     (Prime_Power (N).Exponent);

   function Prime_Power_Count (N : U64) return U64 is
      Sum : U64;
      Last : U64;
   begin
      if N <= 5 then
         return (if N = 0 then 0 else N - 1);
      end if;
      Sum := Count.Prime_Count (N);
      Last := Int.Logint (N, 2);
      for K in U64 range 2 .. Last loop
         Sum := Sum + Count.Prime_Count (Int.Rootint (N, K));
      end loop;
      return Sum;
   end Prime_Power_Count;

   function Prime_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else High < Low then
         return 0;
      end if;
      return Prime_Power_Count (High)
        - (if Low <= 2 then 0 else Prime_Power_Count (Low - 1));
   end Prime_Power_Count;

   function Bounded_Count (Kind : Estimate; N : U64) return U64 is
      Sum : U64;
      Last : U64;
      function One (X : U64) return U64 is
        (case Kind is
            when Lower => Count.Prime_Count_Lower (X),
            when Upper => Count.Prime_Count_Upper (X),
            when Approx => Count.Prime_Count_Approx (X));
   begin
      if N <= 5 then
         return (if N = 0 then 0 else N - 1);
      end if;
      Sum := One (N);
      Last := Int.Logint (N, 2);
      for K in U64 range 2 .. Last loop
         Sum := Sum + One (Int.Rootint (N, K));
      end loop;
      return Sum;
   end Bounded_Count;

   function Prime_Power_Count_Lower (N : U64) return U64 is
     (Bounded_Count (Lower, N));
   function Prime_Power_Count_Upper (N : U64) return U64 is
     (Bounded_Count (Upper, N));
   function Prime_Power_Count_Approx (N : U64) return U64 is
     (Bounded_Count (Approx, N));

   function Eval (Kind : Estimate; X : U64) return U64 is
     (case Kind is
         when Lower => Prime_Power_Count_Lower (X),
         when Upper => Prime_Power_Count_Upper (X),
         when Approx => Prime_Power_Count_Approx (X));

   --  inverse_interpolate.c: _linear_interpolate. Double arithmetic.
   function Linear (Lo, Hi, Rlo, Rhi, N : U64) return U64 is
      Rdiff : constant U64 := N - Rlo;
      Rspan : constant U64 := Rhi - Rlo;
      Xspan : constant U64 := Hi - Lo;
      Dmove : Long_Float;
      Move : U64;
   begin
      if N = Rlo then
         return Lo + 1;
      elsif N = Rhi then
         return Hi - 1;
      end if;
      Dmove := Long_Float (Rdiff) * Long_Float (Xspan)
        / Long_Float (Rspan) + 0.5;
      if Dmove >= Long_Float (Xspan) then
         Move := Xspan;
      elsif Dmove <= 0.0 then
         Move := 0;
      else
         Move := U64 (Long_Float'Truncation (Dmove));
      end if;
      if Move = 0 then
         return Lo + 1;
      elsif Move >= Xspan then
         return Hi - 1;
      else
         return Lo + Move;
      end if;
   end Linear;

   --  inverse_interpolate.c: _inverse_interpolate, threshold at the end.
   function Inverse (Bound_Lo, Bound_Hi, N : U64; Kind : Estimate)
      return U64
   is
      Lo : U64 := Bound_Lo;
      Hi : U64 := Bound_Hi;
      Mid, Rlo, Rhi, Rmid : U64 := 0;
      X0, X1, X3, Rx1, Rx3 : U64;
      D0, D1, D2, Den, Sgn, Pos : Long_Float;
      Pos_Ld, Adj : Long_Long_Float;
      Wide : Int.I128;
      Close : U64;
      Loopc : Natural := 0;
   begin
      if Hi /= 0 then
         Mid := Lo + (Hi - Lo) / 2;
         Rmid := Eval (Kind, Mid);
         if Rmid >= N then
            Hi := Mid;
            Rhi := Rmid;
            Rlo := Eval (Kind, Lo);
            if Rlo = N then
               return Lo;
            end if;
         else
            Lo := Mid;
            Rlo := Rmid;
            Rhi := Eval (Kind, Hi);
         end if;
      else
         Rlo := Eval (Kind, Lo);
         if Rlo = N then
            return Lo;
         end if;
         loop
            declare
               Est : Long_Float :=
                 Long_Float (N) / Long_Float (Rlo) - 0.004;
            begin
               if Est <= 1.004 then
                  Est := 1.004;
               elsif Est > 8.0 then
                  Est := 8.0;
               end if;
               if Long_Float (U64'Last) / Long_Float (Lo) <= Est then
                  Mid := U64'Last;
               else
                  Mid := U64 (Long_Float'Truncation
                    (Est * Long_Float (Lo) + 1.0));
               end if;
            end;
            Rmid := Eval (Kind, Mid);
            if Rmid >= N then
               Hi := Mid;
               Rhi := Rmid;
               exit;
            end if;
            Lo := Mid;
            Rlo := Rmid;
            if Lo = U64'Last then
               return 0;
            end if;
         end loop;
      end if;
      if Hi - Lo <= 1 then
         if Rlo = N or else (Rlo < N and then Rhi > N) then
            return Lo;
         else
            return Hi;
         end if;
      end if;
      Mid := Linear (Lo, Hi, Rlo, Rhi, N);
      while Hi - Lo > 1 and then Rhi > N loop
         Loopc := Loopc + 1;
         Rmid := Eval (Kind, Mid);
         if Rmid >= N then
            Hi := Mid;
            Rhi := Rmid;
         else
            Lo := Mid;
            Rlo := Rmid;
         end if;
         exit when Rhi = N or else Hi - Lo <= 1;
         Mid := Linear (Lo, Hi, Rlo, Rhi, N);
         if Loopc mod 6 = 0 then
            Close := U64 (Long_Float'Truncation
              (0.003 * Long_Float (Hi - Lo) + 1.0));
            if Lo + Close > Mid then
               Mid := Lo + Close;
            elsif Hi - Close < Mid then
               Mid := Hi - Close;
            end if;
         end if;
         if Mid <= Lo then
            Mid := Lo + 1;
         elsif Mid >= Hi then
            Mid := Hi - 1;
         end if;
      end loop;
      if Rlo = N then
         return Lo;
      elsif Hi - Lo <= 1 then
         if Rlo = N or else (Rlo < N and then Rhi > N) then
            return Lo;
         else
            return Hi;
         end if;
      end if;
      while Hi - Lo > 8 and then (Hi - Lo > 0 or else Rhi > N) loop
         X0 := Lo;
         X1 := Lo + (Hi - Lo) / 2;
         Rx1 := Eval (Kind, X1);
         D0 := Long_Float (N - Rlo);
         D1 := Long_Float ((if Rx1 >= N then Rx1 - N else N - Rx1));
         D2 := Long_Float (Rhi - N + 1);
         Den := D1 * D1 + D0 * D2;
         Sgn := (if Rx1 >= N then 1.0 else -1.0);
         if Den <= 0.0 then
            if Rx1 >= N then
               Hi := X1;
               Rhi := Rx1;
            else
               Lo := X1;
               Rlo := Rx1;
            end if;
         else
            Pos_Ld := Long_Long_Float
              (Sgn * Long_Float (X1 - X0) * D1)
              / C_Sqrtl (Long_Long_Float (Den));
            Pos := Long_Float (Pos_Ld);
            Adj := Long_Long_Float (Pos)
              + (if Pos >= 0.0 then 0.5 else -0.5);
            if Adj >= 0.0 then
               Wide := Int.I128 (Long_Long_Float'Truncation (Adj));
            else
               Wide := Int.I128 (Long_Long_Float'Truncation (Adj));
            end if;
            Wide := Int.I128 (X1) - Wide;
            if Wide <= Int.I128 (Lo) or else Wide >= Int.I128 (Hi)
              or else Wide = Int.I128 (X1)
            then
               if Rx1 >= N then
                  Hi := X1;
                  Rhi := Rx1;
               else
                  Lo := X1;
                  Rlo := Rx1;
               end if;
            else
               X3 := U64 (Wide);
               Rx3 := Eval (Kind, X3);
               if Rx1 > Rx3 then
                  declare
                     T : U64 := X1;
                  begin
                     X1 := X3;
                     X3 := T;
                     T := Rx1;
                     Rx1 := Rx3;
                     Rx3 := T;
                  end;
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
         end if;
      end loop;
      while Hi - Lo > 1 and then (Hi - Lo > 0 or else Rhi > N) loop
         Mid := Lo + (Hi - Lo) / 2;
         if Eval (Kind, Mid) < N then
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
      if V <= 0.0 then
         return 0;
      elsif V >= 2.0 ** 64 then
         return U64'Last;
      else
         return U64 (Long_Float'Truncation (V));
      end if;
   end Simple_Lower;

   function Bracket (N : U64) return U64 is separate;
   --  Placeholder replaced below: Bracket is local, not separate.

   function Nth_From (Kind : Estimate; N : U64) return Int.Optional_U64
   is
      Lo, Hi : U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, N + 1 + N / 5);
      end if;
      Lo := Simple_Lower (N);
      Hi := Count.Nth_Prime_Upper (N);
      if Lo > Hi then
         Lo := Hi;
      end if;
      return (True, Inverse (Lo, Hi, N, Kind));
   end Nth_From;

   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64 is
     (Nth_From (Upper, N));
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64 is
     (Nth_From (Lower, N));
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64 is
     (Nth_From (Approx, N));

   function Nth_Prime_Power (N : U64) return Int.Optional_U64 is
      Approx_N, Guess, Ac, Adjust, Span, Step : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Count_N : U64 := 0;
      Below : Boolean;
      Settled : Boolean := False;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, N + 1 + N / 5);
      elsif N > 425_656_284_035_217_743 then
         return (True, Max_Prime);
      end if;
      Approx_N := Nth_Prime_Power_Approx (N).Value;
      Guess := Approx_N;
      for Round in 2 .. 19 loop
         if Guess > Count.Prime_Count_Limit then
            Guess := Count.Prime_Count_Limit;
         end if;
         Count_N := Prime_Power_Count (Guess);
         if N = Count_N
           or else (N > Count_N and then N - Count_N < 800)
           or else (N < Count_N and then Count_N - N < 800)
         then
            Settled := True;
            exit;
         end if;
         if Count_N = 0 then
            Ac := 0;
         else
            Ac := Nth_Prime_Power_Approx (Count_N).Value;
         end if;
         if Count_N <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_N >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_N >= Ac then
            Adjust := Approx_N - Ac;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Ac - Approx_N;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := 799;
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
         if Round = 19 then
            Settled := False;
         end if;
      end loop;
      if not Settled then
         if Guess > Count.Prime_Count_Limit then
            Guess := Count.Prime_Count_Limit;
         end if;
         Count_N := Prime_Power_Count (Guess);
      end if;
      if Count_N < N then
         while Count_N < N loop
            Count_N := Count_N + 1;
            loop
               exit when Guess = U64'Last;
               Guess := Guess + 1;
               exit when Is_Prime_Power (Guess) /= 0;
            end loop;
         end loop;
      else
         while Is_Prime_Power (Guess) = 0 and then Guess > 2 loop
            Guess := Guess - 1;
         end loop;
         while Count_N > N loop
            Count_N := Count_N - 1;
            loop
               exit when Guess <= 2;
               Guess := Guess - 1;
               exit when Is_Prime_Power (Guess) /= 0;
            end loop;
         end loop;
      end if;
      return (True, Guess);
   end Nth_Prime_Power;

   function Next_Prime_Power (N : U64) return Optional_I128 is
      Bit, I : U64;
   begin
      if N < 2 then
         return (True, 2);
      elsif N >= Max_Prime then
         return (True, Int.I128 (2 ** 64));
      end if;
      Bit := 2 ** Natural (Int.Logint (N, 2));
      I := N + 1 + (N and 1);
      while (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return (True, Int.I128 (I));
         end if;
         exit when I > U64'Last - 2;
         I := I + 2;
      end loop;
      if (I and Bit) = 0 then
         return (True, Int.I128 (I - 1));
      else
         return (True, Int.I128 (2 ** 64));
      end if;
   end Next_Prime_Power;

   function Prev_Prime_Power (N : U64) return Int.Optional_U64 is
      M, Bit, I : U64;
   begin
      if N <= 2 then
         return (Defined => False);
      end if;
      M := N - 1;
      Bit := 2 ** Natural (Int.Logint (M, 2));
      if (M and 1) = 0 then
         I := M - 1;
      else
         I := M;
      end if;
      while (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return (True, I);
         end if;
         exit when I < 2;
         I := I - 2;
      end loop;
      return (True, I + 1);
   end Prev_Prime_Power;

   procedure Sort_Powers (V : in out Power_Vectors.Vector) is
      type Arr is array (Positive range <>) of U64;
      procedure Sort is new Ada.Containers.Generic_Array_Sort
        (Positive, U64, Arr);
      A : Arr (1 .. Natural (V.Length));
      Cursor : Natural := V.First_Index;
   begin
      if V.Length < 2 then
         return;
      end if;
      for J in A'Range loop
         A (J) := V.Element (Cursor);
         if J /= A'Last then
            Cursor := Cursor + 1;
         end if;
      end loop;
      Sort (A);
      V.Clear;
      for Value of A loop
         V.Append (Value);
      end loop;
   end Sort_Powers;

   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector
   is
      V : Power_Vectors.Vector;
      Start : U64;
      N : U64;
   begin
      if High < 2 or else Low > High then
         return V;
      end if;
      Start := U64'Max (Low, 2);
      if High - Start <= Scan_Limit then
         N := Start;
         loop
            if Is_Prime_Power (N) /= 0 then
               V.Append (N);
            end if;
            exit when N = High;
            N := N + 1;
         end loop;
         return V;
      end if;
      declare
         Primes : constant Power_Vectors.Vector :=
           Sieve.Primes (Start, High);
         Pow : Int.Optional_U64;
         Root : U64;
      begin
         for I in Primes.First_Index .. Primes.Last_Index loop
            V.Append (Primes.Element (I));
         end loop;
         for K in U64 range 2 .. Int.Logint (High, 2) loop
            Root := Int.Rootint (High, K);
            declare
               Ps : constant Power_Vectors.Vector :=
                 Sieve.Primes (Root);
            begin
               for I in Ps.First_Index .. Ps.Last_Index loop
                  Pow := Int.Powint (Ps.Element (I), K);
                  if Pow.Defined and then Pow.Value >= Start
                    and then Pow.Value <= High
                  then
                     V.Append (Pow.Value);
                  end if;
               end loop;
            end;
         end loop;
      end;
      Sort_Powers (V);
      return V;
   end Prime_Powers;

   function Prime_Powers (High : U64) return Power_Vectors.Vector is
     (Prime_Powers (0, High));

   function Is_Perfect_Power (N : Int.I128) return Boolean is
      K : Natural;
   begin
      if N >= 0 then
         if N <= 1 then
            return True;
         end if;
         return Largest_Exponent (Magnitude (N)) > 1;
      elsif N = -1 then
         return True;
      end if;
      K := Largest_Exponent (Magnitude (N));
      return K > 2 and then (U64 (K) and (U64 (K) - 1)) /= 0;
   end Is_Perfect_Power;

   --  perfect_powers.c: _next_perfect_power. Odd_Only selects odd exponents.
   function Next_Raw (N : U128; Odd_Only : Boolean) return U128 is
      Kinit : constant Positive := (if Odd_Only then 3 else 2);
      Kinc : constant Positive := (if Odd_Only then 2 else 1);
      Limit : Natural;
      K : Positive;
      Best : U128 := 0;
      Have : Boolean := False;
      R, C : U128;
      Ok : Boolean;
   begin
      if N = 0 then
         return 1;
      elsif N = 1 then
         return (if Odd_Only then 8 else 4);
      end if;
      Limit := Log2_Floor (N) + 1;
      R := U_Root (N, Kinit) + 1;
      C := U_Pow (R, Kinit, Ok);
      if Ok and then C > N then
         Best := C;
         Have := True;
      end if;
      K := Kinit + Kinc;
      while K <= Limit loop
         R := U_Root (N, K) + 1;
         C := U_Pow (R, K, Ok);
         if Ok and then C > N and then (not Have or else C < Best) then
            Best := C;
            Have := True;
         end if;
         K := K + Kinc;
      end loop;
      if not Have then
         raise Constraint_Error with "no next perfect power";
      end if;
      return Best;
   end Next_Raw;

   --  perfect_powers.c: _prev_perfect_power.
   function Prev_Raw (N : U128; Odd_Only : Boolean) return U128 is
      Kinit : constant Positive := (if Odd_Only then 3 else 2);
      Kinc : constant Positive := (if Odd_Only then 2 else 1);
      Best : U128 := 8;
      R, C : U128;
      Ok : Boolean;
      K : Positive;
   begin
      if N <= 4 then
         if N <= 1 then
            return (if N = 0 then 0 else 0);
         else
            return 1;
         end if;
      elsif N <= 8 then
         return (if Odd_Only then 1 else 4);
      end if;
      K := Kinit;
      while K <= Log2_Floor (N) loop
         R := U_Root (N, K);
         if R > 1 then
            C := U_Pow (R, K, Ok);
            if Ok and then C >= N then
               C := U_Pow (R - 1, K, Ok);
            end if;
            if Ok and then C > Best and then C < N then
               Best := C;
            end if;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Prev_Raw;

   function Next_Perfect_Power (N : Int.I128) return Int.I128 is
   begin
      if N < 1 and then N >= -4 then
         if N >= 0 then
            return 1;
         elsif N = -1 then
            return 0;
         else
            return -1;
         end if;
      elsif N < 0 then
         return -To_I128 (Prev_Raw (Magnitude (N), True));
      else
         return To_I128 (Next_Raw (Magnitude (N), False));
      end if;
   end Next_Perfect_Power;

   function Prev_Perfect_Power (N : Int.I128) return Int.I128 is
   begin
      if N <= 4 and then N >= 0 then
         if N = 0 then
            return -1;
         elsif N = 1 then
            return 0;
         else
            return 1;
         end if;
      elsif N < 0 then
         return -To_I128 (Next_Raw (Magnitude (N), True));
      else
         return To_I128 (Prev_Raw (Magnitude (N), False));
      end if;
   end Prev_Perfect_Power;

   function Perfect_Power_Count (N : U64) return U64 is
      Sum : Int.I128 := 1;
      R : U64;
   begin
      if N < 8 then
         return (if N >= 4 then 2 elsif N >= 1 then 1 else 0);
      end if;
      for K in 2 .. Natural (Int.Logint (N, 2)) loop
         if Mu (K) /= 0 then
            R := Int.Rootint (N, U64 (K));
            Sum := Sum - Int.I128 (Mu (K)) * Int.I128 (R - 1);
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
        - (if Low <= 1 then 0
           else Perfect_Power_Count (Low - 1));
   end Perfect_Power_Count;

   function Perfect_Power_Count_Lower (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Perfect_Power_Count_Upper (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Perfect_Power_Count_Approx (N : U64) return U64 is
     (Perfect_Power_Count (N));

   --  First index past the native C limit. XS calls PP.pm there.
   --  Lower and upper are Math::BigFloat at div_scale 40. Approx is
   --  GMP powreal rounded to 2 * length (n) + 2 digits.
   function Past_Index (N : U64; Kind : Bound_Kind) return Int.I128 is
   begin
      if N /= 4_297_615_582 then
         return Int.I128 (Max_Perfect_Pow);
      elsif Kind = Low_B then
         return 18_446_743_767_352_942_184;
      elsif Kind = Up_B then
         return 18_446_744_717_534_467_451;
      else
         return 18_446_744_109_147_667_342;
      end if;
   end Past_Index;

   function Perfect_Bound (N : U64; Kind : Bound_Kind) return Int.I128
   is
      X : constant Long_Float := Long_Float (N);
      Pp : Long_Float;
      function P (E : Long_Float) return Long_Float is (C_Pow (X, E));
   begin
      if N <= 1 then
         return Int.I128 (N);
      elsif N > Max_Perfect_Idx then
         return Past_Index (N, Kind);
      elsif N = Max_Perfect_Idx then
         return Int.I128 (Max_Perfect_Pow);
      end if;
      Pp := P (2.0) + (13.0 / 3.0) * P (4.0 / 3.0)
        + (32.0 / 15.0) * P (16.0 / 15.0);
      case Kind is
         when Low_B =>
            Pp := Pp - 2.0 * P (5.0 / 3.0) - 2.0 * P (7.0 / 5.0);
            Pp := Pp - 2.0 * P (9.0 / 7.0) + 2.0 * P (12.0 / 10.0);
            Pp := Pp - 2.0 * P (13.0 / 11.0) - 2.0 * P (15.0 / 13.0);
            Pp := Pp + 5.5;
         when Up_B =>
            Pp := Pp - 2.0 * P (5.0 / 3.0) - 2.0 * P (7.0 / 5.0);
            Pp := Pp - 2.0 * P (9.0 / 7.0) + 2.0 * P (12.0 / 10.0);
            Pp := Pp + 2.0 * P (16.0 / 14.0);
            Pp := Pp - 3.5;
         when Ap_B =>
            Pp := Pp - 2.0 * P (5.0 / 3.0) - 2.0 * P (7.0 / 5.0);
            Pp := Pp - 2.0 * P (9.0 / 7.0) + 2.0 * P (12.0 / 10.0);
            Pp := Pp - 2.0 * P (13.0 / 11.0) - 2.0 * P (15.0 / 13.0);
            Pp := Pp + 2.0 * P (16.0 / 14.0) + 2.0 * P (17.0 / 15.0);
            Pp := Pp - 0.48 * P (19.0 / 17.0);
            Pp := Pp - 1.5;
      end case;
      if Pp >= 2.0 ** 64 then
         return Int.I128 (U64'Last);
      elsif Pp <= 0.0 then
         return 0;
      else
         return Int.I128 (U64 (Long_Float'Truncation (Pp)));
      end if;
   end Perfect_Bound;

   function Nth_Perfect_Power_Lower (N : U64) return Optional_I128 is
     (if N = 0 then (Defined => False)
      else (True, Perfect_Bound (N, Low_B)));
   function Nth_Perfect_Power_Upper (N : U64) return Optional_I128 is
     (if N = 0 then (Defined => False)
      else (True, Perfect_Bound (N, Up_B)));
   function Nth_Perfect_Power_Approx (N : U64) return Optional_I128 is
     (if N = 0 then (Defined => False)
      else (True, Perfect_Bound (N, Ap_B)));

   function Nth_Perfect_Power (N : U64) return Optional_I128 is
      Lo : U64 := 1;
      Hi : U64 := U64'Last;
      Mid : U64;
      Steps : U64;
      G : U128;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (True, 1);
      elsif N > Max_Perfect_Idx then
         G := 2 ** 64;
         Steps := N - Max_Perfect_Idx - 1;
         while Steps > 0 loop
            G := Next_Raw (G, False);
            Steps := Steps - 1;
         end loop;
         return (True, To_I128 (G));
      end if;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo) / 2;
         if Perfect_Power_Count (Mid) < N then
            Lo := Mid + 1;
         else
            Hi := Mid;
         end if;
      end loop;
      return (True, Int.I128 (Lo));
   end Nth_Perfect_Power;
end Math_Prime_Util.Powers;
