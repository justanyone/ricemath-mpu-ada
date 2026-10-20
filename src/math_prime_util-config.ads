--  Configuration of Math::Prime::Util 0.75.
--  Prime_Get_Config and Prime_Set_Config port lib/Math/Prime/Util.pm
--  (prime_get_config, prime_set_config). The platform constants port
--  the newCONSTSUB block in reference/mpu/XS.xs (_uvsize .. _nvmantdigits).
package Math_Prime_Util.Config is

   --  XS.xs: BITS_PER_WORD, the largest prime size in bits.
   Max_Bits : constant := 64;

   --  XS.xs: UVSIZE and IVSIZE, in bytes.
   Uv_Size : constant := 8;
   Iv_Size : constant := 8;

   --  XS.xs: NVSIZE, in bytes (IEEE double).
   Nv_Size : constant := 8;

   --  XS.xs: NVMANTBITS, the mantissa bits of a double.
   Nv_Mant_Bits : constant := 53;

   --  XS.xs: (NVMANTBITS+1) / 3.322, as an integer (54 / 3.322 = 16.2).
   Nv_Mant_Digits : constant := 16;

   --  Settings of MPU's %_Config hash that the Ada port keeps.
   type Config_Record is record
      Maxbits   : Positive := Max_Bits;
      Verbose   : Natural := 0;
      Assume_RH : Boolean := False;
   end record;

   --  Key names that Prime_Set_Config accepts: verbose and the
   --  assume_rh names (assume_rh, rh, grh, erh, riemann hypothesis).
   --  Other MPU keys (xs, gmp, bigint, secure, ...) are not supported.
   --  Port of the key test in prime_set_config.
   function Is_Known_Key (Key : String) return Boolean;

   --  Value that Prime_Set_Config accepts for Key. A verbose value is
   --  digits (at most 9) or starts with t, y, f or n. Other values are
   --  truthy when they are not empty and not "0".
   function Is_Valid_Value (Key : String; Value : String) return Boolean;

   --  Port of prime_get_config: a copy of the current settings.
   function Prime_Get_Config return Config_Record
     with Post => Prime_Get_Config'Result.Maxbits = Max_Bits;

   --  Port of prime_set_config for one key and value.
   --  MPU croaks on an unknown key or an invalid verbose value; the
   --  Ada port states those checks as preconditions.
   procedure Prime_Set_Config (Key : String; Value : String)
     with Pre => Is_Known_Key (Key) and then Is_Valid_Value (Key, Value),
          Post => Prime_Get_Config'Result.Maxbits = Max_Bits;

   --  Platform constants (XS.xs newCONSTSUB block).
   function Uvsize return Positive
     with Post => Uvsize'Result = Uv_Size;

   --  Bits in a UV: XS.xs _uvbits = UVSIZE * 8.
   function Uvbits return Positive
     with Post => Uvbits'Result = Uv_Size * 8;

   --  XS.xs: IVSIZE.
   function Ivsize return Positive
     with Post => Ivsize'Result = Iv_Size;

   --  XS.xs: NVSIZE.
   function Nvsize return Positive
     with Post => Nvsize'Result = Nv_Size;

   --  XS.xs: NVMANTBITS.
   function Nvmantbits return Positive
     with Post => Nvmantbits'Result = Nv_Mant_Bits;

   --  XS.xs: NVMANTDIGITS, (NVMANTBITS+1) / 3.322.
   function Nvmantdigits return Positive
     with Post => Nvmantdigits'Result = Nv_Mant_Digits;

end Math_Prime_Util.Config;
