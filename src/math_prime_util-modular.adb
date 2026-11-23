with Math_Prime_Util.Errors;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Modular with SPARK_Mode => On is
   use Int;
   use type Primality.Prime_Result;
   Empty : constant Root_List (1 .. 0) := [others => 0];
   Max_Roots : constant := 600_000_000;

   function Mul (A, B, N : U64) return U64 is
     (Mulmod (A, B, N).Value) with Pre => N > 0;
   function Pow (A, K, N : U64) return U64 is
     (Powmod (A, K, N).Value) with Pre => N > 0;
   function Sub (A, B, N : U64) return U64 is
     (Submod (A, B, N).Value) with Pre => N > 0;
   function Reduce (A : I128; N : U64) return U64 is
     (U64 (A mod I128 (N))) with Pre => N > 0;

   procedure Append (List : in out Root_List; Count : in out Natural;
                     R : U64) with Pre => Count < List'Length is
   begin
      Count := Count + 1;
      List (List'First + Count - 1) := R;
   end Append;

   function Sorted (List : Root_List) return Root_List is
      R : Root_List (1 .. List'Length) := List;
      V : U64;
      J : Natural;
   begin
      for I in 2 .. R'Last loop
         V := R (I);
         J := I - 1;
         while J > 0 and then R (J) > V loop
            R (J + 1) := R (J);
            J := J - 1;
         end loop;
         R (J + 1) := V;
      end loop;
      return R;
   end Sorted;

   --  Private trial factorization until the Factor dependency is available.
   --  A prime remainder is recognized before trial division (large prime N).
   function First_Factor (N : U64) return U64 with Pre => N >= 2 is
      P : U64 := 3;
   begin
      if N mod 2 = 0 then
         return 2;
      elsif Primality.Is_Prime (N) /= 0 then
         return N;
      end if;
      while P <= N / P loop
         if N mod P = 0 then
            return P;
         end if;
         P := P + 2;
      end loop;
      return N;
   end First_Factor;

   --  rootmod.c: _sqrtmod_prime, including Atkin and then Tonelli-Shanks.
   function Sqrt_Prime (A, P : U64) return U64
     with Pre => P >= 2 and then A < P
   is
      Q, E, T, Z, R, M, B, X, Alpha, Beta, D : U64;
   begin
      if P = 2 or else A <= 1 then
         return A;
      elsif P mod 4 = 3 then
         return Pow (A, P / 4 + 1, P);
      elsif P mod 8 = 5 then
         T := Mul (2, A, P);
         Alpha := Pow (T, (P - 5) / 8, P);
         Beta := Mul (T, Mul (Alpha, Alpha, P), P);
         return Mul (Alpha, Mul (A, Sub (Beta, 1, P), P), P);
      elsif P mod 16 = 9 then
         T := Mul (2, A, P);
         Alpha := Pow (T, (P - 9) / 16, P);
         Beta := Mul (T, Mul (Alpha, Alpha, P), P);
         D := 1;
         if Mul (Beta, Beta, P) /= P - 1 then
            loop
               D := D + 2;
               exit when Pow (D, (P - 1) / 2, P) = P - 1;
            end loop;
            Alpha := Mul (Alpha, Pow (D, (P - 9) / 8, P), P);
            Beta := Mul (T, Mul (Mul (D, D, P),
                         Mul (Alpha, Alpha, P), P), P);
         end if;
         return Mul (Alpha, Mul (A, Mul (D, Sub (Beta, 1, P), P), P), P);
      end if;
      if Pow (A, (P - 1) / 2, P) /= 1 then
         return 0;
      end if;
      Q := P - 1;
      E := 0;
      while Q mod 2 = 0 loop
         Q := Q / 2;
         E := E + 1;
      end loop;
      T := 3;
      while Pow (T, (P - 1) / 2, P) /= P - 1 loop
         T := T + 2;
      end loop;
      Z := Pow (T, Q, P);
      B := Pow (A, Q, P);
      R := E;
      X := Pow (A, (Q + 1) / 2, P);
      while B /= 1 loop
         T := B;
         M := 0;
         while M < R and then T /= 1 loop
            T := Mul (T, T, P);
            M := M + 1;
         end loop;
         if M >= R then
            return 0;
         end if;
         T := Pow (Z, 2 ** Natural (R - M - 1), P);
         X := Mul (X, T, P);
         Z := Mul (T, T, P);
         B := Mul (B, Z, P);
         R := M;
      end loop;
      return X;
   end Sqrt_Prime;

   --  rootmod.c: _ts_prime, for prime K dividing P-1.
   procedure TS_Prime (A, K, P : U64; X, Z : out U64)
     with Pre => A > 0 and then P > 2 and then K >= 2
   is
      R : U64 := P - 1;
      Ke, B, Y, T, V, C : U64;
   begin
      while R mod K = 0 loop
         R := R / K;
      end loop;
      Ke := (P - 1) / R;
      X := Pow (A, Invmod (K mod R, R).Value, P);
      B := Mul (Pow (X, K, P), Invmod (A, P).Value, P);
      C := 2;
      loop
         V := Pow (C, R, P);
         Y := Pow (V, Ke / K, P);
         exit when Y /= 1;
         C := C + 1;
      end loop;
      while Ke /= K loop
         Ke := Ke / K;
         T := V;
         V := Pow (V, K, P);
         C := Pow (B, Ke / K, P);
         while C /= 1 loop
            X := Mul (X, T, P);
            B := Mul (B, V, P);
            C := Mul (C, Y, P);
         end loop;
      end loop;
      Z := V;
   end TS_Prime;

   function Prime_Roots (A, K, P : U64) return Root_List
     with Pre => P >= 2 and then K >= 2
   is
      V : constant U64 := A mod P;
      X, Z : U64;
   begin
      if P = 2 or else V = 0 then
         return [1 => V];
      elsif K = 2 then
         X := Sqrt_Prime (V, P);
         if Mul (X, X, P) /= V then
            return Empty;
         end if;
         return [X, P - X];
      elsif Gcd (K, P - 1) = 1 then
         return [1 => Pow (V, Invmod (K mod (P - 1), P - 1).Value, P)];
      elsif Pow (V, (P - 1) / K, P) /= 1 then
         return Empty;
      end if;
      TS_Prime (V, K, P, X, Z);
      if K > Max_Roots then
         raise Errors.Maximum_Roots_Exceeded;
      end if;
      declare
         Roots : Root_List (1 .. Natural (K));
      begin
         for I in Roots'Range loop
            Roots (I) := X;
            X := Mul (X, Z, P);
         end loop;
         return Roots;
      end;
   end Prime_Roots;

   --  Hensel lifting: solve the linear congruence for each next base-P digit.
   function Power_Roots (A, K, P : U64; E : Positive) return Root_List
     with Pre => P >= 2 and then K >= 2
   is
      Base : constant Root_List := Prime_Roots (A, K, P);
      function Lift (Roots : Root_List; M : U64; Level : Positive)
                     return Root_List
      is
         Next_M : U64;
         Count : Natural := 0;
      begin
         if Level = E or else Roots'Length = 0 then
            return Roots;
         end if;
         Next_M := M * P;
         --  At most P lifts per root, bounded before allocating storage.
         for R of Roots loop
            declare
               F : constant U64 := Sub (A, Pow (R, K, Next_M), Next_M) / M;
               D : constant U64 := Mul (K, Pow (R, K - 1, P), P);
            begin
               if D /= 0 then
                  Count := Count + 1;
               elsif F = 0 then
                  if P > Max_Roots - U64 (Count) then
                     raise Errors.Maximum_Roots_Exceeded;
                  end if;
                  Count := Count + Natural (P);
               end if;
            end;
         end loop;
         if Count > Max_Roots then
            raise Errors.Maximum_Roots_Exceeded;
         end if;
         declare
            Result : Root_List (1 .. Count);
            Used : Natural := 0;
         begin
            for R of Roots loop
               declare
                  F : constant U64 :=
                    Sub (A, Pow (R, K, Next_M), Next_M) / M;
                  D : constant U64 := Mul (K, Pow (R, K - 1, P), P);
               begin
                  if D /= 0 then
                     Append (Result, Used,
                             R + M * Mul (F, Invmod (D, P).Value, P));
                  elsif F = 0 then
                     for J in U64 range 0 .. P - 1 loop
                        Append (Result, Used, R + M * J);
                     end loop;
                  end if;
               end;
            end loop;
            return Lift (Result, Next_M, Level + 1);
         end;
      end Lift;
   begin
      return Lift (Base, P, 1);
   end Power_Roots;

   --  rootmod.c: _rootmod_cprod, Cartesian product via CRT.
   function Combine (Left, Right : Root_List; M, P : U64)
                     return Root_List
     with Pre => M > 0 and then P > 0
   is
      Inv : constant U64 := Invmod (M, P).Value;
      Count : Natural := 0;
   begin
      if U64 (Left'Length) * U64 (Right'Length) > Max_Roots then
         raise Errors.Maximum_Roots_Exceeded;
      end if;
      declare
         Result : Root_List (1 .. Left'Length * Right'Length);
      begin
         for L of Left loop
            for R of Right loop
               Append (Result, Count, L + M * Mul (Inv, Sub (R, L, P), P));
            end loop;
         end loop;
         return Result;
      end;
   end Combine;

   function Kprime_Roots (A, K, N : U64) return Root_List
     with Pre => N >= 2 and then K >= 2
   is
      P : constant U64 := First_Factor (N);
      M : U64 := P;
      Rest : U64 := N / P;
      E : Positive := 1;
   begin
      while Rest mod P = 0 loop
         Rest := Rest / P;
         M := M * P;
         E := E + 1;
      end loop;
      declare
         Roots : constant Root_List := Power_Roots (A, K, P, E);
      begin
         if Rest = 1 or else Roots'Length = 0 then
            return Roots;
         end if;
         return Combine (Roots, Kprime_Roots (A, K, Rest), M, Rest);
      end;
   end Kprime_Roots;

   function Allrootmod (A, K : I128; N : U64) return Root_List is
      V, Exponent : U64;
      function Split (Values : Root_List; Remaining : U64)
                      return Root_List
      is
         F : U64;
      begin
         if Remaining = 1 or else Values'Length = 0 then
            return Values;
         end if;
         F := First_Factor (Remaining);
         declare
            function Expand (Index : Positive) return Root_List is
            begin
               if Index > Values'Last then
                  return Empty;
               end if;
               declare
                  R : constant Root_List := Kprime_Roots (Values (Index), F, N);
                  Tail : constant Root_List := Expand (Index + 1);
               begin
                  if R'Length > Max_Roots - Tail'Length then
                     raise Errors.Maximum_Roots_Exceeded;
                  end if;
                  return R & Tail;
               end;
            end Expand;
         begin
            return Split (Expand (Values'First), Remaining / F);
         end;
      end Split;
   begin
      if N = 0 then
         return Empty;
      end if;
      V := Reduce (A, N);
      if N = 1 then
         return [1 => 0];
      end if;
      if K < 0 then
         declare
            Inv : constant Optional_U64 := Invmod (V, N);
         begin
            if not Inv.Defined then
               return Empty;
            end if;
            V := Inv.Value;
         end;
      end if;
      Exponent := U64 (abs K);
      if Exponent = 0 then
         if V /= 1 then
            return Empty;
         elsif N > Max_Roots then
            raise Errors.Maximum_Roots_Exceeded;
         end if;
         declare
            R : Root_List (1 .. Natural (N));
         begin
            for I in R'Range loop
               R (I) := U64 (I - 1);
            end loop;
            return R;
         end;
      end if;
      return Sorted (Split ([1 => V], Exponent));
   end Allrootmod;

   function Allsqrtmod (A : I128; N : U64) return Root_List is
   begin
      return Allrootmod (A, 2, N);
   end Allsqrtmod;

   --  rootmod.c: _sqrtmod_prime_power, Newton lifting with gcd division.
   function Sqrt_Power (A, P : U64; E : Natural) return Optional_U64 is
      N : constant U64 := Powint (P, U64 (E)).Value;
      S, R, Np, D, F, G : U64;
      Half : Natural;
      Result : Optional_U64;
   begin
      if E = 0 or else A mod N = 0 then
         return (True, 0);
      elsif E = 1 then
         R := Sqrt_Prime (A mod P, P);
      elsif A mod P = 0 then
         if A / P mod P /= 0 then
            return (Defined => False);
         end if;
         Result := Sqrt_Power (A / P / P, P, E - 2);
         if not Result.Defined then
            return Result;
         end if;
         R := Result.Value * P;
      else
         Half := (if P > 2 or else E < 5 then (E + 1) / 2
                  else (E + 3) / 2);
         Result := Sqrt_Power (A, P, Half);
         if not Result.Defined then
            return Result;
         end if;
         S := Result.Value;
         Np := (if P /= 2 or else N > U64'Last / P then N else N * P);
         F := Sub (A, Mul (S, S, Np), Np);
         D := Mul (2, S, Np);
         G := Gcd (D, N);
         if F mod G /= 0 then
            return (Defined => False);
         end if;
         R := Addmod (S, Mul (F / G, Invmod (D / G, N / G).Value,
                            N / G), N).Value;
      end if;
      R := U64'Min (R, N - R);
      if Mul (R, R, N) /= A mod N then
         return (Defined => False);
      end if;
      return (True, R);
   end Sqrt_Power;

   function Sqrtmod (A : I128; N : U64) return Optional_U64 is
      V : U64;
      function One (Value, Modulus : U64) return Optional_U64 is
         P : constant U64 := First_Factor (Modulus);
         M : U64 := P;
         Rest : U64 := Modulus / P;
         E : Positive := 1;
         X, Y : U64;
         Other : Optional_U64;
      begin
         while Rest mod P = 0 loop
            Rest := Rest / P;
            M := M * P;
            E := E + 1;
         end loop;
         Other := Sqrt_Power (Value, P, E);
         if not Other.Defined then
            return Other;
         end if;
         X := Other.Value;
         if Rest = 1 then
            return (True, X);
         end if;
         Other := One (Value, Rest);
         if not Other.Defined then
            return Other;
         end if;
         Y := Other.Value;
         return (True, X + M * Mul (Invmod (M, Rest).Value,
                                   Sub (Y, X, Rest), Rest));
      end One;
      R : Optional_U64;
   begin
      if N = 0 then
         return (Defined => False);
      end if;
      V := Reduce (A, N);
      if V <= 1 or else Is_Square (V) then
         return (True, Sqrtint (V));
      end if;
      R := One (V, N);
      if R.Defined then
         R.Value := U64'Min (R.Value, N - R.Value);
      end if;
      return R;
   end Sqrtmod;

   --  rootmod.c: _ts_rootmod and then _rootmod_prime_splitk. The logarithm
   --  below is in the subgroup of prime order F, not the full field.
   function Prime_One (A, K, P : U64) return U64 is
      G : constant U64 := Gcd (K, P - 1);
      Remaining : U64 := G;
      V : U64 := A mod P;
      F, E, R, Ke, Y, M, C, T, X, B, L, Z, Log, Power : U64;
   begin
      if V <= 1 or else P = 2 then
         return V;
      elsif K = 2 then
         return Sqrt_Prime (V, P);
      end if;
      while Remaining > 1 loop
         F := First_Factor (Remaining);
         R := P - 1;
         E := 0;
         while R mod F = 0 loop
            R := R / F;
            E := E + 1;
         end loop;
         Ke := (P - 1) / R / F;
         C := 2;
         loop
            Y := Pow (C, R, P);
            M := Pow (Y, Ke, P);
            exit when M /= 1;
            C := C + 1;
         end loop;
         while Remaining mod F = 0 loop
            X := Pow (V, Invmod (F mod R, R).Value, P);
            B := Mul (Pow (X, F, P), Invmod (V, P).Value, P);
            --  Each extraction consumes the generator, so reset it.
            Y := Pow (C, R, P);
            M := Pow (Y, Ke, P);
            declare
               Order_E : U64 := E;
            begin
               while B /= 1 loop
                  L := 1;
                  T := B;
                  Z := T;
                  while T /= 1 loop
                     if L >= Order_E then
                        return 0;
                     end if;
                     Z := T;
                     T := Pow (T, F, P);
                     L := L + 1;
                  end loop;
                  Log := 0;
                  Power := 1;
                  while Power /= Z and then Log < F loop
                     Power := Mul (Power, M, P);
                     Log := Log + 1;
                  end loop;
                  Log := (F - Log) mod F;
                  M := Pow (M, Log, P);
                  T := Pow (Y, Log * Powint (F, Order_E - L).Value, P);
                  Order_E := L - 1;
                  X := Mul (X, T, P);
                  Y := Pow (T, F, P);
                  if Y <= 1 then
                     return 0;
                  end if;
                  B := Mul (B, Y, P);
               end loop;
            end;
            V := X;
            Remaining := Remaining / F;
         end loop;
      end loop;
      if G /= K then
         R := (P - 1) / G;
         V := Pow (V, Invmod ((K / G) mod R, R).Value, P);
      end if;
      return V;
   end Prime_One;

   function Rootmod (A, K : I128; N : U64) return Optional_U64 is
      V, Exponent, X : U64;
      Inv : Optional_U64;
      function Composite_One (Value, Modulus : U64) return Optional_U64 is
         P : constant U64 := First_Factor (Modulus);
         Rest : U64 := Modulus / P;
         M : U64 := P;
         R : U64 := Prime_One (Value, Exponent, P);
         Other : Optional_U64;
         function Lift (Base, Pe : U64) return Optional_U64 is
            F : constant U64 := Sub (Pow (Base, Exponent, Pe), Value, Pe);
            D, Correction : U64;
         begin
            if F = 0 then
               return (True, Base);
            end if;
            D := Mul (Exponent, Pow (Base, Exponent - 1, Pe), Pe);
            if Gcd (D, Pe) /= 1 then
               return (Defined => False);
            end if;
            Correction := Mul (F, Invmod (D, Pe).Value, Pe);
            return (True, Sub (Base, Correction, Pe));
         end Lift;
      begin
         if Pow (R, Exponent, P) /= Value mod P then
            return (Defined => False);
         end if;
         while Rest mod P = 0 loop
            Rest := Rest / P;
            M := M * P;
            Other := Lift (R, M);
            if not Other.Defined then
               --  The same fallback search as _rootmod_composite1.
               declare
                  Base : constant U64 := R mod P;
                  Found : Boolean := False;
               begin
                  for J in U64 range 0 .. M / P - 1 loop
                     R := Base + J * P;
                     if Pow (R, Exponent, M) = Value mod M then
                        Found := True;
                        exit;
                     end if;
                  end loop;
                  if not Found then
                     return (Defined => False);
                  end if;
               end;
            else
               R := Other.Value;
            end if;
         end loop;
         if Rest = 1 then
            return (True, R);
         end if;
         Other := Composite_One (Value, Rest);
         if not Other.Defined then
            return Other;
         end if;
         return (True, R + M * Mul (Invmod (M, Rest).Value,
                                   Sub (Other.Value, R, Rest), Rest));
      end Composite_One;
   begin
      if N = 0 then
         return (Defined => False);
      elsif K = 2 then
         return Sqrtmod (A, N);
      end if;
      V := Reduce (A, N);
      if K < 0 then
         Inv := Invmod (V, N);
         if not Inv.Defined then
            return Inv;
         end if;
         V := Inv.Value;
      end if;
      Exponent := U64 (abs K);
      if Exponent = 2 then
         return Sqrtmod (I128 (V), N);
      end if;
      if N <= 2 or else V <= 1 then
         X := V;
      elsif Exponent <= 1 then
         X := (if Exponent = 0 then 1 else V);
      elsif Exponent < 64 and then Is_Power (V, Exponent) then
         X := Rootint (V, Exponent);
      elsif Primality.Is_Prime (N) /= 0 then
         X := Prime_One (V, Exponent, N);
      else
         Inv := Composite_One (V, N);
         if not Inv.Defined then
            return Inv;
         end if;
         X := Inv.Value;
      end if;
      if Pow (X, Exponent, N) /= V then
         return (Defined => False);
      end if;
      return (True, X);
   end Rootmod;

   function Cornacchia (D, N : U64) return Cornacchia_Result is
      A, B, T, Limit : U64;
      Root : Optional_U64;
   begin
      if N = 0 then
         return (True, 0, 0);
      elsif D = 0 then
         if Is_Square (N) then
            return (True, Sqrtint (N), 0);
         end if;
         return (Defined => False);
      elsif Primality.Is_Prime (N) /= 0 then
         Root := Sqrtmod (-I128 (D), N);
         if not Root.Defined then
            return (Defined => False);
         end if;
         A := N;
         B := Root.Value;
         Limit := Sqrtint (N);
         while B > Limit loop
            T := A mod B;
            A := B;
            B := T;
         end loop;
         T := N - B * B;
         if T mod D = 0 and then Is_Square (T / D) then
            return (True, B, Sqrtint (T / D));
         end if;
         return (Defined => False);
      end if;
      Limit := Sqrtint (N / D);
      for Y in U64 range 0 .. Limit loop
         T := N - D * Y * Y;
         if Is_Square (T) then
            return (True, Sqrtint (T), Y);
         end if;
      end loop;
      return (Defined => False);
   end Cornacchia;
end Math_Prime_Util.Modular;
