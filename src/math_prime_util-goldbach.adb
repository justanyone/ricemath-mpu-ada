with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Goldbach is
   use type Math_Prime_Util.Primality.Prime_Result;
   use Math_Prime_Util.Sieve;

   function Is_Prime (N : U64) return Boolean is
     (Math_Prime_Util.Primality.Is_Prime (N) /= 0);

   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64 is
   begin
      if N < 4 then
         return (Defined => False);
      elsif N mod 2 = 1 or else N = 4 then
         if Is_Prime (N - 2) then
            return (Defined => True, Value => 2);
         end if;
         return (Defined => False);
      end if;
      for P of Primes (3, N / 2) loop
         if Is_Prime (N - P) then
            return (Defined => True, Value => P);
         end if;
      end loop;
      return (Defined => False);
   end Minimal_Goldbach_Pair;

   function Goldbach_Pairs (N : U64) return Pair_Vectors.Vector is
      Result : Pair_Vectors.Vector;
   begin
      if N < 4 then
         return Result;
      elsif N mod 2 = 1 or else N = 4 then
         if Is_Prime (N - 2) then
            Result.Append (2);
         end if;
         return Result;
      end if;
      for P of Primes (3, N / 2) loop
         if Is_Prime (N - P) then
            Result.Append (P);
         end if;
      end loop;
      return Result;
   end Goldbach_Pairs;

   function Goldbach_Pair_Count (N : U64) return U64 is
   begin
      return U64 (Goldbach_Pairs (N).Length);
   end Goldbach_Pair_Count;
end Math_Prime_Util.Goldbach;
