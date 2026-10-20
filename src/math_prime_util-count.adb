with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Count is
   Max_Prime : constant U64 := 18_446_744_073_709_551_557;

   function Sum_Primes (High : U64) return U128 is
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
   end Sum_Primes;

   function Sum_Primes (Low, High : U64) return U128
     with SPARK_Mode => Off
   is
      --  The existing sieve uses Ada containers outside the SPARK subset.
      Last : constant U64 := U64'Min (High, Max_Prime);
      Sum : U128 := 0;
   begin
      if Low > Last or Last < 2 then
         return 0;
      elsif Low > 2 and then Last - Low < 50_000_000 then
         declare
            Primes : constant Sieve.Prime_Vectors.Vector :=
              Sieve.Primes (Low, Last);
         begin
            for I in Primes.First_Index .. Primes.Last_Index loop
               Sum := Sum + U128 (Primes.Element (I));
            end loop;
         end;
         return Sum;
      elsif Low <= 2 then
         return Sum_Primes (Last);
      else
         return Sum_Primes (Last) - Sum_Primes (Low - 1);
      end if;
   end Sum_Primes;
end Math_Prime_Util.Count;
