with Math_Prime_Util.Errors;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Modular with SPARK_Mode => On is
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
                     R : U64) with Pre => Count < List'Length;
   procedure Append (List : in out Root_List; Count : in out Natural;
                     R : U64) is
   begin
      Count := Count + 1;
      List (List'First + Count - 1) := R;
   end Append;

   function Sorted (List : Root_List) return Root_List;
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
   function First_Factor (N : U64) return U64 with Pre => N >= 2;
   function First_Factor (N : U64) return U64 is
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
     with Pre => P >= 2 and then A < P;
   function Sqrt_Prime (A, P : U64) return U64 is
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
     with Pre => A > 0 and then P > 2 and then K >= 2;
   procedure TS_Prime (A, K, P : U64; X, Z : out U64) is
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
     with Pre => P >= 2 and then K >= 2;
   function Prime_Roots (A, K, P : U64) return Root_List is
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
     with Pre => P >= 2 and then K >= 2;
   function Power_Roots (A, K, P : U64; E : Positive) return Root_List is
      Base : constant Root_List := Prime_Roots (A, K, P);
      function Lift (Roots : Root_List; M : U64; Level : Positive)
                     return Root_List;
      function Lift (Roots : Root_List; M : U64; Level : Positive)
                     return Root_List is
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
     with Pre => M > 0 and then P > 0;
   function Combine (Left, Right : Root_List; M, P : U64)
                     return Root_List is
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
     with Pre => N >= 2 and then K >= 2;
   function Kprime_Roots (A, K, N : U64) return Root_List is
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
                      return Root_List;
      function Split (Values : Root_List; Remaining : U64)
                      return Root_List is
         F : U64;
      begin
         if Remaining = 1 or else Values'Length = 0 then
            return Values;
         end if;
         F := First_Factor (Remaining);
         declare
            function Expand (Index : Positive) return Root_List;
            function Expand (Index : Positive) return Root_List is
            begin
               if Index > Values'Last then
                  return Empty;
               end if;
               declare
                  R : constant Root_List :=
                    Kprime_Roots (Values (Index), F, N);
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
   function Sqrt_Power (A, P : U64; E : Natural) return Optional_U64;
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
         G := Gcd (F, D);
         Result := Invmod (D / G, N);
         if not Result.Defined then
            return (Defined => False);
         end if;
         R := Addmod (S, Mul (F / G, Result.Value, N), N).Value;
      end if;
      R := U64'Min (R, N - R);
      if Mul (R, R, N) /= A mod N then
         return (Defined => False);
      end if;
      return (True, R);
   end Sqrt_Power;

   function Sqrtmod (A : I128; N : U64) return Optional_U64 is
      V : U64;
      function One (Value, Modulus : U64) return Optional_U64;
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
   function Prime_One (A, K, P : U64) return U64;
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
      function Composite_One (Value, Modulus : U64) return Optional_U64;
      function Composite_One (Value, Modulus : U64) return Optional_U64 is
         P : constant U64 := First_Factor (Modulus);
         Rest : U64 := Modulus / P;
         M : U64 := P;
         R : U64 := Prime_One (Value, Exponent, P);
         Other : Optional_U64;
         function Lift (Base, Pe : U64) return Optional_U64;
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
               --  _rootmod_composite1 tries nearby base roots first.
               for J in U64 range 1 .. P - 1 loop
                  Other := Lift (R + J * (M / P / P), M);
                  exit when Other.Defined;
               end loop;
               if Other.Defined then
                  R := Other.Value;
               else
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
               end if;
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
      if Exponent = 2 then
         X := U64'Min (X, N - X);
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
      --  util.c: corn_all. On large composites, try modular roots first.
      if N >= 2 ** 53 then
         declare
            Roots : constant Root_List := Allsqrtmod (-I128 (D), N);
         begin
            for I in 1 .. Roots'Length / 2 loop
               A := N;
               B := U64'Max (Roots (I), N - Roots (I));
               Limit := Sqrtint (N);
               while B > Limit loop
                  T := A mod B;
                  A := B;
                  B := T;
               end loop;
               T := N - B * B;
               if T > 0 and then T mod D = 0 and then Is_Square (T / D) then
                  return (True, B, Sqrtint (T / D));
               end if;
            end loop;
         end;
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

   function Add (A, B, M : U64) return U64
     is (U64 ((U128 (A) + U128 (B)) mod U128 (M)))
     with Pre => M > 0, Post => Add'Result < M;

   function Power (A, E, M : U64) return U64
     is (Powmod (A, E, M).Value)
     with Pre => M > 0, Post => Power'Result < M;

   subtype Factor_Count is Natural range 0 .. 64;
   type Factor_Array is array (Positive range 1 .. 64) of U64;
   type Factors is record
      Count : Factor_Count := 0;
      Values : Factor_Array := [others => 0];
   end record;

   --  Local factorization support until the factor package is available.
   --  Deterministic rho restarts have no shared random or mutable state.
   function Split (N : U64) return U64
     with Pre => N > 1;

   function Split (N : U64) return U64 is
      X, Y, D, C : U64;
   begin
      if N mod 2 = 0 then
         return 2;
      end if;
      C := 1;
      loop
         X := 2;
         Y := 2;
         D := 1;
         for Iteration in 1 .. 200_000 loop
            X := Add (Mul (X, X, N), C, N);
            Y := Add (Mul (Y, Y, N), C, N);
            Y := Add (Mul (Y, Y, N), C, N);
            D := Gcd ((if X > Y then X - Y else Y - X), N);
            exit when D /= 1;
         end loop;
         if D > 1 and then D < N then
            return D;
         end if;
         C := (if C = N - 1 then 1 else C + 1);
      end loop;
   end Split;

   procedure Factor_Into (N : U64; F : in out Factors)
     with Pre => N > 0;

   procedure Factor_Into (N : U64; F : in out Factors)
   is
      D : U64;
   begin
      if N = 1 then
         return;
      elsif Primality.Is_Prime (N) /= 0 then
         F.Count := F.Count + 1;
         F.Values (F.Count) := N;
      else
         D := Split (N);
         Factor_Into (D, F);
         Factor_Into (N / D, F);
      end if;
   end Factor_Into;

   function Factorize (N : U64) return Factors
     with Pre => N > 0;

   function Factorize (N : U64) return Factors
   is
      F : Factors;
      V : U64;
      J : Natural;
   begin
      Factor_Into (N, F);
      for I in 2 .. F.Count loop
         V := F.Values (I);
         J := I;
         while J > 1 and then F.Values (J - 1) > V loop
            F.Values (J) := F.Values (J - 1);
            J := J - 1;
         end loop;
         F.Values (J) := V;
      end loop;
      return F;
   end Factorize;

   function Factorialmod (N, M : U64) return Optional_U64 is
      D : U64 := N;
      R : U64 := 1;
      Backwards : Boolean := False;
      Prime : Boolean;
      F : Factors;
      Bound, Current, Previous : U64 := 0;
   begin
      if M = 0 then
         return (Defined => False);
      elsif M = 1 or else N >= M then
         return (True, 0);
      elsif N <= 1 then
         return (True, 1);
      end if;
      --  factmod.c: Wilson's theorem shortens products near a prime M.
      Prime := Primality.Is_Prime (M) /= 0;
      if N > M / 2 and then Prime then
         D := M - N - 1;
         Backwards := True;
      end if;
      if D > 100 and then not Prime then
         --  factmod.c: max(p*e) bounds the Kempner number of M.
         F := Factorize (M);
         for I in 1 .. F.Count loop
            if F.Values (I) = Previous then
               Current := Current + Previous;
            else
               Previous := F.Values (I);
               Current := Previous;
            end if;
            Bound := U64'Max (Bound, Current);
         end loop;
         if N >= Bound then
            return (True, 0);
         end if;
      end if;
      for I in U64 range 2 .. D loop
         R := Mul (R, I, M);
         exit when R = 0;
      end loop;
      if Backwards then
         if D mod 2 = 0 then
            R := M - R;
         end if;
         return Invmod (R, M);
      end if;
      return (True, R);
   end Factorialmod;

   --  factmod.c: _factorial_valuation, _factorialmod_without_prime,
   --  _factorialmod_without_prime_powers. N may be a transformed signed
   --  binomial input with 65 bits; residues remain native.
   function Valuation (N : U128; P : U64) return U128
     with Pre => P >= 2;

   function Valuation (N : U128; P : U64) return U128
   is
      T : U128 := N;
      R : U128 := 0;
   begin
      while T >= U128 (P) loop
         T := T / U128 (P);
         R := R + T;
      end loop;
      return R;
   end Valuation;

   function Unit_Factorial (N : U128; P, M : U64) return U64
     with Pre => P >= 2 and then M >= P;

   function Unit_Factorial (N : U128; P, M : U64) return U64
   is
      T : U128 := N;
      R : U64 := 1;
      Tail : U64;
   begin
      while T > 1 loop
         if (T / U128 (M)) mod 2 = 1 and then (P > 2 or else M = 4) then
            R := M - R;
         end if;
         Tail := U64 (T mod U128 (M));
         for I in U64 range 2 .. Tail loop
            if I mod P /= 0 then
               R := Mul (R, I, M);
            end if;
         end loop;
         T := T / U128 (P);
      end loop;
      return R;
   end Unit_Factorial;

   function Binomial_Prime_Power
     (N, K : U128; P, M : U64; E : Positive) return U64
     with Pre => K <= N and then P >= 2 and then M >= P;

   function Binomial_Prime_Power
     (N, K : U128; P, M : U64; E : Positive) return U64
   is
      B : constant U128 := Valuation (N, P) - Valuation (K, P)
        - Valuation (N - K, P);
      L : constant U128 := U128'Min (K, N - K);
      Num : U64 := 1;
      Den : U64 := 1;
      T, S : U128;
   begin
      if B >= U128 (E) then
         return 0;
      end if;
      --  Avoid traversing a huge prime modulus for small K.
      if L < U128 (M) then
         for I in U64 range 1 .. U64 (L) loop
            T := N - L + U128 (I);
            S := U128 (I);
            while T mod U128 (P) = 0 loop
               T := T / U128 (P);
            end loop;
            while S mod U128 (P) = 0 loop
               S := S / U128 (P);
            end loop;
            Num := Mul (Num, U64 (T mod U128 (M)), M);
            Den := Mul (Den, U64 (S mod U128 (M)), M);
         end loop;
      else
         Num := Unit_Factorial (N, P, M);
         Den := Mul (Unit_Factorial (K, P, M),
                     Unit_Factorial (N - K, P, M), M);
      end if;
      return Mul (Mul (Num, Invmod (Den, M).Value, M),
                  Power (P, U64 (B), M), M);
   end Binomial_Prime_Power;

   function Binomialmod (N, K : I128; M : U64) return Optional_U64 is
      NN : I128 := N;
      KK : I128 := K;
      Negative : Boolean := False;
      F : Factors;
      I : Positive := 1;
      E : Positive;
      P, Q, R, Difference, X : U64;
      Product : U64 := 1;
      Result : U64 := 0;
   begin
      if M = 0 then
         return (Defined => False);
      elsif M = 1 then
         return (True, 0);
      end if;
      --  MPU's signed binomial convention reflects negative K first.
      if KK < 0 then
         if NN >= 0 or else KK > NN then
            return (True, 0);
         end if;
         KK := NN - KK;
      end if;
      if NN < 0 then
         Negative := KK mod 2 /= 0;
         NN := -NN + KK - 1;
      end if;
      if KK > NN then
         return (True, 0);
      elsif KK = 0 or else KK = NN then
         return (True, (if Negative then M - 1 else 1));
      end if;
      F := Factorize (M);
      while I <= F.Count loop
         P := F.Values (I);
         Q := P;
         E := 1;
         I := I + 1;
         while I <= F.Count and then F.Values (I) = P loop
            Q := Q * P;
            E := E + 1;
            I := I + 1;
         end loop;
         R := Binomial_Prime_Power (U128 (NN), U128 (KK), P, Q, E);
         --  Incremental CRT, with exact 128-bit intermediates.
         Difference := Submod (R, Result mod Q, Q).Value;
         X := Mul (Difference, Invmod (Product mod Q, Q).Value, Q);
         Result := U64 (U128 (Result) + U128 (Product) * U128 (X));
         Product := Product * Q;
      end loop;
      if Negative and then Result /= 0 then
         Result := M - Result;
      end if;
      return (True, Result);
   end Binomialmod;

   --  znlog.c: baby-step/giant-step search, with a bounded local table.
   --  Capping the width bounds memory, not the exponent search space.
   function Baby_Giant (A, G, M, Order : U64) return Optional_U64
     with Pre => M > 1 and then Order > 0;

   function Baby_Giant (A, G, M, Order : U64) return Optional_U64
   is
      Table_Size : constant := 131_071;
      subtype Slot is Natural range 0 .. Table_Size - 1;
      type Table_Entry is record
         Key, Exponent : U64 := 0;
         Used : Boolean := False;
      end record;
      type Table_Array is array (Slot) of Table_Entry;
      Table : Table_Array := [others => (0, 0, False)];
      Width : constant U64 := U64'Min (Sqrtint (Order) + 1, 65_536);
      V : U64 := 1;
      H : Slot;
      Step : U64;
      Inverse : Optional_U64;
      Candidate : U128;
   begin
      for J in U64 range 0 .. Width - 1 loop
         H := Slot (V mod Table_Size);
         while Table (H).Used and then Table (H).Key /= V loop
            H := (if H = Slot'Last then 0 else H + 1);
         end loop;
         if not Table (H).Used then
            Table (H) := (V, J, True);
         end if;
         V := Mul (V, G, M);
      end loop;
      Inverse := Invmod (V, M);
      if not Inverse.Defined then
         return (Defined => False);
      end if;
      Step := Inverse.Value;
      V := A;
      for I in U64 range 0 .. (Order - 1) / Width loop
         H := Slot (V mod Table_Size);
         while Table (H).Used loop
            if Table (H).Key = V then
               Candidate := U128 (I) * U128 (Width)
                 + U128 (Table (H).Exponent);
               if Candidate < U128 (Order) then
                  return (True, U64 (Candidate));
               end if;
            end if;
            H := (if H = Slot'Last then 0 else H + 1);
         end loop;
         V := Mul (V, Step, M);
      end loop;
      return (Defined => False);
   end Baby_Giant;

   function Group_Order (G, M : U64) return U64
     with Pre => M > 1 and then Gcd (G, M) = 1;

   function Group_Order (G, M : U64) return U64
   is
      F : Factors := Factorize (M);
      Phi, Component, P : U64;
      I : Positive := 1;
      E : Natural;
   begin
      --  util.c: znorder, Cohen 1.4.3 starts at Carmichael lambda.
      Phi := 1;
      while I <= F.Count loop
         P := F.Values (I);
         Component := 1;
         E := 0;
         while I <= F.Count and then F.Values (I) = P loop
            if E > 0 then
               Component := Component * P;
            end if;
            E := E + 1;
            I := I + 1;
         end loop;
         Component := Component * (P - 1);
         if P = 2 and then E > 2 then
            Component := Component / 2;
         end if;
         Phi := Phi / Gcd (Phi, Component) * Component;
      end loop;
      F := Factorize (Phi);
      for I in 1 .. F.Count loop
         if Power (G, Phi / F.Values (I), M) = 1 then
            Phi := Phi / F.Values (I);
         end if;
      end loop;
      return Phi;
   end Group_Order;

   --  znlog.c: znlog_ph, znlog_prime_power (Pohlig-Hellman digits).
   function Pohlig_Hellman (A, G, M, Order : U64) return Optional_U64
     with Pre => M > 1 and then Order > 0 and then Gcd (G, M) = 1;

   function Pohlig_Hellman (A, G, M, Order : U64) return Optional_U64
   is
      F : constant Factors := Factorize (Order);
      I : Positive := 1;
      Q, QE, Base, X, Digit_Power, H, Difference, T : U64;
      R : U64 := 0;
      Product : U64 := 1;
      Digit : Optional_U64;
      Inverse_G : constant U64 := Invmod (G, M).Value;
   begin
      while I <= F.Count loop
         Q := F.Values (I);
         QE := 1;
         X := 0;
         Base := Power (G, Order / Q, M);
         while I <= F.Count and then F.Values (I) = Q loop
            Digit_Power := QE;
            QE := QE * Q;
            H := Power (Mul (A, Power (Inverse_G, X, M), M),
                        Order / QE, M);
            Digit := Baby_Giant (H, Base, M, Q);
            if not Digit.Defined then
               return (Defined => False);
            end if;
            X := X + Digit.Value * Digit_Power;
            I := I + 1;
         end loop;
         Difference := Submod (X, R mod QE, QE).Value;
         T := Mul (Difference, Invmod (Product mod QE, QE).Value, QE);
         R := U64 (U128 (R) + U128 (Product) * U128 (T));
         Product := Product * QE;
      end loop;
      if Power (G, R, M) /= A then
         return (Defined => False);
      end if;
      return (True, R);
   end Pohlig_Hellman;

   function Znlog (A, G, M : U64) return Optional_U64 is
      Target, Base, Modulus, D, Accumulator, Offset, V, Order : U64;
      R : Optional_U64;
   begin
      if M = 0 then
         return (Defined => False);
      elsif M = 1 then
         return (True, 0);
      end if;
      Target := A mod M;
      Base := G mod M;
      --  Short exponents also avoid expensive order computations.
      V := 1;
      for I in U64 range 0 .. U64'Min (65_535, M) loop
         if V = Target then
            return (True, I);
         end if;
         V := Mul (V, Base, M);
      end loop;
      Modulus := M;
      Accumulator := 1;
      Offset := 0;
      D := Gcd (Base, Modulus);
      --  znlog.c: znlog_non_coprime strips common factors first.
      while D > 1 loop
         if Target = Accumulator then
            return (True, Offset);
         elsif Target mod D /= 0 then
            return (Defined => False);
         end if;
         Target := Target / D;
         Modulus := Modulus / D;
         Offset := Offset + 1;
         if Modulus = 1 then
            return (True, Offset);
         end if;
         Accumulator := Mul (Accumulator, Base / D, Modulus);
         D := Gcd (Base, Modulus);
      end loop;
      Target := Mul (Target, Invmod (Accumulator, Modulus).Value, Modulus);
      Base := Base mod Modulus;
      Order := Group_Order (Base, Modulus);
      R := Pohlig_Hellman (Target, Base, Modulus, Order);
      if R.Defined then
         if R.Value > U64'Last - Offset then
            return (Defined => False);
         end if;
         R.Value := R.Value + Offset;
      end if;
      return R;
   end Znlog;

   --  Fast doubling returns F(K), F(K+1), including 65-bit candidates.
   procedure Fibonacci (K : U128; M : U64; A, B : out U64)
     with Pre => M > 0;

   procedure Fibonacci (K : U128; M : U64; A, B : out U64)
   is
      X : U64 := 0;
      Y : U64 := 1 mod M;
      C, D, Twice : U64;
      Mask : U128 := 2 ** 127;
   begin
      while Mask > 0 loop
         Twice := Submod (Add (Y, Y, M), X, M).Value;
         C := Mul (X, Twice, M);
         D := Add (Mul (X, X, M), Mul (Y, Y, M), M);
         if (K and Mask) = 0 then
            X := C;
            Y := D;
         else
            X := D;
            Y := Add (C, D, M);
         end if;
         Mask := Mask / 2;
      end loop;
      A := X;
      B := Y;
   end Fibonacci;

   function Is_Period (K : U128; M : U64) return Boolean
     with Pre => M > 1;

   function Is_Period (K : U128; M : U64) return Boolean
   is
      A, B : U64;
   begin
      Fibonacci (K, M, A, B);
      return A = 0 and then B = 1;
   end Is_Period;

   function Prime_Period (P : U64) return U128
     with Pre => P >= 2;

   function Prime_Period (P : U64) return U128
   is
      Candidate : U128;
      F : Factors;
      Bound : U64;
   begin
      if P = 2 then
         return 3;
      elsif P = 5 then
         return 20;
      end if;
      --  util.c: _pisano_prime_power. The period divides P-1 for
      --  quadratic residues of 5, and 2*(P+1) otherwise.
      if P mod 5 = 1 or else P mod 5 = 4 then
         Bound := P - 1;
         Candidate := U128 (Bound);
      else
         Bound := P + 1;
         Candidate := 2 * U128 (Bound);
      end if;
      F := Factorize (Bound);
      if Candidate > U128 (Bound) then
         F.Count := F.Count + 1;
         F.Values (F.Count) := 2;
      end if;
      for I in 1 .. F.Count loop
         if Is_Period (Candidate / U128 (F.Values (I)), P) then
            Candidate := Candidate / U128 (F.Values (I));
         end if;
      end loop;
      return Candidate;
   end Prime_Period;

   function Pisano_Period (N : U64) return Optional_U64 is
      F : Factors;
      I : Positive := 1;
      P : U64;
      Period : U128;
      Result : U64 := 1;
      Combined : U128;
   begin
      if N <= 1 then
         return (True, N);
      end if;
      F := Factorize (N);
      while I <= F.Count loop
         P := F.Values (I);
         Period := Prime_Period (P);
         I := I + 1;
         while I <= F.Count and then F.Values (I) = P loop
            Period := Period * U128 (P);
            I := I + 1;
         end loop;
         if Period > U128 (U64'Last) then
            return (Defined => False);
         end if;
         Combined := U128 (Result / Gcd (Result, U64 (Period))) * Period;
         if Combined > U128 (U64'Last) then
            return (Defined => False);
         end if;
         Result := U64 (Combined);
      end loop;
      return (True, Result);
   end Pisano_Period;
   function Kronecker (A, B : I128) return Symbol is
      X : U64 := U64 (abs A);
      Y : U64 := U64 (abs B);
      S : Symbol := (if A < 0 and then B < 0 then -1 else 1);
      T : U64;
      Odd : Boolean := False;
   begin
      if Y = 0 then
         return (if X = 1 then 1 else 0);
      end if;
      while Y mod 2 = 0 loop
         if X mod 2 = 0 then
            return 0;
         end if;
         Y := Y / 2;
         Odd := not Odd;
      end loop;
      if Odd and then A mod 8 in 3 | 5 then
         S := -S;
      end if;
      if A < 0 then
         X := U64 (A mod I128 (Y));
      end if;
      while X /= 0 loop
         Odd := False;
         while X mod 2 = 0 loop
            X := X / 2;
            Odd := not Odd;
         end loop;
         if Odd and then Y mod 8 in 3 | 5 then
            S := -S;
         end if;
         if X mod 4 = 3 and then Y mod 4 = 3 then
            S := -S;
         end if;
         T := Y mod X;
         Y := X;
         X := T;
      end loop;
      return (if Y = 1 then S else 0);
   end Kronecker;

   function Chinese2 (Pairs : Congruence_List) return Chinese_Result is
      R : U64 := 0;
      M : U64 := 1;
      G, N, A, Step, New_M : U64;
      Difference : I128;
   begin
      if Pairs'Length = 0 then
         return (True, 0, 0);
      end if;
      --  util.c: chinese, generalized pairwise Bezout combination.
      --  Reduce the signed difference before multiplying to avoid overflow.
      for C of Pairs loop
         N := C.Modulus;
         if N = 0 then
            return (Defined => False);
         end if;
         A := Reduce (C.Residue, N);
         G := Gcd (M, N);
         if R mod G /= A mod G then
            return (Defined => False);
         end if;
         N := N / G;
         if M > U64'Last / N then
            return (Defined => False);
         end if;
         New_M := M * N;
         Difference := (I128 (A) - I128 (R)) / I128 (G);
         Step := Mul (Reduce (Difference, N), Invmod (M / G, N).Value, N);
         R := U64 (U128 (R) + U128 (M) * U128 (Step));
         M := New_M;
      end loop;
      return (True, R, M);
   end Chinese2;

   function Chinese (Pairs : Congruence_List) return Optional_U64 is
      R : constant Chinese_Result := Chinese2 (Pairs);
   begin
      return (if R.Defined then (True, R.Remainder)
              else (Defined => False));
   end Chinese;

   function Znorder (A : I128; N : U64) return Optional_U64 is
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (True, 1);
      elsif Gcd (Reduce (A, N), N) /= 1 then
         return (Defined => False);
      end if;
      return (True, Group_Order (Reduce (A, N), N));
   end Znorder;

   function Is_Primitive_Root (A : I128; N : U64) return Boolean is
      V, M, P, Phi : U64;
      F : Factors;
   begin
      if N <= 1 then
         return N = 1;
      end if;
      V := Reduce (A, N);
      if V <= 1 then
         return V = 1 and then N = 2;
      elsif N <= 4 then
         return V = N - 1;
      elsif N mod 4 = 0 then
         return False;
      end if;
      M := N;
      if M mod 2 = 0 then
         if V mod 2 = 0 then
            return False;
         end if;
         M := M / 2;
      end if;
      if Is_Square (V) or else Gcd (V, M) /= 1 then
         return False;
      end if;
      F := Factorize (M);
      P := F.Values (1);
      if F.Values (F.Count) /= P then
         return False;
      elsif F.Count > 1 and then Pow (V, P - 1, P * P) = 1 then
         return False;
      elsif Kronecker (I128 (V), I128 (P)) /= -1 then
         return False;
      end if;
      Phi := P - 1;
      if Is_Power (V, 3) and then Phi mod 3 = 0 then
         return False;
      end if;
      F := Factorize (Phi);
      for I in 1 .. F.Count loop
         if Pow (V, Phi / F.Values (I), P) = 1 then
            return False;
         end if;
      end loop;
      return True;
   end Is_Primitive_Root;

   function Znprimroot (N : U64) return Optional_U64 is
      M : U64 := N;
      P, A : U64;
      F : Factors;
      Even : constant Boolean := N mod 2 = 0;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 4 then
         return (True, N - 1);
      elsif N mod 4 = 0 then
         return (Defined => False);
      end if;
      if Even then
         M := M / 2;
      end if;
      F := Factorize (M);
      P := F.Values (1);
      if F.Values (F.Count) /= P then
         return (Defined => False);
      elsif P = 3 and then Even then
         return (True, 5);
      end if;
      A := 2;
      while A < P loop
         if (not Even or else A mod 2 = 1) and then
           A not in 4 | 8 | 9 and then
           Is_Primitive_Root (I128 (A), N)
         then
            return (True, A);
         end if;
         A := A + 1;
      end loop;
      return (Defined => False);
   end Znprimroot;

   function Is_Qr (A : I128; N : U64) return Boolean is
      V, P, PE : U64;
      I : Positive := 1;
      E : Natural;
      F : Factors;
   begin
      if N = 0 then
         --  XS.xs returns undef; the Boolean API maps it to false.
         return False;
      elsif N <= 2 then
         return True;
      end if;
      V := Reduce (A, N);
      if V <= 1 then
         return True;
      end if;
      F := Factorize (N);
      while I <= F.Count loop
         P := F.Values (I);
         PE := 1;
         E := 0;
         while I <= F.Count and then F.Values (I) = P loop
            PE := PE * P;
            E := E + 1;
            I := I + 1;
         end loop;
         if E = 1 and then (P = 2 or else V mod P = 0) then
            null;
         elsif E = 1 or else (P /= 2 and then V mod P /= 0) then
            if Kronecker (I128 (V), I128 (P)) /= 1 then
               return False;
            end if;
         elsif not Sqrtmod (I128 (V), PE).Defined then
            return False;
         end if;
      end loop;
      return True;
   end Is_Qr;

   function Qnr (N : U64) return Optional_U64 is
      M : U64 := N;
      A : U64 := 2;
      E : Natural := 0;
      F : Factors;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N <= 2 then
         return (True, N);
      elsif Kronecker (2, I128 (N)) = -1 then
         return (True, 2);
      elsif Primality.Is_Prime (N) /= 0 then
         A := 3;
         while A < N loop
            if Kronecker (I128 (A), I128 (N)) = -1 then
               return (True, A);
            end if;
            A := A + 2;
         end loop;
      else
         while M mod 2 = 0 loop
            M := M / 2;
            E := E + 1;
         end loop;
         if E >= 2 or else M = 1 or else M mod 3 = 0 or else
           M mod 5 = 0 or else M mod 11 = 0 or else M mod 13 = 0
           or else M mod 19 = 0
         then
            return (True, 2);
         end if;
         F := Factorize (M);
         while A < M loop
            for I in 1 .. F.Count loop
               if A < F.Values (I) and then
                 Kronecker (I128 (A), I128 (F.Values (I))) = -1
               then
                  return (True, A);
               end if;
            end loop;
            loop
               A := A + 1;
               exit when Primality.Is_Prime (A) /= 0;
            end loop;
         end loop;
      end if;
      return (Defined => False);
   end Qnr;

   function Is_Fundamental (D : I128) return Boolean is
      N : U64 := U64 (abs D);
      R : constant I128 := D mod 16;
      F : Factors;
   begin
      if R mod 4 = 0 and then R /= 0 and then R /= 4 then
         N := N / 4;
      elsif R mod 4 /= 1 then
         return False;
      end if;
      F := Factorize (N);
      for I in 2 .. F.Count loop
         if F.Values (I) = F.Values (I - 1) then
            return False;
         end if;
      end loop;
      return True;
   end Is_Fundamental;

   function Divmod (A, B : I128; N : U64) return Optional_U64 is
      Inverse : Optional_U64;
   begin
      if N = 0 then
         return (Defined => False);
      elsif N = 1 then
         return (True, 0);
      end if;
      Inverse := Invmod (Reduce (B, N), N);
      if not Inverse.Defined then
         return (Defined => False);
      end if;
      return (True, Mul (Reduce (A, N), Inverse.Value, N));
   end Divmod;
end Math_Prime_Util.Modular;
