with Math_Prime_Util.Primality;

--  Native primality proofs from MPU 0.75.
package Math_Prime_Util.Proving with SPARK_Mode => On is
   use type U64;
   use type Primality.Prime_Result;

   --  aks.c: is_aks_prime (the IMPL_V6 variant). Deterministic AKS test
   --  for an unsigned integer. No errors; large primes can be very slow.
   function Is_Aks_Prime (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Aks_Prime'Result);

   --  PrimalityProving.pm: native proof shortcut. Returns 0 for composites
   --  and 2 for primes; the native tier has no inconclusive result.
   function Is_Provable_Prime (N : U64) return Primality.Prime_Result
     with Pre => True,
          Post => Is_Provable_Prime'Result in 0 | 2
            and then (if N < 2 then Is_Provable_Prime'Result = 0);
end Math_Prime_Util.Proving;
