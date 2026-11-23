with Ada.Containers;
with Ada.Numerics.Generic_Elementary_Functions;
with Math_Prime_Util.Count;
with Math_Prime_Util.Inverse;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Ramanujan is
   use type Primality.Prime_Result;
   subtype Wide is Long_Long_Float;
   package Ef is new Ada.Numerics.Generic_Elementary_Functions (Wide);
   use Ef;
   Small : constant array (Positive range 1 .. 23) of U64 :=
     [2, 11, 17, 29, 41, 47, 59, 67, 71, 97, 101, 107, 127,
      149, 151, 167, 179, 181, 227, 229, 233, 239, 241];

   function Small_Count (N : U64) return U64;
   function Small_Count (N : U64) return U64 is
      R : U64 := 0;
   begin
      for P of Small loop
         exit when P > N;
         R := R + 1;
      end loop;
      return R;
   end Small_Count;

   --  prime_counts.c: ramanujan_axler returns double after wide arithmetic.
   function Axler (N : U64; C, D : Wide) return U64;
   function Axler (N : U64; C, D : Wide) return U64 is
      X : constant Wide := Wide (N);
      L : constant Wide := Log (X);
      LL : constant Wide := Log (L);
      L2 : constant Wide := Log (2.0);
      C1 : constant Wide := 2.0 * L2 * L2 + L2 + C;
      C2 : constant Wide := L2 ** 3 + 2.0 * L2 * L2 + D;
      U : constant Wide :=
        (L2 * L * LL * LL - C1 * L * LL + C2 * L - L2 * L2 * LL
         + L2 ** 3 + L2 * L2) /
        (L ** 4 + L ** 3 * LL - L ** 3 * L2 - L * L * L2);
      R : constant Long_Float := Long_Float
        (2.0 * X * (1.0 + L2 / L - (L2 * LL - L2 * L2 - L2) / (L * L) + U));
   begin
      return U64 (Long_Float'Floor (R));
   end Axler;

   function Nth_Ramanujan_Prime_Upper (N : U64)
      return Int.Optional_U64
   is
      R : U64;
      D : Wide := 0.0;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 23 then
         return (Defined => True, Value => Small (Positive (N)));
      end if;
      if N < 12581 then
         if N < 168 then
            R := Axler (N, -4.7691, -6.2682);
         elsif N < 2290 then
            R := Axler (N, -0.9315, -0.5635);
         elsif N < 5225 then
            R := Axler (N, -0.5318, -0.0710);
         elsif N < 12581 then
            R := Axler (N, 0.1212, 0.7973);
         else
            R := 0;
         end if;
         return (Defined => True, Value => Count.Nth_Prime_Upper (R));
      end if;
      if N < 18175 then
         D := 0.3548;
      elsif N < 82883 then
         D := -0.2450;
      elsif N < 316314 then
         D := -0.6384;
      elsif N < 1000001 then
         D := -0.9353;
      elsif N < 4000001 then
         D := -1.1271;
      elsif N < 16000001 then
         D := -1.4152;
      elsif N < 64000001 then
         D := -1.6671;
      elsif N < 128000001 then
         D := -1.8855;
      elsif N < 256000001 then
         D := -1.9325;
      elsif N < 384000001 then
         D := -2.0190;
      elsif N < 512000001 then
         D := -2.0310;
      else
         D := -2.0884;
         if N > 3999654659 then
            D := -2.235;
         end if;
         if N > 84086679236 then
            D := -2.435;
         end if;
         if N > 514808375201 then
            D := -2.535;
         end if;
         if N > 3594243587299 then
            D := -2.635;
         end if;
         if N > 28330126673435 then
            D := -2.735;
         end if;
         if N > 117462814829787 then
            D := -2.8;
         end if;
      end if;
      R := Axler (N, 0.0, D);
      return (Defined => True, Value =>
        (if R > 425_656_284_035_217_743 then 0
         else Count.Nth_Prime_Upper (R)));
   end Nth_Ramanujan_Prime_Upper;

   function Nth_Ramanujan_Prime_Lower (N : U64)
      return Int.Optional_U64
   is
      R : U64;
      D : Wide := 0.0;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 23 then
         return (Defined => True, Value => Small (Positive (N)));
      end if;
      if N < 34816 then
         if N < 189 then
            R := Axler (N, 4.2720, 0.340);
         elsif N < 1245 then
            R := Axler (N, -0.2179, -6.179);
         elsif N < 2984 then
            R := Axler (N, 0.1446, -4.8693);
         elsif N < 14303 then
            R := Axler (N, -0.3570, -5.1154);
         elsif N < 34816 then
            R := Axler (N, -1.5770, -7.5332);
         else
            R := 0;
         end if;
         return (Defined => True, Value => Count.Nth_Prime_Lower (R));
      end if;
      if N < 76400 then
         D := 0.0126;
      elsif N < 280816 then
         D := 0.5132;
      elsif N < 915887 then
         D := 0.9967;
      elsif N < 4000001 then
         D := 1.5004;
      elsif N < 16000001 then
         D := 1.7184;
      elsif N < 64000001 then
         D := 1.9860;
      elsif N < 128000001 then
         D := 2.1352;
      elsif N < 256000001 then
         D := 2.1658;
      elsif N < 384000001 then
         D := 2.1999;
      elsif N < 512000001 then
         D := 2.2047;
      elsif N < 640000001 then
         D := 2.2324;
      else
         D := 2.2385;
         if N > 14888378285 then
            D := 2.29;
         end if;
         if N > 467037926604 then
            D := 2.31;
         end if;
         if N > 2778491401197 then
            D := 2.315;
         end if;
         if N > 10656144781918 then
            D := 2.317;
         end if;
         if N > 63698770351741 then
            D := 2.319;
         end if;
      end if;
      R := Axler (N, 1.472, D);
      return (Defined => True, Value =>
        (if R > 425_656_284_035_217_743 then 0
         else Count.Nth_Prime_Lower (R)));
   end Nth_Ramanujan_Prime_Lower;

   function Upper_Value (N : U64) return U64 is
     (if N = 0 then 0 else Nth_Ramanujan_Prime_Upper (N).Value);
   function Lower_Value (N : U64) return U64 is
     (if N = 0 then 0 else Nth_Ramanujan_Prime_Lower (N).Value);
   function Invert_Upper is new Math_Prime_Util.Inverse (Wide, Upper_Value);
   function Invert_Lower is new Math_Prime_Util.Inverse (Wide, Lower_Value);

   function Ramanujan_Prime_Count_Lower (N : U64) return U64 is
      Lo, Hi : U64;
   begin
      if N <= 241 then
         return Small_Count (N);
      end if;
      Lo := Count.Prime_Count_Lower (N) / 3;
      Hi := Count.Prime_Count_Upper (N) / 2;
      if Upper_Value (Lo) > N or else Upper_Value (Hi) < N then
         return Lo;
      end if;
      return Invert_Upper (Lo, Hi, N);
   end Ramanujan_Prime_Count_Lower;

   function Ramanujan_Prime_Count_Upper (N : U64) return U64 is
      Lo, Hi : U64;
   begin
      if N <= 241 then
         return Small_Count (N);
      end if;
      Lo := Count.Prime_Count_Lower (N) / 3;
      Hi := Count.Prime_Count_Upper (N) / 2;
      if Lower_Value (Lo) > N then
         return Lo;
      elsif Lower_Value (Hi) < N then
         return Hi;
      end if;
      return Invert_Lower (Lo, Hi, N);
   end Ramanujan_Prime_Count_Upper;

   function Ramanujan_Prime_Count_Approx (N : U64) return U64 is
   begin
      if N <= 241 then
         return Small_Count (N);
      end if;
      return Count.Prime_Count_Approx (N) - Count.Prime_Count_Approx (N / 2);
   end Ramanujan_Prime_Count_Approx;

   function Invert_Approx is new Math_Prime_Util.Inverse (Wide, Ramanujan_Prime_Count_Approx);
   function Nth_Ramanujan_Prime_Approx (N : U64) return Int.Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 23 then
         return (Defined => True, Value => Small (Positive (N)));
      end if;
      return (Defined => True, Value => Invert_Approx
        (Lower_Value (N) - 1, Upper_Value (N), N));
   end Nth_Ramanujan_Prime_Approx;

   --  ramanujan_primes.c: n_range_ramanujan_primes, Noe's algorithm.
   --  Containers isolate allocation from the SPARK arithmetic routines.
   function Index_Range (First, Last : U64) return Sieve.Prime_Vectors.Vector
     with SPARK_Mode => Off;
   function Index_Range (First, Last : U64) return Sieve.Prime_Vectors.Vector
   is
      use Sieve.Prime_Vectors;
      Lo : constant U64 := U64'Max (1, First);
      Result : Vector;
      Start, Stop, S, K : U64;
   begin
      if Lo > Last then
         return Result;
      end if;
      Result.Set_Length (Ada.Containers.Count_Type (Last - Lo + 1));
      if Last <= 23 then
         for I in Lo .. Last loop
            Result.Replace_Element (Natural (I - Lo), Small (Positive (I)));
         end loop;
         return Result;
      end if;
      Start := U64'Max (15, Lower_Value (Lo) - 1);
      if Start mod 2 = 0 then
         Start := Start - 1;
      end if;
      Stop := Upper_Value (Last) + 1;
      S := 1 + Count.Prime_Count (Start - 2) -
        Count.Prime_Count ((Start - 1) / 2);
      if Lo = 1 then
         Result.Replace_Element (0, 2);
      end if;
      if Lo <= 2 then
         Result.Replace_Element (Natural (2 - Lo), 11);
      end if;
      declare
         Ps : constant Vector := Sieve.Primes (Start, Stop);
         Half : constant Vector :=
           Sieve.Primes ((Start + 1) / 2, (Stop + 1) / 2);
         Pi : Natural := 0;
         Qi : Natural := 0;
      begin
         K := Start;
         while K <= Stop loop
            if Pi < Natural (Ps.Length) and then Ps.Element (Pi) = K then
               S := S + 1;
               Pi := Pi + 1;
            end if;
            if S >= Lo and then S <= Last then
               Result.Replace_Element (Natural (S - Lo), K + 1);
            end if;
            if K mod 4 = 1 then
               while Qi < Natural (Half.Length) and then
                 Half.Element (Qi) < (K + 1) / 2
               loop
                  Qi := Qi + 1;
               end loop;
               if Qi < Natural (Half.Length) and then
                 Half.Element (Qi) = (K + 1) / 2
               then
                  S := S - 1;
               end if;
            end if;
            if S >= Lo and then S <= Last then
               Result.Replace_Element (Natural (S - Lo), K + 2);
            end if;
            K := K + 2;
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
         return Small_Count (N);
      end if;
      V := Count.Prime_Count (N) - Count.Prime_Count (N / 2);
      if N > 1_000_000_000 then
         Window := 320;
      end if;
      loop
         First := (if V <= Window then 1 else V - Window);
         declare
            Ps : constant Sieve.Prime_Vectors.Vector :=
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
         return (for some P of Small => P = N);
      end if;
      return Nth_Ramanujan_Prime (Ramanujan_Prime_Count (N)).Value = N;
   end Is_Ramanujan_Prime;

   function Ramanujan_Primes (Low, High : U64)
      return Sieve.Prime_Vectors.Vector
     with SPARK_Mode => Off
   is
      Result : Sieve.Prime_Vectors.Vector;
   begin
      if High < 2 or else Low > High then
         return Result;
      end if;
      declare
         Ps : constant Sieve.Prime_Vectors.Vector := Index_Range
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

   function Ramanujan_Primes (High : U64) return Sieve.Prime_Vectors.Vector
     with SPARK_Mode => Off
   is
   begin
      return Ramanujan_Primes (0, High);
   end Ramanujan_Primes;
end Math_Prime_Util.Ramanujan;
