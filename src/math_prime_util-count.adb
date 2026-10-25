with Ada.Containers.Vectors;
with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;
with Math_Prime_Util.Count_Tables;

package body Math_Prime_Util.Count is
   package Counts is new Ada.Containers.Vectors (Natural, U64);

   function Prime_Count (N : U64) return U64 is
      use Sieve.Prime_Vectors;
      Root : constant U64 := Int.Rootint (N, 2);
      Primes : Vector;
      Phi_Table : Counts.Vector;
      Width : constant := 32_768;
      Layers : constant := 64;

      function Pi_Small (X : U64) return U64 is
         Low : Natural := 0;
         High : Natural := Natural (Primes.Length);
         Mid : Natural;
      begin
         while Low < High loop
            Mid := Low + (High - Low) / 2;
            if Primes (Mid) <= X then
               Low := Mid + 1;
            else
               High := Mid;
            end if;
         end loop;
         return U64 (Low);
      end Pi_Small;

      function Phi (X : U64; A : Natural) return U64 is
      begin
         if A = 0 then
            return X;
         elsif A < Layers and then X < Width then
            return Phi_Table (A * Width + Natural (X));
         elsif X < Primes (A - 1) then
            return 1;
         elsif X <= Root and then
           Primes (A - 1) > X / Primes (A - 1)
         then
            return Pi_Small (X) - U64 (A) + 1;
         end if;
         return Phi (X, A - 1) - Phi (X / Primes (A - 1), A - 1);
      end Phi;

      --  lehmer.c: lehmer_prime_count, stages 1, 2 and 4. Prime
      --  indices below are zero based; C uses one based indices.
      function Lehmer (X : U64) return U64 is
         A, B, C, Bi : Natural;
         Sum, W : U64;
      begin
         if X <= Root then
            return Pi_Small (X);
         end if;
         A := Natural (Lehmer (Int.Rootint (X, 4)));
         B := Natural (Lehmer (Int.Rootint (X, 2)));
         C := Natural (Lehmer (Int.Rootint (X, 3)));
         Sum := Phi (X, A) +
           (U64 (B + A - 2) * U64 (B - A + 1)) / 2;
         for I in reverse A .. B - 1 loop
            W := X / Primes (I);
            Sum := Sum - Lehmer (W);
            if I < C then
               Bi := Natural (Lehmer (Int.Rootint (W, 2)));
               for J in I .. Bi - 1 loop
                  Sum := Sum - (Lehmer (W / Primes (J)) - U64 (J));
               end loop;
            end if;
         end loop;
         return Sum;
      end Lehmer;

      Base, Total : U64;
   begin
      if N < 2 then
         return 0;
      elsif N < 100_000_000 then
         Count_Tables.Lookup (N, Base, Total);
         return Total + U64 (Sieve.Primes (Base + 1, N).Length);
      end if;
      Primes := Sieve.Primes (Root);
      Phi_Table.Set_Length (Layers * Width);
      for X in 0 .. Width - 1 loop
         Phi_Table (X) := U64 (X);
      end loop;
      for A in 1 .. Layers - 1 loop
         for X in 0 .. Width - 1 loop
            Phi_Table (A * Width + X) :=
              Phi_Table ((A - 1) * Width + X) -
              Phi_Table ((A - 1) * Width +
                         Natural (U64 (X) / Primes (A - 1)));
         end loop;
      end loop;
      return Lehmer (N);
   end Prime_Count;

   function Nth_Prime (N : U64) return U64 is
      Low : U64 := 2;
      High : U64 := U64'Last;
      Mid : U64;
   begin
      if N = 0 then
         return 0;
      end if;
      --  Bracket by doubling without overflowing the native word.
      High := 2;
      while Prime_Count (High) < N loop
         Low := High + 1;
         if High > U64'Last / 2 then
            High := U64'Last;
            exit;
         end if;
         High := High * 2;
      end loop;
      while Low < High loop
         Mid := Low + (High - Low) / 2;
         if Prime_Count (Mid) < N then
            Low := Mid + 1;
         else
            High := Mid;
         end if;
      end loop;
      return Low;
   end Nth_Prime;
end Math_Prime_Util.Count;
