with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Rational;

package body Compat_Rational is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Rational;
   use type I128;
   use type U64;

   type Rational_Case is new Test_Case with null record;
   overriding function Name (T : Rational_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Rational_Case);

   function Image (N : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (N), Ada.Strings.Both));

   procedure Append (S : in out Unbounded_String; F : Fraction) is
   begin
      if Length (S) > 0 then
         S := S & " ";
      end if;
      S := S & Image (F.Num) & " " & Image (I128 (F.Den));
   end Append;

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("rational"), Func);
      A : array (1 .. 128) of I128 := [others => 0];
      Count : Natural;
      Actual : Unbounded_String;
      F : Fraction;
      Skip : Boolean;
      X : Long_Long_Float;
   begin
      for C of Cases loop
         Actual := Null_Unbounded_String;
         Count := Natural (C.Args.Length);
         Skip := False;
         begin
            for I in 1 .. Count loop
               declare
                  S : constant String := To_String (C.Args (I));
                  Slash : constant Natural :=
                    Ada.Strings.Fixed.Index (S, "/");
               begin
                  if Func = "bestrational" and then I = 1 then
                     X := Long_Long_Float'Value (S);
                  elsif Slash > 0 then
                     A (I) := I128'Value (S (S'First .. Slash - 1));
                     A (I + 1) := I128'Value (S (Slash + 1 .. S'Last));
                  else
                     A (I) := I128'Value (S);
                  end if;
                  if abs A (I) > I128 (U64'Last) then
                     Skip := True;
                  end if;
               end;
            end loop;
            --  Bigint-extension rows exceed rational.c's native UV API.
            --  They belong to the later bigint tier; do not narrow or else wrap.
            declare
               S : constant String := To_String (C.Result);
               Start : Positive := S'First;
            begin
               for I in S'Range loop
                  if S (I) = ' ' or else I = S'Last then
                     declare
                        Last : constant Natural :=
                          (if S (I) = ' ' then I - 1 else I);
                     begin
                        if Last >= Start and then
                          S (Start) in '-' | '0' .. '9'
                        then
                           if abs I128'Value (S (Start .. Last)) >
                             I128 (U64'Last)
                           then
                              Skip := True;
                           end if;
                        end if;
                        Start := I + 1;
                     end;
                  end if;
               end loop;
            end;
            if not Skip then
               if Func /= "from_contfrac" and then Func /= "contfrac"
                 and then Func /= "convergents" and then Func /= "bestrational"
               then
                  for I in 1 .. Count loop
                     if A (I) < 0 then
                        raise Constraint_Error;
                     end if;
                  end loop;
               end if;
               if Func = "contfrac" or else Func = "convergents" then
                  declare
                     Terms : constant Coefficients :=
                       Contfrac (A (1), U64 (A (2)));
                  begin
                     if Func = "contfrac" then
                        for V of Terms loop
                           if Length (Actual) > 0 then
                              Actual := Actual & " ";
                           end if;
                           Actual := Actual & Image (V);
                        end loop;
                     else
                        for V of Convergents (Terms) loop
                           Append (Actual, V);
                        end loop;
                     end if;
                  end;
               elsif Func = "from_contfrac" then
                  F := From_Contfrac (Coefficients (A (1 .. Count)));
                  if F.Defined then
                     Append (Actual, F);
                  else
                     Actual := To_Unbounded_String ("ERROR");
                  end if;
               elsif Func = "farey" then
                  declare
                     Values : constant Fraction_Array := Farey
                       (Positive (A (1)));
                  begin
                     if Count = 1 then
                        for V of Values loop
                           Append (Actual, V);
                        end loop;
                     elsif A (2) < 0 or else A (2) >= I128 (Values'Length) then
                        Actual := To_Unbounded_String ("undef");
                     else
                        Append (Actual, Values (Positive (A (2) + 1)));
                     end if;
                  end;
               elsif Func = "farey_rank" then
                  Actual := To_Unbounded_String (Image (I128
                    (Farey_Rank (Natural (A (1)), U64 (A (2)),
                                 U64 (A (3))))));
               elsif Func = "calkin_wilf_n" then
                  Actual := To_Unbounded_String (Image (I128
                    (Calkin_Wilf_N (U64 (A (1)), U64 (A (2))))));
               elsif Func = "stern_brocot_n" then
                  Actual := To_Unbounded_String (Image (I128
                    (Stern_Brocot_N (U64 (A (1)), U64 (A (2))))));
               elsif Func = "nth_stern_diatomic" then
                  if A (1) < 0 then
                     raise Constraint_Error;
                  end if;
                  Actual := To_Unbounded_String (Image (I128
                    (Nth_Stern_Diatomic (U64 (A (1))))));
               else
                  if Func = "bestrational" then
                     F := Bestrational (X, U64 (A (2)));
                  elsif Func = "next_farey" then
                     F := Next_Farey
                       (U64 (A (1)), U64 (A (2)), U64 (A (3)));
                  elsif Func = "next_calkin_wilf" then
                     F := Next_Calkin_Wilf (U64 (A (1)), U64 (A (2)));
                  elsif Func = "next_stern_brocot" then
                     F := Next_Stern_Brocot (U64 (A (1)), U64 (A (2)));
                  elsif Func = "nth_calkin_wilf" then
                     F := Nth_Calkin_Wilf (U64 (A (1)));
                  else
                     F := Nth_Stern_Brocot (U64 (A (1)));
                  end if;
                  if F.Defined then
                     Append (Actual, F);
                  else
                     Actual := To_Unbounded_String
                       ((if C.Undef then "undef" else "ERROR"));
                  end if;
               end if;
            end if;
         exception
            when Constraint_Error | Ada.Assertions.Assertion_Error =>
               Actual := To_Unbounded_String ("ERROR");
         end;
         if not Skip then
            AUnit.Assertions.Assert
              (Actual = C.Result,
               Func & Positive'Image (C.Line_Number) & ": " &
               To_String (Actual) & " expected " & To_String (C.Result));
         end if;
      end loop;
   end Replay;

   procedure Test_Contfrac (T : in out Test_Case'Class) is
   begin
      Replay ("contfrac");
   end Test_Contfrac;

   procedure Test_From_Contfrac (T : in out Test_Case'Class) is
   begin
      Replay ("from_contfrac");
   end Test_From_Contfrac;

   procedure Test_Convergents (T : in out Test_Case'Class) is
   begin
      Replay ("convergents");
   end Test_Convergents;

   procedure Test_Bestrational (T : in out Test_Case'Class) is
   begin
      Replay ("bestrational");
   end Test_Bestrational;

   procedure Test_Next_Calkin_Wilf (T : in out Test_Case'Class) is
   begin
      Replay ("next_calkin_wilf");
   end Test_Next_Calkin_Wilf;

   procedure Test_Next_Stern_Brocot (T : in out Test_Case'Class) is
   begin
      Replay ("next_stern_brocot");
   end Test_Next_Stern_Brocot;

   procedure Test_Calkin_Wilf_N (T : in out Test_Case'Class) is
   begin
      Replay ("calkin_wilf_n");
   end Test_Calkin_Wilf_N;

   procedure Test_Stern_Brocot_N (T : in out Test_Case'Class) is
   begin
      Replay ("stern_brocot_n");
   end Test_Stern_Brocot_N;

   procedure Test_Nth_Calkin_Wilf (T : in out Test_Case'Class) is
   begin
      Replay ("nth_calkin_wilf");
   end Test_Nth_Calkin_Wilf;

   procedure Test_Nth_Stern_Brocot (T : in out Test_Case'Class) is
   begin
      Replay ("nth_stern_brocot");
   end Test_Nth_Stern_Brocot;

   procedure Test_Nth_Stern_Diatomic (T : in out Test_Case'Class) is
   begin
      Replay ("nth_stern_diatomic");
   end Test_Nth_Stern_Diatomic;

   procedure Test_Farey (T : in out Test_Case'Class) is
   begin
      Replay ("farey");
   end Test_Farey;

   procedure Test_Next_Farey (T : in out Test_Case'Class) is
   begin
      Replay ("next_farey");
   end Test_Next_Farey;

   procedure Test_Farey_Rank (T : in out Test_Case'Class) is
   begin
      Replay ("farey_rank");
   end Test_Farey_Rank;

   overriding function Name (T : Rational_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Rational");
   end Name;

   overriding procedure Register_Tests (T : in out Rational_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Contfrac'Access, "contfrac");
      Registration.Register_Routine
        (T, Test_From_Contfrac'Access, "from_contfrac");
      Registration.Register_Routine
        (T, Test_Convergents'Access, "convergents");
      Registration.Register_Routine
        (T, Test_Bestrational'Access, "bestrational");
      Registration.Register_Routine
        (T, Test_Next_Calkin_Wilf'Access, "next_calkin_wilf");
      Registration.Register_Routine
        (T, Test_Next_Stern_Brocot'Access, "next_stern_brocot");
      Registration.Register_Routine
        (T, Test_Calkin_Wilf_N'Access, "calkin_wilf_n");
      Registration.Register_Routine
        (T, Test_Stern_Brocot_N'Access, "stern_brocot_n");
      Registration.Register_Routine
        (T, Test_Nth_Calkin_Wilf'Access, "nth_calkin_wilf");
      Registration.Register_Routine
        (T, Test_Nth_Stern_Brocot'Access, "nth_stern_brocot");
      Registration.Register_Routine
        (T, Test_Nth_Stern_Diatomic'Access, "nth_stern_diatomic");
      Registration.Register_Routine
        (T, Test_Farey'Access, "farey");
      Registration.Register_Routine
        (T, Test_Next_Farey'Access, "next_farey");
      Registration.Register_Routine
        (T, Test_Farey_Rank'Access, "farey_rank");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Rational_Case);
      return Result;
   end Suite;
end Compat_Rational;
