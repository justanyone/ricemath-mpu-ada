with Interfaces;

--  Native primality predicates from MPU 0.75.
package Math_Prime_Util.Primality with SPARK_Mode => On is
   use type U64;
   subtype Prime_Result is Interfaces.Unsigned_8 range 0 .. 2;
   use type Prime_Result;
   type Mersenne_Result (Defined : Boolean := False) is record
      case Defined is
         when True => Value : Boolean;
         when False => null;
      end case;
   end record;

   --  primality.c: is_prob_prime.
   --  Native integer input; returns the MPU primality result.
   function Is_Prime
     (N : U64) return Prime_Result
     with Pre => True,
          Post => (if N < 2 then Is_Prime'Result = 0);

   --  primality.c: is_prob_prime.
   --  Native integer input; returns the MPU primality result.
   function Is_Prob_Prime
     (N : U64) return Prime_Result
     with Pre => True,
          Post => (if N < 2 then Is_Prob_Prime'Result = 0);

   --  primality.c: BPSW.
   --  Tests the supplied integer; no mutable shared state.
   function Is_Bpsw_Prime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Bpsw_Prime'Result);

   --  primality.c: is_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   --  A must be at least 2; invalid bases fail the precondition.
   function Is_Pseudoprime
     (N, A : U64) return Boolean
     with Pre => A >= 2,
          Post => (if N < 2 then not Is_Pseudoprime'Result);

   --  primality.c: is_euler_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   --  A must be at least 2; invalid bases fail the precondition.
   function Is_Euler_Pseudoprime
     (N, A : U64) return Boolean
     with Pre => A >= 2,
          Post => (if N < 2 then not Is_Euler_Pseudoprime'Result);

   --  primality.c: is_strong_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   --  A must be at least 2; invalid bases fail the precondition.
   function Is_Strong_Pseudoprime
     (N, A : U64) return Boolean
     with Pre => A >= 2,
          Post => (if N < 2 then not Is_Strong_Pseudoprime'Result);

   --  primality.c: is_euler_plumb_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   function Is_Euler_Plumb_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Euler_Plumb_Pseudoprime'Result);

   --  primality.c: is_lucas_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   function Is_Lucas_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Lucas_Pseudoprime'Result);

   --  primality.c: is_lucas_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   function Is_Strong_Lucas_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Strong_Lucas_Pseudoprime'Result);

   --  primality.c: is_lucas_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   function Is_Extra_Strong_Lucas_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Extra_Strong_Lucas_Pseudoprime'Result);

   --  primality.c: is_almost_extra_strong_lucas_pseudoprime.
   --  Tests the supplied integer; no mutable shared state.
   --  Increment must be in 1 .. 256; checked by the precondition.
   function Is_Almost_Extra_Strong_Lucas_Pseudoprime
     (N : U64; Increment : U64 := 1) return Boolean
     with Pre => Increment in 1 .. 256,
          Post => (if N < 2 then
             not Is_Almost_Extra_Strong_Lucas_Pseudoprime'Result);

   --  primality.c: is_safe_prime.
   --  Tests the supplied integer; no mutable shared state.
   function Is_Safe_Prime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Safe_Prime'Result);

   --  primality.c: is_mersenne_prime.
   --  Tests the supplied integer; no mutable shared state.
   --  N is an exponent; undefined beyond the checked table.
   function Is_Mersenne_Prime
     (N : U64) return Mersenne_Result
     with Pre => True,
          Post => (if N < 2 then Is_Mersenne_Prime'Result.Defined
                   and then not Is_Mersenne_Prime'Result.Value);
end Math_Prime_Util.Primality;
