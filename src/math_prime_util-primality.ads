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

   --  util.c: is_prime.
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
   --  primality.c: is_perrin_pseudoprime, calc_perrin_sig.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Perrin_Pseudoprime
     (N : U64; Restricted : Natural := 0) return Boolean
     with Pre => Restricted <= 3,
          Post => (if N < 2 then not Is_Perrin_Pseudoprime'Result);

   --  primality.c: is_frobenius_pseudoprime.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Frobenius_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Frobenius_Pseudoprime'Result);

   --  primality.c: is_frobenius_pseudoprime_pq.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Frobenius_Pseudoprime
     (N : U64; P, Q : Interfaces.Integer_64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Frobenius_Pseudoprime'Result);

   --  primality.c: is_frobenius_khashin_pseudoprime.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Frobenius_Khashin_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Frobenius_Khashin_Pseudoprime'Result);

   --  primality.c: is_frobenius_underwood_pseudoprime.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Frobenius_Underwood_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then
             not Is_Frobenius_Underwood_Pseudoprime'Result);

   --  util.c: is_catalan_pseudoprime.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Catalan_Pseudoprime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Catalan_Pseudoprime'Result);

   --  almost_primes.c: is_chen_prime.
   --  Native predicate; invalid parameters raise Constraint_Error.
   function Is_Chen_Prime
     (N : U64) return Boolean
     with Pre => True,
          Post => (if N < 2 then not Is_Chen_Prime'Result);

   --  util.c: is_delicate_prime. Base >= 2; undefined on digit overflow.
   function Is_Delicate_Prime
     (N : U64; Base : U64 := 10) return Mersenne_Result
     with Pre => Base >= 2,
          Post => (if N < 2 then Is_Delicate_Prime'Result.Defined);

end Math_Prime_Util.Primality;
