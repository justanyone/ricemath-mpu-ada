with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Unchecked_Deallocation;
with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Count is
   use type U128;

   Max_Prime : constant U64 := 18_446_744_073_709_551_557;

   function Prefix_Sum (High : U64) return U128 is
      N : constant U64 := U64'Min (High, Max_Prime);
   begin
      if N < 2 then
         return 0;
      end if;
      declare
         R : constant U64 := Int.Sqrtint (N);
         R2 : constant U64 := R + N / (R + 1);
         type Value_Array is array (U64 range <>) of U64;
         type Sum_Array is array (U64 range <>) of U128;
         V : Value_Array (0 .. R2) := (others => 0);
         S : Sum_Array (0 .. R2) := (others => 0);
         A, B, J : U64;
         Sp : U128;
      begin
         for K in U64 range 1 .. R2 loop
            V (K) := (if K <= R then K else N / (R2 - K + 1));
            S (K) := (U128 (V (K)) + 1) / 2 *
              U128 (V (K) or 1) - 1;
         end loop;
         for P in U64 range 2 .. R loop
            if S (P) > S (P - 1) then
               Sp := S (P - 1);
               J := R2;
               while J > 1 and then V (J) >= P * P loop
                  A := V (J);
                  B := A / P;
                  if A > R then
                     A := R2 - N / A + 1;
                  end if;
                  if B > R then
                     B := R2 - N / B + 1;
                  end if;
                  S (A) := S (A) - U128 (P) * (S (B) - Sp);
                  J := J - 1;
               end loop;
            end if;
         end loop;
         return S (R2);
      end;
   end Prefix_Sum;

   function Sum_Primes (Low, High : U64) return Int.Optional_U64
     with SPARK_Mode => Off
   is
      --  The existing sieve uses Ada containers outside the SPARK subset.
      Last : constant U64 := U64'Min (High, Max_Prime);
      Sum : U128 := 0;
   begin
      if Low > Last or Last < 2 then
         return (Defined => True, Value => 0);
      elsif Low <= 2 and then Last >= 29_505_444_491 then
         return (Defined => False);
      elsif Low > 2 and then Last - Low < 50_000_000 then
         declare
            Primes : constant Sieve.Prime_Vectors.Vector :=
              Sieve.Primes (Low, Last);
         begin
            for I in Primes.First_Index .. Primes.Last_Index loop
               Sum := Sum + U128 (Primes.Element (I));
            end loop;
         end;
      elsif Low <= 2 then
         Sum := Prefix_Sum (Last);
      else
         Sum := Prefix_Sum (Last) - Prefix_Sum (Low - 1);
      end if;
      if Sum > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (Defined => True, Value => U64 (Sum));
   end Sum_Primes;

   function Sum_Primes (High : U64) return Int.Optional_U64 is
   begin
      return Sum_Primes (0, High);
   end Sum_Primes;

   type Count_Array is array (U64 range <>) of U64;
   type Count_Access is access Count_Array;
   procedure Free is new Ada.Unchecked_Deallocation
     (Count_Array, Count_Access);

   function Prime_Count (High : U64) return U64
     with SPARK_Mode => Off
   is
      R : constant U64 := Int.Sqrtint (High);
      --  Small (V) = S (V) for V <= R; Large (I) = S (High / I).
      --  The tables live on the heap: R is up to about 4.5 million.
      Small : Count_Access := new Count_Array (0 .. R);
      Large : Count_Access := new Count_Array (0 .. R);
      Result : U64;
   begin
      if High < 2 then
         Free (Small);
         Free (Large);
         return 0;
      end if;
      Small.all := [others => 0];
      Large.all := [others => 0];
      for V in U64 range 1 .. R loop
         Small (V) := V - 1;
      end loop;
      for I in U64 range 1 .. R loop
         Large (I) := High / I - 1;
      end loop;
      for P in U64 range 2 .. R loop
         if Small (P) > Small (P - 1) then
            declare
               Sp : constant U64 := Small (P - 1);
               P2 : constant U64 := P * P;
            begin
               for I in U64 range 1 .. U64'Min (R, High / P2) loop
                  declare
                     D : constant U64 := I * P;
                  begin
                     if D <= R then
                        Large (I) := Large (I) - (Large (D) - Sp);
                     else
                        Large (I) := Large (I) - (Small (High / D) - Sp);
                     end if;
                  end;
               end loop;
               for V in reverse P2 .. R loop
                  Small (V) := Small (V) - (Small (V / P) - Sp);
               end loop;
            end;
         end if;
      end loop;
      Result := Large (1);
      Free (Small);
      Free (Large);
      return Result;
   end Prime_Count;

   function Legendre_Phi (X : U64; A : Natural) return U64 is
      type Prime_List is array (Positive range <>) of U64;

      --  legendre_phi.c: _legendre_phi, phi (x, a) = phi (x, a - 1)
      --  - phi (x / p_a, a - 1), with phi (x, 0) = x.
      function Phi (Value : U64; K : Natural; Pr : Prime_List) return U64
      is
      begin
         if K = 0 or Value = 0 then
            return Value;
         end if;
         if Value < Pr (K) then
            return 1;
         elsif K = 1 then
            return Value - Value / 2;
         end if;
         return Phi (Value, K - 1, Pr) - Phi (Value / Pr (K), K - 1, Pr);
      end Phi;
   begin
      if A = 0 then
         return X;
      end if;
      declare
         Pr : Prime_List (1 .. A);
         Cur : U64 := 1;
      begin
         for I in Pr'Range loop
            Cur := Sieve.Next_Prime (Cur).Value;
            Pr (I) := Cur;
         end loop;
         return Phi (X, A, Pr);
      end;
   end Legendre_Phi;

   function Nth_Prime (N : U64) return U64
     with SPARK_Mode => Off
   is
      --  Count primes up to the approximation A, then walk with a
      --  segmented sieve in the direction of N. The walk is short:
      --  the approximation is within a few thousand of the answer.
      Window : constant U64 := 1_000_000;
      C : U64;
      A, Lo, Hi : U64;
   begin
      if N < 306 then
         --  The approximations call Nth_Prime for small N.
         declare
            Ps : constant Sieve.Prime_Vectors.Vector := Sieve.Primes (2_100);
         begin
            return Ps.Element (Ps.First_Index + Natural (N - 1));
         end;
      end if;
      A := Nth_Prime_Approx (N);
      C := Prime_Count (A);
      if C < N then
         Lo := A + 1;
         loop
            Hi := Lo + Window - 1;
            declare
               Ps : constant Sieve.Prime_Vectors.Vector :=
                 Sieve.Primes (Lo, Hi);
            begin
               if C + U64 (Ps.Length) >= N then
                  return Ps.Element (Ps.First_Index + Natural (N - C - 1));
               end if;
               C := C + U64 (Ps.Length);
            end;
            Lo := Hi + 1;
         end loop;
      else
         --  C primes are <= A; drop the largest until fewer than N.
         Hi := A;
         loop
            Lo := (if Hi > Window then Hi - Window + 1 else 2);
            declare
               Ps : constant Sieve.Prime_Vectors.Vector :=
                 Sieve.Primes (Lo, Hi);
               Len : constant U64 := U64 (Ps.Length);
            begin
               if C - Len < N then
                  return Ps.Element
                    (Ps.First_Index + Natural (N - (C - Len) - 1));
               end if;
               C := C - Len;
            end;
            Hi := Lo - 1;
         end loop;
      end if;
   end Nth_Prime;
   subtype Wide is Long_Long_Float;
   package Ef is new Ada.Numerics.Generic_Elementary_Functions (Wide);
   use Ef;

   function Li (X : Wide) return Wide is
      L : constant Wide := Log (X);
      Term : Wide := L;
      Sum : Wide := 0.577215664901532860606512090082402431 + Log (L);
      Old : Wide;
   begin
      --  real.c: _Ei positive series, evaluated at log (x).
      for K in 1 .. 1_000 loop
         Old := Sum;
         Sum := Sum + Term / Wide (K);
         exit when Sum = Old;
         Term := Term * L / Wide (K + 1);
      end loop;
      return Sum;
   end Li;

   function Prime_Count_Lower (High : U64) return U64 is
      X : constant Wide := Wide (High);
      L, L2, A, Value : Wide;
   begin
      if High < 33_000 then
         return Prime_Count (High);
      end if;
      L := Log (X);
      L2 := L * L;
      if High <= 300_070 then
         A := (if High < 69_720 then 905.0
               elsif High < 70_120 then 961.0
               elsif High < 88_800 then 918.2
               elsif High < 176_000 then 887.7
               elsif High < 299_270 then 839.46 else 846.66);
         Value := X / (L - 1.0 - 1.0 / L - 2.975666 / L2
                       - 13.024334 / (L * L2) + A / (L2 * L2));
      elsif High < 4_000_000_000 then
         --  prime_counts.c prime_count_lower: -3 below 300_000,
         --  then 5 below 303_000. The 4.0 band is below this branch.
         A := (if High < 300_000 then -3.0
               elsif High < 303_000 then 5.0
               elsif High < 1_100_000 then -7.0
               elsif High < 4_500_000 then -37.0
               elsif High < 10_200_000 then -70.0
               elsif High < 36_900_000 then -53.0
               elsif High < 38_100_000 then -29.0 else -84.0);
         Value := Li (X) - Sqrt (X) / L * (1.94 + 2.50 / L + A / L2);
      else
         Value := Li (X) - 2.0 * Sqrt (X) / L;
      end if;
      return U64 (Wide'Ceiling (Value));
   end Prime_Count_Lower;

   function Prime_Count_Upper (High : U64) return U64 is
      X : constant Wide := Wide (High);
      L, A, Value : Wide;
      type Threshold is record
         N : U64;
         A : Float;
      end record;
      type Threshold_Array is array (Positive range <>) of Threshold;
      --  prime_counts.c: _upper_thresh, including C float rounding.
      Bounds : constant Threshold_Array :=
        [(59_000, 2.48), (355_991, 2.54), (3_550_000, 2.51),
         (3_560_000, 2.49), (5_000_000, 2.48), (8_000_000, 2.47),
         (13_000_000, 2.46), (18_000_000, 2.45), (31_000_000, 2.44),
         (41_000_000, 2.43), (48_000_000, 2.42), (119_000_000, 2.41),
         (182_000_000, 2.40), (192_000_000, 2.395),
         (213_000_000, 2.390), (271_000_000, 2.385),
         (322_000_000, 2.380), (400_000_000, 2.375),
         (510_000_000, 2.370), (682_000_000, 2.367),
         (2_953_652_287, 2.362)];
   begin
      if High < 33_000 then
         return Prime_Count (High);
      end if;
      L := Log (X);
      if High <= 821_800_000 then
         A := 2.334;
         for B of Bounds loop
            if High < B.N then
               A := Wide (B.A);
               exit;
            end if;
         end loop;
         Value := X / L * (1.0 + 1.0 / L + A / (L * L));
      elsif High < 101_260_000_000 then
         A := (if High < 1_100_000_000 then 0.032
               elsif High < 10_010_000_000 then 0.027 else 0.021);
         Value := Li (X) - A * L * Sqrt (X) / 25.132741228718345907701147;
      else
         Value := Li (X);
      end if;
      return U64 (Wide'Floor (Value));
   end Prime_Count_Upper;

   --  real.c: RiemannR and riemann_zeta_table (zeta minus one).
   type Real_Array is array (Natural range <>) of Wide;
   Zeta_Table : constant Real_Array :=
     [0.6449340668482264364724151666460251892,
      0.2020569031595942853997381615114499908,
      0.0823232337111381915160036965411679028,
      0.0369277551433699263313654864570341681,
      0.0173430619844491397145179297909205279,
      0.0083492773819228268397975498497967596,
      0.0040773561979443393786852385086524653,
      0.0020083928260822144178527692324120605,
      0.0009945751278180853371459589003190170,
      0.0004941886041194645587022825264699365,
      0.0002460865533080482986379980477396710,
      0.0001227133475784891467518365263573957,
      0.0000612481350587048292585451051353337,
      0.0000305882363070204935517285106450626,
      0.0000152822594086518717325714876367220,
      0.0000076371976378997622736002935630292,
      0.0000038172932649998398564616446219397,
      0.0000019082127165539389256569577951013,
      0.0000009539620338727961131520386834493,
      0.0000004769329867878064631167196043730,
      0.0000002384505027277329900036481867530,
      0.0000001192199259653110730677887188823,
      0.0000000596081890512594796124402079358,
      0.0000000298035035146522801860637050694,
      0.0000000149015548283650412346585066307,
      0.0000000074507117898354294919810041706,
      0.0000000037253340247884570548192040184,
      0.0000000018626597235130490064039099454,
      0.0000000009313274324196681828717647350,
      0.0000000004656629065033784072989233251,
      0.0000000002328311833676505492001455976,
      0.0000000001164155017270051977592973835,
      0.0000000000582077208790270088924368599,
      0.0000000000291038504449709968692942523,
      0.0000000000145519218910419842359296322,
      0.0000000000072759598350574810145208690,
      0.0000000000036379795473786511902372363,
      0.0000000000018189896503070659475848321,
      0.0000000000009094947840263889282533118,
      0.0000000000004547473783042154026799112,
      0.0000000000002273736845824652515226821,
      0.0000000000001136868407680227849349105,
      0.0000000000000568434198762758560927718,
      0.0000000000000284217097688930185545507,
      0.0000000000000142108548280316067698343,
      0.00000000000000710542739521085271287735,
      0.00000000000000355271369133711367329847,
      0.00000000000000177635684357912032747335,
      0.000000000000000888178421093081590309609,
      0.000000000000000444089210314381336419777,
      0.000000000000000222044605079804198399932,
      0.000000000000000111022302514106613372055,
      0.0000000000000000555111512484548124372374,
      0.0000000000000000277555756213612417258163,
      0.0000000000000000138777878097252327628391];

   function Riemann_R (X : Wide; Epsilon : Wide) return Wide is
      L : constant Wide := Log (X);
      Part : Wide := 1.0;
      Sum : Wide := 1.0;
      Correction : Wide := 0.0;
      Z, Term, Adjusted, Next : Wide;
   begin
      for K in 1 .. 10_000 loop
         Z := (if K - 1 <= Zeta_Table'Last then Zeta_Table (K - 1)
               else 2.0 ** (-Integer (K + 1)));
         Part := Part * L / Wide (K);
         Term := Part / (Wide (K) * (1.0 + Z));
         Adjusted := Term - Correction;
         Next := Sum + Adjusted;
         Correction := (Next - Sum) - Adjusted;
         exit when abs (Next - Sum) <= Epsilon;
         Sum := Next;
      end loop;
      return Sum;
   end Riemann_R;

   function Prime_Count_Approx (High : U64) return U64 is
   begin
      if High < 3_000_000 then
         return Prime_Count (High);
      end if;
      return U64 (Wide'Floor
        (Riemann_R (Wide (High), 1.0E-6) + 0.5));
   end Prime_Count_Approx;

   procedure Simple_Nth_Limits (N : U64; Lo, Hi : out U64) is
      X : constant Wide := Wide (N);
      L : constant Wide := Log (X);
      Ll : constant Wide := Log (L);
      A : constant Wide :=
        (if N < 228 then 0.6483 elsif N < 948 then 0.8032
         elsif N < 2_195 then 0.8800 elsif N < 39_017 then 0.9019
         else 0.9484);
   begin
      Lo := U64 (Wide'Floor (X * (L + Ll - 1.0 + (Ll - 2.10) / L)));
      Hi := U64 (Wide'Floor (X * (L + Ll - A)));
   end Simple_Nth_Limits;

   function Nth_Prime_Lower (N : U64) return U64 is
      package Df is new Ada.Numerics.Generic_Elementary_Functions
        (Long_Float);
      X : constant Long_Float := Long_Float (N);
      L, Ll, B, Value : Long_Float;
      Lo, Hi, Mid : U64;
   begin
      if N < 306 then
         return Nth_Prime (N);
      elsif N >= 425_656_284_035_217_743 then
         return Max_Prime;
      elsif N < 2_000_000 then
         Simple_Nth_Limits (N, Lo, Hi);
         while Lo < Hi loop
            Mid := Lo + (Hi - Lo) / 2;
            if Prime_Count_Upper (Mid) < N then
               Lo := Mid + 1;
            else
               Hi := Mid;
            end if;
         end loop;
         return Lo;
      end if;
      L := Df.Log (X);
      Ll := Df.Log (L);
      B := (if N < 56_000_000 then 11.200 else 11.50800000002);
      Value := X * (L + Ll - 1.0 + (Ll - 2.0) / L
                    - (Ll * Ll - 6.0 * Ll + B) / (2.0 * L * L));
      if Value >= Long_Float (Max_Prime) then
         return Max_Prime;
      end if;
      return U64 (Long_Float'Ceiling (Value));
   end Nth_Prime_Lower;

   function Nth_Prime_Upper (N : U64) return U64 is
      X : constant Wide := Wide (N);
      L, Ll, C, D, Value : Wide;
      Lo, Hi, Mid : U64;
   begin
      if N < 306 then
         return Nth_Prime (N);
      elsif N >= 425_656_284_035_217_743 then
         return Max_Prime;
      elsif N < 15_360 then
         Simple_Nth_Limits (N, Lo, Hi);
         while Lo < Hi loop
            Mid := Lo + (Hi - Lo) / 2;
            if Prime_Count_Lower (Mid) < N then
               Lo := Mid + 1;
            else
               Hi := Mid;
            end if;
         end loop;
         return Lo;
      end if;
      L := Log (X);
      Ll := Log (L);
      if N >= 46_254_381 then
         C := 2.0;
         D := 10.667;
      elsif N >= 8_009_824 then
         C := 2.0;
         D := 10.273;
      elsif N >= 5_450_000 then
         C := 2.0;
         D := 10.1335;
      elsif N >= 3_906_280 then
         C := 1.67;
         D := 20.2675;
      elsif N >= 2_110_840 then
         C := 2.51;
         D := -5.5714;
      elsif N >= 876_700 then
         C := 2.49;
         D := -4.5129;
      elsif N >= 688_382 then
         C := 3.31;
         D := -26.3858;
      elsif N >= 575_750 then
         C := -0.79;
         D := 83.5215;
      elsif N >= 467_650 then
         C := 0.93;
         D := 37.1597;
      elsif N >= 382_440 then
         C := 2.92;
         D := -15.4768;
      elsif N >= 301_130 then
         C := 5.92;
         D := -91.3415;
      elsif N >= 138_630 then
         C := 2.01;
         D := 7.2842;
      elsif N >= 85_820 then
         C := 2.07;
         D := 5.2103;
      elsif N >= 39_016 then
         C := 2.76;
         D := -11.5918;
      elsif N >= 31_490 then
         C := 1.49;
         D := 15.1821;
      elsif N >= 25_070 then
         C := 11.89;
         D := -197.8951;
      elsif N >= 15_359 then
         C := 4.8;
         D := -51.5928;
      else
         C := 3.92;
         D := -33.3994;
      end if;
      Value := X * (L + Ll - 1.0 + (Ll - C) / L
                    - (Ll * Ll - 6.0 * Ll + D) / (2.0 * L * L));
      if Value >= Wide (Max_Prime) then
         return Max_Prime;
      end if;
      return U64 (Wide'Floor (Value));
   end Nth_Prime_Upper;

   function Nth_Prime_Approx (N : U64) return U64 is
      X : constant Wide := Wide (N);
      T, Dn, Term, Old_Term : Wide;
   begin
      if N < 306 then
         return Nth_Prime (N);
      end if;
      T := X * Log (X);
      if N < 1_000 then
         T := T * 1.15;
      else
         Dn := Li (T) - X;
         T := T - Dn * Log (T) / (1.0 + Dn / (2.0 * T));
      end if;
      Old_Term := 0.0;
      for I in 1 .. 100 loop
         Dn := Riemann_R (T, 1.0E-12) - X;
         Term := Dn * Log (T) / (1.0 + Dn / (2.0 * T));
         if I > 1 and then abs Term >= abs Old_Term then
            T := T - Term / 4.0;
            exit;
         end if;
         Old_Term := Term;
         T := T - Term;
      end loop;
      if T >= Wide (Max_Prime) then
         return Max_Prime;
      end if;
      return U64 (Wide'Ceiling (T));
   end Nth_Prime_Approx;

   function Chebyshev_Theta (N : U64) return Long_Float
     with SPARK_Mode => Off
   is
      Sum : Wide := 0.0;
      Product : Wide := 1.0;
      Start : U64 := 2;
      Last : U64;
      I : Natural := 0;
   begin
      --  real.c: _cheby_theta, MPU 0.75 constants copied verbatim.
      --  The following even table endpoint has the same theta as N.
      if N = 67_108_864 or else N = 67_108_863 then
         return Long_Float (67100507.6357700963903836828562472350035880);
      end if;
      if N = 100_000_000 or else N = 99_999_999 then
         return Long_Float (99987730.0180220043832124342600487053812729);
      end if;
      if N = 134_217_728 or else N = 134_217_727 then
         return Long_Float (134204014.5735572091791081610859055728165544);
      end if;
      if N = 268_435_456 or else N = 268_435_455 then
         return Long_Float (268419741.6134308193112682817754501071404173);
      end if;
      if N = 536_870_912 or else N = 536_870_911 then
         return Long_Float (536842885.8045763840625719515011160692495056);
      end if;
      if N = 1_000_000_000 or else N = 999_999_999 then
         return Long_Float (999968978.5775661447991262386023331863364793);
      end if;
      if N = 1_073_741_824 or else N = 1_073_741_823 then
         return Long_Float (1073716064.8860663337617909073555831842945484);
      end if;
      if N = 2_147_483_648 or else N = 2_147_483_647 then
         return Long_Float (2147432200.2475857676814950053003448716360822);
      end if;
      if N = 4_294_967_296 or else N = 4_294_967_295 then
         return Long_Float (4294889489.1735446386752045191908417183337360);
      end if;
      if N = 8_589_934_592 or else N = 8_589_934_591 then
         return Long_Float (8589863179.5654263491545135406516173629373070);
      end if;
      if N = 10_000_000_000 or else N = 9_999_999_999 then
         return Long_Float (9999939830.6577573841592219954033850595228736);
      end if;
      while Start <= N loop
         Last := U64'Min (N, Start + 999_999);
         for P of Sieve.Primes (Start, Last) loop
            Product := Product * Wide (P);
            I := I + 1;
            if I = 8 then
               Sum := Sum + Log (Product);
               Product := 1.0;
               I := 0;
            end if;
         end loop;
         Start := Last + 1;
      end loop;
      return Long_Float (Sum + Log (Product));
   end Chebyshev_Theta;

   function Chebyshev_Psi (N : U64) return Long_Float is
      Sum : Wide := 0.0;
   begin
      if N < 2 then
         return 0.0;
      end if;
      for K in reverse 1 .. Natural (Int.Logint (N, 2)) loop
         Sum := Sum + Wide (Chebyshev_Theta (Int.Rootint (N, U64 (K))));
      end loop;
      return Long_Float (Sum);
   end Chebyshev_Psi;
end Math_Prime_Util.Count;
