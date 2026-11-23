with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Goldbach is
   use type Math_Prime_Util.Primality.Prime_Result;

   function Is_Prime (N : U64) return Boolean is
     (Math_Prime_Util.Primality.Is_Prime (N) /= 0);

   --  goldbach.c: the least partner below 4e18 is at most 9781, so walk
   --  successive primes instead of materializing every prime through N/2.
   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64 is
      P : U64;
      Step : Int.Optional_U64;
   begin
      if N < 4 then
         return (Defined => False);
      elsif N mod 2 = 1 or else N = 4 then
         if Is_Prime (N - 2) then
            return (Defined => True, Value => 2);
         end if;
         return (Defined => False);
      end if;
      P := 3;
      loop
         exit when P > N / 2;
         if Is_Prime (N - P) then
            return (Defined => True, Value => P);
         end if;
         Step := Math_Prime_Util.Sieve.Next_Prime (P);
         exit when not Step.Defined;
         P := Step.Value;
      end loop;
      return (Defined => False);
   end Minimal_Goldbach_Pair;

   function Goldbach_Pairs (N : U64) return Pair_Vectors.Vector is
      Result : Pair_Vectors.Vector;
      P : U64;
      Step : Int.Optional_U64;
   begin
      if N < 4 then
         return Result;
      elsif N mod 2 = 1 or else N = 4 then
         if Is_Prime (N - 2) then
            Result.Append (2);
         end if;
         return Result;
      end if;
      --  Listing every prime through N/2 is practical only for the fixture
      --  range. Larger even inputs walk next_prime, as minimal pairs do.
      if N / 2 <= 100_000_000 then
         for Q of Math_Prime_Util.Sieve.Primes (3, N / 2) loop
            if Is_Prime (N - Q) then
               Result.Append (Q);
            end if;
         end loop;
         return Result;
      end if;
      P := 3;
      loop
         exit when P > N / 2;
         if Is_Prime (N - P) then
            Result.Append (P);
         end if;
         Step := Math_Prime_Util.Sieve.Next_Prime (P);
         exit when not Step.Defined;
         P := Step.Value;
      end loop;
      return Result;
   end Goldbach_Pairs;

   function Goldbach_Pair_Count (N : U64) return U64 is
   begin
      return U64 (Goldbach_Pairs (N).Length);
   end Goldbach_Pair_Count;
end Math_Prime_Util.Goldbach;
