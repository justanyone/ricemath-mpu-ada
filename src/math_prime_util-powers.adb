with Ada.Numerics.Long_Elementary_Functions;
with Interfaces;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Powers with SPARK_Mode => On is
   use Int;
   use type Interfaces.Unsigned_8;
   use Ada.Numerics.Long_Elementary_Functions;
   Max_Perfect : constant U64 := 18_446_744_065_119_617_025;
   Max_Perfect_Index : constant U64 := 4_297_615_581;

   function Prime_Power (N : U64) return Prime_Power_Result is
      E, R : U64;
   begin
      if N < 2 then
         return (0, 0);
      end if;
      E := Is_Power_Exp (N);
      R := (if E = 0 then N else Rootint (N, E));
      if Primality.Is_Prime (R) /= 0 then
         return ((if E = 0 then 1 else E), R);
      end if;
      return (0, 0);
   end Prime_Power;

   function Is_Prime_Power (N : U64) return U64 is
     (Prime_Power (N).Exponent);
   function Is_Perfect_Power (N : U64) return Boolean is
     (N <= 1 or else Is_Power_Exp (N) > 1);
   function Is_Perfect_Power (N : I128) return Boolean is
      E : U64;
   begin
      if N >= -1 then
         return (if N <= 1 then True else Is_Perfect_Power (U64 (N)));
      end if;
      E := Is_Power_Exp (U64 (-N));
      while E > 0 and then E mod 2 = 0 loop
         E := E / 2;
      end loop;
      return E > 1;
   end Is_Perfect_Power;

   --  _next/_prev_perfect_power: inspect roots instead of scanning gaps.
   function Neighbor (N : U64; Forward, Prime, Odd : Boolean)
      return Optional_U64;
   function Neighbor (N : U64; Forward, Prime, Odd : Boolean)
      return Optional_U64 is
      Best : Optional_U64 := (Defined => False);
      R, Base : U64;
      P : Optional_U64;
   begin
      if not Prime then
         if Forward and then N = 0 then
            return (True, 1);
         elsif not Forward and then N <= 1 then
            return (Defined => False);
         elsif not Forward then
            Best := (True, 1);
         end if;
      else
         Best := (if Forward then Sieve.Next_Prime (N)
                  else Sieve.Prev_Prime (N));
      end if;
      for K in 2 .. 63 loop
         if not Odd or else K mod 2 = 1 then
            R := Rootint (N, U64 (K));
            if Prime then
               if Forward then
                  P := Sieve.Next_Prime (R);
               else
                  P := Powint (R, U64 (K));
                  Base := R;
                  if P.Defined and then P.Value = N then
                     Base := Base - 1;
                  end if;
                  P := (if Primality.Is_Prime (Base) /= 0 then
                          (True, Base) else Sieve.Prev_Prime (Base));
               end if;
               if P.Defined then
                  P := Powint (P.Value, U64 (K));
               end if;
            else
               if Forward then
                  R := R + 1;
               elsif Powint (R, U64 (K)).Value = N then
                  R := R - 1;
               end if;
               P := Powint (R, U64 (K));
            end if;
            if P.Defined and then
              ((Forward and then P.Value > N) or else
               (not Forward and then P.Value < N))
              and then (not Best.Defined or else
                (if Forward then P.Value < Best.Value
                 else P.Value > Best.Value))
            then
               Best := P;
            end if;
         end if;
      end loop;
      return Best;
   end Neighbor;

   function Next_Prime_Power (N : U64) return Optional_U64 is
     (Neighbor (N, True, True, False));
   function Prev_Prime_Power (N : U64) return Optional_U64 is
     (Neighbor (N, False, True, False));
   function Next_Perfect_Power (N : U64) return Optional_U64 is
     (Neighbor (N, True, False, False));
   function Prev_Perfect_Power (N : U64) return Optional_U64 is
     (Neighbor (N, False, False, False));
   function Next_Perfect_Power (N : I128) return I128 is
     (if N = -1 then 0 else -I128 (Neighbor
       (U64 (-N), False, False, True).Value));
   function Prev_Perfect_Power (N : I128) return I128 is
     (if N = 0 then -1 else -I128 (Neighbor
       (U64 (-N), True, False, True).Value));

   function Perfect_Power_Count (N : U64) return U64 is
      Mu : constant array (Positive range 1 .. 63) of Integer :=
        [1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1, 1, 1,
         0, -1, 0, -1, 0, 1, 1, -1,
         0, 0, 1, 0, 0, -1, -1, -1, 0, 1, 1, 1, 0, -1, 1, 1,
         0, -1, -1, -1, 0, 0, 1,
         -1, 0, 0, 0, 1, 0, -1, 0, 1, 0, 1, 1, -1, 0, -1, 1, 0];
      Sum : I128 := 1;
   begin
      if N = 0 then
         return 0;
      end if;
      for K in 2 .. Natural (Logint (N, 2)) loop
         if Mu (K) /= 0 then
            Sum := Sum - I128 (Mu (K)) * I128 (Rootint (N, U64 (K)) - 1);
         end if;
      end loop;
      return U64 (Sum);
   end Perfect_Power_Count;
   function Perfect_Power_Count_Lower (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Perfect_Power_Count_Upper (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Perfect_Power_Count_Approx (N : U64) return U64 is
     (Perfect_Power_Count (N));
   function Count_Powers (N : U64; Mode : Natural) return U64;
   function Count_Powers (N : U64; Mode : Natural) return U64 is
      Sum, R : U64 := 0;
   begin
      if N < 2 then
         return 0;
      end if;
      for K in 1 .. Natural (Logint (N, 2)) loop
         R := Rootint (N, U64 (K));
         case Mode is
            when 0 => Sum := Sum + Count.Prime_Count (R);
            when 1 => Sum := Sum + Count.Prime_Count_Lower (R);
            when 2 => Sum := Sum + Count.Prime_Count_Upper (R);
            when others => Sum := Sum + Count.Prime_Count_Approx (R);
         end case;
      end loop;
      return Sum;
   end Count_Powers;
   function Prime_Power_Count (N : U64) return U64 is
     (Count_Powers (N, 0));
   function Prime_Power_Count_Lower (N : U64) return U64 is
     (Count_Powers (N, 1));
   function Prime_Power_Count_Upper (N : U64) return U64 is
     (Count_Powers (N, 2));
   function Prime_Power_Count_Approx (N : U64) return U64 is
     (Count_Powers (N, 3));
   function Prime_Power_Count (Low, High : U64) return U64 is
     (if Low > High then 0 else Prime_Power_Count (High) -
        (if Low = 0 then 0 else Prime_Power_Count (Low - 1)));
   function Perfect_Power_Count (Low, High : U64) return U64 is
     (if Low > High then 0 else Perfect_Power_Count (High) -
        (if Low = 0 then 0 else Perfect_Power_Count (Low - 1)));

   --  Invert counts by bisection; the left edge of each plateau is chosen.
   function Nth_Prime_Estimate (N : U64; Mode : Natural)
      return Optional_U64;
   function Nth_Prime_Estimate (N : U64; Mode : Natural)
      return Optional_U64 is
      Low, High, Mid, C : U64;
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      if N <= 7 then
         return (True, N + 1 + N / 5);
      end if;
      Low := (if N <= 100 then N + 1 else
        U64 (Long_Float'Floor (0.98 *
          Long_Float (Count.Nth_Prime_Lower (N)))) - 400);
      High := Count.Nth_Prime_Upper (N);
      while High - Low > 1 loop
         Mid := Low + (High - Low) / 2;
         C := Count_Powers (Mid, Mode);
         if C < N then
            Low := Mid;
         else
            High := Mid;
         end if;
      end loop;
      return (True, (if Count_Powers (Low, Mode) = N then Low
                     elsif Count_Powers (High, Mode) > N then Low
                     else High));
   end Nth_Prime_Estimate;
   function Nth_Prime_Power (N : U64) return Optional_U64 is
     (Nth_Prime_Estimate (N, 0));
   function Nth_Prime_Power_Lower (N : U64) return Optional_U64 is
     (Nth_Prime_Estimate (N, 2));
   function Nth_Prime_Power_Upper (N : U64) return Optional_U64 is
     (Nth_Prime_Estimate (N, 1));
   function Nth_Prime_Power_Approx (N : U64) return Optional_U64 is
     (Nth_Prime_Estimate (N, 3));
   function Nth_Perfect_Power (N : U64) return Optional_U64 is
      Low : U64 := 1;
      High : U64 := Max_Perfect;
      Mid : U64;
   begin
      if N = 0 or else N > Max_Perfect_Index then
         return (Defined => False);
      end if;
      while Low < High loop
         Mid := Low + (High - Low) / 2;
         if Perfect_Power_Count (Mid) < N then
            Low := Mid + 1;
         else
            High := Mid;
         end if;
      end loop;
      return (True, Low);
   end Nth_Perfect_Power;

   function Perfect_Estimate (N : U64; Mode : Natural)
      return Optional_U64;
   function Perfect_Estimate (N : U64; Mode : Natural)
      return Optional_U64 is
      X : constant Long_Float := Long_Float (N);
      P : Long_Float;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (True, 1);
      elsif N >= Max_Perfect_Index then
         return (if N = Max_Perfect_Index then (True, Max_Perfect)
                 else (Defined => False));
      end if;
      P := X ** 2 + (13.0 / 3.0) * X ** (4.0 / 3.0) +
        (32.0 / 15.0) * X ** (16.0 / 15.0);
      P := P - 2.0 * X ** (5.0 / 3.0) - 2.0 * X ** (7.0 / 5.0) -
        2.0 * X ** (9.0 / 7.0) + 2.0 * X ** (12.0 / 10.0);
      if Mode /= 2 then
         P := P - 2.0 * X ** (13.0 / 11.0) - 2.0 * X ** (15.0 / 13.0);
      end if;
      if Mode /= 1 then
         P := P + 2.0 * X ** (16.0 / 14.0);
      end if;
      if Mode = 3 then
         P := P + 2.0 * X ** (17.0 / 15.0);
         P := P - 0.48 * X ** (19.0 / 17.0);
      end if;
      P := P + (if Mode = 1 then 5.5 elsif Mode = 2 then -3.5 else -1.5);
      if P >= Long_Float (U64'Last) then
         return (True, U64'Last);
      end if;
      return (True, U64 (Long_Float'Floor (P)));
   end Perfect_Estimate;
   function Nth_Perfect_Power_Lower (N : U64) return Optional_U64 is
     (Perfect_Estimate (N, 1));
   function Nth_Perfect_Power_Upper (N : U64) return Optional_U64 is
     (Perfect_Estimate (N, 2));
   function Nth_Perfect_Power_Approx (N : U64) return Optional_U64 is
     (Perfect_Estimate (N, 3));
end Math_Prime_Util.Powers;
