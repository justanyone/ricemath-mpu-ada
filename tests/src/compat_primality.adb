with AUnit.Assertions;
with Ada.Assertions;
with Interfaces;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Primality;

package body Compat_Primality is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Primality;
   use type U64;
   type Primality_Case is new Test_Case with null record;
   overriding function Name (T : Primality_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Primality_Case);
   overriding function Name (T : Primality_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Primality");
   end Name;

   function Evaluate (C : Case_Record; F : String) return Integer is
      N : U64;
      A : U64 := 2;
      B : Boolean := True;
      M : Mersenne_Result;
   begin
      --  Negative integer arguments are outside the native unsigned API.
      --  Their fixture result is composite, as in MPU's signed wrapper.
      if not Parse_U64 (To_String (C.Args (1)), N) then
         if To_String (C.Args (1)) (1) = '-' then
            return 0;
         end if;
         raise Constraint_Error with "non-native fixture input";
      end if;
      if F = "is_prime" then
         return Integer (Is_Prime (N));
      elsif F = "is_prob_prime" then
         return Integer (Is_Prob_Prime (N));
      elsif F = "is_bpsw_prime" then
         return Boolean'Pos (Is_Bpsw_Prime (N));
      elsif F = "is_pseudoprime" then
         if Natural (C.Args.Length) = 1 then
            return Boolean'Pos (Is_Pseudoprime (N, 2));
         end if;
         for J in 2 .. Natural (C.Args.Length) loop
            A := U64'Value (To_String (C.Args (J)));
            B := Is_Pseudoprime (N, A) and B;
         end loop;
         return Boolean'Pos (B);
      elsif F = "is_euler_pseudoprime" then
         if Natural (C.Args.Length) = 1 then
            return Boolean'Pos (Is_Euler_Pseudoprime (N, 2));
         end if;
         for J in 2 .. Natural (C.Args.Length) loop
            A := U64'Value (To_String (C.Args (J)));
            B := Is_Euler_Pseudoprime (N, A) and B;
         end loop;
         return Boolean'Pos (B);
      elsif F = "is_strong_pseudoprime" then
         if Natural (C.Args.Length) = 1 then
            return Boolean'Pos (Is_Strong_Pseudoprime (N, 2));
         end if;
         for J in 2 .. Natural (C.Args.Length) loop
            A := U64'Value (To_String (C.Args (J)));
            B := Is_Strong_Pseudoprime (N, A) and B;
         end loop;
         return Boolean'Pos (B);
      elsif F = "is_euler_plumb_pseudoprime" then
         return Boolean'Pos (Is_Euler_Plumb_Pseudoprime (N));
      elsif F = "is_lucas_pseudoprime" then
         return Boolean'Pos (Is_Lucas_Pseudoprime (N));
      elsif F = "is_strong_lucas_pseudoprime" then
         return Boolean'Pos (Is_Strong_Lucas_Pseudoprime (N));
      elsif F = "is_extra_strong_lucas_pseudoprime" then
         return Boolean'Pos (Is_Extra_Strong_Lucas_Pseudoprime (N));
      elsif F = "is_almost_extra_strong_lucas_pseudoprime" then
         A := 1;
         if Natural (C.Args.Length) > 1 then
            A := U64'Value (To_String (C.Args (2)));
         end if;
         return Boolean'Pos
           (Is_Almost_Extra_Strong_Lucas_Pseudoprime (N, A));
      elsif F = "is_perrin_pseudoprime" then
         if Natural (C.Args.Length) > 1 then
            A := U64'Value (To_String (C.Args (2)));
         else
            A := 0;
         end if;
         return Boolean'Pos (Is_Perrin_Pseudoprime (N, Natural (A)));
      elsif F = "is_frobenius_pseudoprime" then
         if Natural (C.Args.Length) = 3 then
            return Boolean'Pos (Is_Frobenius_Pseudoprime
              (N, Interfaces.Integer_64'Value (To_String (C.Args (2))),
               Interfaces.Integer_64'Value (To_String (C.Args (3)))));
         end if;
         return Boolean'Pos (Is_Frobenius_Pseudoprime (N));
      elsif F = "is_frobenius_khashin_pseudoprime" then
         return Boolean'Pos (Is_Frobenius_Khashin_Pseudoprime (N));
      elsif F = "is_frobenius_underwood_pseudoprime" then
         return Boolean'Pos (Is_Frobenius_Underwood_Pseudoprime (N));
      elsif F = "is_catalan_pseudoprime" then
         return Boolean'Pos (Is_Catalan_Pseudoprime (N));
      elsif F = "is_chen_prime" then
         return Boolean'Pos (Is_Chen_Prime (N));
      elsif F = "is_delicate_prime" then
         A := 10;
         if Natural (C.Args.Length) > 1 then
            A := U64'Value (To_String (C.Args (2)));
         end if;
         M := Is_Delicate_Prime (N, A);
         return (if M.Defined then Boolean'Pos (M.Value) else -1);
      elsif F = "is_safe_prime" then
         return Boolean'Pos (Is_Safe_Prime (N));
      elsif F = "is_mersenne_prime" then
         M := Is_Mersenne_Prime (N);
         return (if M.Defined then Boolean'Pos (M.Value) else -1);
      end if;
      raise Constraint_Error with "unknown function";
   end Evaluate;

   procedure Replay (F : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("primality"), F);
      Value : Integer;
      Raised : Boolean;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & F);
      for C of Cases loop
         Raised := False;
         begin
            Value := Evaluate (C, F);
         exception
            when Constraint_Error | Ada.Assertions.Assertion_Error =>
               Raised := True;
         end;
         AUnit.Assertions.Assert
           (Raised = C.Error, F & " error row" & C.Line_Number'Image);
         if not Raised then
            AUnit.Assertions.Assert
              (Value = (if C.Undef then -1
                        else Integer'Value (To_String (C.Result))),
               F & " row" & C.Line_Number'Image & " got" & Value'Image);
         end if;
      end loop;
   end Replay;
   procedure Test_0 (T : in out Test_Case'Class);
   procedure Test_0 (T : in out Test_Case'Class) is
   begin
      Replay ("is_prime");
   end Test_0;
   procedure Test_1 (T : in out Test_Case'Class);
   procedure Test_1 (T : in out Test_Case'Class) is
   begin
      Replay ("is_prob_prime");
   end Test_1;
   procedure Test_2 (T : in out Test_Case'Class);
   procedure Test_2 (T : in out Test_Case'Class) is
   begin
      Replay ("is_bpsw_prime");
   end Test_2;
   procedure Test_3 (T : in out Test_Case'Class);
   procedure Test_3 (T : in out Test_Case'Class) is
   begin
      Replay ("is_pseudoprime");
   end Test_3;
   procedure Test_4 (T : in out Test_Case'Class);
   procedure Test_4 (T : in out Test_Case'Class) is
   begin
      Replay ("is_euler_pseudoprime");
   end Test_4;
   procedure Test_5 (T : in out Test_Case'Class);
   procedure Test_5 (T : in out Test_Case'Class) is
   begin
      Replay ("is_strong_pseudoprime");
   end Test_5;
   procedure Test_6 (T : in out Test_Case'Class);
   procedure Test_6 (T : in out Test_Case'Class) is
   begin
      Replay ("is_euler_plumb_pseudoprime");
   end Test_6;
   procedure Test_7 (T : in out Test_Case'Class);
   procedure Test_7 (T : in out Test_Case'Class) is
   begin
      Replay ("is_lucas_pseudoprime");
   end Test_7;
   procedure Test_8 (T : in out Test_Case'Class);
   procedure Test_8 (T : in out Test_Case'Class) is
   begin
      Replay ("is_strong_lucas_pseudoprime");
   end Test_8;
   procedure Test_9 (T : in out Test_Case'Class);
   procedure Test_9 (T : in out Test_Case'Class) is
   begin
      Replay ("is_extra_strong_lucas_pseudoprime");
   end Test_9;
   procedure Test_10 (T : in out Test_Case'Class);
   procedure Test_10 (T : in out Test_Case'Class) is
   begin
      Replay ("is_almost_extra_strong_lucas_pseudoprime");
   end Test_10;
   procedure Test_11 (T : in out Test_Case'Class);
   procedure Test_11 (T : in out Test_Case'Class) is
   begin
      Replay ("is_safe_prime");
   end Test_11;
   procedure Test_12 (T : in out Test_Case'Class);
   procedure Test_12 (T : in out Test_Case'Class) is
   begin
      Replay ("is_mersenne_prime");
   end Test_12;
   procedure Test_13 (T : in out Test_Case'Class);
   procedure Test_13 (T : in out Test_Case'Class) is
   begin
      Replay ("is_perrin_pseudoprime");
   end Test_13;
   procedure Test_14 (T : in out Test_Case'Class);
   procedure Test_14 (T : in out Test_Case'Class) is
   begin
      Replay ("is_frobenius_pseudoprime");
   end Test_14;
   procedure Test_15 (T : in out Test_Case'Class);
   procedure Test_15 (T : in out Test_Case'Class) is
   begin
      Replay ("is_frobenius_khashin_pseudoprime");
   end Test_15;
   procedure Test_16 (T : in out Test_Case'Class);
   procedure Test_16 (T : in out Test_Case'Class) is
   begin
      Replay ("is_frobenius_underwood_pseudoprime");
   end Test_16;
   procedure Test_17 (T : in out Test_Case'Class);
   procedure Test_17 (T : in out Test_Case'Class) is
   begin
      Replay ("is_catalan_pseudoprime");
   end Test_17;
   procedure Test_18 (T : in out Test_Case'Class);
   procedure Test_18 (T : in out Test_Case'Class) is
   begin
      Replay ("is_chen_prime");
   end Test_18;
   procedure Test_19 (T : in out Test_Case'Class);
   procedure Test_19 (T : in out Test_Case'Class) is
   begin
      Replay ("is_delicate_prime");
   end Test_19;
   overriding procedure Register_Tests (T : in out Primality_Case) is
   begin
      Registration.Register_Routine
        (T, Test_0'Access, "is_prime");
      Registration.Register_Routine
        (T, Test_1'Access, "is_prob_prime");
      Registration.Register_Routine
        (T, Test_2'Access, "is_bpsw_prime");
      Registration.Register_Routine
        (T, Test_3'Access, "is_pseudoprime");
      Registration.Register_Routine
        (T, Test_4'Access, "is_euler_pseudoprime");
      Registration.Register_Routine
        (T, Test_5'Access, "is_strong_pseudoprime");
      Registration.Register_Routine
        (T, Test_6'Access, "is_euler_plumb_pseudoprime");
      Registration.Register_Routine
        (T, Test_7'Access, "is_lucas_pseudoprime");
      Registration.Register_Routine
        (T, Test_8'Access, "is_strong_lucas_pseudoprime");
      Registration.Register_Routine
        (T, Test_9'Access, "is_extra_strong_lucas_pseudoprime");
      Registration.Register_Routine
        (T, Test_10'Access, "is_almost_extra_strong_lucas_pseudoprime");
      Registration.Register_Routine
        (T, Test_11'Access, "is_safe_prime");
      Registration.Register_Routine
        (T, Test_12'Access, "is_mersenne_prime");
      Registration.Register_Routine
        (T, Test_13'Access, "is_perrin_pseudoprime");
      Registration.Register_Routine
        (T, Test_14'Access, "is_frobenius_pseudoprime");
      Registration.Register_Routine
        (T, Test_15'Access, "is_frobenius_khashin_pseudoprime");
      Registration.Register_Routine
        (T, Test_16'Access, "is_frobenius_underwood_pseudoprime");
      Registration.Register_Routine
        (T, Test_17'Access, "is_catalan_pseudoprime");
      Registration.Register_Routine
        (T, Test_18'Access, "is_chen_prime");
      Registration.Register_Routine
        (T, Test_19'Access, "is_delicate_prime");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Primality_Case);
      return Result;
   end Suite;
end Compat_Primality;
