with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;

package body Math_Prime_Util.Arith with SPARK_Mode => On is
   use type U128;

   --  Sigma_1 (N) / N <= H_N < 65 for native N (dyadic groups).
   --  This bound also keeps conversion to the signed I128 type exact.
   Wide_Limit : constant U128 := U128 (U64'Last) * 128;

   --  A native integer has at most N divisors, each at most N, so sigma_1
   --  fits U128. Cap higher-power sums before any modular wrap.
   function Sigma (N, K : U64; Limit : U128) return U128
     with Pre => Limit in 1 .. U128'Last - 1,
          Post => Sigma'Result <= Limit + 1;
   function Sigma (N, K : U64; Limit : U128) return U128 is
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

   function Native (Value : U128) return Optional_U64;
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
      return Native (Sigma (N, 1, Wide_Limit) - U128 (N));
   end Aliquot_Sum;

   function Abundance (N : U64) return I128 is
   begin
      if N = 0 then
         return 0;
      end if;
      return I128 (Sigma (N, 1, Wide_Limit)) - 2 * I128 (N);
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

   --  Trial divisor count for the native inverse-sigma ranges.
   --  Containers and the scan sit outside the proved sigma routines.
   function Divisor_Count (N : U64) return U64 with SPARK_Mode => Off;
   function Divisor_Count (N : U64) return U64 is
      Remaining : U64 := N;
      Count : U64 := 1;
      Prime : U64 := 2;
   begin
      while Prime <= Remaining / Prime loop
         if Remaining mod Prime = 0 then
            declare
               Exponent : U64 := 0;
            begin
               while Remaining mod Prime = 0 loop
                  Remaining := Remaining / Prime;
                  Exponent := Exponent + 1;
               end loop;
               Count := Count * (Exponent + 1);
            end;
         end if;
         Prime := (if Prime = 2 then 3 else Prime + 2);
      end loop;
      if Remaining > 1 then
         Count := Count * 2;
      end if;
      return Count;
   end Divisor_Count;

   function Inverse_Sigma0 (K, Low, High : U64) return U64_Vectors.Vector is
      Result : U64_Vectors.Vector;
      N : U64 := Low;
   begin
      if K = 0 or else High = 0 or else K > High or else Low > High then
         return Result;
      end if;
      if N < 1 then
         N := 1;
      end if;
      while N <= High loop
         if Divisor_Count (N) = K then
            Result.Append (N);
         end if;
         exit when N = U64'Last;
         N := N + 1;
      end loop;
      return Result;
   end Inverse_Sigma0;

   function Inverse_Sigma0 (K, High : U64) return U64_Vectors.Vector is
     (Inverse_Sigma0 (K, 1, High));

   function Inverse_Sigma0_Count (K, Low, High : U64) return U64 is
      use type Primality.Prime_Result;
      Result : U64 := 0;
      N : U64 := Low;
   begin
      if K = 0 or else High = 0 or else K > High or else Low > High then
         return 0;
      end if;
      if K = 1 then
         return (if Low <= 1 then 1 else 0);
      elsif K = 2 then
         N := (if Low < 2 then 2 else Low);
         while N <= High loop
            if Primality.Is_Prime (N) = 2 then
               Result := Result + 1;
            end if;
            exit when N = U64'Last;
            N := N + 1;
         end loop;
         return Result;
      end if;
      if N < 1 then
         N := 1;
      end if;
      while N <= High loop
         if Divisor_Count (N) = K then
            Result := Result + 1;
         end if;
         exit when N = U64'Last;
         N := N + 1;
      end loop;
      return Result;
   end Inverse_Sigma0_Count;

   function Inverse_Sigma0_Count (K, High : U64) return U64 is
     (Inverse_Sigma0_Count (K, 1, High));
end Math_Prime_Util.Arith;
