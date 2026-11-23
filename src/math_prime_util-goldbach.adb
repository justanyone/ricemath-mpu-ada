with Math_Prime_Util.Primality;

package body Math_Prime_Util.Goldbach is
   use type Math_Prime_Util.Primality.Prime_Result;

   --  families.tsv goldbach_pair_count reaches 60119912. A larger even
   --  argument is walked prime by prime so the sieve is not unbounded.
   Sieve_Limit : constant U64 := 100_000_000;

   function Is_Prime (N : U64) return Boolean is
     (Math_Prime_Util.Primality.Is_Prime (N) /= 0);

   function Contains
     (Known : Sieve.Prime_Vectors.Vector; Q : U64) return Boolean
   is
      Lo : Integer := Integer (Known.First_Index);
      Hi : Integer := Integer (Known.Last_Index);
      Mid : Integer;
   begin
      while Lo <= Hi loop
         Mid := Lo + (Hi - Lo) / 2;
         if Known.Element (Natural (Mid)) = Q then
            return True;
         elsif Known.Element (Natural (Mid)) < Q then
            Lo := Mid + 1;
         else
            Hi := Mid - 1;
         end if;
      end loop;
      return False;
   end Contains;

   function Walk_Pairs (N : U64) return Sieve.Prime_Vectors.Vector is
      Result : Sieve.Prime_Vectors.Vector;
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

   function Sieved_Pairs (N : U64) return Sieve.Prime_Vectors.Vector is
      Half : constant U64 := N / 2;
      Known : constant Sieve.Prime_Vectors.Vector :=
        Sieve.Primes (3, N - 3);
      Result : Sieve.Prime_Vectors.Vector;
   begin
      for P of Known loop
         exit when P > Half;
         if Contains (Known, N - P) then
            Result.Append (P);
         end if;
      end loop;
      return Result;
   end Sieved_Pairs;

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

   function Goldbach_Pairs (N : U64) return Sieve.Prime_Vectors.Vector is
      Result : Sieve.Prime_Vectors.Vector;
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
