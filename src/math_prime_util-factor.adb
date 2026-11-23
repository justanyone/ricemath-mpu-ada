with Ada.Numerics.Long_Elementary_Functions;
with Interfaces;
with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

--  factor.c and the XS.xs wrappers for the single-split methods.
package body Math_Prime_Util.Factor is
   use type U128;
   use type Interfaces.Unsigned_32;
   subtype U32 is Interfaces.Unsigned_32;
   package Long_Math renames Ada.Numerics.Long_Elementary_Functions;

   --  util.c: primes_small. Index 0 is 0; the last entry is 2011.
   Primes_Small : constant array (0 .. 305) of U64 :=
     [0, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47,
      53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109,
      113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179,
      181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241,
      251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313,
      317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389,
      397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461,
      463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547,
      557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617,
      619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691,
      701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773,
      787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859,
      863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947,
      953, 967, 971, 977, 983, 991, 997, 1009, 1013, 1019, 1021,
      1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091,
      1093, 1097, 1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163,
      1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231,
      1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301,
      1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399,
      1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453, 1459,
      1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531,
      1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597, 1601,
      1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667,
      1669, 1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747,
      1753, 1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831,
      1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907,
      1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987, 1993, 1997,
      1999, 2003, 2011];

   --  sieve.h: nextwheel30, distancewheel30, wheeladvance30.
   Next_Wheel : constant array (0 .. 29) of U64 :=
     [1, 7, 7, 7, 7, 7, 7, 11, 11, 11, 11, 13, 13, 17, 17,
      17, 17, 19, 19, 23, 23, 23, 23, 29, 29, 29, 29, 29, 29, 1];
   Distance_Wheel : constant array (0 .. 29) of U64 :=
     [1, 0, 5, 4, 3, 2, 1, 0, 3, 2, 1, 0, 1, 0, 3,
      2, 1, 0, 1, 0, 3, 2, 1, 0, 5, 4, 3, 2, 1, 0];
   Advance_Wheel : constant array (0 .. 29) of U64 :=
     [1, 6, 5, 4, 3, 2, 1, 4, 3, 2, 1, 2, 1, 4, 3,
      2, 1, 2, 1, 4, 3, 2, 1, 6, 5, 4, 3, 2, 1, 2];

   function Mul (A, B, N : U64) return U64 is
     (U64 ((U128 (A) * U128 (B)) mod U128 (N)));

   function Add_Mod (A, B, N : U64) return U64 is
     (if (N - A) > B then A + B else A + B - N);

   function Sqr_Add (A, C, N : U64) return U64 is
     (Add_Mod (Mul (A, A, N), C, N));

   function Mul_Sub (A, B, C, N : U64) return U64 is
      P : constant U64 := Mul (A, B, N);
   begin
      if P >= C then
         return P - C;
      end if;
      return N - (C - P);
   end Mul_Sub;

   function Pow (A, K, N : U64) return U64 is
      R : U64 := 1;
      B : U64 := A mod N;
      E : U64 := K;
   begin
      while E > 0 loop
         if E mod 2 = 1 then
            R := Mul (R, B, N);
         end if;
         E := E / 2;
         if E > 0 then
            B := Mul (B, B, N);
         end if;
      end loop;
      return R;
   end Pow;

   function Abs_Diff (X, Y : U64) return U64 is
     (if X > Y then X - Y else Y - X);

   --  util.h: isqrt. Double square root, then one downward correction.
   function Isqrt_C (N : U64) return U64 is
      Guess : constant Long_Float :=
        Long_Math.Sqrt (Long_Float (N)) + 1.0e-6;
      R : U64;
      Diff : U64;
   begin
      if Guess >= 2.0 ** 64 then
         R := U64'Last;
      else
         R := U64 (Long_Float'Floor (Guess));
      end if;
      Diff := N - R * R;
      if Diff >= 2 ** 63 then
         R := R - 1;
      end if;
      return U64 (U32 (R));
   end Isqrt_C;

   --  util.h: is_perfect_square_ret. The mask rejects non-squares.
   function Is_Square_C (N : U64; Root : out U64) return Boolean is
      R : U64;
      Bit : U64;
   begin
      Bit := Interfaces.Shift_Left (U64'(1), Natural (N and 63));
      if (Bit and 16#FDFD_FDED_FDFC_FDEC#) /= 0 then
         Root := 0;
         return False;
      end if;
      R := Isqrt_C (N);
      Root := R;
      return R * R = N;
   end Is_Square_C;

   function Single (N : U64) return Factor_Vectors.Vector is
      R : Factor_Vectors.Vector;
   begin
      R.Append (N);
      return R;
   end Single;

   function Found (N, F : U64) return Factor_Vectors.Vector is
      G : U64;
      R : Factor_Vectors.Vector;
   begin
      if F <= 1 or else F >= N then
         return Single (N);
      end if;
      G := N / F;
      if F <= G then
         R.Append (F);
         R.Append (G);
      else
         R.Append (G);
         R.Append (F);
      end if;
      return R;
   end Found;

   procedure Append_All
     (To : in out Factor_Vectors.Vector;
      From : Factor_Vectors.Vector) is
   begin
      for Value of From loop
         To.Append (Value);
      end loop;
   end Append_All;

   procedure Sort (Values : in out Factor_Vectors.Vector) is
      Item : U64;
      J : Natural;
   begin
      for I in Values.First_Index + 1 .. Values.Last_Index loop
         Item := Values (I);
         J := I;
         while J > Values.First_Index and then Values (J - 1) > Item loop
            Values (J) := Values (J - 1);
            J := J - 1;
         end loop;
         Values (J) := Item;
      end loop;
   end Sort;

   --  XS.xs: remove 2, 3 and 5, then stop when the cofactor is 1 or prime.
   procedure Strip_Small
     (M : in out U64; R : in out Factor_Vectors.Vector;
      Done : out Boolean) is
   begin
      Done := True;
      if M = 0 then
         R.Append (0);
         return;
      end if;
      while M mod 2 = 0 loop
         R.Append (2);
         M := M / 2;
      end loop;
      while M mod 3 = 0 loop
         R.Append (3);
         M := M / 3;
      end loop;
      while M mod 5 = 0 loop
         R.Append (5);
         M := M / 5;
      end loop;
      if M = 1 then
         return;
      end if;
      if Primality.Is_Prime (M) = 2 then
         R.Append (M);
         return;
      end if;
      Done := False;
   end Strip_Small;

   --  factor.c: trial_factor.
   function Trial_Core (N, First, Last_Arg : U64)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      F : U64 := First;
      Last : U64 := Last_Arg;
      Sp : Natural;
      Limit : U64;
      Wheel : U64;
   begin
      if F < 2 then
         F := 2;
      end if;
      if Last = 0 or else (Last /= 0 and then Last > M / Last) then
         Last := U64'Last;
      end if;
      if M < 4 or else Last < F then
         if M /= 1 then
            R.Append (M);
         end if;
         return R;
      end if;
      if F <= Primes_Small (Primes_Small'Last) then
         if F <= 2 then
            while M mod 2 = 0 loop
               R.Append (2);
               M := M / 2;
            end loop;
         end if;
         if F <= 3 and then 3 <= Last then
            while M mod 3 = 0 loop
               R.Append (3);
               M := M / 3;
            end loop;
         end if;
         if F <= 5 and then 5 <= Last then
            while M mod 5 = 0 loop
               R.Append (5);
               M := M / 5;
            end loop;
         end if;
         Sp := 4;
         while Sp <= Primes_Small'Last
           and then Primes_Small (Sp) < F
         loop
            Sp := Sp + 1;
         end loop;
         while Sp <= Primes_Small'Last loop
            F := Primes_Small (Sp);
            exit when U128 (F) * U128 (F) > U128 (M) or else F > Last;
            while M mod F = 0 loop
               R.Append (F);
               M := M / F;
            end loop;
            Sp := Sp + 1;
         end loop;
         if Sp > Primes_Small'Last then
            F := 2017;
         end if;
      end if;
      if F > Primes_Small (Primes_Small'Last)
        and then Distance_Wheel (Natural (F mod 30)) <= U64'Last - F
      then
         F := F + Distance_Wheel (Natural (F mod 30));
      end if;
      if F /= 0 and then F <= M / F and then F <= Last then
         Limit := Int.Sqrtint (M);
         if Limit > Last then
            Limit := Last;
         end if;
         Wheel := F mod 30;
         while F <= Limit loop
            if M mod F = 0 then
               while M mod F = 0 loop
                  R.Append (F);
                  M := M / F;
               end loop;
               if Int.Sqrtint (M) < Limit then
                  Limit := Int.Sqrtint (M);
               end if;
            end if;
            F := F + Advance_Wheel (Natural (Wheel));
            Wheel := Next_Wheel (Natural (Wheel));
         end loop;
      end if;
      if M /= 1 then
         R.Append (M);
      end if;
      return R;
   end Trial_Core;

   --  factor.c: fermat_factor. Signed steps wrap the way UV arithmetic does.
   function Fermat_Core (N, Rounds : U64) return Factor_Vectors.Vector is
      Sq : constant U64 := Isqrt_C (N);
      X : U64 := 2 * Sq + 1;
      Y : U64 := 1;
      R : U64 := 0 - (N - Sq * Sq);
      Left : U64 := Rounds;
   begin
      while R /= 0 loop
         if Left = 0 then
            return Single (N);
         end if;
         Left := Left - 1;
         R := R + X;
         X := X + 2;
         loop
            R := R - Y;
            Y := Y + 2;
            exit when R = 0 or else R >= 2 ** 63;
         end loop;
      end loop;
      return Found (N, (X - Y) / 2);
   end Fermat_Core;

   --  factor.c: holf_factor.
   function Holf_Core (N, Rounds : U64) return Factor_Vectors.Vector is
      Left : U64 := Rounds;
      Root : U64;
      S, M, F, Ni, Npre : U64;
      Overflow : Boolean := False;
   begin
      if Is_Square_C (N, Root) then
         return Found (N, Root);
      end if;
      if N <= Interfaces.Shift_Right (U64'Last, 6) then
         if N <= Interfaces.Shift_Right (U64'Last, 13) then
            Npre := N * 720;
         elsif N <= Interfaces.Shift_Right (U64'Last, 11) then
            Npre := N * 480;
         elsif N <= Interfaces.Shift_Right (U64'Last, 10) then
            Npre := N * 360;
         elsif N <= Interfaces.Shift_Right (U64'Last, 8) then
            Npre := N * 60;
         else
            Npre := N * 30;
         end if;
         Ni := Npre;
         while Left > 0 loop
            Left := Left - 1;
            S := 1 + Isqrt_C (Ni);
            M := S * S - Ni;
            if Is_Square_C (M, Root) then
               F := Int.Gcd (N, S - Root);
               if F > 1 and then F < N then
                  return Found (N, F);
               end if;
            end if;
            if Ni >= Ni + Npre then
               Overflow := True;
               exit;
            end if;
            Ni := Ni + Npre;
         end loop;
         if not Overflow then
            return Single (N);
         end if;
      end if;
      for I in U64 range 1 .. Left loop
         S := U64 (Long_Float'Floor
           (Long_Math.Sqrt (Long_Float (N) * Long_Float (I))));
         S := S + 1;
         M := Mul (S, S, N);
         if Is_Square_C (M, Root) then
            if S > Root then
               F := Int.Gcd (S - Root, N);
            else
               F := Int.Gcd (Root - S, N);
            end if;
            return Found (N, F);
         end if;
      end loop;
      return Single (N);
   end Holf_Core;

   --  factor.c: prho_factor.
   function Prho_Core (N, Rounds : U64) return Factor_Vectors.Vector is
      Inner : constant U64 := 64;
      U : U64 := 7;
      V : U64 := 7;
      A : U64 := 1;
      F, M, Old_U, Old_V : U64;
      Fails : Integer := 3;
      Left : U64 := (Rounds + Inner - 1) / Inner;
      Guard : U64;
   begin
      while Left > 0 loop
         Left := Left - 1;
         M := 1;
         Old_U := U;
         Old_V := V;
         for Iteration in 1 .. Inner loop
            U := Sqr_Add (U, A, N);
            V := Sqr_Add (Sqr_Add (V, A, N), A, N);
            F := Abs_Diff (U, V);
            M := Mul (M, F, N);
         end loop;
         F := Int.Gcd (M, N);
         if F = 1 then
            null;
         else
            if F = N then
               U := Old_U;
               V := Old_V;
               Guard := Inner;
               loop
                  U := Sqr_Add (U, A, N);
                  V := Sqr_Add (Sqr_Add (V, A, N), A, N);
                  F := Int.Gcd (Abs_Diff (U, V), N);
                  exit when F /= 1 or else Guard = 0;
                  Guard := Guard - 1;
               end loop;
            end if;
            if F = 0 or else F = N then
               if Fails <= 0 then
                  exit;
               end if;
               Fails := Fails - 1;
               U := Add_Mod (U, 2, N);
               V := U;
               A := A + 2;
            else
               return Found (N, F);
            end if;
         end if;
      end loop;
      return Single (N);
   end Prho_Core;

   function Mont_Inverse (N : U64) return U64 is
      Inverse : U64 := (3 * N) xor 2;
   begin
      Inverse := Inverse * (2 - N * Inverse);
      Inverse := Inverse * (2 - N * Inverse);
      Inverse := Inverse * (2 - N * Inverse);
      Inverse := Inverse * (2 - N * Inverse);
      return 0 - Inverse;
   end Mont_Inverse;

   function Mont_One (N : U64) return U64 is
     (U64 ((U128'(2) ** 64) mod U128 (N)));

   function Mont_Mul (A, B, N, Inverse : U64) return U64 is
      Product : constant U128 := U128 (A) * U128 (B);
      Mask : constant U128 := U128'(2) ** 64 - 1;
      Scale : constant U128 := U128'(2) ** 64;
      M : constant U64 := U64 (Product and Mask) * Inverse;
      Correction : constant U128 := U128 (M) * U128 (N);
      Carry : constant U128 :=
        ((Product and Mask) + (Correction and Mask)) / Scale;
      High : constant U128 := Product / Scale + Correction / Scale + Carry;
   begin
      if High >= U128 (N) then
         return U64 (High - U128 (N));
      end if;
      return U64 (High);
   end Mont_Mul;

   --  factor.c: pbrent_factor, USE_MONTMATH path.
   function Pbrent_Core (N, Rounds, A0 : U64)
      return Factor_Vectors.Vector
   is
      function Bit_Length return Natural is
         M : U64 := N;
         Bits : Natural := 0;
      begin
         while M > 0 loop
            M := M / 2;
            Bits := Bits + 1;
         end loop;
         return Bits;
      end Bit_Length;
      Inner : constant U64 :=
        (if Bit_Length <= 31 then 32
         elsif Bit_Length <= 35 then 64
         elsif Bit_Length <= 40 then 160
         elsif Bit_Length <= 52 then 256
         else 320);
      Inverse : constant U64 := Mont_Inverse (N);
      One : constant U64 := Mont_One (N);
      A : U64 := U64 ((U128 (A0) * U128 (One)) mod U128 (N));
      Xi : U64 := One;
      Xm : U64 := One;
      Xs : U64 := One;
      F : U64 := 1;
      M : U64;
      Step : U64 := 1;
      Left : U64 := Rounds;
      Rleft, Batch : U64;
      Fails : Integer := 6;
   begin
      while Left > 0 loop
         Rleft := (if Step > Left then Left else Step);
         Xm := Xi;
         while Rleft > 0 loop
            Batch := (if Rleft > Inner then Inner else Rleft);
            Rleft := Rleft - Batch;
            Left := Left - Batch;
            Xs := Xi;
            if N < 2 ** 63 then
               Xi := Mont_Mul (Xi, Xi + A, N, Inverse);
               M := Abs_Diff (Xi, Xm);
               while Batch > 1 loop
                  Batch := Batch - 1;
                  Xi := Mont_Mul (Xi, Xi + A, N, Inverse);
                  F := Abs_Diff (Xi, Xm);
                  M := Mont_Mul (M, F, N, Inverse);
               end loop;
            elsif A = One then
               Xi := Mont_Mul (Xi, Xi + A, N, Inverse);
               M := Abs_Diff (Xi, Xm);
               while Batch > 1 loop
                  Batch := Batch - 1;
                  Xi := Mont_Mul (Xi, Xi + A, N, Inverse);
                  F := Abs_Diff (Xi, Xm);
                  M := Mont_Mul (M, F, N, Inverse);
               end loop;
            else
               Xi := Add_Mod (Mont_Mul (Xi, Xi, N, Inverse), A, N);
               M := Abs_Diff (Xi, Xm);
               while Batch > 1 loop
                  Batch := Batch - 1;
                  Xi := Add_Mod (Mont_Mul (Xi, Xi, N, Inverse), A, N);
                  F := Abs_Diff (Xi, Xm);
                  M := Mont_Mul (M, F, N, Inverse);
               end loop;
            end if;
            F := Int.Gcd (M, N);
            exit when F /= 1;
         end loop;
         if F = 1 then
            Step := Step * 2;
         else
            if F = N then
               Xi := Xs;
               loop
                  if N < 2 ** 63 or else A = One then
                     Xi := Mont_Mul (Xi, Xi + A, N, Inverse);
                  else
                     Xi := Add_Mod (Mont_Mul (Xi, Xi, N, Inverse), A, N);
                  end if;
                  M := Abs_Diff (Xi, Xm);
                  F := Int.Gcd (M, N);
                  exit when F /= 1 or else Step = 0;
                  Step := Step - 1;
               end loop;
            end if;
            if F = 0 or else F = N then
               if Fails <= 0 then
                  exit;
               end if;
               Fails := Fails - 1;
               Xi := One;
               Xm := One;
               A := Add_Mod
                 (A, U64 ((U128 (11) * U128 (One)) mod U128 (N)), N);
            else
               return Found (N, F);
            end if;
         end if;
      end loop;
      return Single (N);
   end Pbrent_Core;

   --  util.c: _cbrtf. Float bits are read back through an overlay.
   function Cbrt_F (X : Float) return Float is
      type Word is record
         Bits : U32;
      end record with Size => 32;
      for Word use record
         Bits at 0 range 0 .. 31;
      end record;
      type View is record
         Value : Float;
      end record with Size => 32;
      for View use record
         Value at 0 range 0 .. 31;
      end record;
      Storage : Word;
      Alias : View with Volatile, Address => Storage'Address;
      T, R : Float;
   begin
      Alias.Value := X;
      Storage.Bits := (Storage.Bits + 2_129_874_493) / 3;
      T := Alias.Value;
      R := T * T * T;
      T := T * ((X + (X + R)) / ((X + R) + R));
      R := T * T * T;
      T := T + T * ((X - R) / (X + (R + R)));
      return T;
   end Cbrt_F;

   --  util.c: icbrt.
   function Icbrt (N : U64) return U64 is
      Estimate : Float;
      Root, Diff, Cube : U64;
   begin
      if N = 0 then
         return 0;
      end if;
      Estimate := Cbrt_F (Float (N)) + 0.375;
      Root := U64 (Float'Floor (Estimate));
      Cube := U64 (U128 (Root) * U128 (Root) * U128 (Root));
      Diff := N - Cube;
      if Diff >= 2 ** 63 then
         return Root - 1;
      end if;
      return Root;
   end Icbrt;

   function Stage_Bound (B1 : U64) return U64 is
   begin
      if B1 = 0 then
         return 0;
      elsif B1 > U64'Last / 10 then
         return U64'Last;
      end if;
      return 10 * B1;
   end Stage_Bound;

   --  factor.c: pminus1_factor. Montgomery stage 1 matches powmod.
   function Pminus1_Core (N, B1, B2 : U64) return Factor_Vectors.Vector is
      A : U64 := 2;
      Q : U64 := 2;
      Save_A : U64 := 2;
      Save_Q : U64 := 1;
      F : U64 := 1;
      K, Kmin : U64;
      J : Natural := 1;
      Sqrt_B1 : constant U64 := Int.Sqrtint (B1);
      Primes : Sieve.Prime_Vectors.Vector;
      B : U64 := 1;
      Bm, Diff, Last_Q, Gap : U64;
      Precomp : array (0 .. 110) of U64 := [others => 0];
   begin
      if B1 >= 2 then
         Primes := Sieve.Primes (B1);
      end if;
      for P of Primes loop
         Q := P;
         K := P;
         if P <= Sqrt_B1 then
            K := P * P;
            Kmin := B1 / P;
            while K <= Kmin loop
               if K > U64'Last / P then
                  exit;
               end if;
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
         return Single (N);
      end if;
      F := Int.Gcd (A - 1, N);
      if F = N then
         A := Save_A;
         Q := Save_Q;
         loop
            Q := Q + 1;
            exit when Q > B1;
            if Primality.Is_Prime (Q) = 2 then
               K := Q;
               Kmin := B1 / Q;
               while K <= Kmin loop
                  if K > U64'Last / Q then
                     exit;
                  end if;
                  K := K * Q;
               end loop;
               A := Pow (A, K, N);
               F := Int.Gcd (A - 1, N);
               exit when F /= 1;
            end if;
         end loop;
      end if;
      if F = 1 and then B2 > B1 then
         Bm := A;
         Diff := Mul (Bm, Bm, N);
         Precomp (0) := Diff;
         for Index in 1 .. 19 loop
            Diff := Mul (Mul (Diff, Bm, N), Bm, N);
            Precomp (Index) := Diff;
         end loop;
         A := Pow (A, Q, N);
         J := 1;
         if B2 >= 2 then
            Primes := Sieve.Primes (B2);
         end if;
         Last_Q := Q;
         for P of Primes loop
            if P > Last_Q and then P <= B2 then
               Gap := (P - Last_Q) / 2 - 1;
               if Gap >= 111 then
                  Diff := Pow (Bm, P - Last_Q, N);
               else
                  Diff := Precomp (Natural (Gap));
                  if Diff = 0 then
                     if Gap > 0 and then Precomp (Natural (Gap - 1)) /= 0
                     then
                        Diff := Mul
                          (Mul (Precomp (Natural (Gap - 1)), Bm, N), Bm, N);
                     else
                        Diff := Pow (Bm, P - Last_Q, N);
                     end if;
                     Precomp (Natural (Gap)) := Diff;
                  end if;
               end if;
               A := Mul (A, Diff, N);
               exit when A = 0;
               B := Mul (B, A - 1, N);
               if J mod 64 = 0 then
                  F := Int.Gcd (B, N);
                  exit when F /= 1;
               end if;
               J := J + 1;
               Last_Q := P;
               Q := P;
            end if;
         end loop;
         F := Int.Gcd (B, N);
      end if;
      return Found (N, F);
   end Pminus1_Core;

   function Log2_Floor (N : U64) return Natural is
      M : U64 := N;
      Bits : Natural := 0;
   begin
      while M > 1 loop
         M := M / 2;
         Bits := Bits + 1;
      end loop;
      return Bits;
   end Log2_Floor;

   procedure Pp1_Pow (X : in out U64; Exp, N : U64) is
      X0 : constant U64 := X;
      Y : U64 := Mul_Sub (X, X, 2, N);
      Bit : U64 := Interfaces.Shift_Left (U64'(1), Log2_Floor (Exp) - 1);
      T : U64;
   begin
      while Bit /= 0 loop
         T := Mul_Sub (X, Y, X0, N);
         if (Exp and Bit) /= 0 then
            X := T;
            Y := Mul_Sub (Y, Y, 2, N);
         else
            Y := T;
            X := Mul_Sub (X, X, 2, N);
         end if;
         Bit := Interfaces.Shift_Right (Bit, 1);
      end loop;
   end Pp1_Pow;

   --  factor.c: pplus1_factor.
   function Pplus1_Core (N, B1 : U64) return Factor_Vectors.Vector is
      X1 : U64 := 7 mod N;
      X2 : U64 := 11 mod N;
      F : U64 := 1;
      K, Kmin : U64;
      Sqrt_B1 : constant U64 := Int.Sqrtint (B1);
      Primes : Sieve.Prime_Vectors.Vector;
   begin
      if B1 >= 2 then
         Primes := Sieve.Primes (B1);
      end if;
      for P of Primes loop
         K := P;
         if P < Sqrt_B1 then
            Kmin := B1 / P;
            while K <= Kmin loop
               if K > U64'Last / P then
                  exit;
               end if;
               K := K * P;
            end loop;
         end if;
         Pp1_Pow (X1, K, N);
         if X1 /= 2 then
            F := Int.Gcd
              ((if X1 >= 2 then X1 - 2 else N - (2 - X1)), N);
            exit when F /= 1 and then F /= N;
         end if;
         Pp1_Pow (X2, K, N);
         if X2 /= 2 then
            F := Int.Gcd
              ((if X2 >= 2 then X2 - 2 else N - (2 - X2)), N);
            exit when F /= 1 and then F /= N;
         end if;
      end loop;
      return Found (N, F);
   end Pplus1_Core;

   --  factor.c: squfof_factor. State words are 32-bit.
   function Squfof_Core (N, Rounds : U64) return Factor_Vectors.Vector is
      type State is record
         Valid : Integer := -1;
         P, Bn, Qn, Q0, B0, It, Imax, Mult : U32 := 0;
      end record;
      Mults : constant array (1 .. 38) of U64 :=
        [3 * 5 * 7 * 11, 3 * 5 * 7, 3 * 5 * 7 * 11 * 13,
         3 * 5 * 7 * 13, 3 * 5 * 7 * 11 * 17, 3 * 5 * 11,
         3 * 5 * 7 * 17, 3 * 5, 3 * 5 * 7 * 11 * 19,
         3 * 5 * 11 * 13, 3 * 5 * 7 * 19, 3 * 5 * 7 * 13 * 17,
         3 * 5 * 13, 3 * 7 * 11, 3 * 7, 5 * 7 * 11, 3 * 7 * 13, 5 * 7,
         3 * 5 * 17, 5 * 7 * 13, 3 * 5 * 19, 3 * 11, 3 * 7 * 17, 3,
         3 * 11 * 13, 5 * 11, 3 * 7 * 19, 3 * 13, 5, 5 * 11 * 13,
         5 * 7 * 19, 5 * 13, 7 * 11, 7, 3 * 17, 7 * 13, 11, 1];
      Slot : array (Mults'Range) of State;
      Racing : Natural := Mults'Length;
      Done : U64 := 0;
      Nn, Root, F64, Reduced : U64;
      Limit : constant U64 := Interfaces.Shift_Right (U64'Last, 2);

      function Unit (Nn64 : U64; Item : in out State) return U64 is
         P : U32 := Item.P;
         Bn : U32 := Item.Bn;
         Qn : U32 := Item.Qn;
         Q0 : U32 := Item.Q0;
         B0 : constant U32 := Item.B0;
         I : U32 := Item.It;
         Imax : constant U32 := I + Item.Imax;
         T1, T2, S, Ro, So, Bbn : U32;
         Square : U64;
         Guard : Natural := 0;
      begin
         loop
            if (I and 1) /= 0 then
               T1 := P;
               P := Bn * Qn - P;
               T2 := Qn;
               Qn := Q0 + Bn * (T1 - P);
               Q0 := T2;
               Bn := (B0 + P) / Qn;
               I := I + 1;
            end if;
            loop
               if I >= Imax then
                  Item.P := P;
                  Item.Bn := Bn;
                  Item.Qn := Qn;
                  Item.Q0 := Q0;
                  Item.It := I;
                  return 0;
               end if;
               T1 := P;
               P := Bn * Qn - P;
               T2 := Qn;
               Qn := Q0 + Bn * (T1 - P);
               Q0 := T2;
               Bn := (B0 + P) / Qn;
               I := I + 1;
               if Is_Square_C (U64 (Qn), Square) then
                  exit;
               end if;
               T1 := P;
               P := Bn * Qn - P;
               T2 := Qn;
               Qn := Q0 + Bn * (T1 - P);
               Q0 := T2;
               Bn := (B0 + P) / Qn;
               I := I + 1;
            end loop;
            S := U32 (Square);
            Item.It := I;
            Ro := P + S * ((B0 - P) / S);
            So := U32 ((Nn64 - U64 (Ro) * U64 (Ro)) / U64 (S));
            Bbn := (B0 + Ro) / So;
            Guard := 0;
            loop
               T1 := Ro;
               Ro := Bbn * So - Ro;
               T2 := So;
               So := S + Bbn * (T1 - Ro);
               S := T2;
               Bbn := (B0 + Ro) / So;
               exit when Ro = T1;
               T1 := Ro;
               Ro := Bbn * So - Ro;
               T2 := So;
               So := S + Bbn * (T1 - Ro);
               S := T2;
               Bbn := (B0 + Ro) / So;
               exit when Ro = T1;
               T1 := Ro;
               Ro := Bbn * So - Ro;
               T2 := So;
               So := S + Bbn * (T1 - Ro);
               S := T2;
               Bbn := (B0 + Ro) / So;
               exit when Ro = T1;
               T1 := Ro;
               Ro := Bbn * So - Ro;
               T2 := So;
               So := S + Bbn * (T1 - Ro);
               S := T2;
               Bbn := (B0 + Ro) / So;
               exit when Ro = T1;
               Guard := Guard + 1;
               if Guard > 2_000_000 then
                  Item.Valid := 0;
                  return 0;
               end if;
            end loop;
            T1 := U32 (Int.Gcd (U64 (Ro), Nn64));
            if T1 > 1 then
               return U64 (T1);
            end if;
         end loop;
      end Unit;
   begin
      if N > Limit then
         return Single (N);
      end if;
      while Racing > 0 and then Done < Rounds loop
         for Index in Mults'Range loop
            exit when Done >= Rounds;
            if Slot (Index).Valid /= 0 then
               if Slot (Index).Valid = -1 then
                  if Limit / Mults (Index) < N then
                     Slot (Index).Valid := 0;
                     Racing := Racing - 1;
                  else
                     Nn := N * Mults (Index);
                     Root := Isqrt_C (Nn);
                     Slot (Index).Valid := 1;
                     Slot (Index).Q0 := 1;
                     Slot (Index).B0 := U32 (Root);
                     Slot (Index).P := U32 (Root);
                     Slot (Index).Qn :=
                       U32 (Nn - Root * Root);
                     if Slot (Index).Qn = 0 then
                        return Found (N, Root);
                     end if;
                     Slot (Index).Bn :=
                       U32 ((2 * Root) / U64 (Slot (Index).Qn));
                     Slot (Index).It := 0;
                     Slot (Index).Mult := U32 (Mults (Index));
                     Slot (Index).Imax := U32 (Long_Float'Floor
                       (Long_Math.Sqrt (Long_Math.Sqrt (Long_Float (Nn)))
                        / 16.0));
                     if Slot (Index).Imax < 20 then
                        Slot (Index).Imax := 20;
                     end if;
                     if U64 (Slot (Index).Imax) > Rounds then
                        Slot (Index).Imax := U32 (Rounds);
                     end if;
                  end if;
               end if;
               if Slot (Index).Valid > 0 then
                  if Racing = 1 then
                     Slot (Index).Imax := U32 (Rounds - Done);
                  end if;
                  F64 := Unit (N * Mults (Index), Slot (Index));
                  if F64 > 1 then
                     Reduced := F64 / Int.Gcd (F64, Mults (Index));
                     if Reduced > 1 then
                        return Found (N, Reduced);
                     end if;
                     Slot (Index).Valid := 0;
                  end if;
                  if Slot (Index).Valid = 0 then
                     Racing := Racing - 1;
                  end if;
                  Done := Done + U64 (Slot (Index).Imax);
               end if;
            end if;
         end loop;
      end loop;
      return Single (N);
   end Squfof_Core;

   function Trunc_U32 (X : Long_Float) return U32 is
   begin
      if X <= 0.0 then
         return 0;
      elsif X >= 2.0 ** 32 then
         return U32'Last;
      end if;
      return U32 (Long_Float'Floor (X));
   end Trunc_U32;

   --  factor.c: lehman_factor.
   function Lehman_Core (N : U64; Do_Trial : Boolean)
      return Factor_Vectors.Vector
   is
      Tune : constant Long_Float :=
        (if Interfaces.Shift_Right (N, 36) /= 0 then 3.5 else 5.0);
      B : U32;
      First_Cut : U32;
      Ip : Natural := 2;
      P : U64;
      Bred : U32;
      B2, Kn, Kn4, A, C : U64;
      X : Long_Float;
      Bb, R, Inc, U : U32;
      Root : U64;
   begin
      if N mod 2 = 0 then
         return Found (N, 2);
      end if;
      B := Trunc_U32 (Tune * (1.0 + Long_Float (Icbrt (N))));
      if Do_Trial then
         First_Cut := Trunc_U32 (0.1 * Long_Float (B));
         if First_Cut < 84 then
            First_Cut := 84;
         elsif First_Cut > 65535 then
            First_Cut := 65535;
         end if;
         Ip := 2;
         while Ip <= Primes_Small'Last loop
            P := Primes_Small (Ip);
            exit when P >= U64 (First_Cut);
            if N mod P = 0 then
               return Found (N, P);
            end if;
            Ip := Ip + 1;
         end loop;
      end if;
      if N >= 8_796_393_022_207 then
         return Single (N);
      end if;
      Bred := Trunc_U32 (Long_Float (B) / (Tune * Tune * Tune));
      B2 := U64 (B * B);
      Kn := 0;
      for K in U32 range 1 .. Bred loop
         if (K and 1) /= 0 then
            Inc := 4;
            R := U32 ((U64 (K) + N) mod 4);
         else
            Inc := 2;
            R := 1;
         end if;
         Kn := Kn + N;
         if Kn >= 2 ** 60 then
            return Single (N);
         end if;
         Kn4 := Kn * 4;
         X := Long_Math.Sqrt (Long_Float (Kn));
         A := U64 (Long_Float'Floor (X));
         if A * A = Kn then
            return Found (N, Int.Gcd (A, N));
         end if;
         X := X * 2.0;
         A := U64 (Long_Float'Floor (X + 0.9999999665));
         Bb := U32 (A mod U64 (Inc));
         Bb := U32 (U64 (A) + (U64 (Inc) + U64 (R) - U64 (Bb)) mod U64 (Inc));
         C := U64 (Bb) * U64 (Bb) - Kn4;
         U := Trunc_U32 (X + Long_Float (B2) / (2.0 * X));
         A := U64 (Bb);
         while A <= U64 (U) loop
            if Is_Square_C (C, Root) then
               return Found (N, Int.Gcd (A + Root, N));
            end if;
            C := C + U64 (Inc) * (A + A + U64 (Inc));
            A := A + U64 (Inc);
         end loop;
      end loop;
      if Do_Trial then
         if B > 65535 then
            B := 65535;
         end if;
         if Ip > Primes_Small'Last then
            Ip := Primes_Small'Last;
         end if;
         return Trial_Core (N, Primes_Small (Ip), U64 (B));
      end if;
      return Single (N);
   end Lehman_Core;

   function One_Factor (N : U64) return U64 is
      Parts : Factor_Vectors.Vector;
   begin
      Parts := Pbrent_Core (N, 200_000, 1);
      if Natural (Parts.Length) = 2 then
         return Parts (Parts.First_Index);
      end if;
      Parts := Pbrent_Core (N, 200_000, 3);
      if Natural (Parts.Length) = 2 then
         return Parts (Parts.First_Index);
      end if;
      if N <= Interfaces.Shift_Right (U64'Last, 2) then
         Parts := Squfof_Core (N, 200_000);
         if Natural (Parts.Length) = 2 then
            return Parts (Parts.First_Index);
         end if;
      end if;
      Parts := Pbrent_Core (N, 500_000, 5);
      if Natural (Parts.Length) = 2 then
         return Parts (Parts.First_Index);
      end if;
      Parts := Prho_Core (N, 180_000);
      if Natural (Parts.Length) = 2 then
         return Parts (Parts.First_Index);
      end if;
      Parts := Holf_Core (N, 100_000);
      if Natural (Parts.Length) = 2 then
         return Parts (Parts.First_Index);
      end if;
      Parts := Pbrent_Core (N, 2_000_000, 11);
      if Natural (Parts.Length) = 2 then
         return Parts (Parts.First_Index);
      end if;
      return N;
   end One_Factor;

   procedure Factor_Into
     (N : U64; Acc : in out Factor_Vectors.Vector) is
      M : U64 := N;
      F : U64;
      Exp : U64;
      Root : U64;
      Power : Factor_Vectors.Vector;
   begin
      if M = 0 then
         Acc.Append (0);
         return;
      end if;
      if M = 1 then
         return;
      end if;
      while M mod 2 = 0 loop
         Acc.Append (2);
         M := M / 2;
      end loop;
      while M mod 3 = 0 loop
         Acc.Append (3);
         M := M / 3;
      end loop;
      while M mod 5 = 0 loop
         Acc.Append (5);
         M := M / 5;
      end loop;
      if M = 1 then
         return;
      end if;
      Exp := Int.Is_Power_Exp (M);
      if Exp >= 2 then
         Root := Int.Rootint (M, Exp);
         Factor_Into (Root, Power);
         for Value of Power loop
            for Count in 1 .. Exp loop
               Acc.Append (Value);
            end loop;
         end loop;
         return;
      end if;
      if Primality.Is_Prime (M) = 2 then
         Acc.Append (M);
         return;
      end if;
      F := One_Factor (M);
      if F <= 1 or else F >= M then
         Acc.Append (M);
         return;
      end if;
      Factor_Into (F, Acc);
      Factor_Into (M / F, Acc);
   end Factor_Into;

   function Factor (N : U64) return Factor_Vectors.Vector is
      R : Factor_Vectors.Vector;
   begin
      Factor_Into (N, R);
      Sort (R);
      return R;
   end Factor;

   function Trial_Factor (N : U64; Last : U64 := 0)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Trial_Core (M, 2, Last));
      end if;
      return R;
   end Trial_Factor;

   function Fermat_Factor (N : U64; Rounds : U64 := 64_000_000)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Fermat_Core (M, Rounds));
      end if;
      return R;
   end Fermat_Factor;

   function Holf_Factor (N : U64; Rounds : U64 := 8_000_000)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Holf_Core (M, Rounds));
      end if;
      return R;
   end Holf_Factor;

   function Squfof_Factor (N : U64; Rounds : U64 := 4_000_000)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Squfof_Core (M, Rounds));
      end if;
      return R;
   end Squfof_Factor;

   function Lehman_Factor (N : U64; Do_Trial : Boolean := True)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Lehman_Core (M, Do_Trial));
      end if;
      return R;
   end Lehman_Factor;

   function Prho_Factor (N : U64; Rounds : U64 := 4_000_000)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Prho_Core (M, Rounds));
      end if;
      return R;
   end Prho_Factor;

   function Pbrent_Factor
     (N : U64; Rounds : U64 := 4_000_000; A : U64 := 1)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Pbrent_Core (M, Rounds, A));
      end if;
      return R;
   end Pbrent_Factor;

   function Pminus1_Factor
     (N : U64; B1 : U64 := 1_000_000; B2 : U64 := 0)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
      Bound : U64 := B2;
   begin
      if Bound = 0 then
         Bound := Stage_Bound (B1);
      end if;
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Pminus1_Core (M, B1, Bound));
      end if;
      return R;
   end Pminus1_Factor;

   function Pplus1_Factor (N : U64; B1 : U64 := 200)
      return Factor_Vectors.Vector
   is
      R : Factor_Vectors.Vector;
      M : U64 := N;
      Done : Boolean;
   begin
      Strip_Small (M, R, Done);
      if not Done then
         Append_All (R, Pplus1_Core (M, B1));
      end if;
      return R;
   end Pplus1_Factor;

   function Divisors (N : U64; Max_Divisor : U64 := U64'Last)
      return Factor_Vectors.Vector
   is
      Limit : U64 := Max_Divisor;
      Fac : Factor_Vectors.Vector;
      R : Factor_Vectors.Vector;
      Index : Natural;
      Prime : U64;
      Seen : Ada.Containers.Count_Type;
      Multiple : U64;
      Product : U128;
   begin
      if N = 0 or else Limit = 0 then
         return R;
      end if;
      if Limit > N then
         Limit := N;
      end if;
      if N = 1 or else Limit = 1 then
         R.Append (1);
         return R;
      end if;
      Fac := Factor (N);
      R.Append (1);
      Index := Fac.First_Index;
      while Index <= Fac.Last_Index loop
         Prime := Fac (Index);
         Seen := R.Length;
         Multiple := 1;
         while Index <= Fac.Last_Index and then Fac (Index) = Prime loop
            if Multiple > U64'Last / Prime then
               Index := Fac.Last_Index + 1;
               exit;
            end if;
            Multiple := Multiple * Prime;
            for Old in 1 .. Natural (Seen) loop
               Product := U128 (R (Old)) * U128 (Multiple);
               if Product <= U128 (Limit) then
                  R.Append (U64 (Product));
               end if;
            end loop;
            Index := Index + 1;
         end loop;
      end loop;
      Sort (R);
      return R;
   end Divisors;
end Math_Prime_Util.Factor;
