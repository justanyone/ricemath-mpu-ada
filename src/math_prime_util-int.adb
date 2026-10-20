with Ada.Numerics.Long_Elementary_Functions;

package body Math_Prime_Util.Int with SPARK_Mode => On is
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

   function Rootint (N, K : U64) return U64 is
      Lo : U64 := 1;
      Hi : U64;
      Mid : U64;
      P : Optional_U64;
   begin
      if K = 0 then
         return 0;
      elsif N <= 1 or K = 1 then
         return N;
      elsif K = 2 then
         return Sqrtint (N);
      elsif K >= 64 then
         return 1;
      end if;
      --  util.c: rootint upper-midpoint binary search, with checked powers.
      Hi := 2 ** Natural ((Logint (N, 2) / K) + 1) - 1;
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo + 1) / 2;
         P := Powint (Mid, K);
         if not P.Defined or else P.Value > N then
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

   function Is_Power (N, K : U64) return Boolean is
      P : Optional_U64;
   begin
      if N < 2 or K = 1 then
         return True;
      elsif K >= 64 then
         return False;
      end if;
      P := Powint (Rootint (N, K), K);
      return P.Defined and then P.Value = N;
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
