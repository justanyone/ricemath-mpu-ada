<<<<<<< HEAD
with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Factor is
   use type Primality.Prime_Result;

   --  factor.c: ecm64_sigmas, in the original deterministic order.
   Sigmas : constant array (Positive range 1 .. 400) of U64 :=
     [11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
      47, 53, 59, 61, 67, 71, 73, 79, 83, 89,
      103, 127, 139, 149, 151, 157, 163, 181, 191, 197,
      199, 211, 223, 227, 233, 239, 257, 271, 293, 313,
      331, 337, 347, 359, 379, 389, 397, 401, 409, 421,
      443, 449, 457, 479, 487, 509, 521, 523, 547, 557,
      587, 641, 653, 659, 673, 677, 683, 691, 719, 727,
      739, 751, 769, 797, 809, 853, 919, 929, 941, 997,
      1049, 1051, 1063, 1091, 1093, 1109, 1117, 1129, 1153, 1201,
      1217, 1229, 1283, 1327, 1361, 1381, 1427, 1447, 1459, 1471,
      1481, 1489, 1543, 1549, 1571, 1621, 1709, 1723, 1753, 1759,
      1801, 1811, 1867, 1987, 2039, 2099, 2113, 2131, 2251, 2309,
      2347, 2381, 2399, 2447, 2473, 2551, 2557, 2663, 2677, 2689,
      2713, 2719, 2749, 2857, 2879, 2887, 2939, 3001, 3061, 3067,
      3121, 3137, 3187, 3251, 3259, 3271, 3307, 3359, 3371, 3373,
      3467, 3593, 3607, 3623, 3643, 3709, 3733, 3793, 3851, 3923,
      3989, 4019, 4049, 4129, 4231, 4253, 4283, 4339, 4349, 4441,
      4523, 4649, 4787, 4987, 4999, 5171, 5237, 5273, 5297, 5333,
      5387, 5471, 5479, 5647, 5749, 5791, 6101, 6163, 6257, 6299,
      6337, 6451, 6491, 6659, 6793, 6823, 6967, 7013, 7229, 7253,
      7333, 7369, 7477, 7621, 7793, 7817, 8059, 8167, 8209, 8263,
      8311, 8377, 8573, 8641, 8741, 8837, 8863, 8963, 9001, 9151,
      9203, 9433, 9697, 9743, 9781, 9883, 10007, 10069, 10099, 10139,
      10163, 10193, 10267, 10429, 10457, 10487, 10691, 10837, 10949, 11087,
      11243, 11321, 11411, 11681, 11813, 11903, 12011, 12263, 12277, 12401,
      12409, 12437, 12479, 12569, 12619, 12739, 12911, 13331, 13367, 13537,
      13721, 13789, 13841, 13873, 14051, 14149, 14221, 14419, 14431, 14827,
      14887, 15077, 15289, 15467, 15511, 15649, 15773, 15797, 15859, 15901,
      16057, 16141, 16217, 16529, 16547, 16553, 16619, 17299, 17393, 17419,
      17449, 17737, 17921, 18049, 18223, 19073, 19183, 19477, 20021, 20323,
      20347, 20759, 20929, 21023, 21157, 21587, 21611, 21613, 21673, 21751,
      21799, 21821, 22109, 22469, 22651, 22943, 23327, 23459, 23567, 23767,
      23911, 23957, 24001, 24197, 24281, 24407, 24799, 24851, 25147, 25183,
      25469, 25679, 25703, 26561, 26683, 26701, 26821, 27073, 27191, 27271,
      27277, 27427, 27487, 27539, 27617, 27647, 27673, 27749, 27983, 28319,
      28789, 28843, 29017, 29123, 29209, 29669, 29803, 29921, 30323, 30809,
      30851, 30911, 30983, 31397, 31541, 31963, 32369, 32561, 32771, 32969,
      33029, 33083, 33487, 33637, 33757, 34057, 34381, 34513, 34613, 34807,
      35083, 35171, 35311, 35381, 36013, 36251, 36493, 36529, 36551, 36913,
      36919, 37363, 37517, 37699, 37907, 38047, 38177, 38273, 38749, 38903];

   type Point is record
      X, Z : U64;
   end record;
   type Points is array (U64 range <>) of Point;
   type Residues is array (U64 range <>) of U64;

   function Mul (A, B, N : U64) return U64 is
     (Int.Mulmod (A, B, N).Value);
   function Add (A, B, N : U64) return U64 is
     (Int.Addmod (A, B, N).Value);
   function Sub (A, B, N : U64) return U64 is
     (Int.Submod (A, B, N).Value);

   function Double_Point (P : Point; A24, N : U64) return Point
     with Pre => N > 1;
   function Differential_Add
     (P, Q, Pm : Point; N : U64) return Point with Pre => N > 1;
   function Multiply (P : Point; K, A24, N : U64) return Point
     with Pre => N > 1 and then K > 0;
   procedure Normalize
     (P : Points; N : U64; X : out Residues;
      Factor : out U64; Success : out Boolean)
     with Pre => N > 1 and then P'First = X'First
       and then P'Last = X'Last;
   function Stage_Two (Q : Point; A24, N, B1, B2 : U64) return U64
     with Pre => N > 1;
   function Find_Factor (N, B1, B2, Curves : U64) return U64
     with Pre => N > 1;

   --  factor.c: ecm_double64; ordinary residues replace Montgomery form.
   function Double_Point (P : Point; A24, N : U64) return Point is
      U : constant U64 := Mul (Sub (P.X, P.Z, N),
                               Sub (P.X, P.Z, N), N);
      V : constant U64 := Mul (Add (P.X, P.Z, N),
                               Add (P.X, P.Z, N), N);
      W : constant U64 := Sub (V, U, N);
   begin
      return (Mul (U, V, N), Mul (W, Add (U, Mul (A24, W, N), N), N));
   end Double_Point;

   --  factor.c: ecm_dadd64; Pm is the known difference P - Q.
   function Differential_Add
     (P, Q, Pm : Point; N : U64) return Point
   is
      U : constant U64 := Mul (Sub (P.X, P.Z, N),
                               Add (Q.X, Q.Z, N), N);
      V : constant U64 := Mul (Add (P.X, P.Z, N),
                               Sub (Q.X, Q.Z, N), N);
      S : constant U64 := Add (U, V, N);
      D : constant U64 := Sub (U, V, N);
   begin
      return (Mul (Mul (S, S, N), Pm.Z, N),
              Mul (Mul (D, D, N), Pm.X, N));
   end Differential_Add;

   --  factor.c: ecm_mul64, Montgomery's differential ladder.
   function Multiply (P : Point; K, A24, N : U64) return Point is
      R0 : Point := P;
      R1 : Point := Double_Point (P, A24, N);
      Bit : U64 := 2 ** 63;
   begin
      if K = 1 then
         return P;
      elsif K = 2 then
         return R1;
      end if;
      while (Bit and K) = 0 loop
         Bit := Bit / 2;
      end loop;
      Bit := Bit / 2;
      while Bit /= 0 loop
         if (K and Bit) /= 0 then
            R0 := Differential_Add (R0, R1, P, N);
            R1 := Double_Point (R1, A24, N);
         else
            R1 := Differential_Add (R0, R1, P, N);
            R0 := Double_Point (R0, A24, N);
         end if;
         Bit := Bit / 2;
      end loop;
      return R0;
   end Multiply;

   --  factor.c: ecm_batch_normalize_x64. One inversion for all points;
   --  individually inspect Z coordinates when the product has gcd N.
   procedure Normalize
     (P : Points; N : U64; X : out Residues;
      Factor : out U64; Success : out Boolean)
   is
      Prefix : Residues (P'Range);
      Acc : U64 := 1;
      G, Inv, Prev, Zinv : U64;
      Inverse : Int.Optional_U64;
   begin
      Factor := 0;
      Success := False;
      X := [others => 0];
      for I in P'Range loop
         Acc := Mul (Acc, P (I).Z, N);
         Prefix (I) := Acc;
      end loop;
      G := Int.Gcd (Acc, N);
      if G > 1 then
         if G < N then
            Factor := G;
         else
            for V of P loop
               G := Int.Gcd (V.Z, N);
               if G > 1 and then G < N then
                  Factor := G;
                  exit;
               end if;
            end loop;
         end if;
         return;
      end if;
      Inverse := Int.Invmod (Acc, N);
      if not Inverse.Defined then
         return;
      end if;
      Inv := Inverse.Value;
      for I in reverse P'Range loop
         Prev := (if I = P'First then 1 else Prefix (I - 1));
         Zinv := Mul (Inv, Prev, N);
         Inv := Mul (Inv, P (I).Z, N);
         X (I) := Mul (P (I).X, Zinv, N);
      end loop;
      Success := True;
   end Normalize;

   --  Saturating addition for inclusive bounds near U64'Last.
   function Saturating_Add (A, B : U64) return U64 is
     (if A > U64'Last - B then U64'Last else A + B);

   --  factor.c: tinyecm64_stage2, baby steps and giant steps.
   function Stage_Two (Q : Point; A24, N, B1, B2 : U64) return U64 is
      D : U64 := Int.Sqrtint (B2 / 2);
      F, M, Hi, Lo, Idx : U64;
      Product : U64 := 1;
      Ok : Boolean;
   begin
      if B2 <= B1 then
         return 0;
      end if;
      if D mod 2 /= 0 then
         D := D + 1;
      end if;
      if D = 0 then
         return 0;
      end if;
      declare
         Two_D : constant U64 := 2 * D;
         Mend : constant U64 := Saturating_Add (B2, D);
         Windows : constant U64 := (Mend - 2) / Two_D + 1;
         Nq : Points (1 .. Two_D);
         Nqx : Residues (1 .. D);
         S : Points (0 .. Windows - 1);
         Sx : Residues (S'Range);
         Xm, Old : Point;
      begin
         Nq (1) := Q;
         for I in 2 .. Two_D loop
            if I mod 2 /= 0 then
               Nq (I) := Differential_Add
                 (Nq ((I - 1) / 2), Nq ((I + 1) / 2), Q, N);
            else
               Nq (I) := Double_Point (Nq (I / 2), A24, N);
            end if;
         end loop;
         Normalize (Nq (1 .. D), N, Nqx, F, Ok);
         if not Ok then
            return F;
         end if;
         S (0) := Q;
         Xm := Nq (Two_D - 1);
         for W in 1 .. Windows - 1 loop
            Old := S (W - 1);
            S (W) := Differential_Add (Nq (Two_D), Old, Xm, N);
            Xm := Old;
         end loop;
         Normalize (S, N, Sx, F, Ok);
         if not Ok then
            return F;
         end if;
         M := 1;
         for W in S'Range loop
            Hi := U64'Min (Saturating_Add (M, D), B2);
            Lo := (if M > D then M - D else 0);
            if Hi > B1 then
               Lo := U64'Max (U64'Max (Lo, B1 + 1), 2);
               for P in Lo .. Hi loop
                  if Primality.Is_Prime (P) /= 0 and then P /= M then
                     Idx := (if P < M then M - P else P - M);
                     --  Skip the mirrored prime already handled below M.
                     if not (P > M and then M <= U64'Last / 2
                       and then P <= 2 * M
                       and then 2 * M - P > B1
                       and then 2 * M - P >= Lo
                       and then Primality.Is_Prime (2 * M - P) /= 0)
                     then
                        if Idx in Nqx'Range then
                           Product := Mul
                             (Product, Sub (Sx (W), Nqx (Idx), N), N);
                        end if;
                     end if;
                  end if;
               end loop;
               F := Int.Gcd (Product, N);
               if F > 1 then
                  return (if F < N then F else 0);
               end if;
            end if;
            exit when M > U64'Last - Two_D;
            M := M + Two_D;
         end loop;
      end;
      F := Int.Gcd (Product, N);
      return (if F > 1 and then F < N then F else 0);
   end Stage_Two;

   --  factor.c: tinyecm64, Suyama parametrization and prime powers.
   function Find_Factor (N, B1, B2, Curves : U64) return U64 is
      Ui, Vi, Umv, U3, V3, Num, Den, A24, G, K : U64;
      P : Point;
      Inverse : Int.Optional_U64;
      J : U64;
      Failed : Boolean;
   begin
      for Ci in 1 .. Natural (U64'Min (Curves, Sigmas'Length)) loop
         Ui := Sigmas (Ci) ** 2 - 5;
         Vi := 4 * Sigmas (Ci);
         Umv := Ui - Vi;
         U3 := Mul (Mul (Ui, Ui, N), Ui, N);
         V3 := Mul (Mul (Vi, Vi, N), Vi, N);
         Num := Sub (0, Mul (Mul (Mul (Umv, Umv, N), Umv, N),
                            3 * Ui + Vi, N), N);
         Den := Mul (Mul (U3, Vi, N), 16, N);
         Inverse := Int.Invmod (Den, N);
         if not Inverse.Defined then
            G := Int.Gcd (Den, N);
            if G > 1 and then G < N then
               return G;
            end if;
         else
            A24 := Mul (Num, Inverse.Value, N);
            P := (U3, V3);
            J := 0;
            Failed := False;
            for Prime in 2 .. B1 loop
               if Primality.Is_Prime (Prime) /= 0 then
                  K := Prime;
                  while K <= B1 / Prime loop
                     K := K * Prime;
                  end loop;
                  P := Multiply (P, K, A24, N);
                  if J mod 64 = 0 then
                     G := Int.Gcd (P.Z, N);
                     if G > 1 and then G < N then
                        return G;
                     elsif G = N then
                        Failed := True;
                        exit;
                     end if;
                  end if;
                  J := J + 1;
               end if;
            end loop;
            if not Failed then
               G := Int.Gcd (P.Z, N);
               if G > 1 and then G < N then
                  return G;
               end if;
               if B2 > B1 then
                  G := Stage_Two (P, A24, N, B1, B2);
                  if G > 1 and then G < N then
                     return G;
                  end if;
               end if;
            end if;
         end if;
      end loop;
      return 0;
   end Find_Factor;

   function Ecm_Factor
     (N : U64; B1 : U64 := 4_000; B2 : U64 := 0;
      Curves : U64 := 100) return Factor_List
   is
      Result : Factor_List (1 .. 64);
      Count : Natural range 0 .. 64 := 0;
      Remaining : U64 := N;
      Bound : constant U64 :=
        (if B2 /= 0 then B2 elsif B1 > U64'Last / 20 then U64'Last
         else 20 * B1);
      F, T : U64;
   begin
      if N = 0 then
         return [1 => 0];
      end if;
      for Small of Factor_List'[2, 3, 5] loop
         while Remaining > 1 and then Remaining mod Small = 0 loop
            Count := Count + 1;
            Result (Count) := Small;
            Remaining := Remaining / Small;
         end loop;
      end loop;
      if Remaining > 1 then
         F := (if Primality.Is_Prime (Remaining) /= 0 then 0
               else Find_Factor (Remaining, B1, Bound, Curves));
         if F > 1 and then F < Remaining then
            Count := Count + 1;
            Result (Count) := F;
            Remaining := Remaining / F;
         end if;
         Count := Count + 1;
         Result (Count) := Remaining;
      end if;
      --  found_factor sorts its split; small factors are already ordered.
      for I in 2 .. Count loop
         if Result (I) < Result (I - 1) then
            T := Result (I);
            Result (I) := Result (I - 1);
            Result (I - 1) := T;
         end if;
      end loop;
      return Result (1 .. Count);
   end Ecm_Factor;
=======
with Ada.Containers;
with Ada.Containers.Generic_Array_Sort;
with Ada.Numerics.Long_Elementary_Functions;
with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Factor is
   use type U128;
   use type Int.I128;
   use type Primality.Prime_Result;

   type U32 is mod 2 ** 32;
   subtype Lf is Long_Float;

   function One (V : U64) return Factor_List is
      R : Factor_List;
   begin
      R.Count := 1;
      R.Value (1) := V;
      return R;
   end One;

   function Two (A, B : U64) return Factor_List is
      R : Factor_List;
   begin
      R.Count := 2;
      R.Value (1) := A;
      R.Value (2) := B;
      return R;
   end Two;

   procedure Push (L : in out Factor_List; V : U64) is
   begin
      L.Count := L.Count + 1;
      L.Value (L.Count) := V;
   end Push;

   procedure Append (L : in out Factor_List; M : Factor_List) is
   begin
      for I in 1 .. M.Count loop
         Push (L, M.Value (I));
      end loop;
   end Append;

   procedure Sort (L : in out Factor_List) is
      Key : U64;
      J : Natural;
   begin
      for I in 2 .. L.Count loop
         Key := L.Value (I);
         J := I;
         while J > 1 and then L.Value (J - 1) > Key loop
            L.Value (J) := L.Value (J - 1);
            J := J - 1;
         end loop;
         L.Value (J) := Key;
      end loop;
   end Sort;

   function Found (N, F : U64) return Factor_List is
      G : U64;
   begin
      if F <= 1 or else F >= N or else N mod F /= 0 then
         return One (N);
      end if;
      G := N / F;
      if F < G then
         return Two (F, G);
      else
         return Two (G, F);
      end if;
   end Found;

   function Mul_Mod (A, B, N : U64) return U64 is
     (U64 ((U128 (A) * U128 (B)) mod U128 (N)));

   function Add_Mod (A, B, N : U64) return U64 is
      S : constant U128 := U128 (A) + U128 (B);
   begin
      if S >= U128 (N) then
         return U64 (S mod U128 (N));
      end if;
      return U64 (S);
   end Add_Mod;

   function Sub_Mod (A, B, N : U64) return U64 is
     (Add_Mod (A, N - B, N));

   function Sqr_Add (A, C, N : U64) return U64 is
     (U64 ((U128 (A) * U128 (A) + U128 (C)) mod U128 (N)));

   function Mul_Sub (A, B, C, N : U64) return U64 is
     (Sub_Mod (Mul_Mod (A, B, N), C, N));

   function Pow_Mod (A, K, N : U64) return U64 is
      R : U64 := 1;
      B : U64 := A mod N;
      E : U64 := K;
   begin
      while E > 0 loop
         if E mod 2 = 1 then
            R := Mul_Mod (R, B, N);
         end if;
         E := E / 2;
         if E > 0 then
            B := Mul_Mod (B, B, N);
         end if;
      end loop;
      return R;
   end Pow_Mod;

   function Abs_Diff (A, B : U64) return U64 is
     (if A > B then A - B else B - A);

   function Sqrt_Lf (X : Lf) return Lf is
     (Ada.Numerics.Long_Elementary_Functions.Sqrt (X));

   --  C casts of double to UV truncate toward zero.
   function Trunc_U64 (X : Lf) return U64 is
     (U64 (Lf'Truncation (X)));

   function Mont_Inverse (N : U64) return U64 is
      Inv : U64 := (3 * N) xor 2;
   begin
      for Step in 1 .. 4 loop
         Inv := Inv * (2 - N * Inv);
      end loop;
      return 0 - Inv;
   end Mont_Inverse;

   function Mont_One (N : U64) return U64 is
     (U64 ((U128 (2) ** 64) mod U128 (N)));

   function Mont_In (A, N : U64) return U64 is
     (Mul_Mod (A, Mont_One (N), N));

   --  factor.c montmath.h: _mulredc, including the high carry.
   function Mont_Mul (A, B, N, Npi : U64) return U64 is
      Product : constant U128 := U128 (A) * U128 (B);
      Mask : constant U128 := U128 (U64'Last);
      Lo : constant U64 := U64 (Product and Mask);
      M : constant U64 := Lo * Npi;
      Correction : constant U128 := U128 (M) * U128 (N);
      Carry : constant U128 :=
        ((Product and Mask) + (Correction and Mask)) / 2 ** 64;
      High : constant U128 :=
        Product / 2 ** 64 + Correction / 2 ** 64 + Carry;
   begin
      if High >= U128 (N) then
         return U64 (High - U128 (N));
      end if;
      return U64 (High);
   end Mont_Mul;

   --  constants.h: primes through 2011. primes_small[1] = 2.
   Prime_Count : constant := 305;
   type Prime_Array is array (1 .. Prime_Count) of U64;

   function Build_Primes return Prime_Array is
      Mark : array (0 .. 2011) of Boolean := [others => True];
      R : Prime_Array := [others => 0];
      K : Natural := 0;
      J : Natural;
   begin
      Mark (0) := False;
      Mark (1) := False;
      for I in 2 .. 2011 loop
         if Mark (I) then
            K := K + 1;
            R (K) := U64 (I);
            J := I * I;
            while J <= 2011 loop
               Mark (J) := False;
               J := J + I;
            end loop;
         end if;
      end loop;
      if K /= Prime_Count or else R (Prime_Count) /= 2011 then
         raise Program_Error with "small prime table";
      end if;
      return R;
   end Build_Primes;

   Small : constant Prime_Array := Build_Primes;

   --  sieve.h wheel-30 steps used by trial_factor.
   Distance : constant array (0 .. 29) of U64 :=
     [1, 0, 5, 4, 3, 2, 1, 0, 3, 2, 1, 0, 1, 0, 3, 2, 1, 0, 1, 0,
      3, 2, 1, 0, 5, 4, 3, 2, 1, 0];
   Advance : constant array (0 .. 29) of U64 :=
     [1, 6, 5, 4, 3, 2, 1, 4, 3, 2, 1, 2, 1, 4, 3, 2, 1, 2, 1, 4,
      3, 2, 1, 6, 5, 4, 3, 2, 1, 2];
   Next_W : constant array (0 .. 29) of Natural :=
     [1, 7, 7, 7, 7, 7, 7, 11, 11, 11, 11, 13, 13, 17, 17,
      17, 17, 19, 19, 23, 23, 23, 23, 29, 29, 29, 29, 29, 29, 1];

   procedure Strip_235 (N : in out U64; L : in out Factor_List) is
   begin
      while N mod 2 = 0 loop
         Push (L, 2);
         N := N / 2;
      end loop;
      while N mod 3 = 0 loop
         Push (L, 3);
         N := N / 3;
      end loop;
      while N mod 5 = 0 loop
         Push (L, 5);
         N := N / 5;
      end loop;
   end Strip_235;

   --  factor.c: trial_factor. Appends factors and leaves N as 1
   --  when the cofactor was stored.
   procedure C_Trial
     (N : in out U64; First, Last : U64; L : in out Factor_List)
   is
      F : U64 := First;
      Lim : U64 := Last;
      Idx : Natural;
      Residue : Natural;
      Cap, Fresh : U64;
   begin
      if F < 2 then
         F := 2;
      end if;
      if Lim = 0 or else Lim > N / Lim then
         Lim := U64'Last;
      end if;
      if N < 4 or else Lim < F then
         if N /= 1 then
            Push (L, N);
         end if;
         return;
      end if;
      if F <= 2011 then
         if F <= 2 then
            while N mod 2 = 0 loop
               Push (L, 2);
               N := N / 2;
            end loop;
         end if;
         if F <= 3 and then 3 <= Lim then
            while N mod 3 = 0 loop
               Push (L, 3);
               N := N / 3;
            end loop;
         end if;
         if F <= 5 and then 5 <= Lim then
            while N mod 5 = 0 loop
               Push (L, 5);
               N := N / 5;
            end loop;
         end if;
         Idx := 4;
         while Idx <= Prime_Count and then Small (Idx) < F loop
            Idx := Idx + 1;
         end loop;
         while Idx <= Prime_Count loop
            F := Small (Idx);
            exit when F * F > N or else F > Lim;
            while N mod F = 0 loop
               Push (L, F);
               N := N / F;
            end loop;
            Idx := Idx + 1;
         end loop;
         if Idx > Prime_Count then
            F := 2017;
         end if;
      end if;
      if F > 2011 and then Distance (Natural (F mod 30)) <= U64'Last - F
      then
         F := F + Distance (Natural (F mod 30));
      end if;
      if N > 1 and then F <= N / F and then F <= Lim then
         Cap := Int.Sqrtint (N);
         if Cap > Lim then
            Cap := Lim;
         end if;
         Residue := Natural (F mod 30);
         while F <= Cap loop
            if N mod F = 0 then
               while N mod F = 0 loop
                  Push (L, F);
                  N := N / F;
               end loop;
               Fresh := Int.Sqrtint (N);
               if Fresh < Cap then
                  Cap := Fresh;
               end if;
            end if;
            F := F + Advance (Residue);
            Residue := Next_W (Residue);
         end loop;
      end if;
      if N /= 1 then
         Push (L, N);
      end if;
   end C_Trial;

   function Prepare
     (N : U64; Rest : out U64) return Factor_List
   is
      L : Factor_List;
   begin
      Rest := N;
      if N = 0 then
         --  The single 0 is the whole result. Rest = 1 tells callers
         --  not to run an algorithm on 0 (that divides by zero or loops).
         Rest := 1;
         return One (0);
      end if;
      Strip_235 (Rest, L);
      if Rest = 1 then
         return L;
      end if;
      if Primality.Is_Prime (Rest) = 2 then
         Push (L, Rest);
         Rest := 1;
      end if;
      return L;
   end Prepare;

   function Raw_Fermat (N, Rounds : U64) return Factor_List is
      Root : constant U64 := Int.Sqrtint (N);
      X : Int.I128 := Int.I128 (2 * Root + 1);
      Y : Int.I128 := 1;
      R : Int.I128 := -Int.I128 (N - Root * Root);
      Left : U64 := Rounds;
      Factor : U64;
   begin
      while R /= 0 loop
         if Left = 0 then
            return One (N);
         end if;
         Left := Left - 1;
         R := R + X;
         X := X + 2;
         while R > 0 loop
            R := R - Y;
            Y := Y + 2;
         end loop;
      end loop;
      Factor := U64 ((X - Y) / 2);
      return Found (N, Factor);
   end Raw_Fermat;

   function Raw_Holf (N, Rounds : U64) return Factor_List is
      Budget : U64 := Rounds;
      S, F : U64;
      Ni, Npre : U64;
      Mult : U64;
      M : U64;
      Root : U64;
   begin
      if Int.Is_Square (N) then
         return Found (N, Int.Sqrtint (N));
      end if;
      if N <= U64'Last / 64 then
         if N <= U64'Last / 8192 then
            Mult := 720;
         elsif N <= U64'Last / 2048 then
            Mult := 480;
         elsif N <= U64'Last / 1024 then
            Mult := 360;
         elsif N <= U64'Last / 256 then
            Mult := 60;
         else
            Mult := 30;
         end if;
         Npre := N * Mult;
         Ni := Npre;
         while Budget > 0 loop
            Budget := Budget - 1;
            S := 1 + Int.Sqrtint (Ni);
            M := S * S - Ni;
            if Int.Is_Square (M) then
               Root := Int.Sqrtint (M);
               if S > Root then
                  F := Int.Gcd (N, S - Root);
                  if F > 1 and then F < N then
                     return Found (N, F);
                  end if;
               end if;
            end if;
            exit when Ni > U64'Last - Npre;
            Ni := Ni + Npre;
         end loop;
         if Budget = 0 then
            return One (N);
         end if;
      end if;
      for I in 1 .. Budget loop
         S := Trunc_U64 (Sqrt_Lf (Lf (N) * Lf (I))) + 1;
         M := Mul_Mod (S, S, N);
         if Int.Is_Square (M) then
            Root := Int.Sqrtint (M);
            if S > Root then
               F := Int.Gcd (S - Root, N);
            else
               F := Int.Gcd (Root - S, N);
            end if;
            return Found (N, F);
         end if;
      end loop;
      return One (N);
   end Raw_Holf;

   function Raw_Rho (N, Rounds : U64) return Factor_List is
      Inner : constant U64 := 64;
      U : U64 := 7;
      V : U64 := 7;
      A : U64 := 1;
      F, M, Old_U, Old_V, Step : U64;
      Budget : U64 := (Rounds + Inner - 1) / Inner;
      Fails : Integer := 3;
   begin
      while Budget > 0 loop
         Budget := Budget - 1;
         M := 1;
         Old_U := U;
         Old_V := V;
         for Ignore in 1 .. Inner loop
            U := Sqr_Add (U, A, N);
            V := Sqr_Add (V, A, N);
            V := Sqr_Add (V, A, N);
            M := Mul_Mod (M, Abs_Diff (U, V), N);
         end loop;
         F := Int.Gcd (M, N);
         if F /= 1 then
            if F = N then
               U := Old_U;
               V := Old_V;
               Step := Inner;
               loop
                  U := Sqr_Add (U, A, N);
                  V := Sqr_Add (V, A, N);
                  V := Sqr_Add (V, A, N);
                  F := Int.Gcd (Abs_Diff (U, V), N);
                  exit when F /= 1 or else Step = 0;
                  Step := Step - 1;
               end loop;
            end if;
            if F = 0 or else F = N then
               exit when Fails <= 0;
               Fails := Fails - 1;
               U := Add_Mod (U, 2, N);
               V := U;
               A := A + 2;
            else
               return Found (N, F);
            end if;
         end if;
      end loop;
      return One (N);
   end Raw_Rho;

   --  factor.c: pbrent_factor under USE_MONTMATH.
   function Raw_Brent (N, Rounds, A0 : U64) return Factor_List is
      Npi : constant U64 := Mont_Inverse (N);
      Mont1 : constant U64 := Mont_One (N);
      --  factor.c: BITS_PER_WORD - clz. Floor log plus one.
      Nbits : constant U64 := Int.Logint (N, 2) + 1;
      Inner : constant U64 :=
        (if Nbits <= 31 then 32
         elsif Nbits <= 35 then 64
         elsif Nbits <= 40 then 160
         elsif Nbits <= 52 then 256
         else 320);
      A : U64 := Mont_In (A0, N);
      F : U64 := 1;
      M : U64 := 1;
      R : U64 := 1;
      Xi : U64 := Mont1;
      Xm : U64 := Mont1;
      Xs : U64 := Mont1;
      Budget : U64 := Rounds;
      Rleft, Batch : U64;
      Fails : Integer := 6;
   begin
      while Budget > 0 loop
         if R > Budget then
            Rleft := Budget;
         else
            Rleft := R;
         end if;
         Xm := Xi;
         while Rleft > 0 loop
            if Rleft > Inner then
               Batch := Inner;
            else
               Batch := Rleft;
            end if;
            Rleft := Rleft - Batch;
            Budget := Budget - Batch;
            Xs := Xi;
            if N < 2 ** 63 then
               Xi := Mont_Mul (Xi, Xi + A, N, Npi);
               M := Abs_Diff (Xi, Xm);
               while Batch > 1 loop
                  Batch := Batch - 1;
                  Xi := Mont_Mul (Xi, Xi + A, N, Npi);
                  F := Abs_Diff (Xi, Xm);
                  M := Mont_Mul (M, F, N, Npi);
               end loop;
            elsif A = Mont1 then
               Xi := Mont_Mul (Xi, Xi + A, N, Npi);
               M := Abs_Diff (Xi, Xm);
               while Batch > 1 loop
                  Batch := Batch - 1;
                  Xi := Mont_Mul (Xi, Xi + A, N, Npi);
                  F := Abs_Diff (Xi, Xm);
                  M := Mont_Mul (M, F, N, Npi);
               end loop;
            else
               Xi := Add_Mod (Mont_Mul (Xi, Xi, N, Npi), A, N);
               M := Abs_Diff (Xi, Xm);
               while Batch > 1 loop
                  Batch := Batch - 1;
                  Xi := Add_Mod
                    (Mont_Mul (Xi, Xi, N, Npi), A, N);
                  F := Abs_Diff (Xi, Xm);
                  M := Mont_Mul (M, F, N, Npi);
               end loop;
            end if;
            F := Int.Gcd (M, N);
            exit when F /= 1;
         end loop;
         if F = 1 then
            R := R * 2;
         else
            if F = N then
               Xi := Xs;
               loop
                  if N < 2 ** 63 or else A = Mont1 then
                     Xi := Mont_Mul (Xi, Xi + A, N, Npi);
                  else
                     Xi := Add_Mod
                       (Mont_Mul (Xi, Xi, N, Npi), A, N);
                  end if;
                  F := Int.Gcd (Abs_Diff (Xi, Xm), N);
                  exit when F /= 1 or else R = 0;
                  R := R - 1;
               end loop;
            end if;
            if F = 0 or else F = N then
               exit when Fails <= 0;
               Fails := Fails - 1;
               Xi := Mont1;
               Xm := Mont1;
               A := Add_Mod (A, Mont_In (11, N), N);
            else
               return Found (N, F);
            end if;
         end if;
      end loop;
      return One (N);
   end Raw_Brent;

   function Stage_Limit (B1, B2 : U64) return U64 is
     (if B2 > B1 then B2 else B1);

   function Raw_Pminus1 (N, B1, B2 : U64) return Factor_List is
      Hi : constant U64 := Stage_Limit (B1, B2);
      Ps : constant Sieve.Prime_Vectors.Vector := Sieve.Primes (Hi);
      A : U64 := 2;
      Q : U64 := 2;
      Save_A : U64 := 2;
      Save_Q : U64 := 1;
      K, Kmin, F : U64;
      Root : constant U64 := Int.Sqrtint (B1);
      J : Natural := 0;
      Stop : Boolean := False;
      Bm, Bprod, Diff, Last_Q, Gap : U64;
      Pre : array (0 .. 110) of U64 := [others => 0];
   begin
      for P of Ps loop
         exit when P > B1 or else Stop;
         Q := P;
         K := P;
         if P <= Root then
            K := P * P;
            Kmin := B1 / P;
            while K <= Kmin loop
               K := K * P;
            end loop;
         end if;
         A := Pow_Mod (A, K, N);
         J := J + 1;
         if J mod 32 = 0 then
            if A = 0 or else Int.Gcd (A - 1, N) /= 1 then
               Stop := True;
            else
               Save_A := A;
               Save_Q := Q;
            end if;
         end if;
      end loop;
      if A = 0 then
         return One (N);
      end if;
      F := Int.Gcd (A - 1, N);
      if F = N then
         A := Save_A;
         for P of Ps loop
            if P > Save_Q and then P <= B1 then
               K := P;
               Kmin := B1 / P;
               while K <= Kmin loop
                  K := K * P;
               end loop;
               A := Pow_Mod (A, K, N);
               F := Int.Gcd (A - 1, N);
               exit when F /= 1;
            end if;
         end loop;
      end if;
      if F = 1 and then B2 > B1 then
         Bm := A;
         Bprod := 1;
         Diff := Mul_Mod (Bm, Bm, N);
         Pre (0) := Diff;
         for I in 1 .. 19 loop
            Diff := Mul_Mod (Diff, Bm, N);
            Diff := Mul_Mod (Diff, Bm, N);
            Pre (I) := Diff;
         end loop;
         A := Pow_Mod (A, Q, N);
         J := 0;
         Last_Q := Q;
         for P of Ps loop
            if P > Q and then P <= B2 then
               Gap := (P - Last_Q) / 2 - 1;
               if Gap >= 111 then
                  Diff := Pow_Mod (Bm, P - Last_Q, N);
               else
                  Diff := Pre (Natural (Gap));
                  if Diff = 0 then
                     if Gap > 0 and then Pre (Natural (Gap) - 1) /= 0
                     then
                        Diff := Mul_Mod
                          (Mul_Mod (Pre (Natural (Gap) - 1), Bm, N),
                           Bm, N);
                     else
                        Diff := Pow_Mod (Bm, P - Last_Q, N);
                     end if;
                     Pre (Natural (Gap)) := Diff;
                  end if;
               end if;
               A := Mul_Mod (A, Diff, N);
               exit when A = 0;
               Bprod := Mul_Mod (Bprod, A - 1, N);
               J := J + 1;
               if J mod 64 = 0 then
                  F := Int.Gcd (Bprod, N);
                  exit when F /= 1;
               end if;
               Last_Q := P;
            end if;
         end loop;
         F := Int.Gcd (Bprod, N);
      end if;
      return Found (N, F);
   end Raw_Pminus1;

   procedure Pp1_Pow (X : in out U64; Exp, N : U64) is
      X0 : constant U64 := X;
      Y : U64 := Mul_Sub (X, X, 2, N);
      Bit : U64;
      T : U64;
   begin
      if Exp <= 1 then
         return;
      end if;
      Bit := 2 ** Natural (Int.Logint (Exp, 2) - 1);
      while Bit > 0 loop
         T := Mul_Sub (X, Y, X0, N);
         if (Exp and Bit) /= 0 then
            X := T;
            Y := Mul_Sub (Y, Y, 2, N);
         else
            Y := T;
            X := Mul_Sub (X, X, 2, N);
         end if;
         Bit := Bit / 2;
      end loop;
   end Pp1_Pow;

   function Raw_Pplus1 (N, B1 : U64) return Factor_List is
      Ps : constant Sieve.Prime_Vectors.Vector := Sieve.Primes (B1);
      X1 : U64 := 7 mod N;
      X2 : U64 := 11 mod N;
      F : U64 := 1;
      K, Kmin : U64;
      Root : constant U64 := Int.Sqrtint (B1);
      Stop : Boolean := False;
   begin
      for P of Ps loop
         exit when Stop;
         K := P;
         if P < Root then
            Kmin := B1 / P;
            while K <= Kmin loop
               K := K * P;
            end loop;
         end if;
         Pp1_Pow (X1, K, N);
         if X1 /= 2 then
            F := Int.Gcd (Sub_Mod (X1, 2, N), N);
            if F /= 1 and then F /= N then
               Stop := True;
            end if;
         end if;
         if not Stop then
            Pp1_Pow (X2, K, N);
            if X2 /= 2 then
               F := Int.Gcd (Sub_Mod (X2, 2, N), N);
               if F /= 1 and then F /= N then
                  Stop := True;
               end if;
            end if;
         end if;
      end loop;
      return Found (N, F);
   end Raw_Pplus1;

   --  factor.c: squfof_factor, 32-bit racing multipliers.
   Squfof_Max : constant U64 := U64'Last / 4;
   type Mult_State is record
      Valid : Integer := -1;
      P, Bn, Qn, Q0, B0, It, Imax, Mult : U32 := 0;
   end record;
   Multipliers : constant array (1 .. 38) of U64 :=
     [3 * 5 * 7 * 11, 3 * 5 * 7, 3 * 5 * 7 * 11 * 13,
      3 * 5 * 7 * 13, 3 * 5 * 7 * 11 * 17, 3 * 5 * 11,
      3 * 5 * 7 * 17, 3 * 5, 3 * 5 * 7 * 11 * 19,
      3 * 5 * 11 * 13, 3 * 5 * 7 * 19, 3 * 5 * 7 * 13 * 17,
      3 * 5 * 13, 3 * 7 * 11, 3 * 7, 5 * 7 * 11, 3 * 7 * 13,
      5 * 7, 3 * 5 * 17, 5 * 7 * 13, 3 * 5 * 19, 3 * 11,
      3 * 7 * 17, 3, 3 * 11 * 13, 5 * 11, 3 * 7 * 19, 3 * 13,
      5, 5 * 11 * 13, 5 * 7 * 19, 5 * 13, 7 * 11, 7, 3 * 17,
      7 * 13, 11, 1];

   function Squfof_Unit
     (Nn : U64; St : in out Mult_State) return U64
   is
      P : U32 := St.P;
      Bn : U32 := St.Bn;
      Qn : U32 := St.Qn;
      Q0 : U32 := St.Q0;
      B0 : constant U32 := St.B0;
      I : U32 := St.It;
      Imax : constant U32 := St.It + St.Imax;
      S, Ro, So, Bbn, T1, T2 : U32;
      Root : U64;
      Guard : Natural := 0;
   begin
      loop
         if (I and 1) /= 0 then
            T1 := P;
            P := Bn * Qn - P;
            T2 := Qn;
            Qn := Q0 + Bn * (T1 - P);
            Q0 := T2;
            if Qn = 0 then
               return 0;
            end if;
            Bn := (B0 + P) / Qn;
            I := I + 1;
         end if;
         loop
            if I >= Imax then
               St.P := P;
               St.Bn := Bn;
               St.Qn := Qn;
               St.Q0 := Q0;
               St.It := I;
               return 0;
            end if;
            T1 := P;
            P := Bn * Qn - P;
            T2 := Qn;
            Qn := Q0 + Bn * (T1 - P);
            Q0 := T2;
            if Qn = 0 then
               return 0;
            end if;
            Bn := (B0 + P) / Qn;
            I := I + 1;
            if Int.Is_Square (U64 (Qn)) then
               Root := Int.Sqrtint (U64 (Qn));
               exit;
            end if;
            T1 := P;
            P := Bn * Qn - P;
            T2 := Qn;
            Qn := Q0 + Bn * (T1 - P);
            Q0 := T2;
            if Qn = 0 then
               return 0;
            end if;
            Bn := (B0 + P) / Qn;
            I := I + 1;
         end loop;
         S := U32 (Root);
         St.It := I;
         Ro := P + S * ((B0 - P) / S);
         So := U32 ((Nn - U64 (Ro) * U64 (Ro)) / U64 (S));
         if So = 0 then
            return 0;
         end if;
         Bbn := (B0 + Ro) / So;
         loop
            T1 := Ro;
            Ro := Bbn * So - Ro;
            T2 := So;
            So := S + Bbn * (T1 - Ro);
            S := T2;
            if So = 0 then
               return 0;
            end if;
            Bbn := (B0 + Ro) / So;
            exit when Ro = T1;
            Guard := Guard + 1;
            if Guard > 8_000_000 then
               St.Valid := 0;
               return 0;
            end if;
         end loop;
         T1 := U32 (Int.Gcd (U64 (Ro), Nn));
         if T1 > 1 then
            return U64 (T1);
         end if;
      end loop;
   end Squfof_Unit;

   function Raw_Squfof (N, Rounds : U64) return Factor_List is
      State : array (Multipliers'Range) of Mult_State;
      Racing : Natural := Multipliers'Length;
      Done : U64 := 0;
      Mult, Nn, Sqrt_N, F64, Reduced : U64;
   begin
      if N > Squfof_Max then
         return One (N);
      end if;
      while Racing > 0 and then Done < Rounds loop
         for I in Multipliers'Range loop
            exit when Done >= Rounds;
            if State (I).Valid /= 0 then
               Mult := Multipliers (I);
               if State (I).Valid < 0 then
                  if Mult /= 0 and then Squfof_Max / Mult < N then
                     State (I).Valid := 0;
                     Racing := Racing - 1;
                  else
                     Nn := N * Mult;
                     Sqrt_N := Int.Sqrtint (Nn);
                     State (I).Valid := 1;
                     State (I).Q0 := 1;
                     State (I).B0 := U32 (Sqrt_N);
                     State (I).P := U32 (Sqrt_N);
                     State (I).Qn :=
                       U32 (Nn - Sqrt_N * Sqrt_N);
                     if State (I).Qn = 0 then
                        return Found (N, Sqrt_N);
                     end if;
                     State (I).Bn :=
                       U32 ((2 * Sqrt_N) / U64 (State (I).Qn));
                     State (I).It := 0;
                     State (I).Mult := U32 (Mult);
                     State (I).Imax := U32
                       (Trunc_U64 (Sqrt_Lf (Lf (Sqrt_N)) / 16.0));
                     if State (I).Imax < 20 then
                        State (I).Imax := 20;
                     end if;
                     if U64 (State (I).Imax) > Rounds then
                        State (I).Imax := U32 (Rounds);
                     end if;
                  end if;
               end if;
               if State (I).Valid > 0 then
                  if Racing = 1 then
                     State (I).Imax := U32 (Rounds - Done);
                  end if;
                  Nn := N * Mult;
                  F64 := Squfof_Unit (Nn, State (I));
                  if F64 > 1 then
                     Reduced := F64 / Int.Gcd (F64, Mult);
                     if Reduced > 1 then
                        return Found (N, Reduced);
                     end if;
                     State (I).Valid := 0;
                  end if;
                  if State (I).Valid = 0 then
                     Racing := Racing - 1;
                  end if;
                  Done := Done + U64 (State (I).Imax);
               end if;
            end if;
         end loop;
      end loop;
      return One (N);
   end Raw_Squfof;

   function Raw_Lehman
     (N : U64; Do_Trial : Boolean) return Factor_List
   is
      Tune : constant Lf := (if N >= 2 ** 36 then 3.5 else 5.0);
      Cube : constant U64 := Int.Rootint (N, 3);
      B : U64 := Trunc_U64 (Tune * Lf (1 + Cube));
      Cut : U64;
      Idx : Natural := 2;
      P : U64;
      Bred, KN, KN4, AA, BB, CC, UU, Inc, Res : U64;
      X : Lf;
      Root : U64;
      L : Factor_List;
   begin
      if N mod 2 = 0 then
         return Found (N, 2);
      end if;
      Cut := Trunc_U64 (0.1 * Lf (B));
      if Cut < 84 then
         Cut := 84;
      elsif Cut > 65535 then
         Cut := 65535;
      end if;
      while Idx <= Prime_Count loop
         P := Small (Idx);
         exit when P >= Cut;
         if N mod P = 0 then
            return Found (N, P);
         end if;
         Idx := Idx + 1;
      end loop;
      if N >= 8_796_393_022_207 then
         return One (N);
      end if;
      Bred := Trunc_U64 (Lf (B) / (Tune * Tune * Tune));
      KN := 0;
      for K in 1 .. Bred loop
         if K mod 2 = 1 then
            Inc := 4;
            Res := (K + N) mod 4;
         else
            Inc := 2;
            Res := 1;
         end if;
         if KN > U64'Last - N then
            return One (N);
         end if;
         KN := KN + N;
         if KN >= 2 ** 60 then
            return One (N);
         end if;
         KN4 := KN * 4;
         X := Sqrt_Lf (Lf (KN));
         AA := Trunc_U64 (X);
         if AA * AA = KN then
            return Found (N, Int.Gcd (AA, N));
         end if;
         X := X * 2.0;
         AA := Trunc_U64 (X + 0.9999999665);
         BB := AA mod Inc;
         BB := AA + (Inc + Res - BB) mod Inc;
         CC := BB * BB - KN4;
         UU := Trunc_U64 (X + Lf (B * B) / (2.0 * X));
         AA := BB;
         while AA <= UU loop
            if Int.Is_Square (CC) then
               Root := Int.Sqrtint (CC);
               return Found (N, Int.Gcd (AA + Root, N));
            end if;
            CC := CC + Inc * (AA + AA + Inc);
            AA := AA + Inc;
         end loop;
      end loop;
      if Do_Trial then
         if B > 65535 then
            B := 65535;
         end if;
         if Idx > Prime_Count then
            Idx := Prime_Count;
         end if;
         declare
            M : U64 := N;
         begin
            C_Trial (M, Small (Idx), B, L);
            return L;
         end;
      end if;
      return One (N);
   end Raw_Lehman;

   function Wrap
     (N : U64; Piece : Factor_List) return Factor_List
   is
      Rest : U64;
      L : Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      Append (L, Piece);
      return L;
   end Wrap;

   procedure Fill (N : U64; L : in out Factor_List) is
      M : U64 := N;
      K, Root, Piece : U64;
      Sub : Factor_List;
      Split : Factor_List;
   begin
      if M <= 1 then
         return;
      end if;
      for P of Small loop
         exit when P * P > M;
         while M mod P = 0 loop
            Push (L, P);
            M := M / P;
         end loop;
      end loop;
      if M = 1 then
         return;
      end if;
      if Primality.Is_Prime (M) = 2 then
         Push (L, M);
         return;
      end if;
      K := Int.Is_Power_Exp (M);
      if K > 1 then
         Root := Int.Rootint (M, K);
         Fill (Root, Sub);
         for I in 1 .. Sub.Count loop
            for Ignore in 1 .. Natural (K) loop
               Push (L, Sub.Value (I));
            end loop;
         end loop;
         return;
      end if;
      Split := Raw_Brent (M, 500_000, 1);
      if Split.Count /= 2 then
         Split := Raw_Squfof (M, 200_000);
      end if;
      if Split.Count /= 2 then
         Split := Raw_Brent (M, 2_000_000, 3);
      end if;
      if Split.Count /= 2 then
         Split := Raw_Holf (M, 100_000);
      end if;
      if Split.Count /= 2 then
         Push (L, M);
         return;
      end if;
      Piece := Split.Value (1);
      Fill (Piece, L);
      Fill (M / Piece, L);
   end Fill;

   function Factor (N : U64) return Factor_List is
      L : Factor_List;
   begin
      if N = 0 then
         return One (0);
      end if;
      if N = 1 then
         return L;
      end if;
      Fill (N, L);
      Sort (L);
      return L;
   end Factor;

   function Trial_Factor (N : U64; Last : U64 := 0) return Factor_List is
      Rest : U64;
      L : Factor_List := Prepare (N, Rest);
   begin
      if Rest /= 1 then
         C_Trial (Rest, 2, Last, L);
      end if;
      return L;
   end Trial_Factor;

   function Fermat_Factor
     (N : U64; Rounds : U64 := 64_000_000) return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Fermat (Rest, Rounds));
   end Fermat_Factor;

   function Holf_Factor
     (N : U64; Rounds : U64 := 8_000_000) return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Holf (Rest, Rounds));
   end Holf_Factor;

   function Lehman_Factor
     (N : U64; Do_Trial : Boolean := True) return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Lehman (Rest, Do_Trial));
   end Lehman_Factor;

   function Squfof_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Squfof (Rest, Rounds));
   end Squfof_Factor;

   function Prho_Factor
     (N : U64; Rounds : U64 := 4_000_000) return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Rho (Rest, Rounds));
   end Prho_Factor;

   function Pbrent_Factor
     (N : U64; Rounds : U64 := 4_000_000; A : U64 := 1)
      return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Brent (Rest, Rounds, A));
   end Pbrent_Factor;

   function Pminus1_Factor (N, B1, B2 : U64) return Factor_List is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Pminus1 (Rest, B1, B2));
   end Pminus1_Factor;

   function Pminus1_Factor
     (N : U64; B1 : U64 := 1_000_000) return Factor_List
   is
   begin
      return Pminus1_Factor (N, B1, 10 * B1);
   end Pminus1_Factor;

   function Pplus1_Factor
     (N : U64; B1 : U64 := 200) return Factor_List
   is
      Rest : U64;
      L : constant Factor_List := Prepare (N, Rest);
   begin
      if Rest = 1 then
         return L;
      end if;
      return Wrap (N, Raw_Pplus1 (Rest, B1));
   end Pplus1_Factor;

   function Divisors (N, Limit : U64) return U64_Vectors.Vector is
      Cap : U64 := Limit;
      L : Factor_List;
      Acc : U64_Vectors.Vector;
      P, E, Mult, Next : U64;
      Base : Ada.Containers.Count_Type;
      Idx : Natural;
      type Buf is array (Positive range <>) of U64;
      procedure Sort_Buf is new Ada.Containers.Generic_Array_Sort
        (Index_Type => Positive,
         Element_Type => U64,
         Array_Type => Buf);
   begin
      if N = 0 or else Cap = 0 then
         return Acc;
      end if;
      if N = 1 or else Cap = 1 then
         Acc.Append (1);
         return Acc;
      end if;
      if Cap > N then
         Cap := N;
      end if;
      L := Factor (N);
      Acc.Append (1);
      Idx := 1;
      while Idx <= L.Count loop
         P := L.Value (Idx);
         E := 0;
         while Idx <= L.Count and then L.Value (Idx) = P loop
            E := E + 1;
            Idx := Idx + 1;
         end loop;
         exit when P > Cap;
         Base := Acc.Length;
         Mult := 1;
         for Ignore in 1 .. E loop
            exit when Mult > U64'Last / P;
            Mult := Mult * P;
            for S in 1 .. Positive (Base) loop
               if Acc (S) <= Cap / Mult then
                  Next := Acc (S) * Mult;
                  if Next <= Cap then
                     Acc.Append (Next);
                  end if;
               end if;
            end loop;
         end loop;
      end loop;
      declare
         Raw : Buf (1 .. Positive (Acc.Length));
      begin
         for I in Raw'Range loop
            Raw (I) := Acc (I);
         end loop;
         Sort_Buf (Raw);
         Acc.Clear;
         for V of Raw loop
            Acc.Append (V);
         end loop;
      end;
      return Acc;
   end Divisors;

   function Divisors (N : U64) return U64_Vectors.Vector is
     (Divisors (N, N));
>>>>>>> origin/dev-mpuada-001
end Math_Prime_Util.Factor;
