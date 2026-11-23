with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Goldbach with SPARK_Mode => Off is
   --  families.tsv goldbach_pair_count reaches 60119912. Larger even
   --  arguments are walked prime by prime so the sieve stays bounded.
   Sieve_Limit : constant U64 := 100_000_000;

   function Is_Prime (N : U64) return Boolean is
     (Math_Prime_Util.Primality.Is_Prime (N) /= 0);

   --  goldbach.c commented two-pointer scan over one prime list.
   function Sieved_Pairs (N : U64) return Pair_Vectors.Vector is
      Known : constant Sieve.Prime_Vectors.Vector :=
        Sieve.Primes (3, N - 3);
      Result : Pair_Vectors.Vector;
      Lo : Integer := Integer (Known.First_Index);
      Hi : Integer := Integer (Known.Last_Index);
      P, Q : U64;
   begin
      while Lo <= Hi loop
         P := Known.Element (Natural (Lo));
         Q := Known.Element (Natural (Hi));
         if P = N - Q then
            Result.Append (P);
            Lo := Lo + 1;
            Hi := Hi - 1;
         elsif P < N - Q then
            Lo := Lo + 1;
         else
            Hi := Hi - 1;
         end if;
      end loop;
      return Result;
   end Sieved_Pairs;

   function Walk_Pairs (N : U64) return Pair_Vectors.Vector is
      Result : Pair_Vectors.Vector;
      Step : Int.Optional_U64 := Sieve.Next_Prime (2);
   begin
      while Step.Defined and then Step.Value <= N / 2 loop
         if Is_Prime (N - Step.Value) then
            Result.Append (Step.Value);
         end if;
         Step := Sieve.Next_Prime (Step.Value);
      end loop;
      return Result;
   end Walk_Pairs;

   function Minimal_Goldbach_Pair (N : U64) return Int.Optional_U64 is
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
      Step := Sieve.Next_Prime (2);
      while Step.Defined and then Step.Value <= N / 2 loop
         if Is_Prime (N - Step.Value) then
            return (Defined => True, Value => Step.Value);
         end if;
         Step := Sieve.Next_Prime (Step.Value);
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
      elsif N > Sieve_Limit then
         return Walk_Pairs (N);
      end if;
      return Sieved_Pairs (N);
   end Goldbach_Pairs;

   function Goldbach_Pair_Count (N : U64) return U64 is
     (U64 (Goldbach_Pairs (N).Length));

end Math_Prime_Util.Goldbach;
