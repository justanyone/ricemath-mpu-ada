with Math_Prime_Util.Int;
with Math_Prime_Util.Sieve;

--  Ramanujan primes from MPU 0.75 ramanujan_primes.c.
--  Integer arguments and results are dimensionless. Bound violations raise
--  Assertion_Error with contracts enabled. Exact sieves may raise
--  Storage_Error.
--  Nth bounds return zero when the bound exceeds the native prime range.
package Math_Prime_Util.Ramanujan with SPARK_Mode => On is
   use type U64;
   --  Exact operations are bounded by the prime-count backend.
   Exact_Limit : constant U64 := 10_000_000_000_000;
   Index_Limit : constant U64 := 200_000_000_000;

   --  Inclusive interval; reversed bounds are empty. Storage_Error may occur.
   function Ramanujan_Primes (Low, High : U64)
      return Sieve.Prime_Vectors.Vector
     with Pre => High <= Exact_Limit,
          Post => (for all P of Ramanujan_Primes'Result =>
                     P >= Low and then P <= High);
   --  List Ramanujan primes through High. Storage_Error may occur.
   function Ramanujan_Primes (High : U64) return Sieve.Prime_Vectors.Vector
     with Pre => High <= Exact_Limit,
          Post => (for all P of Ramanujan_Primes'Result => P <= High);
   --  Test membership; Storage_Error may occur in window generation.
   function Is_Ramanujan_Prime (N : U64) return Boolean
     with Pre => N <= Exact_Limit,
          Post => (if N < 2 then not Is_Ramanujan_Prime'Result);
   --  Count Ramanujan primes through N; Storage_Error may occur.
   function Ramanujan_Prime_Count (N : U64) return U64
     with Pre => N <= Exact_Limit,
          Post => Ramanujan_Prime_Count'Result <= N;
   --  Count an inclusive interval; reversed bounds return zero.
   function Ramanujan_Prime_Count (Low, High : U64) return U64
     with Pre => High <= Exact_Limit,
          Post => (if Low > High then Ramanujan_Prime_Count'Result = 0);
   --  Exact one-based value; zero is undefined. Storage_Error may occur.
   function Nth_Ramanujan_Prime (N : U64) return Int.Optional_U64
     with Pre => N <= Index_Limit,
          Post => Nth_Ramanujan_Prime'Result.Defined = (N /= 0);
   --  Lower bound on the one-based value; zero is undefined.
   function Nth_Ramanujan_Prime_Lower (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Ramanujan_Prime_Lower'Result.Defined = (N /= 0);
   --  Upper bound on the one-based value; zero is undefined.
   function Nth_Ramanujan_Prime_Upper (N : U64) return Int.Optional_U64
     with Pre => N <= 425_656_284_035_217_743,
          Post => Nth_Ramanujan_Prime_Upper'Result.Defined = (N /= 0);
   --  Estimate of the one-based value; zero is undefined.
   function Nth_Ramanujan_Prime_Approx (N : U64) return Int.Optional_U64
     with Pre => N <= Index_Limit,
          Post => Nth_Ramanujan_Prime_Approx'Result.Defined = (N /= 0);
   --  Lower count bound through N, including the native maximum.
   function Ramanujan_Prime_Count_Lower (N : U64) return U64
     with Pre => True,
          Post => Ramanujan_Prime_Count_Lower'Result <= N;
   --  Upper count bound through N, including the native maximum.
   function Ramanujan_Prime_Count_Upper (N : U64) return U64
     with Pre => True,
          Post => Ramanujan_Prime_Count_Upper'Result <= N;
   --  Count estimate through N, including the native maximum.
   function Ramanujan_Prime_Count_Approx (N : U64) return U64
     with Pre => True,
          Post => Ramanujan_Prime_Count_Approx'Result <= N;
end Math_Prime_Util.Ramanujan;
