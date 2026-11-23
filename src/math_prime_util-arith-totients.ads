--  Remaining totient arithmetic from MPU 0.75.
package Math_Prime_Util.Arith.Totients with SPARK_Mode => On is
   use type U128;

   type Optional_I128 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : I128;
         when False => null;
      end case;
   end record;

   --  totients.c: carmichael_lambda. Exponent of the units modulo N.
   --  Lambda(0)=0; no error cases.
   function Carmichael_Lambda (N : U64) return U64
     with Pre => True, Post => Carmichael_Lambda'Result <= N;

   --  totients.c: dedekind_psi. N product (1+1/p), for primes dividing N.
   --  Negative inputs return zero; undefined on native unsigned overflow.
   function Dedekind_Psi (N : Signed_Input) return Optional_U64
     with Pre => True,
          Post => (if N <= 0 then Dedekind_Psi'Result.Defined
                   and then Dedekind_Psi'Result.Value = 0);

   --  totients.c: inverse_totient_list. Sorted native preimages of N.
   --  Constraint_Error if a preimage exceeds U64; zero has no preimages.
   function Inverse_Totient (N : U64) return U64_Vectors.Vector
     with SPARK_Mode => Off, Pre => True,
          Post => (if N = 0 then Inverse_Totient'Result.Is_Empty);

   --  totients.c: inverse_totient_count. Number of preimages of N.
   --  Constraint_Error on count overflow; no list is materialized.
   function Inverse_Totient_Count (N : U64) return U64
     with SPARK_Mode => Off, Pre => True,
          Post => (if N = 1 then Inverse_Totient_Count'Result = 2);

   --  totients.c: is_totient, _totpred. Is N a positive totient value?
   --  Zero returns False; no error cases.
   function Is_Totient (N : U64) return Boolean
     with SPARK_Mode => Off, Pre => True,
          Post => (if N = 0 then not Is_Totient'Result);

   --  PP.pm: ramanujan_sum(K,N). Exact signed Ramanujan sum.
   --  Either zero argument returns zero; no error cases.
   function Ramanujan_Sum (K, N : U64) return I128
     with Pre => True, Post => abs Ramanujan_Sum'Result <= I128 (K);

   --  totients.c: sumtotient128, _sumt128. Sum phi(1..N), in U128.
   --  Exact for every native N; workspace is local to this call.
   function Sumtotient (N : U64) return U128
     with SPARK_Mode => Off, Pre => True,
          Post => (if N <= 2 then Sumtotient'Result = U128 (N));

   --  moebius.c: sumliouville. Sum lambda(1..N), signed integer units.
   --  Empty sum is zero; workspace is local to this call.
   function Sumliouville (N : U64) return I128
     with SPARK_Mode => Off, Pre => True,
          Post => abs Sumliouville'Result <= I128 (N);

   --  util.c: ramanujan_tau; PP.pm: _tauprime, _taupower fallback.
   --  Signed native coefficient, undefined outside -2**63..2**63-1.
   function Ramanujan_Tau (N : U64) return Optional_I128
     with SPARK_Mode => Off, Pre => True,
          Post => (if Ramanujan_Tau'Result.Defined then
                     Ramanujan_Tau'Result.Value in -2 ** 63 .. 2 ** 63 - 1);
end Math_Prime_Util.Arith.Totients;
