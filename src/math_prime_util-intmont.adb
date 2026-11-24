package body Math_Prime_Util.Intmont is
   use type U128;
   function Powmod (A, K, N : U64) return U64 is
      R : constant U128 := 2 ** 64;
      Mask : constant U128 := R - 1;
      Inverse : U64 := (3 * N) xor 2;
      One : constant U64 := U64 (R mod U128 (N));
      X : U64 := U64 ((U128 (A) * U128 (One)) mod U128 (N));
      Y : U64 := One;
      E : U64 := K;
      function Multiply (L, V : U64) return U64 is
         Product : constant U128 := U128 (L) * U128 (V);
         M : constant U64 := U64 (Product and Mask) * Inverse;
         Correction : constant U128 := U128 (M) * U128 (N);
         Carry : constant U128 :=
           ((Product and Mask) + (Correction and Mask)) / R;
         High : constant U128 := Product / R + Correction / R + Carry;
      begin
         return U64 (if High >= U128 (N) then High - U128 (N)
                     else High);
      end Multiply;
   begin
      for I in 1 .. 4 loop
         Inverse := Inverse * (2 - N * Inverse);
      end loop;
      Inverse := 0 - Inverse;
      while E > 0 loop
         if E mod 2 = 1 then
            Y := Multiply (Y, X);
         end if;
         E := E / 2;
         if E > 0 then
            X := Multiply (X, X);
         end if;
      end loop;
      return Multiply (Y, 1);
   end Powmod;
end Math_Prime_Util.Intmont;
