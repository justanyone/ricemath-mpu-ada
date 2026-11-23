with Math_Prime_Util.Int;

--  Native arithmetic functions from MPU 0.75 totients.c and moebius.c.
package Math_Prime_Util.Arith with SPARK_Mode => On is
   use type U64;
   use type Int.I128;
   subtype Signed_Input is Int.I128 range -Int.I128 (U64'Last) ..
     Int.I128 (U64'Last);
   subtype Sign_Value is Integer range -1 .. 1;
   subtype Liouville_Value is Sign_Value
     with Static_Predicate => Liouville_Value /= 0;

   --  totients.c: totient. Count positive integers coprime to N.
   --  Nonpositive signed inputs return zero; no error cases.
   function Euler_Phi (N : Signed_Input) return U64
     with Pre => True,
          Post => (if N <= 0 then Euler_Phi'Result = 0
                   else Euler_Phi'Result <= U64 (N));

   --  totients.c: jordan_totient. Count coprime K-tuples modulo N.
   --  J_0(N) is one only at N=1. Undefined if the result exceeds U64.
   function Jordan_Totient (K, N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if N = 1 then Jordan_Totient'Result.Defined
                   and then Jordan_Totient'Result.Value = 1);

   --  moebius.c: moebius. Squarefree parity of abs(N); mu(0)=0.
   --  Returns -1, 0, or 1 in integer units; no error cases.
   function Moebius (N : Signed_Input) return Sign_Value
     with Pre => True, Post => (if N = 0 then Moebius'Result = 0);

   --  moebius.c: mertens. Sum mu(i) for 1 <= i <= N; M(0)=0.
   --  Exact signed integer result; workspace is local to the call.
   function Mertens (N : U64) return Int.I128
     with Pre => True,
          Post => abs Mertens'Result <= Int.I128 (N);

   --  moebius.c: mertens_range. Sum mu(i) over inclusive Lo..Hi.
   --  Empty ranges return zero; zero contributes zero. No error cases.
   function Mertens (Lo, Hi : U64) return Int.I128
     with Pre => True,
          Post => (if Lo > Hi then Mertens'Result = 0);

   --  moebius.c: liouville. Parity of prime factors with multiplicity.
   --  Returns -1 or 1; MPU defines liouville(0)=-1. No error cases.
   function Liouville (N : U64) return Liouville_Value
     with Pre => True, Post => (if N = 0 then Liouville'Result = -1);

   --  util.c: exp_mangoldt. Prime base of a prime power, otherwise one.
   --  Integer exponential of the von Mangoldt function; no error cases.
   function Exp_Mangoldt (N : U64) return U64
     with Pre => True,
          Post => Exp_Mangoldt'Result >= 1
       and (if N > 1 then Exp_Mangoldt'Result <= N);
end Math_Prime_Util.Arith;
