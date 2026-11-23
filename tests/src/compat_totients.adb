with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Arith.Totients;

package body Compat_Totients is
   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Arith;
   use Math_Prime_Util.Arith.Totients;
   use type U64;
   use type U128;
   use type I128;
   use type AUnit.Message_String;

   type Totients_Case is new Test_Case with null record;
   overriding function Name (T : Totients_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Totients_Case);

   function Image (N : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (N), Ada.Strings.Both));
   function Image (N : U128) return String is
     (Ada.Strings.Fixed.Trim (U128'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("arith"), Func);
      A, B : I128;
      Actual : Unbounded_String;
      R : Optional_U64;
      Tau : Optional_I128;
   begin
      Assert (not Cases.Is_Empty, Func & " fixtures present");
      for C of Cases loop
         Actual := Null_Unbounded_String;
         begin
            A := I128'Value (To_String (C.Args (1)));
            B := (if Natural (C.Args.Length) = 2 then
                    I128'Value (To_String (C.Args (2))) else 0);
            if Func = "dedekind_psi" then
               R := Dedekind_Psi (A);
               Actual := To_Unbounded_String
                 ((if R.Defined then Image (I128 (R.Value)) else "undef"));
            elsif A < 0 or else B < 0 then
               raise Constraint_Error;
            elsif Func = "carmichael_lambda" then
               Actual := To_Unbounded_String
                 (Image (I128 (Carmichael_Lambda (U64 (A)))));
            elsif Func = "inverse_totient" then
               declare
                  V : constant U64_Vectors.Vector := Inverse_Totient (U64 (A));
               begin
                  Assert (Inverse_Totient_Count (U64 (A)) = U64 (V.Length),
                          "inverse count matches list");
                  if V.Is_Empty then
                     Actual := To_Unbounded_String ("undef");
                  end if;
                  for I in V.First_Index .. V.Last_Index loop
                     if Length (Actual) > 0 then
                        Append (Actual, " ");
                     end if;
                     Append (Actual, Image (I128 (V.Element (I))));
                     Assert (Euler_Phi (I128 (V.Element (I))) = U64 (A),
                             "every fixture preimage has requested phi");
                  end loop;
               end;
            elsif Func = "is_totient" then
               Actual := To_Unbounded_String
                 ((if Is_Totient (U64 (A)) then "1" else "0"));
            elsif Func = "ramanujan_sum" then
               Actual := To_Unbounded_String
                 (Image (Ramanujan_Sum (U64 (A), U64 (B))));
            elsif Func = "sumtotient" then
               --  Named skips arith.tsv:10245, 10246, 10247, 10248:
               --  undef encodes U64 overflow, not a numerical oracle.
               --  The U128 crossing is tested explicitly in Laws.
               if C.Undef then
                  Actual := C.Result;
               else
                  Actual := To_Unbounded_String
                    (Image (Sumtotient (U64 (A))));
               end if;
            elsif Func = "sumliouville" then
               Actual := To_Unbounded_String
                 (Image (Sumliouville (U64 (A))));
            else
               Tau := Ramanujan_Tau (U64 (A));
               Actual := To_Unbounded_String
                 ((if Tau.Defined then Image (Tau.Value) else "undef"));
            end if;
         exception
            when Constraint_Error | Ada.Assertions.Assertion_Error =>
               Actual := To_Unbounded_String ("ERROR");
         end;
         Assert (Actual = C.Result,
                 Func & " line" & C.Line_Number'Image & ": " &
                 To_String (Actual) & " expected " & To_String (C.Result));
      end loop;
   end Replay;

   procedure Test_Carmichael_Lambda (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("carmichael_lambda");
   end Test_Carmichael_Lambda;

   procedure Test_Dedekind_Psi (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("dedekind_psi");
   end Test_Dedekind_Psi;

   procedure Test_Inverse_Totient (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("inverse_totient");
   end Test_Inverse_Totient;

   procedure Test_Is_Totient (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("is_totient");
   end Test_Is_Totient;

   procedure Test_Ramanujan_Sum (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("ramanujan_sum");
   end Test_Ramanujan_Sum;

   procedure Test_Sumtotient (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("sumtotient");
   end Test_Sumtotient;

   procedure Test_Sumliouville (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("sumliouville");
   end Test_Sumliouville;

   procedure Test_Ramanujan_Tau (T : in out Test_Case'Class) is
   begin
      Assert (T.Name /= null, "named totient test");
      Replay ("ramanujan_tau");
   end Test_Ramanujan_Tau;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_123;
      N, L : U64;
      Inputs : constant array (Positive range <>) of U64 :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63 + 1, U64'Last];
      V : U64_Vectors.Vector;
   begin
      Assert (T.Name /= null, "named property test");
      Assert (Sumtotient (7_790_208_951) =
                2 ** 64 + 2_584_983_748, "128-bit phi sum crossing");
      for X of Inputs loop
         L := Carmichael_Lambda (X);
         if X > 0 then
            Assert (L > 0 and then Euler_Phi (I128 (X)) mod L = 0,
                    "native boundary lambda divides phi");
         else
            Assert (L = 0, "lambda zero");
         end if;
         Assert (Ramanujan_Sum (X, 0) = 0, "zero Ramanujan sum");
         if X > 0 then
            Assert (Ramanujan_Sum (X, X) = I128 (Euler_Phi (I128 (X))),
                    "diagonal Ramanujan sum at native boundary");
         end if;
      end loop;
      Assert (not Dedekind_Psi (I128 (U64'Last)).Defined,
              "psi overflow boundary");
      Assert (Sumtotient (0) = 0 and then Sumliouville (0) = 0,
              "empty summatory functions");
      Assert (not Is_Totient (0), "zero is not a totient");
      for I in 1 .. 200 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := Seed mod 10_000 + 1;
         V := Inverse_Totient (N);
         Assert (Is_Totient (N) = not V.Is_Empty,
                 "is_totient iff inverse nonempty seed 20261123");
         for J in V.First_Index .. V.Last_Index loop
            Assert (Euler_Phi (I128 (V.Element (J))) = N,
                    "inverse phi seed 20261123");
            if J > V.First_Index then
               Assert (V.Element (J - 1) < V.Element (J), "sorted unique");
            end if;
         end loop;
         L := Carmichael_Lambda (N);
         Assert (Euler_Phi (I128 (N)) mod L = 0,
                 "lambda divides phi seed 20261123");
         Assert (Sumtotient (N) - Sumtotient (N - 1) =
                   U128 (Euler_Phi (I128 (N))), "phi prefix seed 20261123");
      end loop;
   end Laws;

   overriding function Name (T : Totients_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Totients");
   end Name;

   overriding procedure Register_Tests (T : in out Totients_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Carmichael_Lambda'Access, "carmichael_lambda");
      Register_Routine (T, Test_Dedekind_Psi'Access, "dedekind_psi");
      Register_Routine (T, Test_Inverse_Totient'Access, "inverse_totient");
      Register_Routine (T, Test_Is_Totient'Access, "is_totient");
      Register_Routine (T, Test_Ramanujan_Sum'Access, "ramanujan_sum");
      Register_Routine (T, Test_Sumtotient'Access, "sumtotient");
      Register_Routine (T, Test_Sumliouville'Access, "sumliouville");
      Register_Routine (T, Test_Ramanujan_Tau'Access, "ramanujan_tau");
      Register_Routine (T, Laws'Access, "seeded totient laws 20261123");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Totients_Case);
      return Result;
   end Suite;
end Compat_Totients;
