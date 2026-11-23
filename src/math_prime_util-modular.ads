with Math_Prime_Util.Int;

--  Native modular roots from MPU 0.75 rootmod.c and util.c: cornacchia.
package Math_Prime_Util.Modular with SPARK_Mode => On is
   use type U64;
   use type U128;
   subtype I128 is Int.I128;
   use type I128;
   type Root_List is array (Positive range <>) of U64;
   type Cornacchia_Result (Defined : Boolean := False) is record
      case Defined is
         when True => X, Y : U64;
         when False => null;
      end case;
   end record;

   --  sqrtmod: a root of A modulo N, minimized against its negative.
   --  Undefined for N = 0 or else no root. A is reduced modulo N.
   function Sqrtmod (A : I128; N : U64) return Int.Optional_U64
     with Pre => True,
          Post => (if Sqrtmod'Result.Defined then N > 0 and then then
                     Sqrtmod'Result.Value <= N / 2);

   --  allsqrtmod: all square roots, sorted; empty for N = 0 or else no root.
   --  Raises Errors.Maximum_Roots_Exceeded above MPU's 600000000 root cap.
   function Allsqrtmod (A : I128; N : U64) return Root_List
     with Pre => True,
          Post => (for all R of Allsqrtmod'Result => R < N);

   --  rootmod: one K-th root; negative K first inverts A modulo N.
   --  Undefined for N = 0, no inverse, or else no root; K = 0 uses x**0 = 1.
   function Rootmod (A, K : I128; N : U64) return Int.Optional_U64
     with Pre => K in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (if Rootmod'Result.Defined then
                     N > 0 and then then Rootmod'Result.Value < N);

   --  allrootmod: all K-th roots sorted, with the same domain as Rootmod.
   --  Empty for undefined results; Errors.Maximum_Roots_Exceeded at the cap.
   function Allrootmod (A, K : I128; N : U64) return Root_List
     with Pre => K in -I128 (U64'Last) .. I128 (U64'Last),
          Post => (for all R of Allrootmod'Result => R < N);

   --  util.c: cornacchia. Solve X**2 + D*Y**2 = N in native integers.
   --  Undefined if no solution exists; N = 0 returns (0, 0).
   function Cornacchia (D, N : U64) return Cornacchia_Result
     with Pre => True,
          Post => (if Cornacchia'Result.Defined then
            U128 (Cornacchia'Result.X) ** 2 <= U128 (N) and then then
            (if D > 0 then U128 (Cornacchia'Result.Y) ** 2 <=
               U128 (N) / U128 (D)) and then then
            U128 (Cornacchia'Result.X) ** 2 + U128 (D) *
              U128 (Cornacchia'Result.Y) ** 2 = U128 (N));
end Math_Prime_Util.Modular;
