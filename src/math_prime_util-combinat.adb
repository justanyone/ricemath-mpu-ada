package body Math_Prime_Util.Combinat with SPARK_Mode => On is
   use Math_Prime_Util.Int;

   function Factorial (N : U64) return Optional_U64 is
      R : U64 := 1;
   begin
      if N > 20 then
         return (Defined => False);
      end if;
      for I in U64 range 2 .. N loop
         R := R * I;
      end loop;
      return (True, R);
   end Factorial;

   function Subfactorial (N : U64) return Optional_U64 is
      R : Optional_U64;
   begin
      if N <= 3 then
         return (True, (if N = 0 then 1 else N - 1));
      elsif N > 20 then
         return (Defined => False);
      end if;
      R := Subfactorial (N - 1);
      return (True, (if N mod 2 = 1 then N * R.Value - 1
                     else N * R.Value + 1));
   end Subfactorial;

   function Multifactorial (N, K : U64) return Optional_U64 is
      I : U64 := N;
      R : U64 := 1;
   begin
      if K = 0 then
         raise Constraint_Error with "multifactorial step must be positive";
      end if;
      while I > 0 loop
         if R > U64'Last / I then
            return (Defined => False);
         end if;
         R := R * I;
         exit when I <= K;
         I := I - K;
      end loop;
      return (True, R);
   end Multifactorial;

   function Binomial (N, K : U64) return Optional_U64 is
      M : U64 := N;
      L : U64 := K;
      R : U64 := 1;
      G, Nr, Dr : U64;
   begin
      if K = 0 then
         return (True, 1);
      elsif K = 1 then
         return (True, N);
      elsif K >= N then
         return (True, (if K = N then 1 else 0));
      end if;
      if L > N / 2 then
         L := N - L;
      end if;
      if (N >= 73 and L >= 25) or (N >= 92 and L >= 19)
        or (N >= 131 and L >= 15)
      then
         return (Defined => False);
      end if;
      for D in U64 range 1 .. L loop
         if R >= U64'Last / M then
            G := Gcd (M, D);
            Nr := M / G;
            Dr := D / G;
            G := Gcd (R, Dr);
            R := R / G;
            Dr := Dr / G;
            if R > U64'Last / Nr then
               return (Defined => False);
            end if;
            R := R * Nr / Dr;
         else
            R := R * M / D;
         end if;
         M := M - 1;
      end loop;
      return (True, R);
   end Binomial;

   function Catalan_Number (N : U64) return Optional_U64 is
      use type U128;
      R : U128 := 1;
      M : U128 := 2 * U128 (N);
   begin
      --  The central binomial method from util.c uses a wide intermediate
      --  so Catalan numbers 34 through 36 can still fit the native result.
      if N > 36 then
         return (Defined => False);
      end if;
      for D in U128 range 1 .. U128 (N) loop
         R := R * M / D;
         M := M - 1;
      end loop;
      return (True, U64 (R / (U128 (N) + 1)));
   end Catalan_Number;

   function Bell_Number (N : U64) return Optional_U64 is
      --  Wide scratch entries retain the final row's unused large values.
      use type U128;
      type Bell_Row is array (Natural range 0 .. 26) of U128;
      Row, Next : Bell_Row := [others => 0];
   begin
      if N <= 1 then
         return (True, 1);
      elsif N >= 26 then
         return (Defined => False);
      end if;
      Row (0) := 1;
      for I in 1 .. Natural (N) loop
         Next (0) := Row (I - 1);
         for J in 0 .. I - 1 loop
            Next (J + 1) := Next (J) + Row (J);
         end loop;
         Row := Next;
      end loop;
      return (True, U64 (Row (0)));
   end Bell_Number;

   Primorials : constant array (Natural range 0 .. 15) of U64 :=
     [1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870,
      6469693230, 200560490130, 7420738134810, 304250263527210,
      13082761331670030, 614889782588491410];
   Prime_Map : constant array (Natural range 0 .. 52) of Natural :=
     [0, 0, 1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 6, 6, 6, 6, 7, 7, 8,
      8, 8, 8, 9, 9, 9, 9, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11,
      12, 12, 12, 12, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 15, 15];

   function Pn_Primorial (N : U64) return Optional_U64 is
   begin
      if N > 15 then
         return (Defined => False);
      end if;
      return (True, Primorials (Natural (N)));
   end Pn_Primorial;

   function Primorial (N : U64) return Optional_U64 is
   begin
      if N > 52 then
         return (Defined => False);
      end if;
      return (True, Primorials (Prime_Map (Natural (N))));
   end Primorial;
   function Harmfrac (N : U64) return Optional_Fraction is
      use type U128;
      function Gcd_Wide (A, B : U128) return U128;
      function Split (A, B : U64) return Optional_Fraction;

      function Gcd_Wide (A, B : U128) return U128 is
         X : U128 := A;
         Y : U128 := B;
         T : U128;
      begin
         while Y /= 0 loop
            T := X mod Y;
            X := Y;
            Y := T;
         end loop;
         return X;
      end Gcd_Wide;

      function Split (A, B : U64) return Optional_Fraction is
         L, R : Optional_Fraction;
         G, H, P, Q, Num, Den : U128;
      begin
         if B - A = 1 then
            return (True, 1, U128 (A));
         end if;
         L := Split (A, (A + B) / 2);
         R := Split ((A + B) / 2, B);
         if not L.Defined or not R.Defined then
            return (Defined => False);
         end if;
         --  Cancel the shared denominator before the split's products.
         G := Gcd_Wide (L.Den, R.Den);
         P := L.Den / G;
         Q := R.Den / G;
         if U128 (L.Num) > U128'Last / Q
           or U128 (R.Num) > U128'Last / P
         then
            return (Defined => False);
         end if;
         Num := U128 (L.Num) * Q;
         Den := U128 (R.Num) * P;
         if Num > U128'Last - Den then
            return (Defined => False);
         end if;
         Num := Num + Den;
         H := Gcd_Wide (Num, G);
         Num := Num / H;
         Q := R.Den / H;
         if P > U128'Last / Q or Num > U128 (I128'Last) then
            return (Defined => False);
         end if;
         Den := P * Q;
         return (True, I128 (Num), Den);
      end Split;
   begin
      if N = 0 then
         return (True, 0, 1);
      elsif N > 88 then
         return (Defined => False);
      end if;
      return Split (1, N + 1);
   end Harmfrac;

   function Falling_Factorial (N : I128; M : U64) return Optional_I128 is
      R : U64 := 1;
      A : U64;
   begin
      if M = 0 then
         return (True, 1);
      elsif N < 0 then
         declare
            V : constant Optional_I128 := Rising_Factorial (-N, M);
         begin
            if not V.Defined then
               return V;
            end if;
            return (True, (if M mod 2 = 0 then V.Value else -V.Value));
         end;
      elsif M > U64 (N) then
         return (True, 0);
      end if;
      A := U64 (N);
      for I in U64 range 1 .. M loop
         if R > U64'Last / A then
            return (Defined => False);
         end if;
         R := R * A;
         A := A - 1;
      end loop;
      return (True, I128 (R));
   end Falling_Factorial;

   function Rising_Factorial (N : I128; M : U64) return Optional_I128 is
      V : Optional_I128;
   begin
      if M = 0 then
         return (True, 1);
      elsif N < 0 then
         V := Falling_Factorial (-N, M);
         if not V.Defined then
            return V;
         end if;
         return (True, (if M mod 2 = 0 then V.Value else -V.Value));
      elsif N = 0 then
         return (True, 0);
      elsif M - 1 > U64'Last - U64 (N) then
         return (Defined => False);
      end if;
      return Falling_Factorial (N + I128 (M) - 1, M);
   end Rising_Factorial;

   function Consecutive_Integer_Lcm (N : U64) return Optional_U64 is
      R : U64 := 1;
      P, Power : U64;
      Prime : Boolean;
   begin
      if N > 46 then
         return (Defined => False);
      end if;
      for I in U64 range 2 .. N loop
         Prime := True;
         P := 2;
         while P <= I / P loop
            if I mod P = 0 then
               Prime := False;
               exit;
            end if;
            P := P + 1;
         end loop;
         if Prime then
            Power := I;
            while Power <= N / I loop
               Power := Power * I;
            end loop;
            R := R * Power;
         end if;
      end loop;
      return (True, R);
   end Consecutive_Integer_Lcm;

   --  util.c: stirling2 inclusion-exclusion formula. The caller bounds
   --  N to 18, so all signed wide intermediates fit.
   function Stirling_Second (N, M : U64) return U64;

   function Stirling_Second (N, M : U64) return U64 is
      Sum : I128 := 0;
      Term : I128;
   begin
      if N = M then
         return 1;
      elsif M = 0 or M > N then
         return 0;
      end if;
      for J in U64 range 1 .. M loop
         Term := I128 (Binomial (M, J).Value);
         for K in U64 range 1 .. N loop
            Term := Term * I128 (J);
         end loop;
         Sum := Sum + (if (M - J) mod 2 = 0 then Term else -Term);
      end loop;
      return U64 (Sum / I128 (Factorial (M).Value));
   end Stirling_Second;

   function Fubini (N : U64) return Optional_U64 is
      use type U128;
      Sum : U128 := 1;
   begin
      if N > 18 then
         return (Defined => False);
      end if;
      for K in U64 range 2 .. N loop
         Sum := Sum + U128 (Factorial (K).Value)
           * U128 (Stirling_Second (N, K));
      end loop;
      if Sum > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (True, U64 (Sum));
   end Fubini;

   function Powersum (N, K : U64) return Optional_U64 is
      use type U128;
      Sum : U64 := 0;
      Term : U64;
      Wide : U128;
   begin
      if N <= 1 or K = 0 then
         return (True, N);
      elsif K >= 64 then
         return (Defined => False);
      elsif K = 1 then
         Wide := U128 (N) * (U128 (N) + 1) / 2;
      elsif K = 2 then
         --  util.c triangular-number formula; first bound N so the
         --  wide intermediate cannot wrap.
         if N > 4_000_000 then
            return (Defined => False);
         end if;
         Wide := U128 (N) * (U128 (N) + 1) * (2 * U128 (N) + 1) / 6;
      elsif K = 3 then
         if N > 100_000 then
            return (Defined => False);
         end if;
         Wide := U128 (N) * (U128 (N) + 1) / 2;
         Wide := Wide * Wide;
      else
         --  util.c direct summation path with checked powers and sum.
         for I in U64 range 1 .. N loop
            Term := 1;
            for J in U64 range 1 .. K loop
               if Term > U64'Last / I then
                  return (Defined => False);
               end if;
               Term := Term * I;
            end loop;
            if Sum > U64'Last - Term then
               return (Defined => False);
            end if;
            Sum := Sum + Term;
         end loop;
         return (True, Sum);
      end if;
      if Wide > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (True, U64 (Wide));
   end Powersum;
   function Is_Happy
     (N : U64; Base : U64 := 10; Exp : U64 := 2) return U64 is
      Cur : U64 := N;
      Check : U64 := 0;
      H : U64 := 1;
   begin
      while Cur > 1 and then Cur /= Check loop
         if (H and (H - 1)) = 0 then
            Check := Cur;
         end if;
         declare
            T : U64 := Cur;
            Sum : U128 := 0;
         begin
            while T /= 0 loop
               declare
                  R : constant U64 := T mod Base;
                  Term : U128 := 1;
               begin
                  for J in 1 .. Exp loop
                     Term := Term * U128 (R);
                     exit when Term > U128 (U64'Last);
                  end loop;
                  Sum := Sum + Term;
                  if Sum >= U128 (U64'Last) then
                     return 0;
                  end if;
               end;
               T := T / Base;
            end loop;
            Cur := U64 (Sum);
         end;
         H := H + 1;
      end loop;
      return (if Cur = 1 then H else 0);
   end Is_Happy;

   function Is_Polygonal (N, K : U64) return Boolean is
      D, R, S : U64;
   begin
      if N <= 1 then
         return True;
      end if;
      if K = 4 then
         return Is_Square (N);
      end if;
      if K = 3 then
         if N >= U64'Last / 8 then
            return False;
         end if;
         D := N * 8;
         R := 1;
      else
         if K > U64'Last / K or else N > U64'Last / (8 * K - 16) then
            return False;
         end if;
         D := (8 * K - 16) * N;
         R := (K - 4) * (K - 4);
      end if;
      if D + R <= D or else D > U64'Last - R then
         return False;
      end if;
      D := D + R;
      if not Is_Square (D) then
         return False;
      end if;
      S := Sqrtint (D) + (K - 4);
      return S mod (2 * K - 4) = 0;
   end Is_Polygonal;

   function Is_Pillai (N : U64) return U64 is
      Fac : U64;
      V : U64 := 8;
   begin
      if N < 23 or else N mod 7 = 0 or else N mod 2 = 0
        or else N mod 3 = 0 or else N mod 5 = 0
      then
         return 0;
      end if;
      Fac := 5040 mod N;
      while V < N - 1 and then Fac /= 0 loop
         Fac := U64 ((U128 (Fac) * U128 (V)) mod U128 (N));
         if Fac = N - 1 and then N mod V /= 1 then
            return V;
         end if;
         V := V + 1;
      end loop;
      return 0;
   end Is_Pillai;

   function Stirling (N, K : U64; Kind : Stirling_Kind := 1)
     return Optional_I128 is
      Cap : constant U128 := 2 ** 100;
      type Row is array (0 .. 130) of U128;
      Cur, Prev : Row := (others => 0);
      Mag : U128;
   begin
      if N = K then
         return (True, 1);
      elsif N = 0 or else K = 0 or else K > N then
         return (True, 0);
      elsif N > 130 then
         return (Defined => False);
      end if;
      Prev (0) := 1;
      for I in 1 .. Natural (N) loop
         Cur := (others => 0);
         for J in 1 .. I loop
            declare
               Mul : constant U128 :=
                 (case Kind is
                    when 1 => U128 (I - 1),
                    when 2 => U128 (J),
                    when 3 => U128 (I - 1 + J));
               Val : U128;
            begin
               if Prev (J) /= 0 and then Mul > Cap / Prev (J) then
                  Val := Cap;
               else
                  Val := Prev (J) * Mul;
               end if;
               Val := Val + Prev (J - 1);
               Cur (J) := U128'Min (Val, Cap);
            end;
         end loop;
         Prev := Cur;
      end loop;
      Mag := Prev (Natural (K));
      if Mag > U128 (U64'Last) then
         return (Defined => False);
      end if;
      if Kind = 1 and then (N - K) mod 2 = 1 then
         return (True, -I128 (Mag));
      end if;
      return (True, I128 (Mag));
   end Stirling;

   function Partitions (N : U64) return Optional_U64 is
      type Table is array (0 .. 1000) of U128;
      P : Table := (others => 0);
   begin
      if N > 1000 then
         return (Defined => False);
      end if;
      P (0) := 1;
      for I in 1 .. Natural (N) loop
         declare
            Plus, Minus : U128 := 0;
            K : Natural := 1;
         begin
            loop
               declare
                  G1 : constant Integer := K * (3 * K - 1) / 2;
                  G2 : constant Integer := K * (3 * K + 1) / 2;
               begin
                  exit when G1 > I;
                  if K mod 2 = 1 then
                     Plus := Plus + P (I - G1);
                     if G2 <= I then
                        Plus := Plus + P (I - G2);
                     end if;
                  else
                     Minus := Minus + P (I - G1);
                     if G2 <= I then
                        Minus := Minus + P (I - G2);
                     end if;
                  end if;
               end;
               K := K + 1;
            end loop;
            P (I) := Plus - Minus;
         end;
      end loop;
      if P (Natural (N)) > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (True, U64 (P (Natural (N))));
   end Partitions;

   function Partitionsq (N : U64) return Optional_U64 is
      type Table is array (0 .. 1500) of U128;
      Q : Table := (others => 0);
   begin
      if N > 1500 then
         return (Defined => False);
      end if;
      Q (0) := 1;
      for Part in 1 .. Natural (N) loop
         for I in reverse Part .. Natural (N) loop
            Q (I) := Q (I) + Q (I - Part);
         end loop;
      end loop;
      if Q (Natural (N)) > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (True, U64 (Q (Natural (N))));
   end Partitionsq;

end Math_Prime_Util.Combinat;
