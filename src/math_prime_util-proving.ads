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

   --  PrimalityProving.pm: _small_cert. Return an MPU 1.0 Small certificate
   --  for a native prime, or the empty string for a composite. No errors.
   function Prime_Certificate (N : U64) return String
     with Pre => True,
          Post => (if N < 2 then Prime_Certificate'Result'Length = 0);

   type Certified_Result (Certificate_Length : Natural) is record
      Result : Primality.Prime_Result;
      Certificate : String (1 .. Certificate_Length);
   end record;
   --  PrimalityProving.pm: is_provable_prime_with_cert. Result and text;
   --  composites return 0 and empty text.
   function Is_Provable_Prime_With_Cert (N : U64) return Certified_Result
     with Pre => True,
          Post => Is_Provable_Prime_With_Cert'Result.Result in 0 | 2;

   --  Check a decimal MPU 1.0 certificate containing one Small or BLS5
   --  proof for a U64 candidate. Malformed, unsupported, or non-native
   --  certificates return False; no parsing exceptions are propagated.
   function Verify_Prime (Certificate : String) return Boolean
     with Pre => Certificate'Last < Integer'Last,
          Post => (if Certificate'Length = 0 then not Verify_Prime'Result);
end Math_Prime_Util.Proving;
