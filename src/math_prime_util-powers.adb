with Math_Prime_Util.Count;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Powers with SPARK_Mode => Off is

   --  perfect_powers.c: _moebius, exponents 0 .. 64.
   Moebius : constant array (Natural range 0 .. 64) of Integer :=
     [0, 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1,
      0, -1, 0, -1, 0, 1, 1, -1, 0, 0, 1, 0, 0, -1, -1, -1,
      0, 1, 1, 1, 0, -1, 1, 1, 0, -1, -1, -1, 0, 0, 1, -1,
      0, 0, 0, 1, 0, -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0, 0];

   type Bound_Kind is (Exact, Lower, Upper, Approx);
   type Estimate_Kind is (Lower_Est, Upper_Est, Approx_Est);

   function Log2_U64 (N : U64) return Natural is
     (Natural (Int.Logint (N, 2)));

   function Log2_U128 (N : U128) return Natural is
      V : U128 := N;
      L : Natural := 0;
   begin
      while V > 1 loop
         V := V / 2;
         L := L + 1;
      end loop;
      return L;
   end Log2_U128;

   --  True when Base**Exp <= Limit. Exp is at most 128.
   function Pow_Le (Base : U128; Exp : Natural; Limit : U128)
      return Boolean
   is
      Acc : U128 := 1;
      Left : Natural := Exp;
   begin
      if Exp = 0 then
         return True;
      elsif Base = 0 then
         return True;
      end if;
      while Left > 0 loop
         if Acc > Limit / Base then
            return False;
         end if;
         Acc := Acc * Base;
         Left := Left - 1;
      end loop;
      return True;
   end Pow_Le;

   function Pow_U128 (Base : U128; Exp : Natural) return U128 is
      Acc : U128 := 1;
      B : U128 := Base;
      E : Natural := Exp;
   begin
      while E > 0 loop
         if E mod 2 = 1 then
            if B /= 0 and then Acc > U128'Last / B then
               return 0;
            end if;
            Acc := Acc * B;
         end if;
         E := E / 2;
         if E > 0 then
            if B > U128'Last / B then
               return 0;
            end if;
            B := B * B;
         end if;
      end loop;
      return Acc;
   end Pow_U128;

   function Root_U128 (N : U128; K : Natural) return U128 is
      Lo : U128 := 0;
      Hi : U128 := 2;
      Mid : U128;
   begin
      if K = 0 then
         raise Constraint_Error with "zero root exponent";
      elsif N <= 1 or K = 1 then
         return N;
      end if;
      while Pow_Le (Hi, K, N) loop
         exit when Hi > U128'Last / 2;
         Hi := Hi * 2;
      end loop;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         if Pow_Le (Mid, K, N) then
            Lo := Mid;
         else
            Hi := Mid - 1;
         end if;
      end loop;
      return Lo;
   end Root_U128;

   function Root (N : U128; K : Natural) return U128 is
     (if N <= U128 (U64'Last)
      then U128 (Int.Rootint (U64 (N), U64 (K)))
      else Root_U128 (N, K));

   function Largest_Exponent (N : U128) return Natural is
      Best : Natural;
      R : U128;
   begin
      if N <= 1 then
         return 0;
      elsif N <= U128 (U64'Last) then
         return Natural (Int.Is_Power_Exp (U64 (N)));
      end if;
      Best := Log2_U128 (N);
      while Best >= 2 loop
         R := Root_U128 (N, Best);
         if Pow_U128 (R, Best) = N then
            return Best;
         end if;
         Best := Best - 1;
      end loop;
      return 0;
   end Largest_Exponent;

   function Odd_Power (Exponent : Natural) return Boolean is
     (Exponent > 2 and then (Exponent and (Exponent - 1)) /= 0);

   function Magnitude (N : Int.I128) return U128 is
     (if N >= 0 then U128 (N) else U128 (-N));

   function To_I128 (N : U128) return Int.I128 is
     (Int.I128 (N));

   function Prime_Power (N : U64) return Prime_Power_Factor is
      M : U64 := N;
      E : U64 := 0;
      R : U64;
   begin
      if N < 2 then
         return (0, 0);
      elsif N mod 2 = 0 then
         if (N and (N - 1)) /= 0 then
            return (0, 0);
         end if;
         return (U64 (Log2_U64 (N)), 2);
      end if;
      declare
         Small : constant array (1 .. 3) of U64 := [3, 5, 7];
      begin
         for P of Small loop
            if M mod P = 0 then
               while M > 1 and then M mod P = 0 loop
                  M := M / P;
                  E := E + 1;
               end loop;
               if M /= 1 then
                  return (0, 0);
               end if;
               return (E, P);
            end if;
         end loop;
      end;
      if Primality.Is_Prob_Prime (N) /= 0 then
         return (1, N);
      end if;
      E := Int.Is_Power_Exp (N);
      if E > 1 then
         R := Int.Rootint (N, E);
         if Primality.Is_Prob_Prime (R) /= 0 then
            return (E, R);
         end if;
      end if;
      return (0, 0);
   end Prime_Power;

   function Is_Prime_Power (N : U64) return U64 is
     (Prime_Power (N).Exponent);

   function Bit_At (Shift : Natural) return U64 is
     (2 ** Shift);

   function Next_Prime_Power (N : U64) return U128 is
      Bit : U64;
      I : U64;
   begin
      if N < 2 then
         return 2;
      elsif N >= Max_Prime then
         return 2 ** 64;
      end if;
      Bit := Bit_At (Log2_U64 (N));
      I := N + 1 + (N and 1);
      while (I and Bit) /= 0 loop
         if Is_Prime_Power (I) /= 0 then
            return U128 (I);
         end if;
         exit when I > U64'Last - 2;
         I := I + 2;
      end loop;
      return U128 (I - 1);
   end Next_Prime_Power;

   function Prev_Prime_Power (N : U64) return Int.Optional_U64 is
      M : U64;
      Bit : U64;
      I : U64;
   begin
      if N <= 2 then
         return (Defined => False);
      end if;
      M := N - 1;
      Bit := Bit_At (Log2_U64 (M));
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

   procedure Append_Powers
     (Low, High : U64; Into : in out Power_Vectors.Vector)
   is
      Log_N : constant Natural := Log2_U64 (High);
      Limit, Pk : U64;
      Power : Int.Optional_U64;
   begin
      for K in 2 .. Log_N loop
         Limit := Int.Rootint (High, U64 (K));
         exit when Limit < 2;
         for P of Sieve.Primes (Limit) loop
            Power := Int.Powint (P, U64 (K));
            if Power.Defined then
               Pk := Power.Value;
               if Pk >= Low and then Pk <= High then
                  Into.Append (Pk);
               end if;
            end if;
         end loop;
      end loop;
   end Append_Powers;

   package Power_Sort is new Power_Vectors.Generic_Sorting;

   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector is
      Result : Power_Vectors.Vector;
      Scan : U64;
      Width : U128;
      I : U64;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      Width := U128 (High) - U128 (Low);
      Scan := (if High < 7_929_856 then 10
               else Int.Sqrtint (High) / 256);
      if Width < U128 (Scan) then
         I := U64'Max (Low, 2);
         loop
            if Is_Prime_Power (I) /= 0 then
               Result.Append (I);
            end if;
            exit when I = High;
            I := I + 1;
         end loop;
         return Result;
      end if;
      for P of Sieve.Primes (Low, High) loop
         Result.Append (P);
      end loop;
      Append_Powers (Low, High, Result);
      Power_Sort.Sort (Result);
      return Result;
   end Prime_Powers;

   function Prime_Powers (High : U64) return Power_Vectors.Vector is
     (Prime_Powers (0, High));

   function Count_By (N : U64; Kind : Bound_Kind) return U64 is
     (case Kind is
         when Exact => Count.Prime_Count (N),
         when Lower => Count.Prime_Count_Lower (N),
         when Upper => Count.Prime_Count_Upper (N),
         when Approx => Count.Prime_Count_Approx (N));

   function Prime_Power_Sum (N : U64; Kind : Bound_Kind) return U64 is
      Sum : U64;
      Log_N : Natural;
   begin
      if N <= 5 then
         return (if N = 0 then 0 else N - 1);
      end if;
      Sum := Count_By (N, Kind);
      Log_N := Log2_U64 (N);
      for K in 2 .. Log_N loop
         Sum := Sum + Count_By (Int.Rootint (N, U64 (K)), Kind);
      end loop;
      return Sum;
   end Prime_Power_Sum;

   function Prime_Power_Count (N : U64) return U64 is
     (Prime_Power_Sum (N, Exact));

   function Prime_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else Low > High then
         return 0;
      end if;
      return Prime_Power_Count (High)
        - (if Low <= 2 then 0 else Prime_Power_Count (Low - 1));
   end Prime_Power_Count;

   function Prime_Power_Count_Lower (N : U64) return U64 is
     (Prime_Power_Sum (N, Lower));

   function Prime_Power_Count_Upper (N : U64) return U64 is
     (Prime_Power_Sum (N, Upper));

   function Prime_Power_Count_Approx (N : U64) return U64 is
     (Prime_Power_Sum (N, Approx));

   function Simple_Lower (N : U64) return U64 is
      V : Long_Float;
   begin
      if N <= 100 then
         return N + 1;
      end if;
      V := 0.98 * Long_Float (Count.Nth_Prime_Lower (N)) - 400.0;
      if V <= 0.0 then
         return 0;
      end if;
      return U64 (Long_Float'Truncation (V));
   end Simple_Lower;

   function Inverse_Sum
     (Low, High, Target : U64; Kind : Bound_Kind) return U64
   is
      Lo : U64 := Low;
      Hi : U64 := High;
      Mid : U64;
   begin
      if Hi < Lo then
         return Lo;
      elsif Prime_Power_Sum (Lo, Kind) >= Target then
         return Lo;
      end if;
      while Hi - Lo > 1 loop
         Mid := Lo + (Hi - Lo) / 2;
         if Prime_Power_Sum (Mid, Kind) >= Target then
            Hi := Mid;
         else
            Lo := Mid;
         end if;
      end loop;
      return Hi;
   end Inverse_Sum;

   function Small_Nth (N : U64) return U64 is
     (if N = 0 then 0 else N + 1 + N / 5);

   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      end if;
      return (True, Inverse_Sum
        (Simple_Lower (N), Count.Nth_Prime_Upper (N), N, Upper));
   end Nth_Prime_Power_Lower;

   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      end if;
      return (True, Inverse_Sum
        (Simple_Lower (N), Count.Nth_Prime_Upper (N), N, Lower));
   end Nth_Prime_Power_Upper;

   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      end if;
      return (True, Inverse_Sum
        (Simple_Lower (N), Count.Nth_Prime_Upper (N), N, Approx));
   end Nth_Prime_Power_Approx;

   function Nth_Prime_Power (N : U64) return Int.Optional_U64 is
      Tol : constant U64 := 800;
      Approx_N, Guess, Count_At, Other, Adjust : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Span, Step : U64;
      Below : Boolean;
      Settled : Boolean := False;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, Small_Nth (N));
      end if;
      Approx_N := Nth_Prime_Power_Approx (N).Value;
      Guess := Approx_N;
      Count_At := Prime_Power_Count (Guess);
      for Gn in 2 .. 19 loop
         if Count_At = N
           or else (N > Count_At and then N - Count_At < Tol)
           or else (Count_At > N and then Count_At - N < Tol)
         then
            Settled := True;
            exit;
         end if;
         Other := Nth_Prime_Power_Approx (Count_At).Value;
         if Count_At <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_At >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_N >= Other then
            Adjust := Approx_N - Other;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Other - Approx_N;
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
               Guess := Ming + (Span / 2);
            elsif Below then
               Guess := Ming + Step;
            else
               Guess := Maxg - Step;
            end if;
         end if;
         Count_At := Prime_Power_Count (Guess);
      end loop;
      if not Settled then
         Count_At := Prime_Power_Count (Guess);
      end if;
      if Count_At < N then
         while Count_At < N loop
            loop
               Guess := Guess + 1;
               exit when Is_Prime_Power (Guess) /= 0;
            end loop;
            Count_At := Count_At + 1;
         end loop;
      else
         while Is_Prime_Power (Guess) = 0 loop
            Guess := Guess - 1;
         end loop;
         while Count_At > N loop
            loop
               Guess := Guess - 1;
               exit when Is_Prime_Power (Guess) /= 0;
            end loop;
            Count_At := Count_At - 1;
         end loop;
      end if;
      return (True, Guess);
   end Nth_Prime_Power;

   function Perfect_Power_Count (N : U128) return U64 is
      Sum : U128 := 1;
      Log_N : Natural;
      Mk : Integer;
      R : U128;
   begin
      if N < 8 then
         return (if N >= 1 then 1 else 0) + (if N >= 4 then 1 else 0);
      end if;
      Log_N := Log2_U128 (N);
      for K in 2 .. Log_N loop
         Mk := Moebius (K);
         if Mk /= 0 then
            R := Root (N, K) - 1;
            if Mk > 0 then
               Sum := Sum - R;
            else
               Sum := Sum + R;
            end if;
         end if;
      end loop;
      return U64 (Sum);
   end Perfect_Power_Count;

   function Perfect_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 1 or else Low > High then
         return 0;
      end if;
      return Perfect_Power_Count (U128 (High))
        - (if Low <= 1 then 0
           else Perfect_Power_Count (U128 (Low - 1)));
   end Perfect_Power_Count;

   function Perfect_Power_Count_Lower (N : U128) return U64 is
     (Perfect_Power_Count (N));

   function Perfect_Power_Count_Upper (N : U128) return U64 is
     (Perfect_Power_Count (N));

   function Perfect_Power_Count_Approx (N : U128) return U64 is
     (Perfect_Power_Count (N));

   function Estimate (N : U64; Kind : Estimate_Kind) return U64 is
      X : constant Long_Float := Long_Float (N);
      Pp : Long_Float;
   begin
      if N <= 1 then
         return N;
      elsif N >= Max_Perfect_Index then
         return Max_Perfect_Power;
      end if;
      Pp := X * X
        + (13.0 / 3.0) * X ** (4.0 / 3.0)
        + (32.0 / 15.0) * X ** (16.0 / 15.0);
      case Kind is
         when Approx_Est =>
            Pp := Pp - 2.0 * X ** (5.0 / 3.0)
              - 2.0 * X ** (7.0 / 5.0)
              - 2.0 * X ** (9.0 / 7.0)
              + 2.0 * X ** (12.0 / 10.0);
            Pp := Pp - 2.0 * X ** (13.0 / 11.0)
              - 2.0 * X ** (15.0 / 13.0)
              + 2.0 * X ** (16.0 / 14.0)
              + 2.0 * X ** (17.0 / 15.0);
            Pp := Pp - 0.48 * X ** (19.0 / 17.0) - 1.5;
         when Lower_Est =>
            Pp := Pp - 2.0 * X ** (5.0 / 3.0)
              - 2.0 * X ** (7.0 / 5.0)
              - 2.0 * X ** (9.0 / 7.0)
              + 2.0 * X ** (12.0 / 10.0);
            Pp := Pp - 2.0 * X ** (13.0 / 11.0)
              - 2.0 * X ** (15.0 / 13.0) + 5.5;
         when Upper_Est =>
            Pp := Pp - 2.0 * X ** (5.0 / 3.0)
              - 2.0 * X ** (7.0 / 5.0)
              - 2.0 * X ** (9.0 / 7.0)
              + 2.0 * X ** (12.0 / 10.0)
              + 2.0 * X ** (16.0 / 14.0) - 3.5;
      end case;
      if Pp >= 2.0 ** 64 then
         return U64'Last;
      elsif Pp <= 0.0 then
         return 0;
      end if;
      return U64 (Long_Float'Truncation (Pp));
   end Estimate;

   function Nth_Perfect_Power_Lower (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False)
      else (True, Estimate (N, Lower_Est)));

   function Nth_Perfect_Power_Upper (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False)
      else (True, Estimate (N, Upper_Est)));

   function Nth_Perfect_Power_Approx (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False)
      else (True, Estimate (N, Approx_Est)));

   function Next_Raw (N : U128; Odd : Boolean) return U128 is
      Kinit : constant Natural := (if Odd then 3 else 2);
      Kinc : constant Natural := (if Odd then 2 else 1);
      Log_N : Natural;
      Best, Candidate, R : U128;
      K : Natural;
   begin
      if N = 0 then
         return 1;
      elsif N = 1 then
         return (if Odd then 8 else 4);
      end if;
      Log_N := Log2_U128 (N);
      Best := Pow_U128 (Root (N, Kinit) + 1, Kinit);
      K := Kinit + Kinc;
      while K <= Log_N + 1 loop
         R := Root (N, K) + 1;
         Candidate := Pow_U128 (R, K);
         if Candidate /= 0 and then Candidate < Best
           and then Candidate > N
         then
            Best := Candidate;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Next_Raw;

   function Prev_Raw (N : U128; Odd : Boolean) return U128 is
      Kinit : constant Natural := (if Odd then 3 else 2);
      Kinc : constant Natural := (if Odd then 2 else 1);
      Log_N : Natural;
      Best, Candidate, R : U128;
      K : Natural;
   begin
      if N <= 4 then
         return (if N > 1 then 1 else 0);
      elsif N <= 8 then
         return (if Odd then 1 else 4);
      end if;
      Log_N := Log2_U128 (N);
      Best := 8;
      K := Kinit;
      while K <= Log_N loop
         R := Root (N, K);
         Candidate := Pow_U128 (R, K);
         if Candidate >= N and then R > 0 then
            Candidate := Pow_U128 (R - 1, K);
         end if;
         if Candidate > Best and then Candidate < N then
            Best := Candidate;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Prev_Raw;

   function Is_Perfect_Power (N : Int.I128) return Boolean is
      E : Natural;
   begin
      if N < 0 then
         E := Largest_Exponent (Magnitude (N));
         return Odd_Power (E) or else Magnitude (N) <= 1;
      elsif N <= 1 then
         return True;
      end if;
      return Largest_Exponent (U128 (N)) > 1;
   end Is_Perfect_Power;

   function Next_Perfect_Power (N : Int.I128) return Int.I128 is
   begin
      if N < 1 and then N >= -4 then
         return Int.I128 (Boolean'Pos (N >= 0) - Boolean'Pos (N < -1));
      elsif N < 0 then
         return -To_I128 (Prev_Raw (Magnitude (N), True));
      end if;
      return To_I128 (Next_Raw (U128 (N), False));
   end Next_Perfect_Power;

   function Prev_Perfect_Power (N : Int.I128) return Int.I128 is
   begin
      if N >= 0 and then N <= 4 then
         return Int.I128 (Boolean'Pos (N > 1) - Boolean'Pos (N = 0));
      elsif N < 0 then
         return -To_I128 (Next_Raw (Magnitude (N), True));
      end if;
      return To_I128 (Prev_Raw (U128 (N), False));
   end Prev_Perfect_Power;

   function Nth_Perfect_Power (N : U64) return Optional_U128 is
      Tol : constant U64 := 1_000;
      Guess, Count_At, Approx_N, Other : U128;
      Adjust : U128;
      Ming : U128 := 0;
      Maxg : U128 := U128'Last;
      Steps : Natural := 0;
      Span, Step : U128;
      Below : Boolean;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = Max_Perfect_Index + 1 then
         return (True, 2 ** 64);
      elsif N > Max_Perfect_Index then
         return (True, U128 (Max_Perfect_Power));
      elsif N <= 1 then
         return (True, U128 (N));
      end if;
      Approx_N := U128 (Nth_Perfect_Power_Approx (N).Value);
      Guess := Approx_N;
      Count_At := U128 (Perfect_Power_Count (Guess));
      while Steps < 18 loop
         exit when Count_At = U128 (N)
           or else (U128 (N) > Count_At
                    and then U128 (N) - Count_At < U128 (Tol))
           or else (Count_At > U128 (N)
                    and then Count_At - U128 (N) < U128 (Tol));
         Other := U128
           (Nth_Perfect_Power_Approx (U64 (Count_At)).Value);
         if Count_At <= U128 (N) and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_At >= U128 (N) and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_N >= Other then
            Adjust := Approx_N - Other;
            if Guess > U128'Last - Adjust then
               Guess := U128'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Other - Approx_N;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := U128 (Tol - 1);
            Below := Guess <= Ming;
            if Span <= 1 then
               Guess := (if Below then Maxg else Ming);
            elsif Step >= Span then
               Guess := Ming + (Span / 2);
            elsif Below then
               Guess := Ming + Step;
            else
               Guess := Maxg - Step;
            end if;
         end if;
         Count_At := U128 (Perfect_Power_Count (Guess));
         Steps := Steps + 1;
      end loop;
      if Guess > U128 (Max_Perfect_Power) then
         Guess := U128 (Max_Perfect_Power);
         Count_At := U128 (Perfect_Power_Count (Guess));
      end if;
      if Count_At >= U128 (N) then
         Guess := Prev_Raw (Guess + 1, False);
         while Count_At > U128 (N) loop
            Guess := Prev_Raw (Guess, False);
            Count_At := Count_At - 1;
         end loop;
      else
         while Count_At < U128 (N) loop
            Guess := Next_Raw (Guess, False);
            Count_At := Count_At + 1;
         end loop;
      end if;
      return (True, Guess);
   end Nth_Perfect_Power;
end Math_Prime_Util.Powers;
