with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Count is
   use type U128;

   Max_Prime : constant U64 := 18_446_744_073_709_551_557;

   function Prefix_Sum (High : U64) return U128 is
      N : constant U64 := U64'Min (High, Max_Prime);
   begin
      if N < 2 then
         return 0;
      end if;
      declare
         R : constant U64 := Int.Sqrtint (N);
         R2 : constant U64 := R + N / (R + 1);
         type Value_Array is array (U64 range <>) of U64;
         type Sum_Array is array (U64 range <>) of U128;
         V : Value_Array (0 .. R2) := (others => 0);
         S : Sum_Array (0 .. R2) := (others => 0);
         A, B, J : U64;
         Sp : U128;
      begin
         for K in U64 range 1 .. R2 loop
            V (K) := (if K <= R then K else N / (R2 - K + 1));
            S (K) := (U128 (V (K)) + 1) / 2 *
              U128 (V (K) or 1) - 1;
         end loop;
         for P in U64 range 2 .. R loop
            if S (P) > S (P - 1) then
               Sp := S (P - 1);
               J := R2;
               while J > 1 and then V (J) >= P * P loop
                  A := V (J);
                  B := A / P;
                  if A > R then
                     A := R2 - N / A + 1;
                  end if;
                  if B > R then
                     B := R2 - N / B + 1;
                  end if;
                  S (A) := S (A) - U128 (P) * (S (B) - Sp);
                  J := J - 1;
               end loop;
            end if;
         end loop;
         return S (R2);
      end;
   end Prefix_Sum;

   function Sum_Primes (Low, High : U64) return Int.Optional_U64
     with SPARK_Mode => Off
   is
      --  The existing sieve uses Ada containers outside the SPARK subset.
      Last : constant U64 := U64'Min (High, Max_Prime);
      Sum : U128 := 0;
   begin
      if Low > Last or Last < 2 then
         return (Defined => True, Value => 0);
      elsif Low <= 2 and then Last >= 29_505_444_491 then
         return (Defined => False);
      elsif Low > 2 and then Last - Low < 50_000_000 then
         declare
            Primes : constant Sieve.Prime_Vectors.Vector :=
              Sieve.Primes (Low, Last);
         begin
            for I in Primes.First_Index .. Primes.Last_Index loop
               Sum := Sum + U128 (Primes.Element (I));
            end loop;
         end;
      elsif Low <= 2 then
         Sum := Prefix_Sum (Last);
      else
         Sum := Prefix_Sum (Last) - Prefix_Sum (Low - 1);
      end if;
      if Sum > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (Defined => True, Value => U64 (Sum));
   end Sum_Primes;

   function Sum_Primes (High : U64) return Int.Optional_U64 is
   begin
      return Sum_Primes (0, High);
   end Sum_Primes;

   type Count_Array is array (U64 range <>) of U64;

   function Prime_Count (High : U64) return U64 is
      R : constant U64 := Int.Sqrtint (High);
      --  Small (V) = S (V) for V <= R; Large (I) = S (High / I).
      Small : Count_Array (0 .. R) := (others => 0);
      Large : Count_Array (0 .. R) := (others => 0);
   begin
      if High < 2 then
         return 0;
      end if;
      for V in U64 range 1 .. R loop
         Small (V) := V - 1;
      end loop;
      for I in U64 range 1 .. R loop
         Large (I) := High / I - 1;
      end loop;
      for P in U64 range 2 .. R loop
         if Small (P) > Small (P - 1) then
            declare
               Sp : constant U64 := Small (P - 1);
               P2 : constant U64 := P * P;
            begin
               for I in U64 range 1 .. U64'Min (R, High / P2) loop
                  declare
                     D : constant U64 := I * P;
                  begin
                     if D <= R then
                        Large (I) := Large (I) - (Large (D) - Sp);
                     else
                        Large (I) := Large (I) - (Small (High / D) - Sp);
                     end if;
                  end;
               end loop;
               for V in reverse P2 .. R loop
                  Small (V) := Small (V) - (Small (V / P) - Sp);
               end loop;
            end;
         end if;
      end loop;
      return Large (1);
   end Prime_Count;

   function Legendre_Phi (X : U64; A : Natural) return U64 is
      type Prime_List is array (Positive range <>) of U64;

      --  legendre_phi.c: _legendre_phi, phi (x, a) = phi (x, a - 1)
      --  - phi (x / p_a, a - 1), with phi (x, 0) = x.
      function Phi (Value : U64; K : Natural; Pr : Prime_List) return U64
      is
      begin
         if K = 0 or Value = 0 then
            return Value;
         end if;
         return Phi (Value, K - 1, Pr) - Phi (Value / Pr (K), K - 1, Pr);
      end Phi;
   begin
      if A = 0 then
         return X;
      end if;
      declare
         Pr : Prime_List (1 .. A);
         Cur : U64 := 1;
      begin
         for I in Pr'Range loop
            Cur := Sieve.Next_Prime (Cur).Value;
            Pr (I) := Cur;
         end loop;
         return Phi (X, A, Pr);
      end;
   end Legendre_Phi;

   function Nth_Prime (N : U64) return U64 is
      Lo : U64 := 2;
      Hi : U64 := 20 * N;
      Mid : U64;
   begin
      --  Invariant: Prime_Count (Hi) >= N, since p_N < 20 N here.
      while Lo < Hi loop
         Mid := Lo + (Hi - Lo) / 2;
         if Prime_Count (Mid) >= N then
            Hi := Mid;
         else
            Lo := Mid + 1;
         end if;
      end loop;
      return Lo;
   end Nth_Prime;
end Math_Prime_Util.Count;
