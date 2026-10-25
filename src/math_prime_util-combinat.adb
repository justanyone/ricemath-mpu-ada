with Ada.Containers.Vectors;
with Interfaces;
with Math_Prime_Util.Sieve;
package body Math_Prime_Util.Combinat with SPARK_Mode => Off is
   use Math_Prime_Util.Int;
   use type Interfaces.Unsigned_8;
   use type Interfaces.Unsigned_32;

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

   procedure Numtoperm
     (N, K : U64; Perm : out Perm_Array; Defined : out Boolean)
   is
      Pool : Perm_Array (0 .. Natural (N)) := (others => 0);
      Fact : U64 := 1;
      Rest : U64 := K;
      Count : Natural := Natural (N);
      Idx : U64;
   begin
      Perm := (others => 0);
      for I in 2 .. N loop
         Fact := Fact * I;
      end loop;
      Rest := K mod Fact;
      Defined := True;
      for I in 0 .. Count - 1 loop
         Pool (I) := U64 (I);
      end loop;
      for I in 0 .. Count - 1 loop
         Fact := (if Count - I > 1 then Fact / U64 (Count - I) else 1);
         Idx := Rest / Fact;
         Rest := Rest mod Fact;
         Perm (Perm'First + I) := Pool (Natural (Idx));
         for J in Natural (Idx) .. Count - I - 2 loop
            Pool (J) := Pool (J + 1);
         end loop;
      end loop;
   end Numtoperm;

   function Permtonum (P : Perm_Array) return Optional_U64 is
      Len : constant Natural := P'Length;
      Seen : array (0 .. 19) of Boolean := (others => False);
      Rank : U64 := 0;
      Fact : U64 := 1;
      Smaller : U64;
   begin
      if Len > 20 then
         return (Defined => False);
      end if;
      for I in P'Range loop
         if P (I) >= U64 (Len) or else Seen (Natural (P (I))) then
            return (Defined => False);
         end if;
         Seen (Natural (P (I))) := True;
      end loop;
      for I in 1 .. Len - 1 loop
         Fact := Fact * U64 (I);
      end loop;
      for I in 0 .. Len - 1 loop
         Smaller := 0;
         for J in I + 1 .. Len - 1 loop
            if P (P'First + J) < P (P'First + I) then
               Smaller := Smaller + 1;
            end if;
         end loop;
         Rank := Rank + Smaller * Fact;
         if Len - 1 - I > 0 then
            Fact := Fact / U64 (Len - 1 - I);
         end if;
      end loop;
      return (True, Rank);
   end Permtonum;

   ---------------------------------------------------------------------
   --  Shared helpers for the functions below (not in the SPARK subset).
   ---------------------------------------------------------------------

   Trial_Primes : constant Sieve.Prime_Vectors.Vector :=
     Sieve.Primes (300_000);

   type U64_List is array (1 .. 20) of U64;
   type Factor_Table is record
      Count : Natural := 0;
      P : U64_List := [others => 0];
      E : U64_List := [others => 0];
   end record;

   --  Trial division; complete for N below 300_000 ** 2.
   procedure Factorize (N : U64; F : out Factor_Table)
     with SPARK_Mode => Off
   is
      M : U64 := N;
      Ex : U64;
   begin
      F := (others => <>);
      for P of Trial_Primes loop
         exit when P * P > M;
         if M mod P = 0 then
            Ex := 0;
            while M mod P = 0 loop
               M := M / P;
               Ex := Ex + 1;
            end loop;
            F.Count := F.Count + 1;
            F.P (F.Count) := P;
            F.E (F.Count) := Ex;
         end if;
      end loop;
      if M > 1 then
         F.Count := F.Count + 1;
         F.P (F.Count) := M;
         F.E (F.Count) := 1;
      end if;
   end Factorize;

   ---------------------------------------------------------------------
   --  intcomplexity.c
   ---------------------------------------------------------------------

   package Byte_Vectors is new Ada.Containers.Vectors
     (Index_Type => U64, Element_Type => Interfaces.Unsigned_8);

   --  intcomplexity.c: _calcg (A000792).
   function Calc_G (N_In : U64) return U64
     with SPARK_Mode => Off
   is
      N : U64 := N_In;
      Res : U64 := 1;
   begin
      if N >= 122 then
         return U64'Last;
      end if;
      while N >= 5 or else N = 3 loop
         Res := Res * 3;
         N := N - 3;
      end loop;
      return Res * 2 ** Natural (N / 2);
   end Calc_G;

   protected IC_Cache with SPARK_Mode => Off is
      procedure Lookup (N : U64; Result : out U64);
   private
      Data : Byte_Vectors.Vector;
      Size : U64 := 0;
   end IC_Cache;

   protected body IC_Cache is
      --  intcomplexity.c: expand_ic.
      procedure Expand (To_In : U64)
        with SPARK_Mode => Off
      is
         To : constant U64 := To_In + 32_767;
         A : Byte_Vectors.Vector;
         G : array (U64 range 0 .. 127) of U64;
         First : U64;
         J, IJ, T, K : U64;
      begin
         if Size >= To then
            return;
         end if;
         A.Set_Length (Ada.Containers.Count_Type (To + 1));
         if not Data.Is_Empty then
            for I in U64 range 0 .. Size loop
               A (I) := Data (I);
            end loop;
         end if;
         if Size < 2 then
            A (0) := 0;
            A (1) := 1;
            First := 2;
         else
            First := Size + 1;
         end if;
         for I in First .. To loop
            A (I) := 127;
         end loop;
         for I in G'Range loop
            G (I) := Calc_G (I);
         end loop;
         --  Multiplication loop for new data.
         for I in U64 range 2 .. First - 1 loop
            exit when I > To / 2;
            J := 2;
            IJ := 2 * I;
            while J <= I and then IJ <= To loop
               if IJ >= First
                 and then Natural (A (I)) + Natural (A (J))
                          < Natural (A (IJ))
               then
                  A (IJ) := A (I) + A (J);
               end if;
               J := J + 1;
               IJ := IJ + I;
            end loop;
         end loop;
         --  Fill in the rest.
         for I in First .. To loop
            T := U64 (A (I - 1));
            K := 1;
            if T + 1 < U64 (A (I)) then
               A (I) := Interfaces.Unsigned_8 (T + 1);
            end if;
            while K < T / 2 and then G (K + 1) + G (T - K - 1) >= I loop
               K := K + 1;
            end loop;
            --  Additions.
            J := 6;
            while J <= G (K) and then J < I loop
               if Natural (A (J)) + Natural (A (I - J)) < Natural (A (I))
               then
                  A (I) := A (J) + A (I - J);
               end if;
               J := J + 1;
            end loop;
            --  Multiplications.
            if I <= To / 2 then
               J := 2;
               IJ := 2 * I;
               while J <= I and then IJ <= To loop
                  if Natural (A (I)) + Natural (A (J)) < Natural (A (IJ))
                  then
                     A (IJ) := A (I) + A (J);
                  end if;
                  J := J + 1;
                  IJ := IJ + I;
               end loop;
            end if;
         end loop;
         Data.Move (A);
         Size := To;
      end Expand;

      procedure Lookup (N : U64; Result : out U64)
        with SPARK_Mode => Off
      is
      begin
         if Size < N then
            Expand (N);
         end if;
         Result := U64 (Data (N));
      end Lookup;
   end IC_Cache;

   function Integer_Complexity (N : U64) return U64
     with SPARK_Mode => Off
   is
      R : U64;
   begin
      IC_Cache.Lookup (N, R);
      return R;
   end Integer_Complexity;

   ---------------------------------------------------------------------
   --  real.c: bernfrac
   ---------------------------------------------------------------------

   Big_Limbs : constant := 16;
   type Big is array (0 .. Big_Limbs - 1) of Interfaces.Unsigned_32;

   procedure Big_Mul (X : in out Big; M : U64)
     with SPARK_Mode => Off
   is
      Carry : U128 := 0;
      Cur : U128;
   begin
      for I in X'Range loop
         Cur := U128 (X (I)) * U128 (M) + Carry;
         X (I) := Interfaces.Unsigned_32 (Cur mod 2 ** 32);
         Carry := Cur / 2 ** 32;
      end loop;
   end Big_Mul;

   procedure Big_Add (X : in out Big; Y : Big)
     with SPARK_Mode => Off
   is
      Carry : U64 := 0;
      Cur : U64;
   begin
      for I in X'Range loop
         Cur := U64 (X (I)) + U64 (Y (I)) + Carry;
         X (I) := Interfaces.Unsigned_32 (Cur mod 2 ** 32);
         Carry := Cur / 2 ** 32;
      end loop;
   end Big_Add;

   --  Divide in place; return the remainder.
   procedure Big_Div (X : in out Big; D : U64; Rem_Out : out U64)
     with SPARK_Mode => Off
   is
      R : U128 := 0;
      Cur : U128;
   begin
      for I in reverse X'Range loop
         Cur := R * 2 ** 32 + U128 (X (I));
         X (I) := Interfaces.Unsigned_32 (Cur / U128 (D));
         R := Cur mod U128 (D);
      end loop;
      Rem_Out := U64 (R);
   end Big_Div;

   function Is_Prime_Small (N : U64) return Boolean
     with SPARK_Mode => Off
   is
      D : U64 := 2;
   begin
      if N < 2 then
         return False;
      end if;
      while D * D <= N loop
         if N mod D = 0 then
            return False;
         end if;
         D := D + 1;
      end loop;
      return True;
   end Is_Prime_Small;

   function Bernfrac (N : U64) return Optional_Fraction
     with SPARK_Mode => Off
   is
      Half : constant Natural := Natural (N / 2);
      T : array (1 .. 31) of Big := [others => [others => 0]];
      Tmp, Num : Big;
      Den, Four_N : U64;
      Rem_Part : U64;
      Value : U128 := 0;
   begin
      if N = 0 then
         return (True, 1, 1);
      elsif N = 1 then
         return (True, 1, 2);
      elsif N mod 2 = 1 then
         return (True, 0, 1);
      elsif N > 62 then
         return (Defined => False);
      end if;
      --  Tangent numbers T (1 .. Half), Brent and Harvey, algorithm 2.
      T (1) (0) := 1;
      for K in 2 .. Half loop
         T (K) := T (K - 1);
         Big_Mul (T (K), U64 (K - 1));
      end loop;
      for K in 2 .. Half loop
         for J in K .. Half loop
            Tmp := T (J - 1);
            Big_Mul (Tmp, U64 (J - K));
            Big_Mul (T (J), U64 (J - K + 2));
            Big_Add (T (J), Tmp);
         end loop;
      end loop;
      --  von Staudt-Clausen: the denominator is the product of the
      --  primes P with (P - 1) dividing N.
      Den := 1;
      for D in U64 range 1 .. N loop
         if N mod D = 0 and then Is_Prime_Small (D + 1) then
            Den := Den * (D + 1);
         end if;
      end loop;
      --  |B_N| = N * T / (4**Half * (4**Half - 1)); the numerator is
      --  |B_N| * Den.
      Num := T (Half);
      Big_Mul (Num, N);
      Big_Mul (Num, Den);
      Four_N := 4 ** Half;
      Big_Div (Num, Four_N - 1, Rem_Part);
      Big_Div (Num, Four_N, Rem_Part);
      for I in 4 .. Big_Limbs - 1 loop
         if Num (I) /= 0 then
            return (Defined => False);
         end if;
      end loop;
      for I in reverse 0 .. 3 loop
         Value := Value * 2 ** 32 + U128 (Num (I));
      end loop;
      if Value > U128 (I128'Last) then
         return (Defined => False);
      end if;
      return (True,
              (if Half mod 2 = 1 then I128 (Value) else -I128 (Value)),
              U128 (Den));
   end Bernfrac;

   ---------------------------------------------------------------------
   --  util.c: frobenius_number
   ---------------------------------------------------------------------

   function Coprime_Set (A : Number_Array) return Boolean
     with SPARK_Mode => Off
   is
      G : U64 := 0;
   begin
      for X of A loop
         G := Gcd (G, X);
      end loop;
      return A'Length < 2 or else G = 1;
   end Coprime_Set;

   package Word_Vectors is new Ada.Containers.Vectors
     (Index_Type => U64, Element_Type => U128);

   function Frobenius_Number (A : Number_Array) return Optional_I128
     with SPARK_Mode => Off
   is
      Sorted : Number_Array := A;
      Max : constant U128 := U128'Last;
      Swap : U64;
      Nlen, G_Len, R_Len : U64;
      N : Word_Vectors.Vector;
      Result : Optional_I128;
      Big_Max : U128 := 0;
   begin
      if A'Length = 0 then
         return (Defined => False);
      end if;
      --  Insertion sort.
      for I in Sorted'First + 1 .. Sorted'Last loop
         Swap := Sorted (I);
         declare
            J : Integer := I - 1;
         begin
            while J >= Sorted'First and then Sorted (J) > Swap loop
               Sorted (J + 1) := Sorted (J);
               J := J - 1;
            end loop;
            Sorted (J + 1) := Swap;
         end;
      end loop;
      if Sorted (Sorted'First) = 1 then
         return (True, -1);
      elsif Sorted'Length < 2 then
         return (Defined => False);
      end if;
      if Sorted'Length = 2 then
         declare
            Lo : constant U128 := U128 (Sorted (Sorted'First));
            Hi : constant U128 := U128 (Sorted (Sorted'First + 1));
            V : constant U128 := Lo * Hi - Lo - Hi;
         begin
            if V > U128 (I128'Last) then
               return (Defined => False);
            end if;
            return (True, I128 (V));
         end;
      end if;
      Nlen := Sorted (Sorted'First);
      if Nlen > 5_000_000 then
         return (Defined => False);
      end if;
      N.Set_Length (Ada.Containers.Count_Type (Nlen + 1));
      N (0) := 0;
      for J in U64 range 1 .. Nlen - 1 loop
         N (J) := Max;
      end loop;
      for I in Sorted'First + 1 .. Sorted'Last loop
         declare
            Ai : constant U64 := Sorted (I);
            Np : constant U128 := N (Ai mod Nlen);
            D : U64;
         begin
            if Np = Max or else Np > U128 (Ai) then
               D := Gcd (Nlen, Ai);
               G_Len := Nlen / D;
               for R in U64 range 0 .. D - 1 loop
                  declare
                     Nn : U128 := 0;
                     P : U64;
                     Q : U64 := R;
                  begin
                     if R > 0 then
                        Nn := Max;
                        while Q < Nlen loop
                           if N (Q) < Nn then
                              Nn := N (Q);
                           end if;
                           Q := Q + D;
                        end loop;
                     end if;
                     if Nn /= Max then
                        R_Len := 1;
                        while R_Len < G_Len loop
                           if Nn > Max - U128 (Ai) then
                              return (Defined => False);
                           end if;
                           Nn := Nn + U128 (Ai);
                           P := U64 (Nn mod U128 (Nlen));
                           if N (P) >= Nn then
                              N (P) := Nn;
                           else
                              Nn := N (P);
                           end if;
                           R_Len := R_Len + 1;
                        end loop;
                     end if;
                  end;
               end loop;
            end if;
         end;
      end loop;
      for I in U64 range 0 .. Nlen - 1 loop
         if N (I) = Max then
            return (Defined => False);
         elsif N (I) > Big_Max then
            Big_Max := N (I);
         end if;
      end loop;
      Big_Max := Big_Max - U128 (Nlen);
      if Big_Max > U128 (I128'Last) then
         return (Defined => False);
      end if;
      Result := (True, I128 (Big_Max));
      return Result;
   end Frobenius_Number;

   ---------------------------------------------------------------------
   --  congruent_numbers.c
   ---------------------------------------------------------------------

   --  The square-free part of N (congruent_numbers.c: remove_square_part).
   function Square_Free_Part (N : U64) return U64
     with SPARK_Mode => Off
   is
      F : Factor_Table;
      R : U64 := 1;
   begin
      Factorize (N, F);
      for I in 1 .. F.Count loop
         if F.E (I) mod 2 = 1 then
            R := R * F.P (I);
         end if;
      end loop;
      return R;
   end Square_Free_Part;

   --  congruent_numbers.c: _is_congruent_number_tunnell.
   function Tunnell (N : U64) return Boolean
     with SPARK_Mode => Off
   is
      X, Y, Z, Limz, Limy, Limx, N8z, Zsols : U64;
      Sols : array (0 .. 1) of U64 := [0, 0];
   begin
      if N mod 2 = 1 then
         Limz := Sqrtint (N / 8);
         Z := 0;
         while Z <= Limz loop
            Zsols := 0;
            N8z := N - 8 * Z * Z;
            Limy := Sqrtint (N8z / 2);
            Y := 0;
            while Y <= Limy loop
               X := N8z - 2 * Y * Y;
               if Is_Square (X) then
                  Zsols := Zsols + 2 ** (1 + Boolean'Pos (Y > 0)
                                           + Boolean'Pos (Z > 0));
               end if;
               Y := Y + 1;
            end loop;
            Sols (Natural (Z mod 2)) := Sols (Natural (Z mod 2)) + Zsols;
            Z := Z + 1;
         end loop;
      else
         Limz := Sqrtint ((N / 2) / 8);
         Z := 0;
         while Z <= Limz loop
            Zsols := 0;
            N8z := N / 2 - 8 * Z * Z;
            Limx := Sqrtint (N8z);
            X := 1;
            while X <= Limx loop
               Y := N8z - X * X;
               if Y = 0 or else Is_Square (Y) then
                  Zsols := Zsols + 2 ** (1 + Boolean'Pos (Y > 0)
                                           + Boolean'Pos (Z > 0));
               end if;
               X := X + 2;
            end loop;
            Sols (Natural (Z mod 2)) := Sols (Natural (Z mod 2)) + Zsols;
            Z := Z + 1;
         end loop;
      end if;
      return Sols (0) = Sols (1);
   end Tunnell;

   function Is_Congruent_Number (N : U64) return Boolean
     with SPARK_Mode => Off
   is
      S : U64;
   begin
      if N = 0 then
         return False;
      end if;
      S := Square_Free_Part (N);
      if S < 13 then
         return S >= 5 and then S <= 7;
      end if;
      return Tunnell (S);
   end Is_Congruent_Number;

   ---------------------------------------------------------------------
   --  util.c: hclassno
   ---------------------------------------------------------------------

   --  Number of divisors of B2 in S .. Lim (util.c: _count_class_div).
   function Count_Class_Div (S, B2 : U64) return U64
     with SPARK_Mode => Off
   is
      Lim : U64 := Sqrtint (B2);
      H : U64 := 0;
   begin
      if Lim * Lim = B2 then
         Lim := Lim - 1;
      end if;
      if S > Lim then
         return 0;
      end if;
      if Lim - S < 70 then
         for I in S .. Lim loop
            if B2 mod I = 0 then
               H := H + 1;
            end if;
         end loop;
         return H;
      end if;
      declare
         F : Factor_Table;
         Divs : array (1 .. 40_000) of U64;
         Nd, Cur, Pw : U64;
      begin
         Factorize (B2, F);
         Divs (1) := 1;
         Nd := 1;
         for I in 1 .. F.Count loop
            Cur := Nd;
            Pw := 1;
            for E in 1 .. F.E (I) loop
               Pw := Pw * F.P (I);
               for K in 1 .. Cur loop
                  Nd := Nd + 1;
                  Divs (Natural (Nd)) := Divs (Natural (K)) * Pw;
               end loop;
            end loop;
         end loop;
         for I in 1 .. Natural (Nd) loop
            if Divs (I) >= S and then Divs (I) <= Lim then
               H := H + 1;
            end if;
         end loop;
      end;
      return H;
   end Count_Class_Div;

   function Hclassno (N : U64) return Optional_U64
     with SPARK_Mode => Off
   is
      Nmod4 : constant U64 := N mod 4;
      B, B2, H, Corr : U64;
      Square : U64;
      F : Factor_Table;
      Ndiv : U64 := 1;
   begin
      if N = 0 then
         return (Defined => False);
      elsif Nmod4 = 1 or else Nmod4 = 2 then
         return (True, 0);
      elsif N = 3 then
         return (True, 4);
      end if;
      B := N and 1;
      B2 := (N + 1) / 4;
      Square := Boolean'Pos (Is_Square (B2));
      Factorize (B2, F);
      for I in 1 .. F.Count loop
         Ndiv := Ndiv * (F.E (I) + 1);
      end loop;
      H := Ndiv / 2;
      if B = 1 then
         H := 1 + Square + ((H - 1) * 2);
      end if;
      B := B + 2;
      loop
         B2 := (N + B * B) / 4;
         exit when 3 * B2 >= N;
         H := H + Boolean'Pos (B2 mod B = 0)
           + Boolean'Pos (Is_Square (B2))
           + Count_Class_Div (B + 1, B2) * 2;
         B := B + 2;
      end loop;
      Corr := (if B2 * 3 = N then 4
               elsif Square = 1 and then N mod 2 = 0 then 6 else 0);
      if H > (U64'Last - Corr) / 12 then
         return (Defined => False);
      end if;
      return (True, 12 * H + Corr);
   end Hclassno;

end Math_Prime_Util.Combinat;
