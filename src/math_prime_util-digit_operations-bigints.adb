with Ada.Characters.Handling;
with Ada.Strings.Fixed;

package body Math_Prime_Util.Digit_Operations.Bigints is
   function Absint (A : Big_Integer)
      return Big_Integer is
     (abs A);

   function Negint (A : Big_Integer)
      return Big_Integer is
     (-A);

   function Signint (A : Big_Integer)
      return Integer is
     ((if A < 0 then -1 elsif A > 0 then 1 else 0));

   function Cmpint (A, B : Big_Integer)
      return Integer is
     ((if A < B then -1 elsif A > B then 1 else 0));

   function Addint (A, B : Big_Integer)
      return Big_Integer is
     (A + B);

   function Subint (A, B : Big_Integer)
      return Big_Integer is
     (A - B);

   function Add1int (A : Big_Integer)
      return Big_Integer is
     (A + 1);

   function Sub1int (A : Big_Integer)
      return Big_Integer is
     (A - 1);

   function Mulint (A, B : Big_Integer)
      return Big_Integer is
     (A * B);

   function Muladdint (A, B, C : Big_Integer)
      return Big_Integer is
     (A * B + C);

   function Mulsubint (A, B, C : Big_Integer)
      return Big_Integer is
     (A * B - C);

   function Tdivrem (A, B : Big_Integer) return Division_Result is
     (Quotient => A / B, Remainder => A rem B);

   function Fdivrem (A, B : Big_Integer) return Division_Result is
      D : Division_Result := Tdivrem (A, B);
   begin
      if D.Remainder /= 0 and then ((A < 0) /= (B < 0)) then
         D.Quotient := D.Quotient - 1;
         D.Remainder := D.Remainder + B;
      end if;
      return D;
   end Fdivrem;

   function Cdivrem (A, B : Big_Integer) return Division_Result is
      D : Division_Result := Fdivrem (A, B);
   begin
      if D.Remainder /= 0 then
         D.Quotient := D.Quotient + 1;
         D.Remainder := D.Remainder - B;
      end if;
      return D;
   end Cdivrem;

   function Divrem (A, B : Big_Integer) return Division_Result is
      D : Division_Result := Tdivrem (A, B);
   begin
      if D.Remainder < 0 then
         if B > 0 then
            D.Quotient := D.Quotient - 1;
            D.Remainder := D.Remainder + B;
         else
            D.Quotient := D.Quotient + 1;
            D.Remainder := D.Remainder - B;
         end if;
      end if;
      return D;
   end Divrem;

   function Divint (A, B : Big_Integer) return Big_Integer is
     (Fdivrem (A, B).Quotient);
   function Modint (A, B : Big_Integer) return Big_Integer is
     (Fdivrem (A, B).Remainder);
   function Cdivint (A, B : Big_Integer) return Big_Integer is
     (Cdivrem (A, B).Quotient);

   function Lshiftint
     (A : Big_Integer; Bits : Integer := 1) return Big_Integer is
   begin
      if Bits < 0 then
         return Rshiftint (A, -Bits);
      end if;
      return A * To_Big_Integer (2) ** Bits;
   end Lshiftint;

   function Rshiftint
     (A : Big_Integer; Bits : Integer := 1) return Big_Integer is
   begin
      if Bits < 0 then
         return Lshiftint (A, -Bits);
      end if;
      return A / To_Big_Integer (2) ** Bits;
   end Rshiftint;

   function Rashiftint
     (A : Big_Integer; Bits : Integer := 1) return Big_Integer is
   begin
      if Bits < 0 then
         return Lshiftint (A, -Bits);
      end if;
      return Fdivrem (A, To_Big_Integer (2) ** Bits).Quotient;
   end Rashiftint;

   function Is_Odd (A : Big_Integer) return Boolean is (A rem 2 /= 0);
   function Is_Even (A : Big_Integer) return Boolean is (A rem 2 = 0);
   function Is_Divisible (A, B : Big_Integer) return Boolean is
     (if B = 0 then A = 0 else A rem B = 0);
   function Is_Congruent
     (A, B, Modulus : Big_Integer) return Boolean is
     (if Modulus = 0 then A = B else A mod Modulus = B mod Modulus);

   function Todigits
     (N : Big_Integer; Base : Big_Integer := 10;
      Length : Integer := -1) return Digit_Array
   is
      V : Big_Integer := abs N;
      Count : Natural := 0;
   begin
      while V /= 0 loop
         Count := Count + 1;
         V := V / Base;
      end loop;
      V := abs N;
      return Result : Digit_Array
        (1 .. (if Length < 0 then Count else Length))
      do
         for I in reverse Result'Range loop
            Result (I) := V mod Base;
            V := V / Base;
         end loop;
      end return;
   end Todigits;

   function Todigitstring
     (N : Big_Integer; Base : Big_Integer := 10;
      Length : Integer := -1) return String
   is
      Alphabet : constant String := "0123456789abcdefghijklmnopqrstuvwxyz";
      D : constant Digit_Array := Todigits (N, Base, Length);
   begin
      return Result : String (D'Range) do
         for I in D'Range loop
            Result (I) := Alphabet (To_Integer (D (I)) + 1);
         end loop;
      end return;
   end Todigitstring;

   function Fromdigits
     (Text : String; Base : Big_Integer := 10) return Big_Integer
   is
      R : Big_Integer := To_Big_Integer (0);
      D : Integer;
   begin
      for C of Ada.Characters.Handling.To_Lower (Text) loop
         D := (if C in '0' .. '9' then Character'Pos (C) - 48
               elsif C in 'a' .. 'z' then Character'Pos (C) - 87
               else -1);
         if D < 0 or else To_Big_Integer (D) >= Base then
            raise Constraint_Error with "invalid digit";
         end if;
         R := R * Base + To_Big_Integer (D);
      end loop;
      return R;
   end Fromdigits;

   function Sumdigits
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
   is
      R : Big_Integer := To_Big_Integer (0);
      V : Big_Integer := abs N;
   begin
      while V /= 0 loop
         R := R + V mod Base;
         V := V / Base;
      end loop;
      return R;
   end Sumdigits;

   function Reverse_Digits
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
   is
      R : Big_Integer := To_Big_Integer (0);
      V : Big_Integer := abs N;
   begin
      while V /= 0 loop
         R := R * Base + V mod Base;
         V := V / Base;
      end loop;
      return R;
   end Reverse_Digits;

   function Is_Palindrome
     (N : Big_Integer; Base : Big_Integer := 10) return Boolean is
     (N >= 0 and then Reverse_Digits (N, Base) = N);
   function Is_Harshad
     (N : Big_Integer; Base : Big_Integer := 10) return Boolean is
     (N > 0 and then N mod Sumdigits (N, Base) = 0);
   function Digital_Root
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer is
     (if N = 0 then To_Big_Integer (0) else 1 + (abs N - 1) mod (Base - 1));

   function Mult_Digital_Root
     (N : Big_Integer; Base : Big_Integer := 10) return Big_Integer
   is
      R : Big_Integer := abs N;
      V : Big_Integer;
   begin
      while R >= Base loop
         V := R;
         R := To_Big_Integer (1);
         while V /= 0 loop
            R := R * (V mod Base);
            V := V / Base;
         end loop;
      end loop;
      return R;
   end Mult_Digital_Root;

   function Hammingweight (N : Big_Integer) return Natural is
      V : Big_Integer := abs N;
      Count : Natural := 0;
   begin
      while V /= 0 loop
         Count := Count + To_Integer (V mod 2);
         V := V / 2;
      end loop;
      return Count;
   end Hammingweight;

   function Tozeckendorf (N : Big_Integer) return String is
      A : Big_Integer := To_Big_Integer (0);
      B : Big_Integer := To_Big_Integer (1);
      C : Big_Integer := To_Big_Integer (1);
      V : Big_Integer := N;
      Count : Natural := 0;
   begin
      if N = 0 then
         return "0";
      end if;
      while C <= V loop
         A := B;
         B := C;
         C := A + B;
         Count := Count + 1;
      end loop;
      return Result : String (1 .. Count) do
         for I in Result'Range loop
            C := B;
            B := A;
            A := C - B;
            Result (I) := (if C <= V then '1' else '0');
            if C <= V then
               V := V - C;
            end if;
         end loop;
      end return;
   end Tozeckendorf;

   function Fromzeckendorf (Text : String) return Big_Integer is
      A : Big_Integer := To_Big_Integer (1);
      B : Big_Integer := To_Big_Integer (2);
      C : Big_Integer;
      R : Big_Integer := To_Big_Integer (0);
   begin
      if Text = "0" then
         return R;
      end if;
      if Text'Length = 0 or else Text (Text'First) /= '1' then
         raise Constraint_Error with "invalid Zeckendorf representation";
      end if;
      for I in reverse Text'Range loop
         if Text (I) not in '0' | '1' or else
           (I > Text'First and then Text (I) = '1'
            and then Text (I - 1) = '1')
         then
            raise Constraint_Error with "invalid Zeckendorf representation";
         end if;
         if Text (I) = '1' then
            R := R + A;
         end if;
         C := A + B;
         A := B;
         B := C;
      end loop;
      return R;
   end Fromzeckendorf;

   function Toint (Text : String) return Big_Integer is
      Native : constant Optional_I128 := Digit_Operations.Toint (Text);
   begin
      if Native.Defined then
         return From_String (I128'Image (Native.Value));
      end if;
      return From_String (Text);
   end Toint;
end Math_Prime_Util.Digit_Operations.Bigints;
