with Ada.Characters.Handling;
with Ada.Strings.Fixed;

package body Math_Prime_Util.Config is

   type Key_Kind is (Key_Verbose, Key_Assume_RH, Key_Unknown);

   --  Lower case, with spaces and underscores removed.
   --  Used to match the key names of prime_set_config.
   function Squash (S : String) return String is
      Buf  : String (1 .. S'Length);
      Last : Natural := 0;
   begin
      for C of S loop
         if C /= ' ' and then C /= '_' then
            Last := Last + 1;
            Buf (Last) := Ada.Characters.Handling.To_Lower (C);
         end if;
      end loop;
      return Buf (1 .. Last);
   end Squash;

   --  Port of the key tests in prime_set_config (Util.pm):
   --  /^(assume[_ ]?)?[ge]?rh$/ or /riemann\s*h/.
   function Kind_Of (Key : String) return Key_Kind is
      N : constant String := Squash (Key);
   begin
      if N = "verbose" then
         return Key_Verbose;
      elsif N = "rh" or else N = "grh" or else N = "erh"
        or else N = "assumerh" or else N = "assumegrh"
        or else N = "assumeerh"
        or else Ada.Strings.Fixed.Index (N, "riemannh") /= 0
      then
         return Key_Assume_RH;
      else
         return Key_Unknown;
      end if;
   end Kind_Of;

   function Is_Digits (S : String) return Boolean is
     (for all C of S => C in '0' .. '9');

   --  Perl verbose values: digits, or a word starting with t, y, f, n.
   function Parse_Verbose (Value : String) return Natural is
     (if Is_Digits (Value) then Natural'Value (Value)
      elsif Value (Value'First) in 't' | 'T' | 'y' | 'Y' then 1
      else 0)
     with Pre => Is_Valid_Value (Key => "verbose", Value => Value);

   --  Perl truth: "" and "0" are false.
   function Truthy (Value : String) return Boolean is
     (Value /= "" and then Value /= "0");

   --  The settings, behind a protected object: safe for concurrent use.
   protected Store is
      function Current return Config_Record;
      procedure Set_Verbose (V : Natural);
      procedure Set_Assume_RH (V : Boolean);
   private
      Settings : Config_Record;
   end Store;

   protected body Store is
      function Current return Config_Record is (Settings);

      procedure Set_Verbose (V : Natural) is
      begin
         Settings.Verbose := V;
      end Set_Verbose;

      procedure Set_Assume_RH (V : Boolean) is
      begin
         Settings.Assume_RH := V;
      end Set_Assume_RH;
   end Store;

   function Is_Known_Key (Key : String) return Boolean is
     (Kind_Of (Key) /= Key_Unknown);

   function Is_Valid_Value (Key : String; Value : String) return Boolean is
     (case Kind_Of (Key) is
         when Key_Verbose =>
           Value /= "" and then
           ((Is_Digits (Value) and then Value'Length <= 9)
            or else Value (Value'First) in
              't' | 'T' | 'y' | 'Y' | 'f' | 'F' | 'n' | 'N'),
         when Key_Assume_RH => True,
         when Key_Unknown => False);

   function Prime_Get_Config return Config_Record is (Store.Current);

   procedure Prime_Set_Config (Key : String; Value : String) is
   begin
      case Kind_Of (Key) is
         when Key_Verbose =>
            Store.Set_Verbose (Parse_Verbose (Value));
         when Key_Assume_RH =>
            Store.Set_Assume_RH (Truthy (Value));
         when Key_Unknown =>
            null;  --  Excluded by the precondition.
      end case;
   end Prime_Set_Config;

   function Uvsize return Positive is (Uv_Size);
   function Uvbits return Positive is (Uv_Size * 8);
   function Ivsize return Positive is (Iv_Size);
   function Nvsize return Positive is (Nv_Size);
   function Nvmantbits return Positive is (Nv_Mant_Bits);
   function Nvmantdigits return Positive is (Nv_Mant_Digits);

end Math_Prime_Util.Config;
