with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

--  Pair lists use vectors, so this body is outside the SPARK subset.
package body Math_Prime_Util.Goldbach with SPARK_Mode => Off is
   use type Math_Prime_Util.Primality.Prime_Result;

   --  families.tsv goldbach_pair_count reaches 60119912. Larger even
   --  arguments are walked prime by prime so the sieve stays bounded.
   Sieve_Limit : constant U64 := 100_000_000;

   function Is_Prime (N : U64) return Boolean is
     (Math_Prime_Util.Primality.Is_Prime (N) /= 0);

   function Sieved_Pairs (N : U64) return Pair_Vectors.Vector;
   function Walk_Pairs (N : U64) return Pair_Vectors.Vector;

   --  goldbach.c commented two-pointer scan over one prime list.
   --  Both members are at least 3, so 2 is not in the list.
   function Sieved_Pairs (N : U64) return Pair_Vectors.Vector is
      Known : constant Sieve.Prime_Vectors.Vector :=
        Sieve.Primes (3, N - 3);
      Result : Pair_Vectors.Vector;
      Lo : Natural;
      Hi : Natural;
      P, Q : U64;
   begin
      if Known.Is_Empty then
         return Result;
      end if;
      Lo := Known.First_Index;
      Hi := Known.Last_Index;
      while Lo <= Hi loop
         P := Known.Element (Lo);
         Q := Known.Element (Hi);
         if P = N - Q then
            Result.Append (P);
            exit when Lo = Hi;
            Lo := Lo + 1;
            Hi := Hi - 1;
         elsif P < N - Q then
            Lo := Lo + 1;
         else
            exit when Lo = Hi;
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

   function Odd_Or_Four (N : U64) return Pair_Vectors.Vector is
      Result : Pair_Vectors.Vector;
   begin
      if Is_Prime (N - 2) then
         Result.Append (2);
      end if;
      return Result;
   end Odd_Or_Four;

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
   begin
      if N < 4 then
         return Pair_Vectors.Empty_Vector;
      elsif N mod 2 = 1 or else N = 4 then
         return Odd_Or_Four (N);
      elsif N > Sieve_Limit then
         return Walk_Pairs (N);
      end if;
      return Sieved_Pairs (N);
   end Goldbach_Pairs;

   function Goldbach_Pair_Count (N : U64) return U64 is
     (U64 (Goldbach_Pairs (N).Length));

end Math_Prime_Util.Goldbach;
