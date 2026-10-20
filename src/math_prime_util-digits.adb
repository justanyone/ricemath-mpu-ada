with Ada.Characters.Handling;
with Ada.Strings.Fixed;

package body Math_Prime_Util.Digits is
   function Todigits
     (N : U128; Base : U128 := 10; Length : Integer := -1)
      return Digit_Array
   is
      Buffer : Digit_Array (1 .. 128) := [others => 0];
      V : U128 := N;
      Count : Natural := 0;
      Size : Natural;
   begin
      while V > 0 loop
         Count := Count + 1;
         Buffer (Count) := V mod Base;
         V := V / Base;
      end loop;
      Size := (if Length < 0 then Count else Length);
      return Result : Digit_Array (1 .. Size) do
         for I in Result'Range loop
            Result (I) := Buffer (Size - I + 1);
         end loop;
      end return;
   end Todigits;

   function Todigitstring
     (N : U128; Base : U128 := 10; Length : Integer := -1)
      return String
   is
      Alphabet : constant String := "0123456789abcdefghijklmnopqrstuvwxyz";
      D : constant Digit_Array := Todigits (N, Base, Length);
   begin
      return Result : String (D'Range) do
         for I in D'Range loop
            Result (I) := Alphabet (Natural (D (I)) + 1);
         end loop;
      end return;
   end Todigitstring;

   function Fromdigits (Text : String; Base : U128 := 10) return U128 is
      N, D : U128 := 0;
   begin
      for C of Text loop
         if C in '0' .. '9' then
            D := Character'Pos (C) - Character'Pos ('0');
         elsif C in 'a' .. 'z' then
            D := Character'Pos (C) - Character'Pos ('a') + 10;
         elsif C in 'A' .. 'Z' then
            D := Character'Pos (C) - Character'Pos ('A') + 10;
         else
            raise Constraint_Error with "invalid digit";
         end if;
         if D >= Base or else N > (U128'Last - D) / Base then
            raise Constraint_Error with "digit overflow or invalid digit";
         end if;
         N := N * Base + D;
      end loop;
      return N;
   end Fromdigits;

   function Sumdigits (N : U128; Base : U128 := 10) return U128 is
      V : U128 := N;
      S : U128 := 0;
   begin
      while V /= 0 loop
         S := S + V mod Base;
         V := V / Base;
      end loop;
      return S;
   end Sumdigits;

   function Reverse_Digits (N : U128; Base : U128 := 10) return U128 is
      V : U128 := N;
      R, D : U128 := 0;
   begin
      while V /= 0 loop
         D := V mod Base;
         if R > (U128'Last - D) / Base then
            raise Constraint_Error with "reversal overflow";
         end if;
         R := R * Base + D;
         V := V / Base;
      end loop;
      return R;
   end Reverse_Digits;

   function Is_Palindrome (N : U128; Base : U128 := 10) return Boolean is
      D : constant Digit_Array := Todigits (N, Base);
   begin
      for I in D'Range loop
         if D (I) /= D (D'Last - I + 1) then
            return False;
         end if;
      end loop;
      return True;
   end Is_Palindrome;

   function Is_Harshad (N : U128; Base : U128 := 10) return Boolean is
     (N /= 0 and then N mod Sumdigits (N, Base) = 0);

   function Digital_Root (N : U128; Base : U128 := 10) return U128 is
     (if N = 0 then 0 else 1 + (N - 1) mod (Base - 1));

   function Mult_Digital_Root
     (N : U128; Base : U128 := 10) return U128
   is
      R : U128 := N;
      V : U128;
   begin
      while R >= Base loop
         V := R;
         R := 1;
         while V /= 0 loop
            R := R * (V mod Base);
            V := V / Base;
         end loop;
      end loop;
      return R;
   end Mult_Digital_Root;

   function Hammingweight (N : U128) return Natural is
      V : U128 := N;
      Count : Natural := 0;
   begin
      while V /= 0 loop
         V := V and (V - 1);
         Count := Count + 1;
      end loop;
      return Count;
   end Hammingweight;

   function Tozeckendorf (N : U64) return String is
      Fa : U128 := 0;
      Fb : U128 := 1;
      Fc : U128 := 1;
      R : U128 := U128 (N);
      Buffer : String (1 .. 92);
      K : Natural := 0;
   begin
      if N = 0 then
         return "0";
      end if;
      while Fc <= R loop
         Fa := Fb;
         Fb := Fc;
         Fc := Fa + Fb;
         K := K + 1;
      end loop;
      for I in 1 .. K loop
         Fc := Fb;
         Fb := Fa;
         Fa := Fc - Fb;
         Buffer (I) := (if Fc <= R then '1' else '0');
         if Fc <= R then
            R := R - Fc;
         end if;
      end loop;
      return Buffer (1 .. K);
   end Tozeckendorf;

   function Fromzeckendorf (Text : String) return U64 is
      Fa : U128 := 0;
      Fb : U128 := 1;
      Fc : U128 := 1;
      N : U128 := 0;
      Previous : Character := '0';
   begin
      if Text'Length = 0 or else
        (Text'Length > 1 and then Text (Text'First) /= '1')
      then
         raise Constraint_Error with "noncanonical Zeckendorf";
      end if;
      for C of Text loop
         if C not in '0' .. '1' or else
           (C = '1' and Previous = '1')
         then
            raise Constraint_Error with "invalid Zeckendorf";
         end if;
         Previous := C;
      end loop;
      for I in reverse Text'Range loop
         if Text (I) = '1' then
            N := N + Fc;
         end if;
         Fa := Fb;
         Fb := Fc;
         Fc := Fa + Fb;
      end loop;
      if N > U128 (U64'Last) then
         raise Constraint_Error with "Zeckendorf overflow";
      end if;
      return U64 (N);
   end Fromzeckendorf;

   function Absint (A : I128) return Optional_I128 is
   begin
      return (True, abs A);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Absint;

   function Negint (A : I128) return Optional_I128 is
   begin
      return (True, -A);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Negint;

   function Add1int (A : I128) return Optional_I128 is
   begin
      return (True, A + 1);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Add1int;

   function Sub1int (A : I128) return Optional_I128 is
   begin
      return (True, A - 1);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Sub1int;

   function Addint (A, B : I128) return Optional_I128 is
   begin
      return (True, A + B);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Addint;

   function Subint (A, B : I128) return Optional_I128 is
   begin
      return (True, A - B);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Subint;

   function Mulint (A, B : I128) return Optional_I128 is
   begin
      return (True, A * B);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Mulint;

   function Muladdint (A, B, C : I128) return Optional_I128 is
   begin
      return (True, A * B + C);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Muladdint;

   function Mulsubint (A, B, C : I128) return Optional_I128 is
   begin
      return (True, A * B - C);
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Mulsubint;

   function Signint (A : I128) return Integer is
     (if A < 0 then -1 elsif A > 0 then 1 else 0);

   function Cmpint (A, B : I128) return Integer is
     (if A < B then -1 elsif A > B then 1 else 0);

   function Tdivrem (A, B : I128) return Division_Result is
   begin
      if B = 0 or else (A = I128'First and B = -1) then
         return (False, 0, 0);
      end if;
      return (True, A / B, A rem B);
   end Tdivrem;

   function Fdivrem (A, B : I128) return Division_Result is
      D : Division_Result := Tdivrem (A, B);
   begin
      if D.Defined and then D.Remainder /= 0 and then
        ((A < 0) /= (B < 0))
      then
         D.Quotient := D.Quotient - 1;
         D.Remainder := D.Remainder + B;
      end if;
      return D;
   end Fdivrem;

   function Cdivrem (A, B : I128) return Division_Result is
      D : Division_Result := Tdivrem (A, B);
   begin
      if D.Defined and then D.Remainder /= 0 and then
        ((A < 0) = (B < 0))
      then
         D.Quotient := D.Quotient + 1;
         D.Remainder := D.Remainder - B;
      end if;
      return D;
   end Cdivrem;

   function Divrem (A, B : I128) return Division_Result is
     (Fdivrem (A, B));

   function Divint (A, B : I128) return Optional_I128 is
      D : constant Division_Result := Fdivrem (A, B);
   begin
      return (if D.Defined then (True, D.Quotient)
              else (Defined => False));
   end Divint;

   function Modint (A, B : I128) return Optional_I128 is
      D : constant Division_Result := Fdivrem (A, B);
   begin
      return (if D.Defined then (True, D.Remainder)
              else (Defined => False));
   end Modint;

   function Cdivint (A, B : I128) return Optional_I128 is
      D : constant Division_Result := Cdivrem (A, B);
   begin
      return (if D.Defined then (True, D.Quotient)
              else (Defined => False));
   end Cdivint;

   function Lshiftint
     (A : I128; Bits : Natural := 1) return Optional_I128
   is
      R : Optional_I128 := (True, A);
   begin
      if A = 0 then
         return R;
      end if;
      if Bits > 127 then
         return (Defined => False);
      end if;
      for I in 1 .. Bits loop
         R := Mulint (R.Value, 2);
         exit when not R.Defined;
      end loop;
      return R;
   end Lshiftint;

   function Rshiftint
     (A : I128; Bits : Natural := 1) return Optional_I128
   is
      R : I128 := A;
   begin
      for I in 1 .. Natural'Min (Bits, 128) loop
         R := R / 2;
      end loop;
      return (True, R);
   end Rshiftint;

   function Rashiftint
     (A : I128; Bits : Natural := 1) return Optional_I128
   is
      R : I128 := A;
   begin
      for I in 1 .. Natural'Min (Bits, 128) loop
         R := Fdivrem (R, 2).Quotient;
      end loop;
      return (True, R);
   end Rashiftint;

   function Toint (Text : String) return Optional_I128 is
      S : constant String := Ada.Strings.Fixed.Trim (Text, Ada.Strings.Both);
      L : constant String := Ada.Characters.Handling.To_Lower (S);
      V : Long_Long_Float;
      Negative : Boolean := False;
      First : Integer := S'First;
   begin
      if S'Length = 0 then
         return (True, 0);
      end if;
      if S (First) in '+' | '-' then
         Negative := S (First) = '-';
         First := First + 1;
      end if;
      if First + 1 <= S'Last and then S (First) = '0' then
         if L (First + 1) in 'x' | 'b' | 'o' then
            declare
               Base : constant U128 :=
                 (case L (First + 1) is
                     when 'x' => 16, when 'b' => 2, when others => 8);
               N : constant U128 := Fromdigits (S (First + 2 .. S'Last), Base);
            begin
               if First + 2 > S'Last then
                  raise Constraint_Error;
               end if;
               return (True, (if Negative then -I128 (N) else I128 (N)));
            end;
         end if;
      end if;
      if (for all C of S (First .. S'Last) => C in '0' .. '9') then
         return (True, I128'Value (S));
      end if;
      V := Long_Long_Float'Value (S);
      return (True, I128 (Long_Long_Float'Truncation (V)));
   exception
      when Constraint_Error =>
         return (Defined => False);
   end Toint;

   function Is_Odd (A : I128) return Boolean is (A rem 2 /= 0);
   function Is_Even (A : I128) return Boolean is (A rem 2 = 0);
   function Is_Divisible (A, B : I128) return Boolean is
     (if B = 0 then A = 0 elsif B = -1 then True else A rem B = 0);
   function Is_Congruent (A, B, Modulus : I128) return Boolean is
     (if Modulus = 0 then A = B elsif Modulus = -1 then True
      else A mod Modulus = B mod Modulus);
end Math_Prime_Util.Digits;
