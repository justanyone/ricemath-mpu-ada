--  Internal inverse search shared by lucky and Ramanujan estimates.
--  MPU 0.75 inverse_interpolate.c: inverse_interpolate, zero threshold.
generic
   type Wide is digits <>;
   with function Value (X : U64) return U64;
private function Math_Prime_Util.Inverse
  (First, Last, Target : U64) return U64
  with SPARK_Mode => On,
       Pre => First <= Last,
       Post => Inverse'Result >= First and then Inverse'Result <= Last;
