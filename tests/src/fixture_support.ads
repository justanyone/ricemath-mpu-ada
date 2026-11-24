with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Math_Prime_Util;

--  Test infrastructure for the format in tools/gen_fixtures.pl.
--  No MPU C algorithm is translated by this package.
package Fixture_Support is
   use Ada.Strings.Unbounded;
   use type Math_Prime_Util.U64;
   use type Math_Prime_Util.U128;
   package String_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Unbounded_String);

   --  Strings retain decimal spelling and the result retains list spacing.
   --  Ada reserves "case", so the fixture case type is Case_Record.
   type Case_Record is record
      Func : Unbounded_String;
      Args : String_Vectors.Vector;
      Result : Unbounded_String;
      Undef : Boolean := False;
      Error : Boolean := False;
      Line_Number : Positive := 1;
   end record;
   package Case_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Case_Record);

   --  Load fixtures/<family>.tsv from the test or repository directory.
   --  Missing files raise Name_Error; malformed rows raise Constraint_Error.
   function Load (Family : String) return Case_Vectors.Vector
     with Pre => Family'Length > 0
       and then (for all Ch of Family =>
                   Ch in 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '-');

   --  Select one function in fixture order; an absent name gives no cases.
   function For_Function
     (Cases : Case_Vectors.Vector; Func : String)
      return Case_Vectors.Vector
     with Pre => Func'Length > 0,
          Post => (for all C of For_Function'Result => C.Func = Func);

   --  Parse unsigned decimal text. Invalid text or overflow returns False
   --  and sets Value to zero. Leading zeroes are accepted; signs are not.
   function Parse_U64 (Text : String; Value : out Math_Prime_Util.U64)
      return Boolean
     with Post => (if not Parse_U64'Result then Value = 0);

   --  Parse unsigned decimal text up to U128'Last without modular wrapping.
   --  Invalid text or overflow returns False and sets Value to zero.
   function Parse_U128 (Text : String; Value : out Math_Prime_Util.U128)
      return Boolean
     with Post => (if not Parse_U128'Result then Value = 0);

end Fixture_Support;
