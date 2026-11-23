with Math_Prime_Util.Int;

package body Math_Prime_Util.Proving is
   use type U128;

   type Polynomial is array (Natural range <>) of U64;

   --  aks.c: poly_mod_mul. Cyclic convolution modulo X**R - 1 and N.
   function Multiply (Left, Right : Polynomial; N : U64)
     return Polynomial
     with Pre => N > 1 and then Left'First = 0
       and then Right'First = 0 and then Left'Length = Right'Length
       and then Left'Length > 1 and then Left'Last < Natural'Last / 2;

   function Multiply (Left, Right : Polynomial; N : U64)
     return Polynomial
   is
      Result : Polynomial (Left'Range) := (others => 0);
      K : Natural;
   begin
      for I in Left'Range loop
         if Left (I) /= 0 then
            for J in Right'Range loop
               K := (I + J) mod Left'Length;
               --  Reduce the product before adding: even a U128 sum of
               --  several unreduced U64 products could overflow.
               Result (K) := U64
                 ((U128 (Result (K)) +
                    (U128 (Left (I)) * U128 (Right (J))) mod U128 (N))
                    mod U128 (N));
            end loop;
         end if;
      end loop;
      return Result;
   end Multiply;

   --  aks.c: poly_mod_pow and test_anr.
   function Congruent (A, N : U64; R : Positive) return Boolean
     with Pre => N > 1 and R > 1 and R < Natural'Last / 2;

   function Congruent (A, N : U64; R : Positive) return Boolean is
      Base : Polynomial (0 .. R - 1) := (others => 0);
      Result : Polynomial (Base'Range) := (others => 0);
      Expected : Polynomial (Base'Range) := (others => 0);
      Power : U64 := N;
   begin
      Base (0) := A mod N;
      Base (1) := 1;
      Result (0) := 1;
      while Power > 0 loop
         if Power mod 2 = 1 then
            Result := Multiply (Result, Base, N);
         end if;
         Power := Power / 2;
         if Power > 0 then
            Base := Multiply (Base, Base, N);
         end if;
      end loop;
      Expected (0) := A mod N;
      Expected (Natural (N mod U64 (R))) :=
        Int.Addmod (Expected (Natural (N mod U64 (R))), 1, N).Value;
      return Result = Expected;
   end Congruent;

   function Is_Aks_Prime (N : U64) return Boolean is
      R : U64 := 2;
      Residue : U64;
      Large_Order : Boolean;
      Bits : U64;
      Limit : U64;
      Bound : U64;
   begin
      if N < 2 then
         return False;
      end if;
      --  A fixed trial prefix preserves polynomial asymptotic complexity
      --  and makes the small native fixture range inexpensive.
      for D in U64 range 2 .. 65_536 loop
         if D > N / D then
            return True;
         elsif N mod D = 0 then
            return False;
         end if;
      end loop;
      if Int.Is_Power_Exp (N) > 1 then
         return False;
      end if;
      --  Integer upper bounds replace floating log2 and sqrt in IMPL_V6.
      --  Requiring a larger order and more congruences is conservative.
      Bits := Int.Logint (N, 2) + 1;
      Limit := Bits * Bits;
      loop
         if N mod R = 0 then
            return False;
         elsif R > N / R then
            return True;
         end if;
         Residue := 1;
         Large_Order := True;
         for K in U64 range 1 .. Limit loop
            Residue := Int.Mulmod (Residue, N, R).Value;
            if Residue = 1 then
               Large_Order := False;
               exit;
            end if;
         end loop;
         exit when Large_Order;
         R := R + 1;
      end loop;
      Bound := (Int.Sqrtint (R - 1) + 1) * Bits;
      for A in U64 range 1 .. Bound loop
         if not Congruent (A, N, Positive (R)) then
            return False;
         end if;
      end loop;
      return True;
   end Is_Aks_Prime;

   function Is_Provable_Prime (N : U64) return Primality.Prime_Result is
     (Primality.Is_Prime (N));

   function Decimal (Text : String; Value : out U64) return Boolean is
      Digit : U64;
   begin
      Value := 0;
      if Text'Length = 0 then
         return False;
      end if;
      for C of Text loop
         if C not in '0' .. '9' then
            return False;
         end if;
         Digit := U64 (Character'Pos (C) - Character'Pos ('0'));
         if Value > (U64'Last - Digit) / 10 then
            return False;
         end if;
         Value := Value * 10 + Digit;
      end loop;
      return True;
   end Decimal;

   function Prime_Certificate (N : U64) return String is
      Image : constant String := N'Image;
      Number : constant String := Image (Image'First + 1 .. Image'Last);
      LF : constant Character := ASCII.LF;
   begin
      if Is_Provable_Prime (N) = 0 then
         return "";
      end if;
      return "[MPU - Primality Certificate]" & LF & "Version 1.0" &
        LF & LF & "Proof for:" & LF & "N " & Number & LF & LF &
        "Type Small" & LF & "N " & Number & LF;
   end Prime_Certificate;

   subtype Factor_Index is Natural range 0 .. 63;
   type Proof_Values is array (Factor_Index) of U64;

   --  PrimalityProving.pm: _verify_bls5, BLS75 theorem 5.
   function Check_Bls5 (N : U64; Q, A : Proof_Values;
                       Last : Factor_Index) return Boolean
   is
      use type Int.I128;
      R : U64;
      F : U64;
      S, Remain, Bound, Discriminant : Int.I128;
      Root : U64;
      Power : U64;
   begin
      if N < 5 or else N mod 2 = 0 then
         return False;
      end if;
      R := N - 1;
      for I in 0 .. Last loop
         if Q (I) < 2 or else Q (I) >= N - 1
           or else A (I) < 2 or else A (I) >= N
           or else (N - 1) mod Q (I) /= 0
           or else Primality.Is_Prime (Q (I)) = 0
         then
            return False;
         end if;
         for J in 0 .. I - 1 loop
            if Q (I) = Q (J) then
               return False;
            end if;
         end loop;
         while R mod Q (I) = 0 loop
            R := R / Q (I);
         end loop;
         if Int.Powmod (A (I), N - 1, N).Value /= 1 then
            return False;
         end if;
         Power := Int.Powmod (A (I), (N - 1) / Q (I), N).Value;
         --  The residue zero represents -1 after subtraction.
         if Int.Gcd ((if Power = 0 then N - 1 else Power - 1), N)
           /= 1
         then
            return False;
         end if;
      end loop;
      F := (N - 1) / R;
      if F mod 2 /= 0 or else Int.Gcd (F, R) /= 1 then
         return False;
      end if;
      --  When F > sqrt(N), R < F and the theorem's size condition
      --  holds immediately. Avoid forming a potentially 192-bit cube.
      if F > Int.Sqrtint (N) then
         return True;
      end if;
      S := Int.I128 (R) / (2 * Int.I128 (F));
      Remain := Int.I128 (R) mod (2 * Int.I128 (F));
      Bound := (Int.I128 (F) + 1) *
        (2 * Int.I128 (F) ** 2 + (Remain - 1) * Int.I128 (F) + 1);
      if Int.I128 (N) >= Bound then
         return False;
      end if;
      Discriminant := Remain ** 2 - 8 * S;
      if S = 0 or else Discriminant < 0 then
         return True;
      end if;
      --  F <= sqrt(N) and R = (N-1)/F imply Remain**2 < 2*N.
      --  Use an exact binary square root for this possibly 65-bit value.
      declare
         Low : U64 := 0;
         High : U64 := 2 ** 33;
      begin
         while Low + 1 < High loop
            Root := Low + (High - Low) / 2;
            if Int.I128 (Root) ** 2 <= Discriminant then
               Low := Root;
            else
               High := Root;
            end if;
         end loop;
         return Int.I128 (Low) ** 2 /= Discriminant;
      end;
   end Check_Bls5;

   function Verify_Prime (Certificate : String) return Boolean is
      Position : Integer := Certificate'First;
      Candidate, N, Value, Index : U64 := 0;
      Q : Proof_Values := (0 => 2, others => 0);
      A : Proof_Values := (others => 2);
      Seen_A : array (Factor_Index) of Boolean := (others => False);
      Last : Factor_Index := 0;
      Stage : Natural := 0;
      Bls : Boolean := False;
      Ended : Boolean := False;
   begin
      while Position <= Certificate'Last loop
         declare
            First : Integer := Position;
            Finish : Integer;
         begin
            while Position <= Certificate'Last
              and then Certificate (Position) /= ASCII.LF
            loop
               Position := Position + 1;
            end loop;
            Finish := Position - 1;
            Position := Position + 1;
            while First <= Finish and then
              Certificate (First) in ' ' | ASCII.HT | ASCII.CR
            loop
               First := First + 1;
            end loop;
            while Finish >= First and then
              Certificate (Finish) in ' ' | ASCII.HT | ASCII.CR
            loop
               Finish := Finish - 1;
            end loop;
            declare
               Line : constant String := Certificate (First .. Finish);
            begin
               if Line'Length = 0 or else Line (First) = '#' then
                  null;
               elsif Stage = 0 then
                  if Line /= "[MPU - Primality Certificate]" then
                     return False;
                  end if;
                  Stage := 1;
               elsif Stage = 1 then
                  if Line /= "Version 1.0" then
                     return False;
                  end if;
                  Stage := 2;
               elsif Stage = 2 then
                  if Line /= "Proof for:" then
                     return False;
                  end if;
                  Stage := 3;
               elsif Stage = 3 or else Stage = 5 then
                  if Line'Length < 3 or else Line (First .. First + 1)
                    /= "N " or else not Decimal
                      (Line (First + 2 .. Finish), Value)
                  then
                     return False;
                  end if;
                  if Stage = 3 then
                     Candidate := Value;
                     Stage := 4;
                  else
                     N := Value;
                     Stage := 6;
                  end if;
               elsif Stage = 4 then
                  if Line = "Type BLS5" then
                     Bls := True;
                  elsif Line /= "Type Small" then
                     return False;
                  end if;
                  Stage := 5;
               elsif not Bls or else Ended then
                  return False;
               elsif Line = "----" then
                  Ended := True;
               elsif Line'Length >= 6 and then
                 Line (First) in 'Q' | 'A' and then Line (First + 1) = '['
               then
                  declare
                     Close : Integer := First + 2;
                  begin
                     while Close <= Finish and then Line (Close) /= ']' loop
                        Close := Close + 1;
                     end loop;
                     if Close + 2 > Finish or else Line (Close + 1) /= ' '
                       or else not Decimal
                         (Line (First + 2 .. Close - 1), Index)
                       or else Index > 63 or else not Decimal
                         (Line (Close + 2 .. Finish), Value)
                     then
                        return False;
                     end if;
                     if Line (First) = 'Q' then
                        if Index /= U64 (Last) + 1 then
                           return False;
                        end if;
                        Last := Factor_Index (Index);
                        Q (Last) := Value;
                     else
                        if Index > U64 (Last)
                          or else Seen_A (Factor_Index (Index))
                        then
                           return False;
                        end if;
                        A (Factor_Index (Index)) := Value;
                        Seen_A (Factor_Index (Index)) := True;
                     end if;
                  end;
               else
                  return False;
               end if;
            end;
         end;
      end loop;
      if Stage /= 6 or else Candidate /= N then
         return False;
      elsif Bls then
         return Ended and then Check_Bls5 (N, Q, A, Last);
      else
         return Is_Provable_Prime (N) = 2;
      end if;
   end Verify_Prime;
end Math_Prime_Util.Proving;
