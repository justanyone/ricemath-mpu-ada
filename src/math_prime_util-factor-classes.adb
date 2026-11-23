with Math_Prime_Util.Int;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Factor.Classes is
   use type U128;
   use type Primality.Prime_Result;

   Small : constant array (Positive range <>) of U64 :=
     [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43];

   function Is_Carmichael (N : U64) return Boolean is
      F : Factor_List;
   begin
      if N < 561 or else N mod 2 = 0 then
         return False;
      end if;
      for P of Small loop
         if P <= 13 and then N mod (P * P) = 0 then
            return False;
         end if;
         if N mod P = 0 and then (N - 1) mod (P - 1) /= 0 then
            return False;
         end if;
      end loop;
      if N > 5_000_000 and then not Primality.Is_Pseudoprime (N, 2) then
         return False;
      end if;
      F := Factor (N);
      if F.Count < 3 then
         return False;
      end if;
      for I in 1 .. F.Count loop
         if (I > 1 and then F.Value (I) = F.Value (I - 1))
           or else (N - 1) mod (F.Value (I) - 1) /= 0
         then
            return False;
         end if;
      end loop;
      return True;
   end Is_Carmichael;

   function Is_Quasi_Carmichael (N : U64) return U64 is
      F : Factor_List;
      Bases : U64 := 0;
      First, Last, Limit : U64;
      function Is_Base (B : U64) return Boolean is
         D : U64;
      begin
         for I in 1 .. F.Count loop
            --  MPU encodes negative bases in UV. Modular subtraction is
            --  intentional here and in Last - D below, matching util.c.
            D := F.Value (I) - B;
            if D = 0 or else (N - B) mod D /= 0 then
               return False;
            end if;
         end loop;
         return True;
      end Is_Base;
   begin
      if N < 35 then
         return 0;
      end if;
      F := Factor (N);
      if F.Count < 2 then
         return 0;
      end if;
      for I in 2 .. F.Count loop
         if F.Value (I) = F.Value (I - 1) then
            return 0;
         end if;
      end loop;
      First := F.Value (1);
      Last := F.Value (F.Count);
      Limit := (if F.Count = 2 then N / First - 1 else N - Last);
      declare
         Divs : constant U64_Vectors.Vector := Divisors (Limit);
         D, B : U64;
      begin
         for I in 1 .. Natural (Divs.Length) loop
            D := Divs.Element (I);
            if F.Count = 2 then
               exit when D >= First;
               B := First - D;
            else
               B := Last - D;
            end if;
            if not (F.Count > 2 and then Last > D and then B >= First)
              and then B /= 0 and then Is_Base (B)
            then
               Bases := Bases + 1;
            end if;
         end loop;
      end;
      return Bases;
   end Is_Quasi_Carmichael;

   function Is_Cyclic (N : U64) return Boolean is
      F : Factor_List;
      Phi : U64 := 1;
   begin
      if N < 4 then
         return N /= 0;
      elsif N mod 2 = 0 then
         return False;
      end if;
      F := Factor (N);
      for I in 1 .. F.Count loop
         if I > 1 and then F.Value (I) = F.Value (I - 1) then
            return False;
         end if;
         Phi := Phi * (F.Value (I) - 1);
      end loop;
      return Int.Gcd (N, Phi) = 1;
   end Is_Cyclic;

   function Is_Perfect_Number (N : U64) return Boolean is
      M : U64 := N;
      V : Natural := 0;
   begin
      if N = 0 or else N mod 2 = 1 then
         return False;
      end if;
      while M mod 2 = 0 loop
         M := M / 2;
         V := V + 1;
      end loop;
      return (M and (M + 1)) = 0 and then M / 2 ** V = 1
        and then Primality.Is_Mersenne_Prime (U64 (V + 1));
   end Is_Perfect_Number;

   function Is_Practical (N : U64) return Boolean is
      F : Factor_List;
      Prod : U128 := 1;
      Power, Sum : U128;
      I : Positive := 1;
   begin
      if N = 0 or else N mod 2 = 1 then
         return N = 1;
      end if;
      F := Factor (N);
      while I <= F.Count loop
         if U128 (F.Value (I)) > Prod + 1 then
            return False;
         end if;
         Power := U128 (F.Value (I));
         Sum := 1 + Power;
         while I < F.Count and then F.Value (I + 1) = F.Value (I) loop
            Power := Power * U128 (F.Value (I));
            Sum := Sum + Power;
            I := I + 1;
         end loop;
         --  Sigma of a U64 fits U128; using UV as in C can wrap here.
         Prod := Prod * Sum;
         I := I + 1;
      end loop;
      return True;
   end Is_Practical;

   function Is_Smooth (N, K : U64) return Boolean is
      M : U64 := N;
      F : Factor_List;
   begin
      if M <= 1 then
         return True;
      elsif K <= 1 then
         return False;
      elsif M <= K then
         return True;
      elsif K = 2 then
         return (M and (M - 1)) = 0;
      end if;
      while M mod 2 = 0 loop
         M := M / 2;
      end loop;
      if M <= K then
         return True;
      end if;
      --  SMOOTH_TEST, trial primes through 997, then the C trial bounds.
      declare
         Primes : constant Sieve.Prime_Vectors.Vector :=
           Sieve.Primes (3, 1_009);
         P, Next : U64;
      begin
         for I in Primes.First_Index .. Primes.Last_Index - 1 loop
            P := Primes.Element (I);
            Next := Primes.Element (I + 1);
            if M < P * P then
               return M <= K;
            end if;
            while M mod P = 0 loop
               M := M / P;
            end loop;
            if M < Next then
               return True;
            elsif K < Next then
               return M <= K;
            end if;
         end loop;
      end;
      if Primality.Is_Prime (M) /= Primality.Composite then
         return False;
      end if;
      F := Trial_Factor (M, (if K <= 290_000 then K else 4_999));
      M := F.Value (F.Count);
      if K <= 290_000 or else M < 5_003 * 5_003 then
         return M <= K;
      end if;
      F := Factor (M);
      return F.Value (F.Count) <= K;
   end Is_Smooth;

   function Is_Rough (N, K : U64) return Boolean is
      F : Factor_List;
      M : U64 := N;
   begin
      if N = 0 then
         return K = 0;
      elsif N = 1 or else K <= 2 then
         return True;
      elsif K > N then
         return False;
      elsif K = 3 then
         return N mod 2 = 1;
      elsif N mod 2 = 0 or else N mod 3 = 0 then
         return False;
      elsif K <= 5 then
         return True;
      elsif N mod 5 = 0 then
         return False;
      elsif K > Int.Sqrtint (N) then
         return Primality.Is_Prime (N) /= Primality.Composite;
      end if;
      F := Trial_Factor (N, (if K <= 2_500 then K else 200));
      if K <= 2_500 then
         return F.Value (1) >= K;
      elsif F.Count > 1 and then F.Value (F.Count - 1) <= K then
         return False;
      end if;
      M := F.Value (F.Count);
      if M < K then
         return False;
      elsif M >= 2 ** 36 then
         if Primality.Is_Prime (M) /= Primality.Composite then
            return True;
         end if;
         F := Pminus1_Factor (M, 500, 500);
         if F.Count > 1 then
            for I in 1 .. F.Count loop
               declare
                  Part : constant Factor_List := Factor (F.Value (I));
               begin
                  if Part.Value (1) < K then
                     return False;
                  end if;
               end;
            end loop;
            return True;
         end if;
      end if;
      F := Factor (M);
      return F.Value (1) >= K;
   end Is_Rough;

   Cache_7 : constant array (Natural range <>) of U64 :=
     [8, 9, 10, 10, 11, 11, 12, 13, 14, 14, 15, 15, 16, 17, 17, 17, 18, 19, 
      19, 20, 21, 21, 22, 22, 23, 23, 23, 24, 25, 25, 25, 25, 26, 26, 27, 
      27, 27, 28, 28, 28, 29, 30, 31, 31, 31, 31, 32, 32, 33, 33, 33, 33, 
      34, 34, 34, 35, 36, 36, 36, 36, 36, 36, 37, 37, 38, 38, 38, 39, 39, 
      39, 39, 39, 40, 41, 41, 41, 42, 42, 42, 42, 42, 42, 43, 43, 43, 43, 
      43, 43, 44, 44, 45, 45, 46, 46, 46, 46, 46, 47, 47, 47, 48, 48, 48, 
      48, 49, 49, 49, 49, 49, 49, 49, 49, 50, 50, 50, 50, 50, 51, 52, 52, 
      53, 53, 53, 53, 53, 53, 53, 54];

   Cache_11 : constant array (Natural range <>) of U64 :=
     [12, 12, 13, 14, 15, 15, 16, 16, 17, 18, 19, 19, 20, 21, 21, 22, 23, 
      23, 24, 24, 25, 26, 26, 27, 28, 28, 28, 28, 29, 29, 30, 30, 31, 32, 
      32, 32, 33, 34, 35, 35, 35, 35, 36, 37, 38, 38, 38, 38, 39, 39, 39, 
      40, 41, 41, 42, 42, 42, 42, 43, 43, 44, 44, 44, 45, 45, 46, 46, 46, 
      47, 48, 48, 48, 49, 49, 49, 49, 50, 50, 51, 51, 51, 51, 51, 51, 52, 
      52, 53, 54, 55, 55, 55, 55, 55, 56, 56, 56];

   Cache_13 : constant array (Natural range <>) of U64 :=
     [14, 15, 16, 16, 17, 17, 18, 19, 20, 20, 21, 22, 23, 24, 25, 25, 26, 
      26, 27, 28, 28, 29, 30, 30, 30, 31, 32, 32, 33, 33, 34, 35, 35, 35, 
      36, 37, 38, 38, 39, 39, 40, 41, 42, 42, 42, 42, 43, 43, 43, 44, 45, 
      46, 47, 47, 47, 47, 48, 48, 49, 49, 49, 50, 50, 51];

   X_Table : constant array (Natural range <>) of U64 :=
     [19, 23, 29, 31, 37, 38, 41, 43, 46, 47, 53, 57, 58, 59, 61, 62, 67, 
      69, 71, 73, 74, 76, 79, 82, 83, 86, 87, 89, 92, 93, 94, 95, 97, 101, 
      103, 106, 107, 109, 111, 113, 114, 115, 116, 118, 122, 123, 124, 
      127];

   Y_Table : constant array (Natural range <>) of U64 :=
     [19, 23, 29, 31, 37, 19, 41, 43, 23, 47, 53, 19, 29, 59, 61, 31, 67, 
      23, 71, 73, 37, 19, 79, 41, 83, 43, 29, 89, 23, 31, 47, 19, 97, 101, 
      103, 53, 107, 109, 37, 113, 19, 23, 29, 59, 61, 41, 31, 127];

   function Log2_Floor (N : U64) return U64 is
      M : U64 := N;
      R : U64 := 0;
   begin
      while M > 1 loop
         M := M / 2;
         R := R + 1;
      end loop;
      return R;
   end Log2_Floor;

   function Smooth_Count (N, K : U64) return U64 is
      Y : U64 := K;
      Sum, X3, X5 : U64;
   begin
      if N = 0 then
         return 0;
      elsif Y <= 1 then
         return 1;
      elsif Y >= N then
         return N;
      elsif Y = 2 then
         return 1 + Log2_Floor (N);
      end if;
      if Y mod 2 = 0 then
         Y := Y - 1;
      end if;
      if Y = 7 and then N - 7 <= 128 then
         return Cache_7 (Natural (N - 8));
      elsif Y = 11 and then N - 11 <= 96 then
         return Cache_11 (Natural (N - 12));
      elsif Y = 13 and then N - 13 <= 64 then
         return Cache_13 (Natural (N - 14));
      elsif Y >= 17 and then N <= 128 then
         Sum := N;
         for I in X_Table'Range loop
            exit when N < X_Table (I);
            if Y < Y_Table (I) then
               Sum := Sum - 1;
            end if;
         end loop;
         return Sum;
      end if;
      Sum := 1 + Log2_Floor (N);
      X3 := N / 3;
      while X3 > 3 loop
         Sum := Sum + 1 + Log2_Floor (X3);
         X3 := X3 / 3;
      end loop;
      Sum := Sum + X3;
      if Y >= 5 then
         X5 := N / 5;
         while X5 > 5 loop
            Sum := Sum + 1 + Log2_Floor (X5);
            X3 := X5 / 3;
            while X3 > 3 loop
               Sum := Sum + 1 + Log2_Floor (X3);
               X3 := X3 / 3;
            end loop;
            Sum := Sum + X3;
            X5 := X5 / 5;
         end loop;
         Sum := Sum + X5;
      end if;
      declare
         Primes : constant Sieve.Prime_Vectors.Vector :=
           Sieve.Primes (7, Y);
         P, XP : U64;
      begin
         for I in Primes.First_Index .. Primes.Last_Index loop
            P := Primes.Element (I);
            XP := N / P;
            Sum := Sum + (if P >= XP then XP else Smooth_Count (XP, P));
         end loop;
      end;
      return Sum;
   end Smooth_Count;

   function Rough_Count (N, K : U64) return U64 is
   begin
      if N = 0 or else K <= 2 then
         return N;
      elsif K <= 3 then
         return N - N / 2;
      elsif K <= 5 then
         return N - N / 2 - N / 3 + N / 6;
      elsif K > N then
         return 1;
      end if;
      declare
         --  Legendre's recurrence with exactly the primes below K.
         Primes : constant Sieve.Prime_Vectors.Vector :=
           Sieve.Primes (K - 1);
         function Phi (X : U64; A : Natural) return U64 is
            P : U64;
         begin
            if X = 0 or else A = 0 then
               return X;
            end if;
            P := Primes.Element (A - 1);
            if X < P then
               return 1;
            elsif A = 1 then
               return X - X / 2;
            end if;
            return Phi (X, A - 1) - Phi (X / P, A - 1);
         end Phi;
      begin
         return Phi (N, Natural (Primes.Length));
      end;
   end Rough_Count;
end Math_Prime_Util.Factor.Classes;
