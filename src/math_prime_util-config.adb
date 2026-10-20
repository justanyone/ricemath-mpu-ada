with Ada.Characters.Handling;

package body Math_Prime_Util.Config is

   type Key_Kind is (Key_Verbose, Key_Assume_RH, Key_Unknown);

   function Lower (S : String) return String is
      Buf : String (1 .. S'Length);
   begin
      for I in S'Range loop
         Buf (I - S'First + 1) := Ada.Characters.Handling.To_Lower (S (I));
      end loop;
      return Buf;
   end Lower;

   function Is_Space (C : Character) return Boolean is
     (C in ' ' | ASCII.HT | ASCII.LF | ASCII.CR | ASCII.VT | ASCII.FF);

   --  Port of the key test in prime_set_config (Util.pm):
   --  /^(assume[_ ]?)?[ge]?rh$/ or /riemann\s*h/, on the lower case key.
   function Is_RH_Name (L : String) return Boolean is
      First : Natural := L'First;
   begin
      if L'Length >= 6 and then L (L'First .. L'First + 5) = "assume" then
         First := L'First + 6;
         if First <= L'Last and then L (First) in '_' | ' ' then
            First := First + 1;
         end if;
      end if;
      if L (First .. L'Last) = "rh" or else L (First .. L'Last) = "grh"
        or else L (First .. L'Last) = "erh"
      then
         return True;
      end if;
      for I in L'First .. L'Last loop
         if I + 6 <= L'Last and then L (I .. I + 6) = "riemann" then
            declare
               J : Natural := I + 7;
            begin
               while J <= L'Last and then Is_Space (L (J)) loop
                  J := J + 1;
               end loop;
               if J <= L'Last and then L (J) = 'h' then
                  return True;
               end if;
            end;
         end if;
      end loop;
      return False;
   end Is_RH_Name;

   --  Port of the key tests in prime_set_config (Util.pm). The verbose
   --  test is an exact match after lc, with no space or underscore removal.
   function Kind_Of (Key : String) return Key_Kind is
      L : constant String := Lower (Key);
   begin
      if L = "verbose" then
         return Key_Verbose;
      elsif Is_RH_Name (L) then
         return Key_Assume_RH;
      else
         return Key_Unknown;
      end if;
   end Kind_Of;

   function Is_Digits (S : String) return Boolean is
     (for all C of S => C in '0' .. '9');

   --  True when the digits S give a value that fits in Natural.
   --  Leading zeros are allowed, so the digit count is not limited.
   function Digits_Fit (S : String) return Boolean is
      Acc : Natural := 0;
      D   : Natural;
   begin
      for C of S loop
         D := Character'Pos (C) - Character'Pos ('0');
         if Acc > (Natural'Last - D) / 10 then
            return False;
         end if;
         Acc := Acc * 10 + D;
      end loop;
      return True;
   end Digits_Fit;

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
           ((Is_Digits (Value) and then Digits_Fit (Value))
            or else Value (Value'First) in
              't' | 'T' | 'y' | 'Y' | 'f' | 'F' | 'n' | 'N'),
         when Key_Assume_RH => True,
         when Key_Unknown => False);

   function Prime_Get_Config return Config_Record is (Store.Current);

   procedure Prime_Set_Config (Key : String; Value : String) is
   begin
      --  Checked at run time too: preconditions are off in release builds.
      if not Is_Known_Key (Key) then
         raise Config_Error with "Unknown or invalid configuration setting";
      elsif not Is_Valid_Value (Key, Value) then
         raise Config_Error with "Invalid setting for " & Key;
      end if;
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
