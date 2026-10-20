--  Real functions from Math::Prime::Util 0.75.
package Math_Prime_Util.Real is
   subtype F64 is Long_Float;
   --  real.c: Ei, _Ei. Exponential integral; zero returns -Inf (XS.xs).
   function Exponential_Integral (X : F64) return F64
     with Pre => True, Post => True;
   --  real.c: Li, _Li. Logarithmic integral; negative is invalid.
   function Logarithmic_Integral (X : F64) return F64
     with Pre => X >= 0.0 or else X /= X, Post => True;
   --  real.c: ld_riemann_zeta. Returns zeta(X) minus one.
   function Riemann_Zeta (X : F64) return F64
     with Pre => X >= 0.0 or else X /= X, Post => True;
   --  real.c: RiemannR. Prime counting estimate; X must be positive.
   function Riemann_R
     (X : F64; Epsilon : F64 := 1.0E-16) return F64
     with Pre => X > 0.0 or else X /= X, Post => True;
   --  real.c: lambertw. Principal real branch; X must be >= -1/e.
   function Lambert_W (X : F64) return F64
     with Pre => X >= -0.36787944117145 or else X /= X,
          Post => True;
   --  real.c: inverse_li. Integral ceiling of the inverse li, or zero.
   function Inverse_Li (X : F64) return F64
     with Pre => X >= 0.0 and then X <= F64'Last / 1024.0,
          Post => Inverse_Li'Result >= 0.0;
   --  real.c: ld_inverse_li; XS.xs: inverse_li_nv. Real inverse li.
   function Inverse_Li_Nv (X : F64) return F64
     with Pre => X >= 0.0 and then X <= F64'Last / 1024.0,
          Post => Inverse_Li_Nv'Result > 1.0;
   --  util.c: pidigits; XS.xs: Pi. Rounded significant decimal digits.
   function Pi (Digit_Count : Natural := 0) return String
     with Pre => Digit_Count <= 100_000, Post => Pi'Result'Length > 0;
   --  Util.pm: bernreal. Bernoulli B_n with positive B_1.
   function Bernreal (N : Natural) return F64
     with Pre => N <= 258, Post => True;
   --  PP.pm: harmreal. Harmonic sum of reciprocals from 1 through N.
   function Harmreal (N : Natural) return F64
     with Pre => True, Post => Harmreal'Result >= 0.0;
end Math_Prime_Util.Real;
