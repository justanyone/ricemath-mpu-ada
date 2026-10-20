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
      Row, Next : array (Natural range 0 .. 26) of U128 := [others => 0];
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
end Math_Prime_Util.Combinat;
