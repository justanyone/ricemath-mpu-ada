with Ada.Numerics.Generic_Elementary_Functions;
with Interfaces.C;
with System;
package body Math_Prime_Util.Real is
   subtype Wide is Long_Long_Float;
   package EF is new Ada.Numerics.Generic_Elementary_Functions (Wide);
   use EF;
   Eps : constant Wide := Wide'Model_Epsilon;
   Euler : constant Wide := 0.577215664901532860606512090082402431;
   function Strtod
     (Text : Interfaces.C.char_array; Tail : System.Address)
      return Interfaces.C.double
     with Import, Convention => C, External_Name => "strtod";
   Infinity : constant Wide := Wide
     (Strtod (Interfaces.C.To_C ("inf"), System.Null_Address));
   type Vector is array (Natural range <>) of Wide;
   C6p : constant Vector :=
     (-148151.02102575750838086,
      150260.59476436982420737,
      89904.972007457256553251,
      15924.175980637303639884,
      2150.0672908092918123209,
      116.69552669734461083368,
      5.0196785185439843791020);
   C6q : constant Vector :=
     (256664.93484897117319268,
      184340.70063353677359298,
      52440.529172056355429883,
      8125.8035174768735759866,
      750.43163907103936624165,
      40.205465640027706061433,
      1.0000000000000000000000);
   P2 : constant Vector :=
     (1.75338801265465972390E02,
      -2.23127670777632409550E02,
      -1.81949664929868906455E01,
      -2.79798528624305389340E01,
      -7.63147701620253630855E00,
      -1.52856623636929636839E01,
      -7.06810977895029358836E00,
      -5.00006640413131002475E00,
      -3.00000000320981265753E00,
      1.00000000000000485503E00);
   Q2 : constant Vector :=
     (3.97845977167414720840E04,
      3.97277109100414518365E00,
      1.37790390235747998793E02,
      1.17179220502086455287E02,
      7.04831847180424675988E01,
      -1.20187763547154743238E01,
      -7.99243595776339741065E00,
      -2.99999894040324959612E00,
      1.99999999999048104167E00);
   Zeta_Table : constant Vector :=
     (0.6449340668482264364724151666460251892,
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
      0.0000000000000000138777878097252327628391);
   C8p : constant Vector :=
     (1.287168121482446392809e10,
      1.375396932037025111825e10,
      5.106655918364406103683e09,
      8.561471002433314862469e08,
      7.483618124380232984824e07,
      4.860106585461882511535e06,
      2.739574990221406087728e05,
      4.631710843183427123061e03,
      5.787581004096660659109e01);
   C8q : constant Vector :=
     (2.574336242964846244667e10,
      5.938165648679590160003e09,
      9.006330373261233439089e08,
      8.042536634283289888587e07,
      5.609711759541920062814e06,
      2.247431202899137523543e05,
      7.574578909341537560115e03,
      -2.373835781373772623086e01,
      1.000000000000000000000);
   A : constant Vector :=
     (12.0,
      -720.0,
      30240.0,
      -1209600.0,
      47900160.0,
      -1892437580.3183791606367583212735166425,
      74724249600.0,
      -2950130727918.1642244954382084600497650,
      116467828143500.67248729113000661089201,
      -4597978722407472.6105457273596737891656,
      181521054019435467.73425331153534235290,
      -7166165256175667011.3346447367083352775,
      282908877253042996618.18640556532523927);
   type Accumulator is record
      Sum : Wide := 0.0;
      Correction : Wide := 0.0;
   end record;
   procedure Add (S : in out Accumulator; V : Wide) is
      T : constant Wide := S.Sum + V;
   begin
      if abs S.Sum >= abs V then
         S.Correction := S.Correction + ((S.Sum - T) + V);
      else
         S.Correction := S.Correction + ((V - T) + S.Sum);
      end if;
      S.Sum := T;
   end Add;
   function Value (S : Accumulator) return Wide is
     (S.Sum + S.Correction);
   function Polynomial (C : Vector; X : Wide) return Wide is
      R : Wide := C (C'Last);
   begin
      for I in reverse C'First .. C'Last - 1 loop
         R := C (I) + X * R;
      end loop;
      return R;
   end Polynomial;
   function Ei (X : Wide) return Wide is
      S : Accumulator;
      L0 : Wide := 1.0;
      L1 : Wide := 1.0 - X;
      Q, R, Term : Wide;
      Fact : Wide := X;
      Frac : Wide := 0.0;
   begin
      if X /= X then
         return X;
      elsif X <= -12000.0 then
         return 0.0;
      elsif X >= 12000.0 then
         return Infinity;
      elsif X < 0.0 then
         if X >= -1.0 then
            return Log (-X) - Polynomial (C6p, -X) /
              Polynomial (C6q, -X);
         end if;
         Add (S, 1.0 / L1);
         for K in 1 .. 499 loop
            Q := (L1 * (-X + Wide (2 * K + 1)) -
                    L0 * Wide (K)) / Wide (K + 1);
            R := 1.0 / (Wide (K + 1) * Q * L1);
            Add (S, R);
            L0 := L1;
            L1 := Q;
            exit when abs R < 0.1 * Eps;
         end loop;
         return -Value (S) * Exp (X);
      elsif X < -2.0 * Log (Eps) then
         for N in 2 .. 400 loop
            Fact := Fact * X / Wide (N);
            Term := Fact / Wide (N);
            Add (S, Term);
            exit when abs Term < Eps * abs Value (S);
         end loop;
         Add (S, Euler);
         Add (S, Log (abs X));
         Add (S, X);
         return Value (S);
      end if;
      for N in 0 .. 8 loop
         Frac := Q2 (N) / (P2 (N) + X + Frac);
      end loop;
      Frac := Frac + P2 (9);
      if X < 700.0 then
         return Exp (X) * (1.0 / X + Frac / X / X);
      end if;
      return Exp (X - Log (X)) * (1.0 + Frac / X);
   end Ei;
   function Li (X : Wide) return Wide is
      S : Wide := 0.0;
      Old, P : Wide := -1.0;
      Fact, Power : Wide := 1.0;
      Inner : Accumulator;
      K : Natural := 0;
      L : Wide;
   begin
      if X /= X or else X = Infinity then
         return X;
      elsif X = 0.0 then
         return 0.0;
      elsif X = 1.0 then
         return -Infinity;
      elsif X = 2.0 then
         return 1.0451637801174927848445888891946131365;
      elsif X < 1.0 or else X > 1.0E16 then
         return Ei (Log (X));
      end if;
      L := Log (X);
      for N in 1 .. 199 loop
         Fact := Fact * Wide (N);
         P := P * (-L);
         while K <= (N - 1) / 2 loop
            Add (Inner, 1.0 / Wide (2 * K + 1));
            K := K + 1;
         end loop;
         Old := S;
         S := S + P / (Fact * Power) * Value (Inner);
         Power := Power * 2.0;
         exit when abs (S - Old) <= Eps;
      end loop;
      return Euler + Log (L) + Sqrt (X) * S;
   end Li;
   function Zeta (X : Wide) return Wide is
      B, S, T : Wide := 0.0;
      Product : Wide := 1.0;
      Num, Den : Wide;
   begin
      if X /= X then
         return X;
      elsif X = 1.0 then
         return Infinity;
      elsif X >= 2.0 and then X < Wide (Zeta_Table'Length + 2)
        and then X = Wide'Floor (X)
      then
         return Zeta_Table (Natural (X) - 2);
      elsif X >= 0.5 and then X <= 5.0 then
         Num := Polynomial (C8p, X);
         Den := Polynomial (C8q, X);
         return (Num - (X - 1.0) * Den) / ((X - 1.0) * Den);
      elsif X > 17000.0 then
         return 0.0;
      end if;
      for I in 2 .. 10 loop
         B := Wide (I) ** (-X);
         S := S + B;
         if abs B < abs (Eps * S) then
            return S;
         end if;
      end loop;
      S := S + B * 10.0 / (X - 1.0) - 0.5 * B;
      for I in A'Range loop
         Product := Product * (X + Wide (2 * I));
         B := B / 10.0;
         T := Product * B / A (I);
         S := S + T;
         exit when abs T < abs (Eps * S);
         Product := Product * (X + Wide (2 * I + 1));
         B := B / 10.0;
      end loop;
      return S;
   end Zeta;
   function Inverse (X : Wide) return Wide is
      T, Term, Dn, L : Wide;
      Old : Wide := 0.0;
   begin
      if X < 2.719 then
         T := (if X >= 1.668 then 3.0 else 2.0);
      else
         L := Log (X);
         T := X * (L + Log (L));
      end if;
      for I in 0 .. 3 loop
         Dn := Li (T) - X;
         Term := Dn * Log (T) / (1.0 + Dn / (2.0 * T));
         exit when I > 0 and then abs Term >= abs Old;
         Old := Term;
         T := T - Term;
      end loop;
      return T;
   end Inverse;
   function Exponential_Integral (X : F64) return F64 is
     (F64 (Ei (Wide (X))));
   function Logarithmic_Integral (X : F64) return F64 is
     (F64 (Li (Wide (X))));
   function Riemann_Zeta (X : F64) return F64 is
     (F64 (Zeta (Wide (X))));
   function Inverse_Li_Nv (X : F64) return F64 is
     (F64 (Inverse (Wide (X))));
   function Inverse_Li (X : F64) return F64 is
      R : Wide;
   begin
      if X <= 2.0 then
         return (if X = 0.0 then 0.0 else X + 1.0);
      end if;
      R := Wide'Ceiling (Inverse (Wide (X)));
      if R < 2.0 ** 63 then
         while Li (R - 1.0) >= Wide (X) loop
            R := R - 1.0;
         end loop;
         while Li (R) < Wide (X) loop
            R := R + 1.0;
         end loop;
      end if;
      return F64 (R);
   end Inverse_Li;
   function Moebius (N : Positive) return Integer is
      V : Positive := N;
      M : Integer := 1;
   begin
      for P in 2 .. N loop
         if V mod P = 0 then
            V := V / P;
            M := -M;
            if V mod P = 0 then
               return 0;
            end if;
         end if;
      end loop;
      return M;
   end Moebius;
   function Riemann_R
     (X : F64; Epsilon : F64 := 1.0E-16) return F64
   is
      S : Accumulator;
      Term, Old : Wide;
      Part : Wide := 1.0;
      L : Wide;
      Tol : constant Wide := Wide'Max (Eps, Wide (Epsilon));
   begin
      if X /= X or else Wide (X) = Infinity then
         return X;
      end if;
      L := Log (Wide (X));
      if X > 1.0E19 then
         Add (S, Li (Wide (X)));
         for K in 2 .. 100 loop
            if Moebius (K) /= 0 then
               Term := Wide (Moebius (K)) / Wide (K) *
                 Li (Wide (X) ** (1.0 / Wide (K)));
               Old := Value (S);
               Add (S, Term);
               exit when abs (Value (S) - Old) <= Tol;
            end if;
         end loop;
      else
         Add (S, 1.0);
         for K in 1 .. 10_000 loop
            Part := Part * L / Wide (K);
            Term := Part / (Wide (K) * (1.0 + Zeta (Wide (K + 1))));
            Old := Value (S);
            Add (S, Term);
            exit when abs (Value (S) - Old) <= Tol;
         end loop;
      end if;
      return F64 (Value (S));
   end Riemann_R;
   function Lambert_Approx (X : Wide) return Wide is
      W, K1, K2, K3 : Wide;
   begin
  if x < -0.312 then


    k2 := 2.0 * (1.0 + 2.7182818284590452353603 * x);
    if K2 <= 0.0 then return -1.0 + Eps; end if;
    k1 := Sqrt(k2);
    w := -1.0 + (1.0 + (-1.0/3.0 + (11.0/72.0 + (-43.0/540.0 +
        (769.0/17280.0 + (-221.0/8505.0 + (680863.0/43545600.0 +
        (-1963.0/204120.0 + 226287557.0/37623398400.0
    * k1) * k1) * k1) * k1) * k1) * k1) * k1) * k1) * k1;

  elsif x > -0.14 and then x < 0.085 then

    w := (1.0 + (-1.0 + (3.0/2.0 + (-8.0/3.0 + (125.0/24.0 + (-54.0/5.0 +
        (16807.0/720.0 + (-16384.0/315.0 + 531441.0/4480.0
        * x) * x) * x) * x) * x) * x) * x) * x) * x;

  elsif x < 1.0 then

    k1 := Sqrt(1.0 + 2.7182818284590452353603 * x);
    k2 := 0.33333333333333333333333 + 0.70710678118654752440084 / k1 -
        0.058925565098878960366737 * k1 +
         (x + 0.36787944117144) * (0.050248489761611 + (0.11138904851051 +
        0.040744556245195 * x) * x)
         /
         (1.0 + (2.7090878606183 + (1.5510922597820 + 0.095477712183841 * x)
        * x) * x);
    w := -(k2-1.0)/k2;

  elsif x < 40.0 then
    k1 := 1.0 + (5.950065500550155 + (13.96586471370701 + (10.52192021050505
        + (3.065294254265870 + 0.1204576876518760 * x) * x) * x) * x) * x;
    w := 0.1600049638651493 * Log(k1);

  elsif x < 20000.0 then
    k1 := 1.0 + (-3.16866642511229e11 + (3.420439800038598e10 +
         (-1.501433652432257e9 + (3.44887729947585e7 + (-4.453783741137856e5
        +
         (3257.926478908996 + (-10.82545259305382 + (0.6898058947898353e-1.0
        +
         0.4703653406071575e-4.0 * x) * x) * x) * x) * x) * x) * x) * x) *
        x;
    w := 0.9898045358731312e-1.0 * Log(k1);

  else
    k1 := 1.0 / (1.0 + Log(1.0 + x));
    k2 := 1.0 / k1;
    k3 := Log(k2);
    w := k2-1.0-k3+(1.0+k3+(-1.0/2.0+(1.0/2.0)*k3*k3 +
        (-1.0/6.0+(-1.0+(-1.0/2.0+(1.0/3.0)*k3)*k3)*k3) * k1) * k1) * k1;
  end if;
      return W;
   end Lambert_Approx;
   function Lambert_W (X : F64) return F64 is
      W, W1, Zn, Qn, En, Wen : Wide;
   begin
      if X /= X or else Wide (X) = Infinity then
         return X;
      elsif X <= -0.367879441171442321595523770161460867 then
         return -1.0;
      elsif X = 0.0 then
         return 0.0;
      end if;
      W := Lambert_Approx (Wide (X));
      if X < -0.36768 then
         return F64 (W);
      end if;
      for I in 0 .. 5 loop
         exit when W = 0.0;
         W1 := 1.0 + W;
         Zn := Log (Wide (X) / W) - W;
         Qn := 2.0 * W1 * (W1 + (2.0 / 3.0) * Zn);
         En := (Zn / W1) * (Qn - Zn) / (Qn - 2.0 * Zn);
         Wen := W * En;
         W := W + Wen;
         exit when abs Wen <= 64.0 * Eps;
      end loop;
      return F64 (W);
   end Lambert_W;
   function Pi (Digits : Natural := 0) return String is
      Count : constant Positive := (if Digits = 0 then 15 else Digits);
      C : Natural := 14 * ((Count + 1) / 4 + 2);
      type Work_Array is array (Natural range <>) of Long_Long_Integer;
      Work : Work_Array (0 .. C - 1) := [others => 2000];
      Out_Text : String (1 .. Count + 5) := [others => '0'];
      D, E, G, Chunk : Long_Long_Integer := 0;
      I : Natural := 1;
      B : Natural;
   begin
      if Count = 1 then
         return "3";
      end if;
      while I <= Count + 1 loop
         C := C - 14;
         B := C;
         D := D mod 10_000;
         E := D;
         while B > 1 loop
            B := B - 1;
            G := Long_Long_Integer (2 * B - 1);
            D := D * Long_Long_Integer (B) + 10_000 * Work (B);
            Work (B) := D mod G;
            D := D / G;
         end loop;
         Chunk := E + D / 10_000;
         if Chunk > 9999 then
            Chunk := Chunk - 10_000;
            B := I - 1;
            while Out_Text (B) = '9' loop
               Out_Text (B) := '0';
               B := B - 1;
            end loop;
            Out_Text (B) := Character'Succ (Out_Text (B));
         end if;
         for J in reverse I .. I + 3 loop
            Out_Text (J) := Character'Val (48 + Chunk mod 10);
            Chunk := Chunk / 10;
         end loop;
         I := I + 4;
      end loop;
      if Out_Text (Count + 1) >= '5' then
         B := Count;
         while Out_Text (B) = '9' loop
            Out_Text (B) := '0';
            B := B - 1;
         end loop;
         Out_Text (B) := Character'Succ (Out_Text (B));
      end if;
      return Out_Text (1 .. 1) & "." & Out_Text (2 .. Count);
   end Pi;
   function Bernreal (N : Natural) return F64 is
      R : Wide := 2.0;
      Two_Pi : constant Wide := 6.283185307179586476925286766559;
   begin
      if N = 0 then
         return 1.0;
      elsif N = 1 then
         return 0.5;
      elsif N mod 2 = 1 then
         return 0.0;
      end if;
      for I in 1 .. N loop
         R := R * Wide (I) / Two_Pi;
      end loop;
      R := R * (1.0 + Zeta (Wide (N)));
      return F64 ((if N mod 4 = 0 then -R else R));
   end Bernreal;
   function Harmreal (N : Natural) return F64 is
      S : Accumulator;
      X : constant Wide := Wide (N);
   begin
      if N <= 2002 then
         for I in 1 .. N loop
            Add (S, 1.0 / Wide (I));
         end loop;
         return F64 (Value (S));
      end if;
      return F64 (Log (X) + Euler + 1.0 / (2.0 * X) -
        1.0 / (12.0 * X ** 2) + 1.0 / (120.0 * X ** 4) -
        1.0 / (252.0 * X ** 6));
   end Harmreal;
end Math_Prime_Util.Real;
