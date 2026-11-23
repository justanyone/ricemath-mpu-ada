with Ada.Numerics.Generic_Elementary_Functions;
with Math_Prime_Util.Count;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Ramanujan is
   subtype Wide is Long_Long_Float;
   package Ef is new Ada.Numerics.Generic_Elementary_Functions (Wide);
   use Ef;
   Small : constant array (Positive range 1 .. 23) of U64 :=
     [2, 11, 17, 29, 41, 47, 59, 67, 71, 97, 101, 107, 127,
      149, 151, 167, 179, 181, 227, 229, 233, 239, 241];

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
   function Axler (N : U64; C, D : Wide) return U64 is
      X : constant Wide := Wide (N);
      L : constant Wide := Log (X);
      LL : constant Wide := Log (L);
      L2 : constant Wide := Log (2.0);
      C1 : constant Wide := 2 * L2 * L2 + L2 + C;
      C2 : constant Wide := L2 ** 3 + 2 * L2 * L2 + D;
      U : constant Wide :=
        (L2 * L * LL * LL - C1 * L * LL + C2 * L - L2 * L2 * LL
         + L2 ** 3 + L2 * L2) /
        (L ** 4 + L ** 3 * LL - L ** 3 * L2 - L * L * L2);
      R : constant Long_Float := Long_Float
        (2 * X * (1.0 + L2 / L - (L2 * LL - L2 * L2 - L2) / (L * L) + U));
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
      return (Defined => True, Value => Count.Nth_Prime_Upper
        (Axler (N, 0.0, D)));
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
      return (Defined => True, Value => Count.Nth_Prime_Lower
        (Axler (N, 1.472, D)));
   end Nth_Ramanujan_Prime_Lower;
