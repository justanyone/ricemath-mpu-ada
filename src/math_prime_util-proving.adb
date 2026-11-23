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
end Math_Prime_Util.Proving;
