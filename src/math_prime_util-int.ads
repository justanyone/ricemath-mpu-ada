--  Integer helpers from Math::Prime::Util 0.75.
package Math_Prime_Util.Int with SPARK_Mode => On is
   use type U64;
   use type U128;

   --  Undefined results include zero moduli and native integer overflow.
   type Optional_U64 (Defined : Boolean := False) is record
      case Defined is
         when True => Value : U64;
         when False => null;
      end case;
   end record;

   --  Wide signed intermediates keep Bezout coefficients exact.
   type I128 is range -(2 ** 127) .. 2 ** 127 - 1;
   type Bezout_Result is record
      D : U64;
      X, Y : I128;
   end record;

   --  util.h: gcd_ui. Greatest common divisor; Gcd (0, 0) = 0.
   function Gcd (A, B : U64) return U64
     with Pre => True,
          Post => (if Gcd'Result = 0 then A = 0 and B = 0
                   else A mod Gcd'Result = 0 and B mod Gcd'Result = 0);

   --  util.c: gcdext. Signed native inputs; no error cases.
   function Gcdext (A, B : I128) return Bezout_Result
     with Pre => A in -(2 ** 63) .. 2 ** 63 - 1
       and B in -(2 ** 63) .. 2 ** 63 - 1,
          Post => A * Gcdext'Result.X + B * Gcdext'Result.Y =
                    I128 (Gcdext'Result.D);

   --  util.h: lcm_ui, util.c: lcmsafe. Undefined on native overflow.
   function Lcm (A, B : U64) return Optional_U64
     with Pre => True,
          Post => (if A = 0 or B = 0 then
                     Lcm'Result.Defined and then Lcm'Result.Value = 0);

   --  util.h: ipow. Exact native power; undefined on overflow; 0**0 = 1.
   function Powint (A, K : U64) return Optional_U64
     with Pre => True,
          Post => (if K = 0 then
                     Powint'Result.Defined and then Powint'Result.Value = 1);

   --  util.h: isqrt. Floor square root, in integer units; no errors.
   function Sqrtint (N : U64) return U64
     with Pre => True,
          Post => U128 (Sqrtint'Result) ** 2 <= U128 (N)
       and (U128 (Sqrtint'Result) + 1) ** 2 > U128 (N);

   --  util.c: rootint. Floor K-th root; K = 0 gives zero.
   function Rootint (N, K : U64) return U64
     with Pre => True, Post => Rootint'Result <= N;

   --  util.c: crootint. Ceiling K-th root; K = 0 gives zero.
   function Crootint (N, K : U64) return U64
     with Pre => True, Post => Crootint'Result <= N;

   --  util.c: logint. Floor logarithm to base B; N > 0 and B >= 2.
   function Logint (N, B : U64) return U64
     with Pre => N > 0 and B >= 2, Post => Logint'Result <= 63;

   --  util.h: is_perfect_square_ret. Includes zero and one; no errors.
   function Is_Square (N : U64) return Boolean
     with Pre => True,
          Post => Is_Square'Result = (Sqrtint (N) ** 2 = N);

   --  util.c: is_power_ret. Test an exact K-th power; K must be positive.
   function Is_Power (N, K : U64) return Boolean
     with Pre => K > 0,
          Post => (if N < 2 or K = 1 then Is_Power'Result);

   --  util.c: powerof_ret. Largest exponent >= 2; zero if none or N < 2.
   function Is_Power_Exp (N : U64) return U64
     with Pre => True, Post => Is_Power_Exp'Result <= 63;

   --  mulmod.h: addmod. Residue in [0, N); undefined for N = 0.
   function Addmod (A, B, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Addmod'Result.Defined then
                     N > 0 and then Addmod'Result.Value < N);

   --  mulmod.h: submod. Residue in [0, N); undefined for N = 0.
   function Submod (A, B, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Submod'Result.Defined then
                     N > 0 and then Submod'Result.Value < N);

   --  mulmod.h: mulmod. Residue in [0, N); undefined for N = 0.
   function Mulmod (A, B, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Mulmod'Result.Defined then
                     N > 0 and then Mulmod'Result.Value < N);

   --  mulmod.h: powmod. Residue in [0, N); undefined for N = 0.
   function Powmod (A, K, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Powmod'Result.Defined then
                     N > 0 and then Powmod'Result.Value < N);

   --  mulmod.h: sqrmod. Residue in [0, N); undefined for N = 0.
   function Sqrmod (A, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Sqrmod'Result.Defined then
                     N > 0 and then Sqrmod'Result.Value < N);

   --  mulmod.h: negmod. Residue in [0, N); undefined for N = 0.
   function Negmod (A, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Negmod'Result.Defined then
                     N > 0 and then Negmod'Result.Value < N);

   --  mulmod.h: muladdmod. Residue in [0, N); undefined for N = 0.
   function Muladdmod (A, B, C, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Muladdmod'Result.Defined then
                     N > 0 and then Muladdmod'Result.Value < N);

   --  mulmod.h: mulsubmod. Residue in [0, N); undefined for N = 0.
   function Mulsubmod (A, B, C, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Mulsubmod'Result.Defined then
                     N > 0 and then Mulsubmod'Result.Value < N);

   --  util.c: modinverse. Residue in [0, N); undefined for N = 0.
   --  Also undefined when A has no multiplicative inverse.
   function Invmod (A, N : U64) return Optional_U64
     with Pre => True,
          Post => (if Invmod'Result.Defined then
                     N > 0 and then Invmod'Result.Value < N);
end Math_Prime_Util.Int;
