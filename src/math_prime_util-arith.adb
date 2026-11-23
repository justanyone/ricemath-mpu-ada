with Math_Prime_Util.Factor;

package body Math_Prime_Util.Arith with SPARK_Mode => On is
   use type U128;

   --  A native integer has at most N divisors, each at most N, so sigma
   --  fits U128. Cap intermediate products before any modular wrap.
   function Sigma (N, K : U64; Limit : U128) return U128
     with Pre => Limit in 1 .. U128'Last - 1
   is
      Factors : constant Factor.Factor_List := Factor.Factor (N);
      Product : U128 := 1;
      I : Positive := 1;
   begin
      if N <= 1 then
         return U128 (N);
      end if;
      while I <= Factors.Count loop
         declare
            P : constant U128 := U128 (Factors.Value (I));
            Power : U128 := 1;
            Term : U128 := 1;
            Sum : U128 := 1;
            Exponent : Natural := 0;
         begin
            while I <= Factors.Count
              and then U128 (Factors.Value (I)) = P
            loop
               Exponent := Exponent + 1;
               I := I + 1;
            end loop;
            --  P >= 2, hence P**K exceeds a native result for K >= 64.
            --  For K = 1 the wider limit retains sigma before subtraction.
            if K >= 64 then
               return Limit + 1;
            end if;
            for J in 1 .. Natural (K) loop
               if Power > Limit / P then
                  return Limit + 1;
               end if;
               Power := Power * P;
            end loop;
            for J in 1 .. Exponent loop
               if Term > Limit / Power then
                  return Limit + 1;
               end if;
               Term := Term * Power;
               if Sum > Limit - Term then
                  return Limit + 1;
               end if;
               Sum := Sum + Term;
            end loop;
            if Product > Limit / Sum then
               return Limit + 1;
            end if;
            Product := Product * Sum;
         end;
      end loop;
      return Product;
   end Sigma;

   function Native (Value : U128) return Optional_U64 is
   begin
      if Value > U128 (U64'Last) then
         return (Defined => False);
      end if;
      return (True, U64 (Value));
   end Native;

   function Divisor_Sum (N : U64; K : U64 := 1) return Optional_U64 is
   begin
      return Native (Sigma (N, K, U128 (U64'Last)));
   end Divisor_Sum;

   function Aliquot_Sum (N : U64) return Optional_U64 is
   begin
      if N <= 1 then
         return (True, 0);
      end if;
      return Native (Sigma (N, 1, U128'Last - 1) - U128 (N));
   end Aliquot_Sum;

   function Abundance (N : U64) return I128 is
   begin
      if N = 0 then
         return 0;
      end if;
      return I128 (Sigma (N, 1, U128'Last - 1)) - 2 * I128 (N);
   end Abundance;

   function Sopf (N : U64) return U64 is
      Factors : constant Factor.Factor_List := Factor.Factor (N);
      Sum : U64 := 0;
      Previous : U64 := 0;
   begin
      for I in 1 .. Factors.Count loop
         if Factors.Value (I) /= Previous then
            Sum := Sum + Factors.Value (I);
            Previous := Factors.Value (I);
         end if;
      end loop;
      return Sum;
   end Sopf;

   function Sopfr (N : U64) return U64 is
      Factors : constant Factor.Factor_List := Factor.Factor (N);
      Sum : U64 := 0;
   begin
      for I in 1 .. Factors.Count loop
         Sum := Sum + Factors.Value (I);
      end loop;
      return Sum;
   end Sopfr;
end Math_Prime_Util.Arith;
