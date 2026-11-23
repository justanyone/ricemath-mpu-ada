with Math_Prime_Util.Primality;

package body Math_Prime_Util.Arith is
   use type U64;
   use type Primality.Prime_Result;

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
