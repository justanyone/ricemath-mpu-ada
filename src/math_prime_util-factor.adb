with Ada.Containers;
with Ada.Numerics.Long_Elementary_Functions;
with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Factor is
   use type U128;
   use type Int.I128;

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
         S := U64
           (Lf'Sqrt (Lf (N) * Lf (I))) + 1;
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
      Bits : constant U64 := 64 - U64 (Int.Logint (N, 2));
      Inner : constant U64 :=
        (if Bits <= 31 then 32
         elsif Bits <= 35 then 64
         elsif Bits <= 40 then 160
         elsif Bits <= 52 then 256
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
   Multipliers : constant array (1 .. 37) of U64 :=
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
                       (Lf (Lf'Sqrt (Lf (Sqrt_N)) / 16.0));
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
      B : U64 := U64 (Tune * Lf (1 + Cube));
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
      Cut := U64 (0.1 * Lf (B));
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
      Bred := U64 (Lf (B) / (Tune * Tune * Tune));
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
         X := Lf'Sqrt (Lf (KN));
         AA := U64 (X);
         if AA * AA = KN then
            return Found (N, Int.Gcd (AA, N));
         end if;
         X := X * 2.0;
         AA := U64 (X + 0.9999999665);
         BB := AA mod Inc;
         BB := AA + (Inc + Res - BB) mod Inc;
         CC := BB * BB - KN4;
         UU := U64 (X + Lf (B * B) / (2.0 * X));
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
      Prior, Mult, Next : U64;
      Mark : Ada.Containers.Count_Type;
      type Buf is array (Positive range <>) of U64;
      procedure Sort_Buf is new Ada.Containers.Generic_Array_Sort
        (Positive, U64, Buf);
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
      Prior := 0;
      Mult := 1;
      for I in 1 .. L.Count loop
         if L.Value (I) /= Prior then
            Prior := L.Value (I);
            Mult := 1;
         end if;
         if Prior > Cap then
            exit;
         end if;
         if Mult > U64'Last / Prior then
            exit;
         end if;
         Mult := Mult * Prior;
         Mark := Acc.Length;
         for S in 1 .. Positive (Mark) loop
            if Acc (S) <= Cap / Mult then
               Next := Acc (S) * Mult;
               if Next <= Cap then
                  Acc.Append (Next);
               end if;
            end if;
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
end Math_Prime_Util.Factor;
