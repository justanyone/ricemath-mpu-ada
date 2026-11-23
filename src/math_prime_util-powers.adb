with Interfaces;
with Ada.Numerics.Long_Elementary_Functions;
with Math_Prime_Util.Count;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Powers with SPARK_Mode => Off is
   use Ada.Numerics.Long_Elementary_Functions;
   use type U128;
   use type Interfaces.Unsigned_8;
   subtype F64 is Long_Float;

   type Pow_Result (Ok : Boolean := False) is record
      case Ok is
         when True => Value : U128;
         when False => null;
      end case;
   end record;

   --  util.c moebius values through 64, used by perfect_power_count.
   Moebius : constant array (Natural range 0 .. 64) of Integer :=
     [0, 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1, 0, -1,
      0, -1, 0, 1, 1, -1, 0, 0, 1, 0, 0, -1, -1, -1, 0, 1, 1, 1,
      0, -1, 1, 1, 0, -1, -1, -1, 0, 0, 1, -1, 0, 0, 0, 1, 0,
      -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0, 0];

   function Trunc (X : F64) return U64 is
     (U64 (F64'Floor (X)));

   function Floor_Log2 (N : U128) return Natural with
     Pre => N > 0;
   function Floor_Log2 (N : U128) return Natural is
      High : constant U64 := U64 (N / 2 ** 64);
   begin
      if High /= 0 then
         return 64 + Natural (Int.Logint (High, 2));
      end if;
      return Natural (Int.Logint (U64 (N), 2));
   end Floor_Log2;

   --  util.c: ipowsafe. Ok is false when the power exceeds U128.
   function Try_Pow (Base : U128; Exp : Natural) return Pow_Result;
   function Try_Pow (Base : U128; Exp : Natural) return Pow_Result is
      Result : U128 := 1;
      Factor : U128 := Base;
      Left : Natural := Exp;
   begin
      if Base = 0 then
         return (if Exp = 0 then (True, U128'(1)) else (True, U128'(0)));
      elsif Exp = 0 or else Base = 1 then
         return (True, U128'(1));
      end if;
      while Left > 0 loop
         if Left mod 2 = 1 then
            if Result > U128'Last / Factor then
               return (Ok => False);
            end if;
            Result := Result * Factor;
         end if;
         Left := Left / 2;
         if Left > 0 then
            if Factor > U128'Last / Factor then
               return (Ok => False);
            end if;
            Factor := Factor * Factor;
         end if;
      end loop;
      return (True, Result);
   end Try_Pow;

   --  Floor K-th root. K = 1 returns N.
   function Wide_Root (N : U128; K : Positive) return U128;
   function Wide_Root (N : U128; K : Positive) return U128 is
      Lo : U128 := 0;
      Hi : U128 := N;
      Mid : U128;
      Power : Pow_Result;
   begin
      if K = 1 or else N <= 1 then
         return N;
      end if;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         Power := Try_Pow (Mid, K);
         if not Power.Ok or else Power.Value > N then
            Hi := Mid - 1;
         else
            Lo := Mid;
         end if;
      end loop;
      return Lo;
   end Wide_Root;

   function Largest_Exponent (N : U128) return Natural;
   function Largest_Exponent (N : U128) return Natural is
      Log2 : Natural;
      Power : Pow_Result;
   begin
      if N <= 3 then
         return 0;
      elsif N <= U128 (U64'Last) then
         return Natural (Int.Is_Power_Exp (U64 (N)));
      end if;
      Log2 := Floor_Log2 (N);
      for K in reverse 2 .. Log2 loop
         Power := Try_Pow (Wide_Root (N, K), K);
         if Power.Ok and then Power.Value = N then
            return K;
         end if;
      end loop;
      return 0;
   end Largest_Exponent;

   type Base is record
      Exponent : Natural;
      Prime : U64;
   end record;

   --  prime_powers.c: prime_power.
   function Classify (N : U64) return Base;
   function Classify (N : U64) return Base is
      M : U64;
      Power : Natural;
      Exp : U64;
      Root : U64;

      function Pure (Divisor : U64) return Base;
      function Pure (Divisor : U64) return Base is
      begin
         M := N;
         Power := 0;
         while M mod Divisor = 0 loop
            M := M / Divisor;
            Power := Power + 1;
         end loop;
         if M /= 1 then
            return (0, 0);
         end if;
         return (Power, Divisor);
      end Pure;
   begin
      if N < 2 then
         return (0, 0);
      elsif N mod 2 = 0 then
         if (N and (N - 1)) /= 0 then
            return (0, 0);
         end if;
         return (Natural (Int.Logint (N, 2)), 2);
      elsif N mod 3 = 0 then
         return Pure (3);
      elsif N mod 5 = 0 then
         return Pure (5);
      elsif N mod 7 = 0 then
         return Pure (7);
      elsif Primality.Is_Prob_Prime (N) /= 0 then
         return (1, N);
      end if;
      Exp := Int.Is_Power_Exp (N);
      if Exp > 1 then
         Root := Int.Rootint (N, Exp);
         if Primality.Is_Prob_Prime (Root) /= 0 then
            return (Natural (Exp), Root);
         end if;
      end if;
      return (0, 0);
   end Classify;

   function Is_Prime_Power (N : U64) return Natural is
     (Classify (N).Exponent);

   function Prime_Power_Root (N : U64) return U64 is
     (Classify (N).Prime);

   function Next_Prime_Power (N : U64) return Int.Optional_U64 is
      Bit, Cursor : U64;
   begin
      if N < 2 then
         return (True, 2);
      elsif N >= Max_Prime then
         return (Defined => False);
      end if;
      Bit := U64'(2) ** Natural (Int.Logint (N, 2));
      Cursor := N + 1 + (N and 1);
      while (Cursor and Bit) /= 0 loop
         if Is_Prime_Power (Cursor) /= 0 then
            return (True, Cursor);
         end if;
         Cursor := Cursor + 2;
      end loop;
      return (True, Cursor - 1);
   end Next_Prime_Power;

   function Prev_Prime_Power (N : U64) return Int.Optional_U64 is
      M, Bit, Cursor : U64;
   begin
      if N <= 2 then
         return (Defined => False);
      end if;
      M := N - 1;
      Bit := U64'(2) ** Natural (Int.Logint (M, 2));
      if (M and 1) = 0 then
         Cursor := M - 1;
      else
         Cursor := M;
      end if;
      while (Cursor and Bit) /= 0 loop
         if Is_Prime_Power (Cursor) /= 0 then
            return (True, Cursor);
         end if;
         Cursor := Cursor - 2;
      end loop;
      return (True, Cursor + 1);
   end Prev_Prime_Power;

   function Higher_Powers (Low, High : U64) return Power_Vectors.Vector;
   function Higher_Powers (Low, High : U64) return Power_Vectors.Vector is
      Powers : Power_Vectors.Vector;
      Log2 : Natural;
      Limit : U64;
      Pk : Int.Optional_U64;
   begin
      if High < 4 then
         return Powers;
      end if;
      Log2 := Natural (Int.Logint (High, 2));
      for K in 2 .. Log2 loop
         Limit := Int.Rootint (High, U64 (K));
         for P of Sieve.Primes (Limit) loop
            Pk := Int.Powint (P, U64 (K));
            if Pk.Defined and then Pk.Value >= Low
              and then Pk.Value <= High
            then
               Powers.Append (Pk.Value);
            end if;
         end loop;
      end loop;
      declare
         package Sorter is new Power_Vectors.Generic_Sorting;
      begin
         Sorter.Sort (Powers);
      end;
      return Powers;
   end Higher_Powers;

   function Prime_Powers (Low, High : U64) return Power_Vectors.Vector is
      Result, Powers : Power_Vectors.Vector;
      Scanlim : U64;
      Ip, Iw : Integer;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      if High < 7_929_856 then
         Scanlim := 10;
      else
         Scanlim := Int.Sqrtint (High) / 256;
      end if;
      if High - Low < Scanlim then
         for Value in Low .. High loop
            if Is_Prime_Power (Value) /= 0 then
               Result.Append (Value);
            end if;
         end loop;
         return Result;
      end if;
      Powers := Higher_Powers (Low, High);
      declare
         Primes : constant Sieve.Prime_Vectors.Vector :=
           Sieve.Primes (Low, High);
      begin
         Ip := Primes.First_Index;
         Iw := Powers.First_Index;
         while Ip <= Primes.Last_Index and then Iw <= Powers.Last_Index
         loop
            if Primes.Element (Ip) < Powers.Element (Iw) then
               Result.Append (Primes.Element (Ip));
               Ip := Ip + 1;
            else
               Result.Append (Powers.Element (Iw));
               Iw := Iw + 1;
            end if;
         end loop;
         while Ip <= Primes.Last_Index loop
            Result.Append (Primes.Element (Ip));
            Ip := Ip + 1;
         end loop;
         while Iw <= Powers.Last_Index loop
            Result.Append (Powers.Element (Iw));
            Iw := Iw + 1;
         end loop;
      end;
      return Result;
   end Prime_Powers;

   function Prime_Powers (High : U64) return Power_Vectors.Vector is
     (Prime_Powers (0, High));

   function Prime_Power_Count (N : U64) return U64 is
      Sum : U64;
      Log2 : Natural;
   begin
      if N <= 5 then
         return (if N = 0 then 0 else N - 1);
      end if;
      Sum := Count.Prime_Count (N);
      Log2 := Natural (Int.Logint (N, 2));
      for K in 2 .. Log2 loop
         Sum := Sum + Count.Prime_Count (Int.Rootint (N, U64 (K)));
      end loop;
      return Sum;
   end Prime_Power_Count;

   function Prime_Power_Count (Low, High : U64) return U64 is
   begin
      if High < 2 or else Low > High then
         return 0;
      elsif Low <= 2 then
         return Prime_Power_Count (High);
      end if;
      return Prime_Power_Count (High) - Prime_Power_Count (Low - 1);
   end Prime_Power_Count;

   function Bounded_Count (N : U64; Kind : Character) return U64;
   function Bounded_Count (N : U64; Kind : Character) return U64 is
      Sum : U64;
      Log2 : Natural;
      function Term (Value : U64) return U64;
      function Term (Value : U64) return U64 is
      begin
         case Kind is
            when 'L' =>
               return Count.Prime_Count_Lower (Value);
            when 'U' =>
               return Count.Prime_Count_Upper (Value);
            when others =>
               return Count.Prime_Count_Approx (Value);
         end case;
      end Term;
   begin
      if N <= 5 then
         return (if N = 0 then 0 else N - 1);
      end if;
      Sum := Term (N);
      Log2 := Natural (Int.Logint (N, 2));
      for K in 2 .. Log2 loop
         Sum := Sum + Term (Int.Rootint (N, U64 (K)));
      end loop;
      return Sum;
   end Bounded_Count;

   function Prime_Power_Count_Lower (N : U64) return U64 is
     (Bounded_Count (N, 'L'));
   function Prime_Power_Count_Upper (N : U64) return U64 is
     (Bounded_Count (N, 'U'));
   function Prime_Power_Count_Approx (N : U64) return U64 is
     (Bounded_Count (N, 'A'));

   --  inverse_interpolate.c: inverse_interpolate, threshold zero. Keep
   --  integer brackets to avoid losing adjacent U64 values in floating point.
   generic
      with function Value (X : U64) return U64;
   function Inverse (Low, High, N : U64) return U64;

   function Inverse (Low, High, N : U64) return U64 is
      Lo : U64 := Low;
      Hi : U64 := High;
      Mid, Rlo, Rhi, Rmid : U64;
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
      while Hi - Lo > 1 loop
         Mid := Lo + (Hi - Lo) / 2;
         Rmid := Value (Mid);
         if Rmid < N then
            Lo := Mid;
            Rlo := Rmid;
         else
            Hi := Mid;
            Rhi := Rmid;
         end if;
      end loop;
      return (if Rlo = N or else Rhi > N then Lo else Hi);
   end Inverse;

   function Simple_Prime_Lower (N : U64) return U64;
   function Simple_Prime_Lower (N : U64) return U64 is
      V : F64;
   begin
      if N <= 100 then
         return N + 1;
      end if;
      V := 0.98 * F64 (Count.Nth_Prime_Lower (N)) - 400.0;
      if V <= 0.0 then
         return 0;
      elsif V >= 2.0 ** 64 then
         return U64'Last;
      end if;
      return Trunc (V);
   end Simple_Prime_Lower;

   function Value_Lower (X : U64) return U64 is
     (Prime_Power_Count_Lower (X));
   function Value_Upper (X : U64) return U64 is
     (Prime_Power_Count_Upper (X));
   function Value_Approx (X : U64) return U64 is
     (Prime_Power_Count_Approx (X));
   function Invert_Lower is new Inverse (Value_Lower);
   function Invert_Upper is new Inverse (Value_Upper);
   function Invert_Approx is new Inverse (Value_Approx);

   function Raw_Prime_Bound (N : U64; Kind : Character) return U64;
   function Raw_Prime_Bound (N : U64; Kind : Character) return U64 is
      Lo, Hi : U64;
   begin
      if N = 0 then
         return 0;
      elsif N <= 7 then
         return N + 1 + N / 5;
      elsif N > Max_Prime_Index then
         return Max_Prime;
      end if;
      Lo := Simple_Prime_Lower (N);
      Hi := Count.Nth_Prime_Upper (N);
      if Lo > Hi then
         declare
            Swap : constant U64 := Lo;
         begin
            Lo := Hi;
            Hi := Swap;
         end;
      end if;
      case Kind is
         when 'L' =>
            return Invert_Upper (Lo, Hi, N);
         when 'U' =>
            return Invert_Lower (Lo, Hi, N);
         when others =>
            return Invert_Approx (Lo, Hi, N);
      end case;
   end Raw_Prime_Bound;

   function Nth_Prime_Power_Lower (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False) else (True, Raw_Prime_Bound (N, 'L')));
   function Nth_Prime_Power_Upper (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False) else (True, Raw_Prime_Bound (N, 'U')));
   function Nth_Prime_Power_Approx (N : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False) else (True, Raw_Prime_Bound (N, 'A')));

   function Nth_Prime_Power (N : U64) return Int.Optional_U64 is
      Guess : U64;
      Approx_Nth, Count_At, Adjust, Approx_Count, Span, Step : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Settled : Boolean := False;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 7 then
         return (True, N + 1 + N / 5);
      elsif N > Max_Prime_Index then
         return (True, Max_Prime);
      end if;
      --  inverse_interpolate.c: interpolate_with_approx, tolerance 800.
      Guess := Raw_Prime_Bound (N, 'A');
      Approx_Nth := Guess;
      Count_At := 0;
      for Gn in 2 .. 19 loop
         Count_At := Prime_Power_Count (Guess);
         if N = Count_At
           or else (N > Count_At and then N - Count_At < 800)
           or else (N < Count_At and then Count_At - N < 800)
         then
            Settled := True;
            exit;
         end if;
         Approx_Count := Raw_Prime_Bound (Count_At, 'A');
         if Count_At <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_At >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_Nth >= Approx_Count then
            Adjust := Approx_Nth - Approx_Count;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Approx_Count - Approx_Nth;
            if Adjust > Guess then
               Guess := 0;
            else
               Guess := Guess - Adjust;
            end if;
         end if;
         if Guess <= Ming or else Guess >= Maxg then
            Span := Maxg - Ming;
            Step := 799;
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

   --  perfect_powers.c: _next_perfect_power. Odd_Only selects odd exponents.
   function Next_Wide (N : U128; Odd_Only : Boolean) return U128;
   function Next_Wide (N : U128; Odd_Only : Boolean) return U128 is
      Kinit : constant Positive := (if Odd_Only then 3 else 2);
      Kinc : constant Positive := (if Odd_Only then 2 else 1);
      Log2, K : Natural;
      Best : U128;
      Cand : Pow_Result;
      Root : U128;
   begin
      if N = 0 then
         return 1;
      elsif N = 1 then
         return (if Odd_Only then 8 else 4);
      end if;
      Log2 := Floor_Log2 (N);
      Root := Wide_Root (N, Kinit) + 1;
      Best := U128'Last;
      Cand := Try_Pow (Root, Kinit);
      if Cand.Ok then
         Best := Cand.Value;
      end if;
      K := Kinit + Kinc;
      while K <= Log2 + 1 loop
         Root := Wide_Root (N, K) + 1;
         Cand := Try_Pow (Root, K);
         if Cand.Ok and then Cand.Value < Best and then Cand.Value > N then
            Best := Cand.Value;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Next_Wide;

   function Prev_Wide (N : U128; Odd_Only : Boolean) return U128;
   function Prev_Wide (N : U128; Odd_Only : Boolean) return U128 is
      Kinit : constant Positive := (if Odd_Only then 3 else 2);
      Kinc : constant Positive := (if Odd_Only then 2 else 1);
      Best : U128 := 8;
      Log2, K : Natural;
      Root : U128;
      Cand : Pow_Result;
   begin
      if N <= 4 then
         return (if N > 1 then 1 else 0);
      elsif N <= 8 then
         return (if Odd_Only then 1 else 4);
      end if;
      Log2 := Floor_Log2 (N);
      K := Kinit;
      while K <= Log2 loop
         Root := Wide_Root (N, K);
         Cand := Try_Pow (Root, K);
         if Cand.Ok and then Cand.Value >= N and then Root > 0 then
            Cand := Try_Pow (Root - 1, K);
         end if;
         if Cand.Ok and then Cand.Value > Best and then Cand.Value < N then
            Best := Cand.Value;
         end if;
         K := K + Kinc;
      end loop;
      return Best;
   end Prev_Wide;

   function Is_Perfect_Power (N : Power_Domain) return Boolean is
      K : Natural;
   begin
      if N >= -1 and then N <= 1 then
         return True;
      elsif N > 1 then
         return Largest_Exponent (U128 (N)) > 1;
      end if;
      K := Largest_Exponent (U128 (-N));
      return K > 2 and then (U64 (K) and (U64 (K) - 1)) /= 0;
   end Is_Perfect_Power;

   function Next_Perfect_Power (N : Power_Domain) return Int.I128 is
   begin
      if N >= 0 then
         return Int.I128 (Next_Wide (U128 (N), False));
      end if;
      return -Int.I128 (Prev_Wide (U128 (-N), True));
   end Next_Perfect_Power;

   function Prev_Perfect_Power (N : Power_Domain) return Int.I128 is
   begin
      if N = 0 then
         return -1;
      elsif N > 0 then
         return Int.I128 (Prev_Wide (U128 (N), False));
      end if;
      return -Int.I128 (Next_Wide (U128 (-N), True));
   end Prev_Perfect_Power;

   function Perfect_Power_Count (N : U64) return U64 is
      Sum : Int.I128 := 1;
      Log2 : Natural;
      Term : U64;
   begin
      if N < 8 then
         return (if N >= 4 then 2 elsif N >= 1 then 1 else 0);
      end if;
      Log2 := Natural (Int.Logint (N, 2));
      for K in 2 .. Log2 loop
         if Moebius (K) /= 0 then
            Term := Int.Rootint (N, U64 (K)) - 1;
            Sum := Sum - Int.I128 (Moebius (K)) * Int.I128 (Term);
         end if;
      end loop;
      return U64 (Sum);
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

   function Perfect_Power_Count_Lower (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Perfect_Power_Count_Upper (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Perfect_Power_Count_Approx (N : U64) return U64 is
     (Perfect_Power_Count (N));

   function To_U64 (Value : F64) return U64;
   function To_U64 (Value : F64) return U64 is
   begin
      if Value >= 2.0 ** 64 then
         return U64'Last;
      elsif Value <= 0.0 then
         return 0;
      end if;
      return U64 (F64'Floor (Value));
   end To_U64;

   function Raw_Perfect_Bound (N : U64; Kind : Character) return U64;
   function Raw_Perfect_Bound (N : U64; Kind : Character) return U64 is
      X : constant F64 := F64 (N);
      Pp : F64;
   begin
      if N <= 1 then
         return N;
      elsif N >= Max_Perfect_Power_Index then
         return Max_Perfect_Power;
      end if;
      Pp := X * X + (13.0 / 3.0) * X ** (4.0 / 3.0)
        + (32.0 / 15.0) * X ** (16.0 / 15.0);
      Pp := Pp - 2.0 * X ** (5.0 / 3.0) - 2.0 * X ** (7.0 / 5.0)
        - 2.0 * X ** (9.0 / 7.0) + 2.0 * X ** (12.0 / 10.0);
      case Kind is
         when 'L' =>
            Pp := Pp - 2.0 * X ** (13.0 / 11.0)
              - 2.0 * X ** (15.0 / 13.0) + 5.5;
         when 'U' =>
            Pp := Pp + 2.0 * X ** (16.0 / 14.0) - 3.5;
         when others =>
            Pp := Pp - 2.0 * X ** (13.0 / 11.0)
              - 2.0 * X ** (15.0 / 13.0) + 2.0 * X ** (16.0 / 14.0)
              + 2.0 * X ** (17.0 / 15.0)
              - 0.48 * X ** (19.0 / 17.0) - 1.5;
      end case;
      return To_U64 (Pp);
   end Raw_Perfect_Bound;

   function As_Optional (N, Value : U64) return Int.Optional_U64 is
     (if N = 0 then (Defined => False) else (True, Value));

   function Nth_Perfect_Power_Lower (N : U64) return Int.Optional_U64 is
     (As_Optional (N, Raw_Perfect_Bound (N, 'L')));
   function Nth_Perfect_Power_Upper (N : U64) return Int.Optional_U64 is
     (As_Optional (N, Raw_Perfect_Bound (N, 'U')));
   function Nth_Perfect_Power_Approx (N : U64) return Int.Optional_U64 is
     (As_Optional (N, Raw_Perfect_Bound (N, 'A')));

   function Nth_Perfect_Power (N : U64) return Optional_I128 is
      Guess, Count_At, Approx_Nth, Adjust, Approx_Count : U64;
      Ming : U64 := 0;
      Maxg : U64 := U64'Last;
      Span, Step : U64;
      Settled : Boolean := False;
   begin
      if N = 0 or else N > Max_Perfect_Power_Index + 1 then
         return (Defined => False);
      elsif N <= 1 then
         return (True, Int.I128 (N));
      elsif N >= Max_Perfect_Power_Index then
         if N = Max_Perfect_Power_Index then
            return (True, Int.I128 (Max_Perfect_Power));
         end if;
         return (True, 2 ** 64);
      end if;
      Guess := Raw_Perfect_Bound (N, 'A');
      Approx_Nth := Guess;
      Count_At := 0;
      for Gn in 2 .. 19 loop
         Count_At := Perfect_Power_Count (Guess);
         if N = Count_At
           or else (N > Count_At and then N - Count_At < 1_000)
           or else (N < Count_At and then Count_At - N < 1_000)
         then
            Settled := True;
            exit;
         end if;
         Approx_Count := Raw_Perfect_Bound (Count_At, 'A');
         if Count_At <= N and then Guess > Ming then
            Ming := Guess;
         end if;
         if Count_At >= N and then Guess < Maxg then
            Maxg := Guess;
         end if;
         if Approx_Nth >= Approx_Count then
            Adjust := Approx_Nth - Approx_Count;
            if Adjust > U64'Last - Guess then
               Guess := U64'Last;
            else
               Guess := Guess + Adjust;
            end if;
         else
            Adjust := Approx_Count - Approx_Nth;
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
      end loop;
      if not Settled then
         Count_At := Perfect_Power_Count (Guess);
      end if;
      if Guess > Max_Perfect_Power then
         Guess := Max_Perfect_Power;
      end if;
      if Count_At >= N then
         Guess := U64 (Prev_Perfect_Power (Int.I128 (Guess) + 1));
         while Count_At > N loop
            Guess := U64 (Prev_Perfect_Power (Int.I128 (Guess)));
            Count_At := Count_At - 1;
         end loop;
      else
         while Count_At < N loop
            Guess := U64 (Next_Perfect_Power (Int.I128 (Guess)));
            Count_At := Count_At + 1;
         end loop;
      end if;
      return (True, Int.I128 (Guess));
   end Nth_Perfect_Power;
end Math_Prime_Util.Powers;
