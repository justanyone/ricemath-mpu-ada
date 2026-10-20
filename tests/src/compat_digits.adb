with Ada.Containers;
with AUnit.Assertions;
with Ada.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Digit_Operations;

package body Compat_Digits is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Digit_Operations;
   use type Ada.Containers.Count_Type;
   use type U128;
   use type I128;

   type Digits_Case is new Test_Case with null record;
   overriding function Name (T : Digits_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Digits_Case);

   function Image (N : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (N), Ada.Strings.Both));
   function Image (N : U128) return String is
     (Ada.Strings.Fixed.Trim (U128'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("digits"), Func);
      A : array (1 .. 3) of I128 := [others => 0];
      Base : U128;
      Len : Integer;
      O : Optional_I128;
      D : Division_Result;
      Actual : Unbounded_String;
      Raised : Boolean;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, Func & " has no rows");
      for C of Cases loop
         Actual := Null_Unbounded_String;
         Raised := False;
         A := [others => 0];
         begin
            if Func not in "toint" | "fromdigits" | "fromzeckendorf" |
              "sumdigits" then
               for I in 1 .. Natural (C.Args.Length) loop
                  A (I) := I128'Value (To_String (C.Args (I)));
               end loop;
            end if;
            Base := (if C.Args.Length >= 2 then U128 (A (2)) else 10);
            Len := (if C.Args.Length >= 3 then Integer (A (3)) else -1);
            O := (Defined => False);
            if Func = "absint" then
               O := Absint (A (1));
            elsif Func = "negint" then
               O := Negint (A (1));
            elsif Func = "signint" then
               Actual := To_Unbounded_String
                 (Image (I128 (Signint (A (1)))));
            elsif Func = "add1int" then
               O := Add1int (A (1));
            elsif Func = "sub1int" then
               O := Sub1int (A (1));
            elsif Func = "cmpint" then
               Actual := To_Unbounded_String
                 (Image (I128 (Cmpint (A (1), A (2)))));
            elsif Func = "addint" then
               O := Addint (A (1), A (2));
            elsif Func = "subint" then
               O := Subint (A (1), A (2));
            elsif Func = "mulint" then
               O := Mulint (A (1), A (2));
            elsif Func = "divint" then
               O := Divint (A (1), A (2));
            elsif Func = "modint" then
               O := Modint (A (1), A (2));
            elsif Func = "cdivint" then
               O := Cdivint (A (1), A (2));
            elsif Func = "divrem" then
               D := Divrem (A (1), A (2));
               if D.Defined then
                  Actual := To_Unbounded_String
                    (Image (D.Quotient) & " " & Image (D.Remainder));
               else
                  Raised := True;
               end if;
            elsif Func = "tdivrem" then
               D := Tdivrem (A (1), A (2));
               if D.Defined then
                  Actual := To_Unbounded_String
                    (Image (D.Quotient) & " " & Image (D.Remainder));
               else
                  Raised := True;
               end if;
            elsif Func = "fdivrem" then
               D := Fdivrem (A (1), A (2));
               if D.Defined then
                  Actual := To_Unbounded_String
                    (Image (D.Quotient) & " " & Image (D.Remainder));
               else
                  Raised := True;
               end if;
            elsif Func = "cdivrem" then
               D := Cdivrem (A (1), A (2));
               if D.Defined then
                  Actual := To_Unbounded_String
                    (Image (D.Quotient) & " " & Image (D.Remainder));
               else
                  Raised := True;
               end if;
            elsif Func = "muladdint" then
               O := Muladdint (A (1), A (2), A (3));
            elsif Func = "mulsubint" then
               O := Mulsubint (A (1), A (2), A (3));
            elsif Func = "lshiftint" then
               O := Lshiftint
                 (A (1), (if C.Args.Length > 1 then Natural (A (2))
                          else 1));
            elsif Func = "rshiftint" then
               O := Rshiftint
                 (A (1), (if C.Args.Length > 1 then Natural (A (2))
                          else 1));
            elsif Func = "rashiftint" then
               O := Rashiftint
                 (A (1), (if C.Args.Length > 1 then Natural (A (2))
                          else 1));
            elsif Func = "toint" then
               O := Toint (To_String (C.Args (1)));
            elsif Func = "todigits" then
               for V of Todigits (U128 (abs A (1)), Base, Len) loop
                  if Length (Actual) > 0 then
                     Append (Actual, " ");
                  end if;
                  Append (Actual, Image (V));
               end loop;
            elsif Func = "todigitstring" then
               Actual := To_Unbounded_String
                 (Todigitstring (U128 (abs A (1)), Base, Len));
            elsif Func = "fromdigits" then
               declare
                  Text : constant String := To_String (C.Args (1));
               begin
                  Actual := To_Unbounded_String (Image (Fromdigits
                    (Text, (if C.Args.Length > 1 then
                       U128'Value (To_String (C.Args (2))) else 10))));
               end;
            elsif Func = "sumdigits" then
               Actual := To_Unbounded_String (Image (Sumdigits
                 (To_String (C.Args (1)),
                  (if C.Args.Length > 1 then
                     U128'Value (To_String (C.Args (2))) else 10))));
            elsif Func = "reverse_digits" then
               Actual := To_Unbounded_String
                 (Image (Reverse_Digits (U128 (abs A (1)), Base)));
            elsif Func = "is_palindrome" then
               Actual := To_Unbounded_String (Image (I128
                 (Boolean'Pos (Is_Palindrome (U128 (abs A (1)), Base)))));
            elsif Func = "is_harshad" then
               Actual := To_Unbounded_String (Image (I128
                 (Boolean'Pos (Is_Harshad (U128 (abs A (1)), Base)))));
            elsif Func = "digital_root" then
               Actual := To_Unbounded_String
                 (Image (Digital_Root (U128 (abs A (1)), Base)));
            elsif Func = "mult_digital_root" then
               Actual := To_Unbounded_String
                 (Image (Mult_Digital_Root (U128 (abs A (1)), Base)));
            elsif Func = "hammingweight" then
               Actual := To_Unbounded_String
                 (Image (I128 (Hammingweight (U128 (abs A (1))))));
            elsif Func = "tozeckendorf" then
               Actual := To_Unbounded_String (Tozeckendorf (U64 (A (1))));
            elsif Func = "fromzeckendorf" then
               declare
                  Text : constant String := To_String (C.Args (1));
               begin
                  Actual := To_Unbounded_String
                    (Image (U128 (Fromzeckendorf (Text))));
               end;
            end if;
            if O.Defined then
               Actual := To_Unbounded_String (Image (O.Value));
            elsif Func in "absint" | "negint" | "add1int" | "sub1int" |
              "addint" | "subint" | "mulint" | "muladdint" | "mulsubint" |
              "divint" | "modint" | "cdivint" | "lshiftint" |
              "rshiftint" | "rashiftint" | "toint"
            then
               Raised := True;
            end if;
         exception
            when Constraint_Error | Ada.Assertions.Assertion_Error =>
               Raised := True;
         end;
         AUnit.Assertions.Assert
           (Raised = C.Error and then
            (Raised or else Actual = C.Result),
            Func & Positive'Image (C.Line_Number) & ": " &
            To_String (Actual) & " expected " & To_String (C.Result));
      end loop;
   end Replay;

   overriding function Name (T : Digits_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Digits");
   end Name;

   procedure Test_Absint (T : in out Test_Case'Class) is
   begin
      Replay ("absint");
   end Test_Absint;

   procedure Test_Negint (T : in out Test_Case'Class) is
   begin
      Replay ("negint");
   end Test_Negint;

   procedure Test_Signint (T : in out Test_Case'Class) is
   begin
      Replay ("signint");
   end Test_Signint;

   procedure Test_Add1int (T : in out Test_Case'Class) is
   begin
      Replay ("add1int");
   end Test_Add1int;

   procedure Test_Sub1int (T : in out Test_Case'Class) is
   begin
      Replay ("sub1int");
   end Test_Sub1int;

   procedure Test_Cmpint (T : in out Test_Case'Class) is
   begin
      Replay ("cmpint");
   end Test_Cmpint;

   procedure Test_Addint (T : in out Test_Case'Class) is
   begin
      Replay ("addint");
   end Test_Addint;

   procedure Test_Subint (T : in out Test_Case'Class) is
   begin
      Replay ("subint");
   end Test_Subint;

   procedure Test_Mulint (T : in out Test_Case'Class) is
   begin
      Replay ("mulint");
   end Test_Mulint;

   procedure Test_Divint (T : in out Test_Case'Class) is
   begin
      Replay ("divint");
   end Test_Divint;

   procedure Test_Modint (T : in out Test_Case'Class) is
   begin
      Replay ("modint");
   end Test_Modint;

   procedure Test_Cdivint (T : in out Test_Case'Class) is
   begin
      Replay ("cdivint");
   end Test_Cdivint;

   procedure Test_Divrem (T : in out Test_Case'Class) is
   begin
      Replay ("divrem");
   end Test_Divrem;

   procedure Test_Tdivrem (T : in out Test_Case'Class) is
   begin
      Replay ("tdivrem");
   end Test_Tdivrem;

   procedure Test_Fdivrem (T : in out Test_Case'Class) is
   begin
      Replay ("fdivrem");
   end Test_Fdivrem;

   procedure Test_Cdivrem (T : in out Test_Case'Class) is
   begin
      Replay ("cdivrem");
   end Test_Cdivrem;

   procedure Test_Muladdint (T : in out Test_Case'Class) is
   begin
      Replay ("muladdint");
   end Test_Muladdint;

   procedure Test_Mulsubint (T : in out Test_Case'Class) is
   begin
      Replay ("mulsubint");
   end Test_Mulsubint;

   procedure Test_Lshiftint (T : in out Test_Case'Class) is
   begin
      Replay ("lshiftint");
   end Test_Lshiftint;

   procedure Test_Rshiftint (T : in out Test_Case'Class) is
   begin
      Replay ("rshiftint");
   end Test_Rshiftint;

   procedure Test_Rashiftint (T : in out Test_Case'Class) is
   begin
      Replay ("rashiftint");
   end Test_Rashiftint;

   procedure Test_Toint (T : in out Test_Case'Class) is
   begin
      Replay ("toint");
   end Test_Toint;

   procedure Test_Todigits (T : in out Test_Case'Class) is
   begin
      Replay ("todigits");
   end Test_Todigits;

   procedure Test_Todigitstring (T : in out Test_Case'Class) is
   begin
      Replay ("todigitstring");
   end Test_Todigitstring;

   procedure Test_Fromdigits (T : in out Test_Case'Class) is
   begin
      Replay ("fromdigits");
   end Test_Fromdigits;

   procedure Test_Sumdigits (T : in out Test_Case'Class) is
   begin
      Replay ("sumdigits");
   end Test_Sumdigits;

   procedure Test_Reverse_Digits (T : in out Test_Case'Class) is
   begin
      Replay ("reverse_digits");
   end Test_Reverse_Digits;

   procedure Test_Is_Palindrome (T : in out Test_Case'Class) is
   begin
      Replay ("is_palindrome");
   end Test_Is_Palindrome;

   procedure Test_Is_Harshad (T : in out Test_Case'Class) is
   begin
      Replay ("is_harshad");
   end Test_Is_Harshad;

   procedure Test_Digital_Root (T : in out Test_Case'Class) is
   begin
      Replay ("digital_root");
   end Test_Digital_Root;

   procedure Test_Mult_Digital_Root (T : in out Test_Case'Class) is
   begin
      Replay ("mult_digital_root");
   end Test_Mult_Digital_Root;

   procedure Test_Hammingweight (T : in out Test_Case'Class) is
   begin
      Replay ("hammingweight");
   end Test_Hammingweight;

   procedure Test_Tozeckendorf (T : in out Test_Case'Class) is
   begin
      Replay ("tozeckendorf");
   end Test_Tozeckendorf;

   procedure Test_Fromzeckendorf (T : in out Test_Case'Class) is
   begin
      Replay ("fromzeckendorf");
   end Test_Fromzeckendorf;

   overriding procedure Register_Tests (T : in out Digits_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Absint'Access, "absint");
      Registration.Register_Routine
        (T, Test_Negint'Access, "negint");
      Registration.Register_Routine
        (T, Test_Signint'Access, "signint");
      Registration.Register_Routine
        (T, Test_Add1int'Access, "add1int");
      Registration.Register_Routine
        (T, Test_Sub1int'Access, "sub1int");
      Registration.Register_Routine
        (T, Test_Cmpint'Access, "cmpint");
      Registration.Register_Routine
        (T, Test_Addint'Access, "addint");
      Registration.Register_Routine
        (T, Test_Subint'Access, "subint");
      Registration.Register_Routine
        (T, Test_Mulint'Access, "mulint");
      Registration.Register_Routine
        (T, Test_Divint'Access, "divint");
      Registration.Register_Routine
        (T, Test_Modint'Access, "modint");
      Registration.Register_Routine
        (T, Test_Cdivint'Access, "cdivint");
      Registration.Register_Routine
        (T, Test_Divrem'Access, "divrem");
      Registration.Register_Routine
        (T, Test_Tdivrem'Access, "tdivrem");
      Registration.Register_Routine
        (T, Test_Fdivrem'Access, "fdivrem");
      Registration.Register_Routine
        (T, Test_Cdivrem'Access, "cdivrem");
      Registration.Register_Routine
        (T, Test_Muladdint'Access, "muladdint");
      Registration.Register_Routine
        (T, Test_Mulsubint'Access, "mulsubint");
      Registration.Register_Routine
        (T, Test_Lshiftint'Access, "lshiftint");
      Registration.Register_Routine
        (T, Test_Rshiftint'Access, "rshiftint");
      Registration.Register_Routine
        (T, Test_Rashiftint'Access, "rashiftint");
      Registration.Register_Routine
        (T, Test_Toint'Access, "toint");
      Registration.Register_Routine
        (T, Test_Todigits'Access, "todigits");
      Registration.Register_Routine
        (T, Test_Todigitstring'Access, "todigitstring");
      Registration.Register_Routine
        (T, Test_Fromdigits'Access, "fromdigits");
      Registration.Register_Routine
        (T, Test_Sumdigits'Access, "sumdigits");
      Registration.Register_Routine
        (T, Test_Reverse_Digits'Access, "reverse_digits");
      Registration.Register_Routine
        (T, Test_Is_Palindrome'Access, "is_palindrome");
      Registration.Register_Routine
        (T, Test_Is_Harshad'Access, "is_harshad");
      Registration.Register_Routine
        (T, Test_Digital_Root'Access, "digital_root");
      Registration.Register_Routine
        (T, Test_Mult_Digital_Root'Access, "mult_digital_root");
      Registration.Register_Routine
        (T, Test_Hammingweight'Access, "hammingweight");
      Registration.Register_Routine
        (T, Test_Tozeckendorf'Access, "tozeckendorf");
      Registration.Register_Routine
        (T, Test_Fromzeckendorf'Access, "fromzeckendorf");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Digits_Case);
      return Result;
   end Suite;
end Compat_Digits;
