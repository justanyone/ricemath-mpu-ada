with Interfaces.C;
with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Factor is
   use type U128;
   use type Interfaces.C.double;
   subtype C_Double is Interfaces.C.double;
   subtype U32 is Interfaces.Unsigned_32;
   use type U32;

   function C_Sqrt (X : C_Double) return C_Double;
   pragma Import (C, C_Sqrt, "sqrt");

   type Pair is record
      Count : Natural range 1 .. 2 := 1;
      A, B : U64 := 0;
   end record;

   type Kind is
     (Do_Fermat, Do_Holf, Do_Squfof, Do_Lehman, Do_Prho, Do_Pbrent,
      Do_Pminus1, Do_Pplus1);

   function Mul (A, B, N : U64) return U64 is
     (U64 ((U128 (A) * U128 (B)) mod U128 (N)));

   function Add (A, B, N : U64) return U64 is
     (U64 ((U128 (A) + U128 (B)) mod U128 (N)));

   function Sub (A, B, N : U64) return U64 is
     (U64 ((U128 (A mod N) + U128 (N) - U128 (B mod N)) mod U128 (N)));

   function Mulsub (A, B, C, N : U64) return U64 is
     (Sub (Mul (A, B, N), C, N));

   function Sqr_Add (A, C, N : U64) return U64 is
     (Add (Mul (A, A, N), C, N));

   function Pow (A, K, N : U64) return U64 is
      T : U64 := 1 mod N;
      B : U64 := A mod N;
      E : U64 := K;
   begin
      while E /= 0 loop
         if E mod 2 = 1 then
            T := Mul (T, B, N);
         end if;
         E := E / 2;
         if E /= 0 then
            B := Mul (B, B, N);
         end if;
      end loop;
      return T;
   end Pow;

   function Abs_Diff (A, B : U64) return U64 is
     (if A > B then A - B else B - A);

   function Low64 (X : U128) return U64 is
     (U64 (X and 16#FFFF_FFFF_FFFF_FFFF#));

   function Trunc_U64 (X : C_Double) return U64 is
   begin
      if X <= 0.0 then
         return 0;
      elsif X >= 18_446_744_073_709_551_615.0 then
         return U64'Last;
      else
         return U64 (C_Double'Truncation (X));
      end if;
   end Trunc_U64;

   function Found (N, F : U64) return Pair is
      G : U64;
   begin
      if F <= 1 or else F >= N or else N mod F /= 0 then
         return (1, N, 0);
      end if;
      G := N / F;
      if F <= G then
         return (2, F, G);
      else
         return (2, G, F);
      end if;
   end Found;

   function None (N : U64) return Pair is (1, N, 0);

   function Prepare (N : U64; Rest : out U64) return Factor_Vectors.Vector
   is
      V : Factor_Vectors.Vector;
      M : U64 := N;
   begin
      Rest := 0;
      if N = 0 then
         V.Append (0);
         return V;
      end if;
      while M mod 2 = 0 loop
         V.Append (2);
         M := M / 2;
      end loop;
      while M mod 3 = 0 loop
         V.Append (3);
         M := M / 3;
      end loop;
      while M mod 5 = 0 loop
         V.Append (5);
         M := M / 5;
      end loop;
      Rest := M;
      return V;
   end Prepare;

   --  sieve.h wheeladvance30, distancewheel30, nextwheel30.
   Distance : constant array (0 .. 29) of U64 :=
     [1, 0, 5, 4, 3, 2, 1, 0, 3, 2, 1, 0, 1, 0, 3, 2, 1, 0, 1, 0, 3, 2,
      1, 0, 5, 4, 3, 2, 1, 0];
   Advance : constant array (0 .. 29) of U64 :=
     [1, 6, 5, 4, 3, 2, 1, 4, 3, 2, 1, 2, 1, 4, 3, 2, 1, 2, 1, 4, 3, 2,
      1, 6, 5, 4, 3, 2, 1, 2];
   Next_W : constant array (0 .. 29) of U64 :=
     [1, 7, 7, 7, 7, 7, 7, 11, 11, 11, 11, 13, 13, 17, 17, 17, 17, 19,
      19, 23, 23, 23, 23, 29, 29, 29, 29, 29, 29, 1];

   function Trial_Raw (N, First, Last : U64) return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      F : U64 := First;
      Lim : U64 := Last;
      Limit : U64;
      W : U64;
      Passed : Boolean;
   begin
      if F < 2 then
         F := 2;
      end if;
      if Lim = 0 or else M / Lim < Lim then
         Lim := U64'Last;
      end if;
      if M < 4 or else Lim < F then
         if M /= 1 then
            R.Append (M);
         end if;
         return R;
      end if;
      if F <= 2_011 then
         if F <= 2 then
            while M mod 2 = 0 loop
               R.Append (2);
               M := M / 2;
            end loop;
         end if;
         if F <= 3 and then 3 <= Lim and then M > 0 then
            while M mod 3 = 0 loop
               R.Append (3);
               M := M / 3;
            end loop;
         end if;
         if F <= 5 and then 5 <= Lim and then M > 0 then
            while M mod 5 = 0 loop
               R.Append (5);
               M := M / 5;
            end loop;
         end if;
         Passed := True;
         for P of Sieve.Primes (2_011) loop
            if P >= F then
               if M <= 1 or else P > Lim or else P > M / P then
                  F := P;
                  Passed := False;
                  exit;
               end if;
               while M mod P = 0 loop
                  R.Append (P);
                  M := M / P;
               end loop;
            end if;
         end loop;
         if Passed then
            F := 2_017;
         end if;
      end if;
      if F > 2_011 and then Distance (F mod 30) <= U64'Last - F then
         F := F + Distance (F mod 30);
      end if;
      if M > 1 and then F /= 0 and then F <= M / F and then F <= Lim then
         Limit := Int.Sqrtint (M);
         if Limit > Lim then
            Limit := Lim;
         end if;
         W := F mod 30;
         while F <= Limit loop
            if M mod F = 0 then
               while M mod F = 0 loop
                  R.Append (F);
                  M := M / F;
               end loop;
               if M = 0 then
                  exit;
               end if;
               if Int.Sqrtint (M) < Limit then
                  Limit := Int.Sqrtint (M);
               end if;
            end if;
            if F > U64'Last - Advance (W) then
               exit;
            end if;
            F := F + Advance (W);
            W := Next_W (W);
         end loop;
      end if;
      if M /= 1 then
         R.Append (M);
      end if;
      return R;
   end Trial_Raw;

   function Fermat_Raw (N, Rounds : U64) return Pair is
      Sq : constant U64 := Int.Sqrtint (N);
      X : Int.I128 := Int.I128 (2 * Sq + 1);
      Y : Int.I128 := 1;
      R : Int.I128 := -Int.I128 (N - Sq * Sq);
      Left : U64 := Rounds;
   begin
      if N < 3 or else N mod 2 = 0 then
         return None (N);
      end if;
      while R /= 0 loop
         if Left = 0 then
            return None (N);
         end if;
         Left := Left - 1;
         R := R + X;
         X := X + 2;
         loop
            R := R - Y;
            Y := Y + 2;
            exit when R <= 0;
         end loop;
      end loop;
      return Found (N, U64 ((X - Y) / 2));
   end Fermat_Raw;

   function Holf_Raw (N, Rounds : U64) return Pair is
      R : U64 := Rounds;
      Npre, Ni, S, M, Root, G : U64;
      I : U64;
   begin
      if N < 3 or else N mod 2 = 0 then
         return None (N);
      end if;
      if Int.Is_Square (N) then
         return Found (N, Int.Sqrtint (N));
      end if;
      if N <= U64'Last / 64 then
         if N <= U64'Last / 8192 then
            Npre := N * 720;
         elsif N <= U64'Last / 2048 then
            Npre := N * 480;
         elsif N <= U64'Last / 1024 then
            Npre := N * 360;
         elsif N <= U64'Last / 256 then
            Npre := N * 60;
         else
            Npre := N * 30;
         end if;
         Ni := Npre;
         loop
            if R = 0 then
               return None (N);
            end if;
            R := R - 1;
            S := 1 + Int.Sqrtint (Ni);
            M := Low64 (U128 (S) * U128 (S) - U128 (Ni));
            if Int.Is_Square (M) then
               Root := Int.Sqrtint (M);
               if S >= Root then
                  G := Int.Gcd (S - Root, N);
                  if G > 1 and then G < N then
                     return Found (N, G);
                  end if;
               end if;
            end if;
            exit when Ni >= Ni + Npre;
            Ni := Ni + Npre;
         end loop;
      end if;
      I := 1;
      while I <= R loop
         S := Trunc_U64
           (C_Sqrt (C_Double (N) * C_Double (I))) + 1;
         M := Mul (S, S, N);
         if Int.Is_Square (M) then
            Root := Int.Sqrtint (M);
            if S >= Root then
               return Found (N, Int.Gcd (S - Root, N));
            else
               return Found (N, Int.Gcd (Root - S, N));
            end if;
         end if;
         I := I + 1;
      end loop;
      return None (N);
   end Holf_Raw;

   function Pbrent_Raw (N, Rounds, A0 : U64) return Pair is
      Inner : constant U64 := (if N <= 4_000_000_000 then 32 else 160);
      F, Mv, R, Xi, Xm, Save : U64;
      A : U64 := A0;
      Left, Batch : U64;
      Fails : Integer := 6;
      Budget : U64 := Rounds;
   begin
      if N < 3 or else N mod 2 = 0 or else Budget = 0 then
         return None (N);
      end if;
      R := 1;
      F := 1;
      Xi := 1;
      Xm := 1;
      while Budget > 0 loop
         Left := (if R > Budget then Budget else R);
         Save := Xi;
         while Left > 0 loop
            Batch := (if Left > Inner then Inner else Left);
            Save := Xi;
            Left := Left - Batch;
            Budget := Budget - Batch;
            Xi := Sqr_Add (Xi, A, N);
            Mv := Abs_Diff (Xi, Xm);
            while Batch > 1 loop
               Batch := Batch - 1;
               Xi := Sqr_Add (Xi, A, N);
               F := Abs_Diff (Xi, Xm);
               Mv := Mul (Mv, F, N);
            end loop;
            F := Int.Gcd (Mv, N);
            exit when F /= 1;
         end loop;
         if F = 1 then
            R := R * 2;
            Xm := Xi;
         else
            if F = N then
               Xi := Save;
               loop
                  Xi := Sqr_Add (Xi, A, N);
                  F := Int.Gcd (Abs_Diff (Xi, Xm), N);
                  exit when F /= 1 or else R = 0;
                  R := R - 1;
               end loop;
            end if;
            if F = 0 or else F = N then
               exit when Fails <= 0;
               Fails := Fails - 1;
               Xm := Add (Xm, 11, N);
               Xi := Xm;
               A := A + 1;
            else
               return Found (N, F);
            end if;
         end if;
      end loop;
      return None (N);
   end Pbrent_Raw;

   function Prho_Raw (N, Rounds : U64) return Pair is
      Inner : constant U64 := 64;
      F, Mv, U, V, Old_U, Old_V, A : U64;
      I, Batches : U64;
      Fails : Integer := 3;
   begin
      if N < 3 or else N mod 2 = 0 or else Rounds = 0 then
         return None (N);
      end if;
      U := 7;
      V := 7;
      A := 1;
      Batches := (Rounds + Inner - 1) / Inner;
      while Batches > 0 loop
         Batches := Batches - 1;
         Mv := 1;
         Old_U := U;
         Old_V := V;
         for Step in 1 .. Inner loop
            U := Sqr_Add (U, A, N);
            V := Sqr_Add (Sqr_Add (V, A, N), A, N);
            Mv := Mul (Mv, Abs_Diff (U, V), N);
         end loop;
         F := Int.Gcd (Mv, N);
         if F /= 1 then
            if F = N then
               U := Old_U;
               V := Old_V;
               I := Inner;
               loop
                  U := Sqr_Add (U, A, N);
                  V := Sqr_Add (Sqr_Add (V, A, N), A, N);
                  F := Int.Gcd (Abs_Diff (U, V), N);
                  exit when F /= 1 or else I = 0;
                  I := I - 1;
               end loop;
            end if;
            if F = 0 or else F = N then
               exit when Fails <= 0;
               Fails := Fails - 1;
               U := Add (U, 2, N);
               V := U;
               A := A + 2;
            else
               return Found (N, F);
            end if;
         end if;
      end loop;
      return None (N);
   end Prho_Raw;

   function Pminus1_Raw (N, B1, B2 : U64) return Pair is
      use Sieve;
      A : U64 := 2;
      Q : U64 := 2;
      Save_A : U64 := 2;
      Save_Q : U64 := 1;
      J : U64 := 1;
      K, Kmin, F, Bm, B, Diff, Half : U64;
      Sqrt_B : U64;
      Ps : Prime_Vectors.Vector;
      Pre : array (0 .. 110) of U64 := [others => 0];
   begin
      if N < 3 or else N mod 2 = 0 then
         return None (N);
      end if;
      Sqrt_B := Int.Sqrtint (B1);
      Ps := Primes (B1);
      for P of Ps loop
         Q := P;
         K := P;
         if P <= Sqrt_B and then P /= 0 then
            K := P * P;
            Kmin := B1 / P;
            while K <= Kmin loop
               exit when P /= 0 and then K > U64'Last / P;
               K := K * P;
            end loop;
         end if;
         A := Pow (A, K, N);
         if J mod 32 = 0 then
            if A = 0 or else Int.Gcd (A - 1, N) /= 1 then
               exit;
            end if;
            Save_A := A;
            Save_Q := Q;
         end if;
         J := J + 1;
      end loop;
      if A = 0 then
         return None (N);
      end if;
      F := Int.Gcd (A - 1, N);
      if F = N then
         A := Save_A;
         for P of Ps loop
            if P > Save_Q and then P <= B1 then
               K := P;
               Kmin := B1 / P;
               while K <= Kmin loop
                  exit when K > U64'Last / P;
                  K := K * P;
               end loop;
               A := Pow (A, K, N);
               F := Int.Gcd (A - 1, N);
               exit when F /= 1;
            end if;
         end loop;
      end if;
      if F = 1 and then B2 > B1 then
         Bm := A;
         B := 1;
         Diff := Mul (Bm, Bm, N);
         Pre (0) := Diff;
         for J2 in 1 .. 19 loop
            Diff := Mul (Mul (Diff, Bm, N), Bm, N);
            Pre (J2) := Diff;
         end loop;
         A := Pow (A, Q, N);
         J := 1;
         for P of Primes (B2) loop
            if P > Q then
               Half := (P - Q) / 2;
               if Half = 0 or else Half - 1 >= 111 then
                  Diff := Pow (Bm, P - Q, N);
               else
                  Diff := Pre (Natural (Half - 1));
                  if Diff = 0 then
                     if Half - 1 >= 1 and then Pre (Natural (Half - 2)) /= 0
                     then
                        Diff := Mul
                          (Mul (Pre (Natural (Half - 2)), Bm, N), Bm, N);
                     else
                        Diff := Pow (Bm, P - Q, N);
                     end if;
                     Pre (Natural (Half - 1)) := Diff;
                  end if;
               end if;
               Q := P;
               A := Mul (A, Diff, N);
               exit when A = 0;
               B := Mul (B, A - 1, N);
               if J mod 64 = 0 then
                  F := Int.Gcd (B, N);
                  exit when F /= 1;
               end if;
               J := J + 1;
            end if;
         end loop;
         F := Int.Gcd (B, N);
      end if;
      return Found (N, F);
   end Pminus1_Raw;

   function Second_Bit (Exp : U64) return U64 is
      B : U64 := 1;
   begin
      while B <= U64'Last / 2 and then B * 2 <= Exp loop
         B := B * 2;
      end loop;
      return B / 2;
   end Second_Bit;

   function Pp1_Pow (Xin, Exp, N : U64) return U64 is
      X0 : constant U64 := Xin;
      X : U64 := Xin;
      Y : U64 := Mulsub (X, X, 2, N);
      Bit : U64 := Second_Bit (Exp);
      T : U64;
   begin
      while Bit > 0 loop
         T := Mulsub (X, Y, X0, N);
         if (Exp and Bit) /= 0 then
            X := T;
            Y := Mulsub (Y, Y, 2, N);
         else
            Y := T;
            X := Mulsub (X, X, 2, N);
         end if;
         Bit := Bit / 2;
      end loop;
      return X;
   end Pp1_Pow;

   function Pplus1_Raw (N, B1 : U64) return Pair is
      X1 : U64 := 7 mod N;
      X2 : U64 := 11 mod N;
      F : U64 := 1;
      K, Kmin : U64;
      Sqrt_B : constant U64 := Int.Sqrtint (B1);
   begin
      if N < 3 or else N mod 2 = 0 then
         return None (N);
      end if;
      for P of Sieve.Primes (B1) loop
         K := P;
         if P < Sqrt_B then
            Kmin := B1 / P;
            while K <= Kmin loop
               exit when K > U64'Last / P;
               K := K * P;
            end loop;
         end if;
         X1 := Pp1_Pow (X1, K, N);
         if X1 /= 2 then
            F := Int.Gcd (Sub (X1, 2, N), N);
            exit when F /= 1 and then F /= N;
         end if;
         X2 := Pp1_Pow (X2, K, N);
         if X2 /= 2 then
            F := Int.Gcd (Sub (X2, 2, N), N);
            exit when F /= 1 and then F /= N;
         end if;
      end loop;
      return Found (N, F);
   end Pplus1_Raw;

   --  factor.c squfof_multipliers, Gower and Wagstaff ordering.
   Mults : constant array (1 .. 38) of U64 :=
     [1155, 105, 15015, 1365, 19635, 165, 1785, 15, 21945, 2145, 1995,
      23205, 195, 231, 21, 385, 273, 35, 255, 455, 285, 33, 357, 3, 429,
      55, 399, 39, 5, 715, 665, 65, 77, 7, 51, 91, 11, 1];

   type Race is record
      Valid : Integer := -1;
      P, Bn, Qn, Q0, B0 : U32 := 0;
      It, Imax : U64 := 0;
   end record;

   function Squfof_Unit (Nn : U64; St : in out Race) return U64 is
      I : U64 := St.It;
      Imax : constant U64 := I + St.Imax;
      P : U32 := St.P;
      Bn : U32 := St.Bn;
      Qn : U32 := St.Qn;
      Q0 : U32 := St.Q0;
      B0 : constant U32 := St.B0;
      T1, T2, S, Ro, So, Bbn : U32;
      Root : U64;
      So64 : U64;
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
               St.Valid := 0;
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
               St.Valid := 0;
               return 0;
            end if;
            Bn := (B0 + P) / Qn;
            I := I + 1;
            if Int.Is_Square (U64 (Qn)) then
               exit;
            end if;
            T1 := P;
            P := Bn * Qn - P;
            T2 := Qn;
            Qn := Q0 + Bn * (T1 - P);
            Q0 := T2;
            if Qn = 0 then
               St.Valid := 0;
               return 0;
            end if;
            Bn := (B0 + P) / Qn;
            I := I + 1;
         end loop;
         Root := Int.Sqrtint (U64 (Qn));
         S := U32 (Root);
         St.It := I;
         if S = 0 then
            St.Valid := 0;
            return 0;
         end if;
         Ro := P + S * ((B0 - P) / S);
         So64 := (Nn - U64 (Ro) * U64 (Ro)) / U64 (S);
         So := U32 (So64 and 16#FFFF_FFFF#);
         if So = 0 then
            St.Valid := 0;
            return 0;
         end if;
         Bbn := (B0 + Ro) / So;
         Guard := 0;
         loop
            T1 := Ro;
            Ro := Bbn * So - Ro;
            T2 := So;
            So := S + Bbn * (T1 - Ro);
            S := T2;
            if So = 0 then
               St.Valid := 0;
               return 0;
            end if;
            Bbn := (B0 + Ro) / So;
            exit when Ro = T1;
            T1 := Ro;
            Ro := Bbn * So - Ro;
            T2 := So;
            So := S + Bbn * (T1 - Ro);
            S := T2;
            if So = 0 then
               St.Valid := 0;
               return 0;
            end if;
            Bbn := (B0 + Ro) / So;
            exit when Ro = T1;
            T1 := Ro;
            Ro := Bbn * So - Ro;
            T2 := So;
            So := S + Bbn * (T1 - Ro);
            S := T2;
            if So = 0 then
               St.Valid := 0;
               return 0;
            end if;
            Bbn := (B0 + Ro) / So;
            exit when Ro = T1;
            T1 := Ro;
            Ro := Bbn * So - Ro;
            T2 := So;
            So := S + Bbn * (T1 - Ro);
            S := T2;
            if So = 0 then
               St.Valid := 0;
               return 0;
            end if;
            Bbn := (B0 + Ro) / So;
            exit when Ro = T1;
            Guard := Guard + 1;
            if Guard > 2_000_000 then
               St.Valid := 0;
               return 0;
            end if;
         end loop;
         Root := Int.Gcd (U64 (Ro), Nn);
         if Root > 1 then
            return Root;
         end if;
      end loop;
   end Squfof_Unit;

   function Squfof_Raw (N, Rounds : U64) return Pair is
      State : array (1 .. 38) of Race;
      Racing : Natural := 38;
      Done : U64 := 0;
      Mult, Nn, Root, F, Red : U64;
   begin
      if N < 3 or else N mod 2 = 0 or else N > U64'Last / 4 then
         return None (N);
      end if;
      while Racing > 0 and then Done < Rounds loop
         for I in State'Range loop
            exit when Done >= Rounds;
            if State (I).Valid /= 0 then
               Mult := Mults (I);
               if State (I).Valid = -1 then
                  if Mult /= 0 and then (U64'Last / 4) / Mult < N then
                     State (I).Valid := 0;
                     Racing := Racing - 1;
                  else
                     Nn := N * Mult;
                     Root := Int.Sqrtint (Nn);
                     State (I).Valid := 1;
                     State (I).Q0 := 1;
                     State (I).B0 := U32 (Root and 16#FFFF_FFFF#);
                     State (I).P := State (I).B0;
                     State (I).Qn := U32
                       ((Nn - Root * Root) and 16#FFFF_FFFF#);
                     if State (I).Qn = 0 then
                        return Found (N, Root);
                     end if;
                     State (I).Bn := U32
                       (((2 * Root) / U64 (State (I).Qn))
                        and 16#FFFF_FFFF#);
                     State (I).It := 0;
                     State (I).Imax := Trunc_U64
                       (C_Sqrt (C_Double (Root)) / 16.0);
                     if State (I).Imax < 20 then
                        State (I).Imax := 20;
                     end if;
                     if State (I).Imax > Rounds then
                        State (I).Imax := Rounds;
                     end if;
                  end if;
               end if;
               if State (I).Valid > 0 then
                  if Racing = 1 then
                     State (I).Imax := Rounds - Done;
                  end if;
                  Nn := N * Mult;
                  F := Squfof_Unit (Nn, State (I));
                  if F > 1 then
                     Red := F / Int.Gcd (F, Mult);
                     if Red > 1 and then Red < N and then N mod Red = 0
                     then
                        return Found (N, Red);
                     end if;
                     State (I).Valid := 0;
                  end if;
                  if State (I).Valid = 0 then
                     Racing := Racing - 1;
                  end if;
                  Done := Done + State (I).Imax;
               end if;
            end if;
         end loop;
      end loop;
      return None (N);
   end Squfof_Raw;

   function Lehman_Raw (N, Trial : U64) return Factor_Vectors.Vector is
      R : Factor_Vectors.Vector;
      Do_Trial : constant Boolean := Trial /= 0;
      Tune : C_Double;
      X : C_Double;
      A, C, KN, KN4, U, B2, Cut, Bound, Start : U64;
      B, K, Inc, Rm, Bb : U64;
      P : Pair;
   begin
      if N mod 2 = 0 then
         P := Found (N, 2);
         R.Append (P.A);
         if P.Count = 2 then
            R.Append (P.B);
         end if;
         return R;
      end if;
      if N >= 2 ** 36 then
         Tune := 3.5;
      else
         Tune := 5.0;
      end if;
      B := Trunc_U64 (Tune * C_Double (Int.Rootint (N, 3) + 1));
      Start := 2;
      if Do_Trial then
         Cut := Trunc_U64 (0.1 * C_Double (B));
         if Cut < 84 then
            Cut := 84;
         elsif Cut > 65_535 then
            Cut := 65_535;
         end if;
         for Pv of Sieve.Primes (65_535) loop
            if Pv >= Cut then
               Start := Pv;
               exit;
            end if;
            if N mod Pv = 0 then
               P := Found (N, Pv);
               R.Append (P.A);
               if P.Count = 2 then
                  R.Append (P.B);
               end if;
               return R;
            end if;
         end loop;
      end if;
      if N >= 8_796_393_022_207 then
         R.Append (N);
         return R;
      end if;
      Bound := Trunc_U64
        (C_Double (B) / (Tune * Tune * Tune));
      B2 := B * B;
      KN := 0;
      K := 1;
      while K <= Bound loop
         if K mod 2 = 1 then
            Inc := 4;
            Rm := (K + N) mod 4;
         else
            Inc := 2;
            Rm := 1;
         end if;
         if KN > U64'Last - N then
            R.Append (N);
            return R;
         end if;
         KN := KN + N;
         if KN >= 1_152_921_504_606_846_976 then
            R.Append (N);
            return R;
         end if;
         KN4 := KN * 4;
         X := C_Sqrt (C_Double (KN));
         A := Trunc_U64 (X);
         if A * A = KN then
            P := Found (N, Int.Gcd (A, N));
            R.Append (P.A);
            if P.Count = 2 then
               R.Append (P.B);
            end if;
            return R;
         end if;
         X := X * 2.0;
         A := Trunc_U64 (X + 0.9999999665);
         Bb := A mod Inc;
         Bb := A + (Inc + Rm - Bb) mod Inc;
         C := Low64 (U128 (Bb) * U128 (Bb) - U128 (KN4));
         if X > 0.0 then
            U := Trunc_U64 (X + C_Double (B2) / (2.0 * X));
         else
            U := A;
         end if;
         A := Bb;
         while A <= U loop
            if Int.Is_Square (C) then
               P := Found (N, Int.Gcd (A + Int.Sqrtint (C), N));
               R.Append (P.A);
               if P.Count = 2 then
                  R.Append (P.B);
               end if;
               return R;
            end if;
            C := Low64
              (U128 (C) + U128 (Inc) * (U128 (A) + U128 (A) + U128 (Inc)));
            if A > U64'Last - Inc then
               exit;
            end if;
            A := A + Inc;
         end loop;
         K := K + 1;
      end loop;
      if Do_Trial then
         if B > 65_535 then
            B := 65_535;
         end if;
         if Start < 2 then
            Start := 2_011;
         end if;
         return Trial_Raw (N, Start, B);
      end if;
      R.Append (N);
      return R;
   end Lehman_Raw;

   function Ten_Times (B1, B2 : U64) return U64 is
   begin
      if B2 /= 0 then
         return B2;
      elsif B1 > U64'Last / 10 then
         return U64'Last;
      else
         return 10 * B1;
      end if;
   end Ten_Times;

   procedure Append_Pair (V : in out Factor_Vectors.Vector; P : Pair) is
   begin
      V.Append (P.A);
      if P.Count = 2 then
         V.Append (P.B);
      end if;
   end Append_Pair;

   function Apply (N : U64; K : Kind; P1, P2 : U64)
      return Factor_Vectors.Vector
   is
      V : Factor_Vectors.Vector;
      Rest : U64;
      P : Pair;
   begin
      V := Prepare (N, Rest);
      if Rest <= 1 then
         return V;
      elsif Primality.Is_Prime (Rest) /= 0 then
         V.Append (Rest);
         return V;
      end if;
      case K is
         when Do_Fermat =>
            Append_Pair (V, Fermat_Raw (Rest, P1));
         when Do_Holf =>
            Append_Pair (V, Holf_Raw (Rest, P1));
         when Do_Squfof =>
            Append_Pair (V, Squfof_Raw (Rest, P1));
         when Do_Lehman =>
            for X of Lehman_Raw (Rest, P1) loop
               V.Append (X);
            end loop;
         when Do_Prho =>
            Append_Pair (V, Prho_Raw (Rest, P1));
         when Do_Pbrent =>
            Append_Pair (V, Pbrent_Raw (Rest, P1, P2));
         when Do_Pminus1 =>
            Append_Pair (V, Pminus1_Raw (Rest, P1, Ten_Times (P1, P2)));
         when Do_Pplus1 =>
            Append_Pair (V, Pplus1_Raw (Rest, P1));
      end case;
      return V;
   end Apply;

   function One_Factor (N : U64) return U64 is
      K : U64;
      P : Pair;
   begin
      if N < 4 or else Primality.Is_Prime (N) /= 0 then
         return N;
      end if;
      K := Int.Is_Power_Exp (N);
      if K > 1 then
         return Int.Rootint (N, K);
      end if;
      if N <= 16#FFFF_FFFF# then
         P := Holf_Raw (N, 20_000);
         if P.Count = 2 then
            return P.A;
         end if;
      end if;
      if N <= 4_611_686_018_427_387_903 then
         P := Squfof_Raw (N, 200_000);
         if P.Count = 2 then
            return P.A;
         end if;
      end if;
      P := Pbrent_Raw (N, 100_000, 1);
      if P.Count = 2 then
         return P.A;
      end if;
      P := Pbrent_Raw (N, 400_000, 3);
      if P.Count = 2 then
         return P.A;
      end if;
      P := Prho_Raw (N, 200_000);
      if P.Count = 2 then
         return P.A;
      end if;
      P := Pbrent_Raw (N, 2_000_000, 5);
      if P.Count = 2 then
         return P.A;
      end if;
      return N;
   end One_Factor;

   procedure Sort (V : in out Factor_Vectors.Vector) is
      T : U64;
      J : Natural;
   begin
      if V.Length <= 1 then
         return;
      end if;
      for I in V.First_Index + 1 .. V.Last_Index loop
         T := V (I);
         J := I;
         while J > V.First_Index and then V (J - 1) > T loop
            V (J) := V (J - 1);
            J := J - 1;
         end loop;
         V (J) := T;
      end loop;
   end Sort;

   function Factor (N : U64) return Factor_Vectors.Vector is
      Result : Factor_Vectors.Vector;
      Stack : array (1 .. 64) of U64 := [others => 0];
      Top : Natural := 0;
      M, F : U64;
   begin
      if N = 0 then
         Result.Append (0);
         return Result;
      elsif N = 1 then
         return Result;
      end if;
      M := N;
      for P of Sieve.Primes (2_011) loop
         exit when M = 1 or else P > M / P;
         while M mod P = 0 loop
            Result.Append (P);
            M := M / P;
         end loop;
      end loop;
      if M /= 1 then
         Top := 1;
         Stack (1) := M;
      end if;
      while Top > 0 loop
         M := Stack (Top);
         Top := Top - 1;
         if Primality.Is_Prime (M) /= 0 then
            Result.Append (M);
         else
            F := One_Factor (M);
            if F <= 1 or else F >= M or else M mod F /= 0 then
               Result.Append (M);
            elsif Top + 2 > Stack'Last then
               Result.Append (F);
               Result.Append (M / F);
            else
               Top := Top + 1;
               Stack (Top) := M / F;
               Top := Top + 1;
               Stack (Top) := F;
            end if;
         end if;
      end loop;
      Sort (Result);
      return Result;
   end Factor;

   function Trial_Factor (N : U64; Last : U64)
      return Factor_Vectors.Vector
   is
      V : Factor_Vectors.Vector;
      Rest : U64;
   begin
      V := Prepare (N, Rest);
      if Rest <= 1 then
         return V;
      elsif Primality.Is_Prime (Rest) /= 0 then
         V.Append (Rest);
         return V;
      end if;
      for X of Trial_Raw (Rest, 2, Last) loop
         V.Append (X);
      end loop;
      return V;
   end Trial_Factor;

   function Fermat_Factor (N : U64; Rounds : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Fermat, Rounds, 0));

   function Holf_Factor (N : U64; Rounds : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Holf, Rounds, 0));

   function Squfof_Factor (N : U64; Rounds : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Squfof, Rounds, 0));

   function Lehman_Factor (N : U64; Trial : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Lehman, Trial, 0));

   function Prho_Factor (N : U64; Rounds : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Prho, Rounds, 0));

   function Pbrent_Factor (N : U64; Rounds : U64; A : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Pbrent, Rounds, A));

   function Pminus1_Factor (N : U64; B1 : U64; B2 : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Pminus1, B1, B2));

   function Pplus1_Factor (N : U64; B1 : U64)
      return Factor_Vectors.Vector
   is (Apply (N, Do_Pplus1, B1, 0));

   function Divisors (N : U64; Max_D : U64)
      return Factor_Vectors.Vector
   is
      Fac, Res : Factor_Vectors.Vector;
      K, Mult : U64;
      P : U64;
      E, Sc : Natural;
      I : Natural;
   begin
      if N = 0 or else Max_D = 0 then
         return Res;
      elsif N = 1 or else Max_D = 1 then
         Res.Append (1);
         return Res;
      end if;
      if Max_D > N then
         K := N;
      else
         K := Max_D;
      end if;
      Fac := Factor (N);
      Res.Append (1);
      I := Fac.First_Index;
      while I <= Fac.Last_Index loop
         P := Fac (I);
         E := 0;
         while I <= Fac.Last_Index and then Fac (I) = P loop
            E := E + 1;
            I := I + 1;
         end loop;
         Sc := Natural (Res.Length);
         Mult := 1;
         for Exp in 1 .. E loop
            exit when Mult > U64'Last / P;
            Mult := Mult * P;
            for S in 1 .. Sc loop
               if U128 (Res (S)) * U128 (Mult) <= U128 (K) then
                  Res.Append (U64 (U128 (Res (S)) * U128 (Mult)));
               end if;
            end loop;
         end loop;
      end loop;
      Sort (Res);
      return Res;
   end Divisors;
end Math_Prime_Util.Factor;
