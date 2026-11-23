with Math_Prime_Util.Int;

--  Native modular helpers from Math::Prime::Util 0.75.
--  Roots and Cornacchia come from rootmod.c and util.c.
--  Znlog, factorialmod, binomialmod, and the Pisano period come from
--  znlog.c, factmod.c, and util.c.
package Math_Prime_Util.Modular with SPARK_Mode => On is
   use Math_Prime_Util.Int;
   use type U64;
   use type U128;
   subtype I128 is Int.I128;
   type Root_List is array (Positive range <>) of U64;
   type Cornacchia_Result (Defined : Boolean := False) is record
      case Defined is
         when True => X, Y : U64;
         when False => null;
      end case;
   end record;

   --  sqrtmod: a root of A modulo N, minimized against its negative.
   --  Undefined for N = 0 or no root. A is reduced modulo N.
   function Sqrtmod (A : I128; N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Sqrtmod'Result.Defined then N > 0 and then
                     Sqrtmod'Result.Value <= N / 2 and then
                     Int.Sqrmod (Sqrtmod'Result.Value, N).Value =
                       U64 (A mod I128 (N)));

   --  allsqrtmod: all square roots, sorted; empty for N = 0 or no root.
   --  Raises Errors.Maximum_Roots_Exceeded above MPU's 600000000 root cap.
   function Allsqrtmod (A : I128; N : U64) return Root_List
     with Pre => True,
          Post => (for all R of Allsqrtmod'Result =>
                     R < N and then Int.Sqrmod (R, N).Value =
                       U64 (A mod I128 (N)));

   --  rootmod: one K-th root; negative K first inverts A modulo N.
   --  Undefined for N = 0, no inverse, or no root; K = 0 uses x**0 = 1.
   function Rootmod (A, K : I128; N : U64) return Int.Optional_U64
     with Pre => K in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (if Rootmod'Result.Defined then
                     N > 0 and then Rootmod'Result.Value < N and then
                     (if K >= 0 then
                        Int.Powmod (Rootmod'Result.Value, U64 (K), N).Value
                          = U64 (A mod I128 (N))
                      else Int.Mulmod
                        (Int.Powmod (Rootmod'Result.Value, U64 (-K), N).Value,
                         U64 (A mod I128 (N)), N).Value = 1 mod N));

   --  allrootmod: all K-th roots sorted, with the same domain as Rootmod.
   --  Empty for undefined results; Errors.Maximum_Roots_Exceeded at the cap.
   function Allrootmod (A, K : I128; N : U64) return Root_List
     with Pre => K in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (for all R of Allrootmod'Result =>
                     R < N and then
                     (if K >= 0 then
                        Int.Powmod (R, U64 (K), N).Value =
                          U64 (A mod I128 (N))
                      else Int.Mulmod
                        (Int.Powmod (R, U64 (-K), N).Value,
                         U64 (A mod I128 (N)), N).Value = 1 mod N));

   --  util.c: cornacchia. Solve X**2 + D*Y**2 = N in native integers.
   --  Undefined if no solution exists; N = 0 returns (0, 0).
   function Cornacchia (D, N : U64) return Cornacchia_Result
     with Pre => True,
          Post => (if Cornacchia'Result.Defined then
            U128 (Cornacchia'Result.X) ** 2 <= U128 (N) and then
            (if D > 0 then U128 (Cornacchia'Result.Y) ** 2 <=
               U128 (N) / U128 (D)) and then
            U128 (Cornacchia'Result.X) ** 2 + U128 (D) *
              U128 (Cornacchia'Result.Y) ** 2 = U128 (N));

   --  znlog.c: znlog. Smallest exponent X with G**X = A modulo M.
   --  Undefined for M = 0 or when no exponent exists; M = 1 returns 0.
   function Znlog (A, G, M : U64) return Optional_U64
     with Pre => True,
          Post => (if Znlog'Result.Defined then M > 0 and then
                     Powmod (G, Znlog'Result.Value, M).Value = A mod M);

   --  factmod.c: factorialmod. N! modulo M, in residue units.
   --  Undefined for M = 0; no intermediate factorial is constructed.
   function Factorialmod (N, M : U64) return Optional_U64
     with Pre => True,
          Post => (if Factorialmod'Result.Defined then M > 0 and then
                     Factorialmod'Result.Value < M);

   --  factmod.c: binomialmod. Generalized signed binomial modulo M.
   --  Inputs have at most 64 magnitude bits. Undefined for M = 0.
   function Binomialmod (N, K : I128; M : U64) return Optional_U64
     with Pre => N in -I128 (U64'Last) .. I128 (U64'Last)
       and then K in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (if Binomialmod'Result.Defined then M > 0 and then
                     Binomialmod'Result.Value < M);

   --  util.c: pisano_period, _pisano_prime_power. Fibonacci period mod N.
   --  Returns 0 for N = 0; undefined if the period exceeds U64'Last.
   function Pisano_Period (N : U64) return Optional_U64
     with Pre => True,
          Post => (if N <= 1 then Pisano_Period'Result.Defined and then
                     Pisano_Period'Result.Value = N);
end Math_Prime_Util.Modular;
