with Ada.Numerics.Elementary_Functions;
with Ada.Unchecked_Conversion;
with Interfaces;
with Ada.Numerics.Long_Elementary_Functions;

package body Math_Prime_Util.Int with SPARK_Mode => On is
   --  Proof skipped: gnatprove is not installed in the Alire environment.
   function Gcd (A, B : U64) return U64 is
      X : U64 := A;
      Y : U64 := B;
      T : U64;
   begin
      while Y /= 0 loop
         T := Y;
         Y := X mod Y;
         X := T;
      end loop;
      return X;
   end Gcd;

   function Gcdext (A, B : I128) return Bezout_Result is
      S : I128 := 0;
      Old_S : I128 := 1;
      T : I128 := 1;
      Old_T : I128 := 0;
      R : I128 := B;
      Old_R : I128 := A;
      Q, Tmp : I128;
   begin
      if A = 0 and B = 0 then
         Old_S := 0;
      end if;
      while R /= 0 loop
         Q := Old_R / R;
         Tmp := R;
         R := Old_R - Q * R;
         Old_R := Tmp;
         Tmp := S;
         S := Old_S - Q * S;
         Old_S := Tmp;
         Tmp := T;
         T := Old_T - Q * T;
         Old_T := Tmp;
      end loop;
      if Old_R < 0 then
         Old_R := -Old_R;
         Old_S := -Old_S;
         Old_T := -Old_T;
      end if;
      return (U64 (Old_R), Old_S, Old_T);
   end Gcdext;

   function Lcm (A, B : U64) return Optional_U64 is
      V : U128;
   begin
      if A = 0 or B = 0 then
         return (True, 0);
      end if;
      V := U128 (A) * U128 (B / Gcd (A, B));
      if V > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (True, U64 (V));
   end Lcm;

   function Powint (A, K : U64) return Optional_U64 is
      P : U64 := 1;
      B : U64 := A;
      E : U64 := K;
   begin
      while E /= 0 loop
         if E mod 2 = 1 then
            if B /= 0 and then P > U64'Last / B then
               return (Defined => False);
            end if;
            P := P * B;
         end if;
         E := E / 2;
         if E /= 0 then
            if B /= 0 and then B > U64'Last / B then
               return (Defined => False);
            end if;
            B := B * B;
         end if;
      end loop;
      return (True, P);
   end Powint;

   function Sqrtint (N : U64) return U64 is
      use Ada.Numerics.Long_Elementary_Functions;
      R : U64 := U64 (Long_Float'Truncation
        (Sqrt (Long_Float (N)) + 1.0E-6));
   begin
      if U128 (R) * U128 (R) > U128 (N) then
         R := R - 1;
      end if;
      return R;
   end Sqrtint;

   --  util.c: _cbrtf and _est_root reinterpret IEEE binary32 bits.
   --  Input bit patterns below always describe finite positive floats.
   --  Compat_Int exercises these conversions at root boundaries.
   subtype U32 is Interfaces.Unsigned_32;
   use type U32;
   function To_Bits is new Ada.Unchecked_Conversion (Float, U32);
   function To_Float is new Ada.Unchecked_Conversion (U32, Float);

   function Cube_Root (N : U64) return U64 is
      X : constant Float := Float (N);
      T : Float := To_Float ((To_Bits (X) + 2_129_874_493) / 3);
      R : Float;
      V : U64;
   begin
      if N = 0 then
         return 0;
      end if;
      R := T * T * T;
      T := T * (X + (X + R)) / ((X + R) + R);
      R := T * T * T;
      T := T + T * (X - R) / (X + (R + R));
      V := U64 (Float'Truncation (T + 0.375));
      if U128 (V) ** 3 > U128 (N) then
         V := V - 1;
      end if;
      return V;
   end Cube_Root;

   function Estimate_Root (N, K : U64) return U64 is
      use Ada.Numerics.Elementary_Functions;
      Y : constant Float := Float (N);
      One : constant U32 := 127 * 2 ** 23;
      X, XK, Err : Float;
      Bit : U64 := 1;
   begin
      if K = 4 then
         return U64 (Float'Truncation (Sqrt (Sqrt (Y)) + 0.5));
      end if;
      X := To_Float ((To_Bits (Y) - One - 89_788) / U32 (K)
                     + One - 282_298);
      while Bit <= K / 2 loop
         Bit := Bit * 2;
      end loop;
      XK := X;
      Bit := Bit / 2;
      while Bit /= 0 loop
         XK := XK * XK;
         if (K and Bit) /= 0 then
            XK := XK * X;
         end if;
         Bit := Bit / 2;
      end loop;
      Err := Y - XK;
      X := X + 2.0 * X * Err / (Float (K) * (Y + XK) - Err);
      return U64 (Float'Truncation (X + 0.5));
   end Estimate_Root;

   Root_Max : constant array (U64 range 0 .. 40) of U64 :=
     [0, 0, 4_294_967_295, 2_642_245, 65_535, 7_131, 1_625, 565,
      255, 138, 84, 56, 40, 30, 23, 19, 15, 13, 11, 10, 9, 8, 7,
      6, 6, 5, 5, 5, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3];

   function Rootint (N, K : U64) return U64 is
      Lo, Hi, Mid, R : U64;
   begin
      if N <= 1 then
         return (if K /= 0 and N /= 0 then 1 else 0);
      end if;
      case K is
         when 0 => return 0;
         when 1 => return N;
         when 2 => return Sqrtint (N);
         when 3 => return Cube_Root (N);
         when others => null;
      end case;
      if K >= 64 or else N / 2 ** Natural (K) = 0 then
         return 1;
      elsif K <= 15 then
         R := Estimate_Root (N, K);
         --  The estimate is the floor root or one above it.
         if not Powint (R, K).Defined or else Powint (R, K).Value > N then
            R := R - 1;
         end if;
         return R;
      elsif K > 40 then
         return 2;
      elsif K >= 32 then
         return 2 + (if N >= Powint (3, K).Value then 1 else 0);
      end if;
      Lo := 2 ** Natural (Logint (N, 2) / K);
      Hi := U64'Min (Root_Max (K), Lo * 2 - 1);
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         if Powint (Mid, K).Value > N then
            Hi := Mid - 1;
         else
            Lo := Mid;
         end if;
      end loop;
      return Lo;
   end Rootint;

   function Crootint (N, K : U64) return U64 is
      R : constant U64 := Rootint (N, K);
      P : Optional_U64;
   begin
      if K = 0 or N <= 1 or K = 1 then
         return R;
      end if;
      P := Powint (R, K);
      if P.Defined and then P.Value < N then
         return R + 1;
      end if;
      return R;
   end Crootint;

   function Logint (N, B : U64) return U64 is
      V : U64 := B;
      M : U64 := N;
      E : U64 := 0;
   begin
      if M > U64'Last / B then
         M := M / B;
         E := 1;
      end if;
      while V <= M loop
         E := E + 1;
         V := V * B;
      end loop;
      return E;
   end Logint;

   function Is_Square (N : U64) return Boolean is
      Mask : constant U64 := 16#FDFD_FDED_FDFC_FDEC#;
   begin
      if (2 ** Natural (N mod 64) and Mask) /= 0 then
         return False;
      end if;
      return Sqrtint (N) ** 2 = N;
   end Is_Square;

   Root_Mask : constant array (U64 range 0 .. 40) of U32 :=
     [16#00000000#, 16#00000000#, 16#FDFCFDEC#, 16#54555454#, 
      16#FFFCFFFC#, 16#55555554#, 16#FDFDFDFC#, 16#55555554#, 
      16#FFFFFFFC#, 16#55555554#, 16#FDFDFDFC#, 16#55555554#, 
      16#FFFDFFFC#, 16#D5555556#, 16#FDFDFDFC#, 16#F57D57D6#, 
      16#FFFFFFFC#, 16#FFFFD556#, 16#FDFDFDFE#, 16#D57FFFFE#, 
      16#FFFDFFFC#, 16#FFD7FF7E#, 16#FDFDFDFE#, 16#FFFFD7FE#, 
      16#FFFFFFFC#, 16#FFFFFFD6#, 16#FDFFFDFE#, 16#D7FFFFFE#, 
      16#FFFDFFFE#, 16#FFF7FFFE#, 16#FDFFFFFE#, 16#FFFFF7FE#, 
      16#FFFFFFFC#, 16#FFFFFFF6#, 16#FFFFFDFE#, 16#F7FFFFFE#, 
      16#FFFDFFFE#, 16#FFF7FFFE#, 16#FDFFFFFE#, 16#FFFFF7FE#, 
      16#FFFFFFFC#];

   function Is_Power (N, K : U64) return Boolean is
      R : U64;
      V : U32;
   begin
      if N < 2 or K = 1 then
         return True;
      elsif K > 40 then
         return K < 64 and then N = 2 ** Natural (K);
      elsif K = 2 then
         return Is_Square (N);
      end if;
      if (2 ** Natural (N mod 32) and Root_Mask (K)) /= 0 then
         return False;
      end if;
      if K = 3 then
         V := U32 (N mod 117);
         if ((V * 833_230_740) and (V * 120_676_722)
             and 813_764_715) /= 0
         then
            return False;
         end if;
         R := Cube_Root (N);
      else
         R := Estimate_Root (N, K);
      end if;
      return Powint (R, K).Defined and then Powint (R, K).Value = N;
   end Is_Power;

   function Is_Power_Exp (N : U64) return U64 is
   begin
      if N <= 3 or N = U64'Last then
         return 0;
      end if;
      for K in reverse U64 range 2 .. 63 loop
         if Is_Power (N, K) then
            return K;
         end if;
      end loop;
      return 0;
   end Is_Power_Exp;

   function Addmod (A, B, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, U64 ((U128 (A) + U128 (B)) mod U128 (N)));
   end Addmod;

   function Submod (A, B, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, (if A mod N >= B mod N then A mod N - B mod N
         else N - (B mod N - A mod N)));
   end Submod;

   function Mulmod (A, B, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, U64 ((U128 (A) * U128 (B)) mod U128 (N)));
   end Mulmod;

   function Sqrmod (A, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, Mulmod (A, A, N).Value);
   end Sqrmod;

   function Negmod (A, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, (if A mod N = 0 then 0 else N - A mod N));
   end Negmod;

   function Muladdmod (A, B, C, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, Addmod (Mulmod (A, B, N).Value, C, N).Value);
   end Muladdmod;

   function Mulsubmod (A, B, C, N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      return (True, Submod (Mulmod (A, B, N).Value, C, N).Value);
   end Mulsubmod;

   function Powmod (A, K, N : U64) return Optional_U64 is
      T : U64;
      B : U64;
      E : U64 := K;
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      T := 1 mod N;
      B := A mod N;
      while E /= 0 loop
         if E mod 2 = 1 then
            T := Mulmod (T, B, N).Value;
         end if;
         E := E / 2;
         if E /= 0 then
            B := Sqrmod (B, N).Value;
         end if;
      end loop;
      return (True, T);
   end Powmod;

   function Invmod (A, N : U64) return Optional_U64 is
      T : U64 := 0;
      NT : U64 := 1;
      R : U64 := N;
      NR : U64;
      Q, Tmp : U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (True, 0);
      end if;
      NR := A mod N;
      while NR /= 0 loop
         Q := R / NR;
         Tmp := NT;
         NT := Submod (T, Mulmod (Q, NT, N).Value, N).Value;
         T := Tmp;
         Tmp := NR;
         NR := R mod NR;
         R := Tmp;
      end loop;
      if R /= 1 then
         return (Defined => False);
      end if;
      return (True, T);
   end Invmod;
end Math_Prime_Util.Int;
