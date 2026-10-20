with Interfaces;
with Math_Prime_Util.Int;

--  Lucas sequences from Math::Prime::Util 0.75, reference/mpu/lucas_seq.c.
package Math_Prime_Util.Lucas with SPARK_Mode => On is
   use type U64;
   use type Int.I128;
   subtype I64 is Interfaces.Integer_64;
   subtype I128 is Int.I128;
   type Optional_Integer (Defined : Boolean := False) is record
      case Defined is
         when True => Value : I128;
         when False => null;
      end case;
   end record;
   type Integer_Pair is record
      U, V : Optional_Integer;
   end record;
   type Residue_Pair is record
      U, V : U64;
   end record;
   type Sequence_Result is record
      U, V, Qk : U64;
   end record;

   --  lucas_seq.c: lucasuv. Exact U and V; undefined beyond native range.
   function Lucasuv (P, Q : I64; K : U64) return Integer_Pair
     with Pre => True,
          Post => (if K = 0 then Lucasuv'Result.U.Value = 0
                   and Lucasuv'Result.V.Value = 2);
   --  lucas_seq.c: lucasuv (U output). Undefined on native overflow.
   function Lucasu (P, Q : I64; K : U64) return Optional_Integer
     with Pre => True,
          Post => (if K = 0 then Lucasu'Result.Value = 0);
   --  lucas_seq.c: lucasuv (V output). Undefined on native overflow.
   function Lucasv (P, Q : I64; K : U64) return Optional_Integer
     with Pre => True,
          Post => (if K = 0 then Lucasv'Result.Value = 2);
   --  lucas_seq.c: lucasuvmod. N must be positive; returns residues.
   function Lucasuvmod (P, Q : I64; K, N : U64) return Residue_Pair
     with Pre => N > 0,
          Post => Lucasuvmod'Result.U < N and Lucasuvmod'Result.V < N;
   --  lucas_seq.c: lucasumod. N must be positive; returns U modulo N.
   function Lucasumod (P, Q : I64; K, N : U64) return U64
     with Pre => N > 0, Post => Lucasumod'Result < N;
   --  lucas_seq.c: lucasvmod. N must be positive; returns V modulo N.
   function Lucasvmod (P, Q : I64; K, N : U64) return U64
     with Pre => N > 0, Post => Lucasvmod'Result < N;
   --  lucas_seq.c: lucas_seq. N must be positive; also returns Q**K mod N.
   function Lucas_Sequence
     (N : U64; P, Q : I64; K : U64) return Sequence_Result
     with Pre => N > 0,
          Post => Lucas_Sequence'Result.U < N
       and Lucas_Sequence'Result.V < N and Lucas_Sequence'Result.Qk < N;
   --  lucas_seq.c: fibonacci_number, _calc_fib. Signed index extension;
   --  undefined when the magnitude exceeds U64'Last.
   function Fibonacci (K : I64) return Optional_Integer
     with Pre => True,
          Post => (if K = 0 then Fibonacci'Result.Value = 0);
   --  lucas_seq.c: lucas_number, _calc_fib. Signed index extension;
   --  undefined when the magnitude exceeds U64'Last.
   function Lucas_Number (K : I64) return Optional_Integer
     with Pre => True,
          Post => (if K = 0 then Lucas_Number'Result.Value = 2);
end Math_Prime_Util.Lucas;
