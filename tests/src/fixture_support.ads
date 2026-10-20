with Ada.Containers.Vectors;
with Math_Prime_Util;

package Fixture_Support is
   type String_Access is access all String;
   package String_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => String_Access);

   type Case_Record is record
      Func : String_Access;
      Args : String_Vectors.Vector;
      Result : String_Access;
      Undef : Boolean := False;
      Error : Boolean := False;
      Line_Number : Positive := 1;
   end record;
   package Case_Vectors is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => Case_Record);

   --  Load all cases from tests/fixtures/<family>.tsv.
   function Load (Family : String) return Case_Vectors.Vector
     with Pre => Family'Length > 0,
          Post => True;
   --  Return cases for one function, preserving fixture order.
   function For_Function
     (Cases : Case_Vectors.Vector; Func : String)
      return Case_Vectors.Vector
     with Pre => Func'Length > 0,
          Post => True;
   --  Parse unsigned decimal values; False means invalid or out of range.
   function Parse_U64 (Text : String; Value : out Math_Prime_Util.U64)
      return Boolean
     with Post => (if Parse_U64'Result then Value'Valid);
   function Parse_U128 (Text : String; Value : out Math_Prime_Util.U128)
      return Boolean
     with Post => (if Parse_U128'Result then Value'Valid);
end Fixture_Support;
