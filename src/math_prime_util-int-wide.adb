package body Math_Prime_Util.Int.Wide with SPARK_Mode => On is
   function Addmod (A, B, N : U128) return U128 is
      NB : constant U128 := N - B;
   begin
      return (if A >= NB then A - NB else A + B);
   end Addmod;

   function Submod (A, B, N : U128) return U128 is
   begin
      return (if A >= B then A - B else N - (B - A));
   end Submod;

   function Mulmod (A, B, N : U128) return U128 is
      X : U128 := A mod N;
      Y : U128 := B mod N;
      R : U128 := 0;
      Temp : U128;
   begin
      if X <= U128 (U64'Last) and then Y <= U128 (U64'Last) then
         return (X * Y) mod N;
      end if;
      if X < Y then
         Temp := X;
         X := Y;
         Y := Temp;
      end if;
      while Y > 0 loop
         pragma Loop_Invariant (X < N and R < N);
         pragma Loop_Variant (Decreases => Y);
         if Y mod 2 = 1 then
            R := Addmod (R, X, N);
         end if;
         X := Addmod (X, X, N);
         Y := Y / 2;
      end loop;
      return R;
   end Mulmod;

   function Gcd (A, B : U128) return U128 is
      X : U128 := A;
      Y : U128 := B;
      Temp : U128;
   begin
      while Y /= 0 loop
         pragma Loop_Variant (Decreases => Y);
         Temp := Y;
         Y := X mod Y;
         X := Temp;
      end loop;
      return X;
   end Gcd;

   function Sqrtint (N : U128) return U64 is
      R : U128 := 1;
      Temp : U128 := N;
      Next : U128;
   begin
      if N = 0 then
         return 0;
      end if;
      while Temp > 3 loop
         pragma Loop_Variant (Decreases => Temp);
         Temp := Temp / 4;
         R := R * 2;
      end loop;
      R := R * 2;
      loop
         Next := (R + N / R) / 2;
         exit when Next >= R;
         R := Next;
      end loop;
      --  Compare by division so the square of 2**64 cannot wrap.
      while R > N / R loop
         R := R - 1;
      end loop;
      return U64 (R);
   end Sqrtint;

   function Is_Square (N : U128) return Boolean is
      R : constant U128 := U128 (Sqrtint (N));
   begin
      return R * R = N;
   end Is_Square;
end Math_Prime_Util.Int.Wide;
