with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Factor is
   use type Primality.Prime_Result;
   use type Int.Optional_U64;

   --  factor.c: ecm64_sigmas, in the original deterministic order.
   Sigmas : constant array (Positive range 1 .. 400) of U64 :=
     (11, 13, 17, 19, 23, 29, 31, 37, 41, 43,
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
      36919, 37363, 37517, 37699, 37907, 38047, 38177, 38273, 38749, 38903);

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
      X := (others => 0);
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
               if G > 1 and G < N then
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
                  if Primality.Is_Prime (P) /= 0 and P /= M then
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
      return (if F > 1 and F < N then F else 0);
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
            if G > 1 and G < N then
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
                     if G > 1 and G < N then
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
               if G > 1 and G < N then
                  return G;
               end if;
               if B2 > B1 then
                  G := Stage_Two (P, A24, N, B1, B2);
                  if G > 1 and G < N then
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
         return (1 => 0);
      end if;
      for Small of Factor_List'(2, 3, 5) loop
         while Remaining > 1 and then Remaining mod Small = 0 loop
            Count := Count + 1;
            Result (Count) := Small;
            Remaining := Remaining / Small;
         end loop;
      end loop;
      if Remaining > 1 then
         F := (if Primality.Is_Prime (Remaining) /= 0 then 0
               else Find_Factor (Remaining, B1, Bound, Curves));
         if F > 1 and F < Remaining then
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
end Math_Prime_Util.Factor;
