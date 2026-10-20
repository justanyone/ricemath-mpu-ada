with Interfaces;

package body Math_Prime_Util.Rational is
   use Math_Prime_Util.Int;
   use type I128;
   use type U128;
   Undefined : constant Fraction := (0, 1, False);

   function Contfrac (Num : I128; Den : U64) return Coefficients is
      A : I128 := Num;
      B : I128 := I128 (Den);
      Q, R : I128;
      Terms : Coefficients (1 .. 128);
      Last : Natural := 0;
   begin
      while B > 0 loop
         Q := A / B;
         R := A rem B;
         if R < 0 then
            Q := Q - 1;
            R := R + B;
         end if;
         Last := Last + 1;
         Terms (Last) := Q;
         A := B;
         B := R;
      end loop;
      return Terms (1 .. Last);
   end Contfrac;

   function Convergents (Terms : Coefficients) return Fraction_Array is
      Result : Fraction_Array (Terms'Range);
      P0 : I128 := 0;
      P1 : I128 := 1;
      Q0 : U64 := 1;
      Q1 : U64 := 0;
      P2 : I128;
      Q2 : U128;
   begin
      for I in Terms'Range loop
         if (I /= Terms'First and then Terms (I) <= 0)
           or else abs Terms (I) > I128 (U64'Last)
         then
            return [Terms'Range => Undefined];
         end if;
         --  Check before multiplication to retain native overflow semantics.
         if P1 /= 0 and then abs Terms (I) >
           (I128 (U64'Last) - abs P0) / abs P1
         then
            return [Terms'Range => Undefined];
         end if;
         P2 := Terms (I) * P1 + P0;
         Q2 := U128 (abs Terms (I)) * U128 (Q1) + U128 (Q0);
         if Q2 > U128 (U64'Last) then
            return [Terms'Range => Undefined];
         end if;
         Result (I) := (P2, U64 (Q2), True);
         P0 := P1;
         P1 := P2;
         Q0 := Q1;
         Q1 := U64 (Q2);
      end loop;
      return Result;
   end Convergents;

   function From_Contfrac (Terms : Coefficients) return Fraction is
      Values : constant Fraction_Array := Convergents (Terms);
   begin
      if Values'Length = 0 then
         return (0, 1, True);
      end if;
      return Values (Values'Last);
   end From_Contfrac;

   function Bestrational (X : Long_Long_Float; Bound : U64) return Fraction is
      A, P0, Q0, P1, Q1, P2, Q2, Limit, PS, QS : U64;
      V : constant Long_Long_Float := abs X;
      R, Inverse : Long_Long_Float;
      Max : constant Long_Long_Float := Long_Long_Float (U64'Last);
   begin
      if Bound = 0 or else not (V < Max) then
         return Undefined;
      end if;
      P0 := 1;
      Q0 := 0;
      P1 := U64 (Long_Long_Float'Truncation (V));
      Q1 := 1;
      R := V - Long_Long_Float (P1);
      while R > 0.0 loop
         Inverse := 1.0 / R;
         if not (Inverse < Max) then
            return Undefined;
         end if;
         A := U64 (Long_Long_Float'Truncation (Inverse));
         R := Inverse - Long_Long_Float (A);
         if A = 0 then
            return Undefined;
         end if;
         Limit := (Bound - Q0) / Q1;
         if A > Limit then
            if Limit >= 1 then
               if P1 /= 0 and then Limit > (U64'Last - P0) / P1 then
                  return Undefined;
               end if;
               PS := Limit * P1 + P0;
               QS := Limit * Q1 + Q0;
               if abs (Long_Long_Float (PS) - V * Long_Long_Float (QS))
                 * Long_Long_Float (Q1) <
                 abs (Long_Long_Float (P1) - V * Long_Long_Float (Q1))
                 * Long_Long_Float (QS)
               then
                  P1 := PS;
                  Q1 := QS;
               end if;
            end if;
            exit;
         end if;
         Q2 := A * Q1 + Q0;
         if P1 > U64'Last / A or else A * P1 > U64'Last - P0 then
            return Undefined;
         end if;
         P2 := A * P1 + P0;
         P0 := P1;
         Q0 := Q1;
         P1 := P2;
         Q1 := Q2;
      end loop;
      return ((if X < 0.0 then -I128 (P1) else I128 (P1)), Q1, True);
   end Bestrational;

   function Next_Calkin_Wilf (Num, Den : U64) return Fraction is
      R, NR, DR : U64;
   begin
      if Num = 0 or Den = 0 or else Gcd (Num, Den) /= 1 then
         return Undefined;
      end if;
      if Num < Den then
         return (I128 (Den), Den - Num, True);
      elsif Den = 1 then
         if Num = U64'Last then
            return Undefined;
         end if;
         return (1, Num + 1, True);
      end if;
      R := Num mod Den;
      NR := Num - R;
      DR := Den - R;
      if NR > U64'Last - DR then
         return Undefined;
      end if;
      return (I128 (Den), NR + DR, True);
   end Next_Calkin_Wilf;

   function Calkin_Wilf_N (Num, Den : U64) return U64 is
      CF : Coefficients := Contfrac (I128 (Num), Den);
      N : U64 := 0;
      Shift : Natural := 0;
      Bit : Boolean := True;
   begin
      CF (CF'Last) := CF (CF'Last) - 1;
      for A of CF loop
         if A >= I128 (64 - Shift) then
            return 0;
         end if;
         for J in 1 .. Natural (A) loop
            if Bit then
               N := N or Interfaces.Shift_Left (U64 (1), Shift);
            end if;
            Shift := Shift + 1;
         end loop;
         Bit := not Bit;
      end loop;
      return N or Interfaces.Shift_Left (U64 (1), Shift);
   end Calkin_Wilf_N;

   function Stern_Brocot_N (Num, Den : U64) return U64 is
      M : U64 := Calkin_Wilf_N (Num, Den);
      N : U64 := 1;
   begin
      if M = 0 then
         return 0;
      end if;
      while M > 1 loop
         N := 2 * N + (M and 1);
         M := M / 2;
      end loop;
      return N;
   end Stern_Brocot_N;

   function Nth_Calkin_Wilf (N : U64) return Fraction is
      P : U64 := 0;
      Q : U64 := 1;
      Mask : U64 := 1;
   begin
      while Mask <= N / 2 loop
         Mask := Mask * 2;
      end loop;
      while Mask > 0 loop
         if (N and Mask) /= 0 then
            P := P + Q;
         else
            Q := Q + P;
         end if;
         Mask := Mask / 2;
      end loop;
      return (I128 (P), Q, True);
   end Nth_Calkin_Wilf;

   function Nth_Stern_Brocot (N : U64) return Fraction is
      M : U64 := N;
      P : U64 := 1;
      Q : U64 := 1;
   begin
      while M > 1 loop
         if M mod 2 = 1 then
            P := P + Q;
         else
            Q := Q + P;
         end if;
         M := M / 2;
      end loop;
      return (I128 (P), Q, True);
   end Nth_Stern_Brocot;

   function Next_Stern_Brocot (Num, Den : U64) return Fraction is
      Index : U64;
   begin
      if Num = 0 or Den = 0 or else Gcd (Num, Den) /= 1 then
         return Undefined;
      end if;
      if Den = 1 then
         if Num = U64'Last then
            return Undefined;
         end if;
         return (1, Num + 1, True);
      end if;
      Index := Stern_Brocot_N (Num, Den);
      if Index = 0 or Index = U64'Last then
         return Undefined;
      end if;
      return Nth_Stern_Brocot (Index + 1);
   end Next_Stern_Brocot;

   function Nth_Stern_Diatomic (N : U64) return U64 is
      M : U64 := N;
      P : U64 := 0;
      Q : U64 := 1;
   begin
      while M > 0 loop
         if M mod 2 = 1 then
            P := P + Q;
         else
            Q := Q + P;
         end if;
         M := M / 2;
      end loop;
      return P;
   end Nth_Stern_Diatomic;

   function Next_Farey (N, Num, Den : U64) return Fraction is
      P : U64 := Num;
      Q : U64 := Den;
      G, R, Tail, H : U64;
      B : Bezout_Result;
   begin
      if N = 0 or P >= Q then
         return Undefined;
      end if;
      G := Gcd (P, Q);
      P := P / G;
      Q := Q / G;
      if Q > N then
         return Undefined;
      end if;
      B := Gcdext (I128 (P), I128 (Q));
      if B.X <= 0 then
         R := U64 (-B.X);
         Tail := U64 (B.Y);
      else
         R := Q - U64 (B.X);
         if -B.Y > I128 (P) then
            return Undefined;
         end if;
         Tail := P - U64 (-B.Y);
      end if;
      H := (N - R) / Q;
      return (I128 (H * P + Tail), H * Q + R, True);
   end Next_Farey;

   function Farey_Rank (N : Natural; Num, Den : U64) return U64 is
      Count : array (0 .. N) of U64 := [others => 0];
      Sum : U64 := 1;
      J : Natural;
   begin
      if N = 0 or Den = 0 or Num = 0 then
         return 0;
      end if;
      for I in 2 .. N loop
         Count (I) := (U64 (I) * Num - 1) / Den;
      end loop;
      for I in 2 .. N loop
         J := I;
         while J <= N - I loop
            J := J + I;
            Count (J) := Count (J) - Count (I);
         end loop;
         Sum := Sum + Count (I);
      end loop;
      return Sum;
   end Farey_Rank;

   function Farey (N : Positive) return Fraction_Array is
      Len : constant U64 := Farey_Rank (N, 1, 1) + 1;
      Result : Fraction_Array (1 .. Natural (Len));
      P0 : U64 := 0;
      Q0 : U64 := 1;
      P1 : U64 := 1;
      Q1 : U64 := U64 (N);
      J, P2, Q2 : U64;
   begin
      for I in Result'Range loop
         Result (I) := (I128 (P0), Q0, True);
         exit when I = Result'Last;
         J := (Q0 + U64 (N)) / Q1;
         P2 := J * P1 - P0;
         Q2 := J * Q1 - Q0;
         P0 := P1;
         Q0 := Q1;
         P1 := P2;
         Q1 := Q2;
      end loop;
      return Result;
   end Farey;
end Math_Prime_Util.Rational;
