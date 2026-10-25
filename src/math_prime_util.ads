with Interfaces;

--  Root package of the Ada port of Math::Prime::Util (MPU) 0.75.
--  Child packages hold the functions; see PLAN.md section 5.
package Math_Prime_Util is
   pragma Pure;

   Version : constant String := "0.1.0-dev";

   subtype U64 is Interfaces.Unsigned_64;
   subtype U128 is Interfaces.Unsigned_128;
end Math_Prime_Util;
