--  Native factoring stages from Math::Prime::Util 0.75.
package Math_Prime_Util.Factor with SPARK_Mode => On is
   use type U64;
   type Factor_List is array (Positive range <>) of U64;

   --  factor.c: tinyecm64_factor; XS.xs: ecm_factor wrapper.
   --  Strip 2, 3, 5, then attempt one ECM split (not full factorization).
   --  Bounds B1/B2 are inclusive prime limits; B2 = 0 means saturated
   --  20 * B1. Curves is capped at the 400 fixed Suyama curves.
   --  Return sorted factors, [0] for zero, an empty list for one, or the
   --  unsplit cofactor on failure. Storage_Error may propagate for bounds
   --  too large to allocate stage-two tables. No randomness or shared state.
   function Ecm_Factor
     (N : U64; B1 : U64 := 4_000; B2 : U64 := 0;
      Curves : U64 := 100) return Factor_List
     with Pre => True,
          Post => Ecm_Factor'Result'Length <= 64
            and then (if N = 1 then Ecm_Factor'Result'Length = 0
              elsif N = 0 then Ecm_Factor'Result = Factor_List'[1 => 0]
              else Ecm_Factor'Result'Length > 0
                and then (for all F of Ecm_Factor'Result =>
                  F > 1 and then N mod F = 0));
end Math_Prime_Util.Factor;
