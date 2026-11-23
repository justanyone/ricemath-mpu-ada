with Math_Prime_Util.Int;

--  Native U64 callback operations from MPU 0.75 XS.xs and PP.pm.
--  Callbacks receive values, never aliases into the input arrays.
--  Callback exceptions propagate; callback arithmetic is the caller's policy.
package Math_Prime_Util.Vec.Folds with SPARK_Mode => On is
   use type U64;

   type Value_Array is array (Positive range <>) of U64;

   --  XS.xs vecreduce: left fold, undefined on empty input.
   generic
      with function Block (A, B : U64) return U64;
   function Vecreduce (Items : Value_Array) return Int.Optional_U64
     with Post => Vecreduce'Result.Defined = (Items'Length > 0);

   --  XS.xs vecslide: one scalar result per adjacent pair, in order.
   generic
      with function Block (A, B : U64) return U64;
   function Vecslide (Items : Value_Array) return Value_Array
     with Post => Vecslide'Result'Length =
       (if Items'Length = 0 then 0 else Items'Length - 1);

   --  XS.xs vecpairwise: concatenate block lists for corresponding pairs.
   --  Stop at the shorter input; empty callback results are allowed.
   generic
      with function Block (A, B : U64) return Value_Array;
   function Vecpairwise (Left, Right : Value_Array) return Value_Array
     with Post => (if Left'Length = 0 or Right'Length = 0
                   then Vecpairwise'Result'Length = 0);

   --  XS.xs / PP.pm vecwindow: concatenate lists from full windows only.
   --  Step and Size count elements and must be positive (Constraint_Error).
   generic
      with function Block (Window : Value_Array) return Value_Array;
   function Vecwindow
     (Step, Size : Positive; Items : Value_Array) return Value_Array
     with Post => (if Size > Items'Length
                   then Vecwindow'Result'Length = 0);

   --  PP.pm setbinop: canonicalize inputs, visit their Cartesian product,
   --  and return sorted unique block results. Null Right means Left x Left;
   --  pass an access to an empty array for an explicit empty second set.
   generic
      with function Block (A, B : U64) return U64;
   function Setbinop
     (Left : Value_Array; Right : access constant Value_Array := null)
      return Value_Array
     with Post => (for all I in Setbinop'Result'First ..
                     Setbinop'Result'Last - 1 =>
                       Setbinop'Result (I) < Setbinop'Result (I + 1));
end Math_Prime_Util.Vec.Folds;
