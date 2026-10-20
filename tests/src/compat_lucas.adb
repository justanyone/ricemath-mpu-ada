with AUnit.Assertions;
with Ada.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Lucas;

package body Compat_Lucas is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use Math_Prime_Util.Lucas;
   use type U64;
   type Lucas_Case is new Test_Case with null record;
   overriding function Name (T : Lucas_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Lucas_Case);

   function Image (V : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (V), Ada.Strings.Both));
   function Image (V : Optional_Integer) return String is
     (if V.Defined then Image (V.Value) else "undef");

   function Evaluate (C : Case_Record; Func : String) return String is
      function Signed (I : Positive) return I64 is
        (I64'Value (To_String (C.Args (I))));
      function Unsigned (I : Positive) return U64 is
        (U64'Value (To_String (C.Args (I))));
      R : Residue_Pair;
      S : Sequence_Result;
      Pair : Integer_Pair;
   begin
      if Func = "fibonacci" then
         return Image (Fibonacci (Signed (1)));
      elsif Func = "lucas_number" then
         return Image (Lucas_Number (Signed (1)));
      elsif Func = "lucasu" then
         return Image (Lucasu (Signed (1), Signed (2), Unsigned (3)));
      elsif Func = "lucasv" then
         return Image (Lucasv (Signed (1), Signed (2), Unsigned (3)));
      elsif Func = "lucasuv" then
         Pair := Lucasuv (Signed (1), Signed (2), Unsigned (3));
         return Image (Pair.U) & " " & Image (Pair.V);
      elsif Func = "lucas_sequence" then
         S := Lucas_Sequence
           (Unsigned (1), Signed (2), Signed (3), Unsigned (4));
         return Image (I128 (S.U)) & " " & Image (I128 (S.V)) &
           " " & Image (I128 (S.Qk));
      elsif Func = "lucasumod" then
         return Image (I128 (Lucasumod
           (Signed (1), Signed (2), Unsigned (3), Unsigned (4))));
      elsif Func = "lucasvmod" then
         return Image (I128 (Lucasvmod
           (Signed (1), Signed (2), Unsigned (3), Unsigned (4))));
      else
         R := Lucasuvmod
           (Signed (1), Signed (2), Unsigned (3), Unsigned (4));
         return Image (I128 (R.U)) & " " & Image (I128 (R.V));
      end if;
   end Evaluate;

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("lucas"), Func);
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         --  Zero modulus undef rows map to the API's checked precondition.
         if (Func = "lucasumod" or Func = "lucasvmod" or
             Func = "lucasuvmod") and then C.Args (4) = "0"
         then
            declare
               Raised : Boolean := False;
            begin
               begin
                  declare
                     Actual : constant String := Evaluate (C, Func);
                  begin
                     AUnit.Assertions.Assert
                       (Actual'Length = 0, "zero modulus accepted");
                  end;
               exception
                  when Constraint_Error | Ada.Assertions.Assertion_Error =>
                     Raised := True;
               end;
               AUnit.Assertions.Assert (Raised, "zero modulus rejected");
            end;
         else
            declare
               Actual : constant String := Evaluate (C, Func);
            begin
               AUnit.Assertions.Assert
                 (Actual = To_String (C.Result), Func & " row" &
                  Positive'Image (C.Line_Number) & " expected " &
                  To_String (C.Result) & " got " & Actual);
            end;
         end if;
      end loop;
   end Replay;

   overriding function Name (T : Lucas_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Lucas");
   end Name;

   procedure Test_Lucasu (T : in out Test_Case'Class) is
   begin
      Replay ("lucasu");
   end Test_Lucasu;

   procedure Test_Lucasv (T : in out Test_Case'Class) is
   begin
      Replay ("lucasv");
   end Test_Lucasv;

   procedure Test_Lucasuv (T : in out Test_Case'Class) is
   begin
      Replay ("lucasuv");
   end Test_Lucasuv;

   procedure Test_Lucasumod (T : in out Test_Case'Class) is
   begin
      Replay ("lucasumod");
   end Test_Lucasumod;

   procedure Test_Lucasvmod (T : in out Test_Case'Class) is
   begin
      Replay ("lucasvmod");
   end Test_Lucasvmod;

   procedure Test_Lucasuvmod (T : in out Test_Case'Class) is
   begin
      Replay ("lucasuvmod");
   end Test_Lucasuvmod;

   procedure Test_Lucas_Sequence (T : in out Test_Case'Class) is
   begin
      Replay ("lucas_sequence");
   end Test_Lucas_Sequence;

   procedure Test_Fibonacci (T : in out Test_Case'Class) is
   begin
      Replay ("fibonacci");
   end Test_Fibonacci;

   procedure Test_Lucas_Number (T : in out Test_Case'Class) is
   begin
      Replay ("lucas_number");
   end Test_Lucas_Number;

   overriding procedure Register_Tests (T : in out Lucas_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Lucasu'Access, "lucasu");
      Registration.Register_Routine
        (T, Test_Lucasv'Access, "lucasv");
      Registration.Register_Routine
        (T, Test_Lucasuv'Access, "lucasuv");
      Registration.Register_Routine
        (T, Test_Lucasumod'Access, "lucasumod");
      Registration.Register_Routine
        (T, Test_Lucasvmod'Access, "lucasvmod");
      Registration.Register_Routine
        (T, Test_Lucasuvmod'Access, "lucasuvmod");
      Registration.Register_Routine
        (T, Test_Lucas_Sequence'Access, "lucas_sequence");
      Registration.Register_Routine
        (T, Test_Fibonacci'Access, "fibonacci");
      Registration.Register_Routine
        (T, Test_Lucas_Number'Access, "lucas_number");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Lucas_Case);
      return Result;
   end Suite;
end Compat_Lucas;
