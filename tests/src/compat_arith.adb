with AUnit.Assertions;
with AUnit.Test_Cases;
<<<<<<< HEAD
with Ada.Strings.Fixed;
=======
>>>>>>> origin/dev-mpuada-001
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Arith;

package body Compat_Arith is
   use AUnit.Test_Cases;
<<<<<<< HEAD
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
=======
   use AUnit.Assertions;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Arith;
   use type U64;
   use type I128;
   use type AUnit.Message_String;

>>>>>>> origin/dev-mpuada-001
   type Arith_Case is new Test_Case with null record;
   overriding function Name (T : Arith_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Arith_Case);

<<<<<<< HEAD
   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Rows : constant Case_Vectors.Vector :=
        For_Function (Load ("arith"), Func);
   begin
      AUnit.Assertions.Assert (not Rows.Is_Empty, "missing " & Func);
      for C of Rows loop
         declare
            K, Low, High : U64 := 0;
            Actual : Unbounded_String;
         begin
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (1)), K), "parse k");
            if C.Args.Length = 2 then
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (2)), High), "parse high");
               Low := (if K = 1 then 0 else 1);
            else
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (2)), Low), "parse low");
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (3)), High), "parse high");
            end if;
            if Func = "inverse_sigma0_count" then
               Actual := To_Unbounded_String
                 (Image
                    ((if C.Args.Length = 2 then
                        Math_Prime_Util.Arith.Inverse_Sigma0_Count (K, High)
                      else
                        Math_Prime_Util.Arith.Inverse_Sigma0_Count
                          (K, Low, High))));
            else
               declare
                  Values : constant Math_Prime_Util.Arith.U64_Vectors.Vector :=
                    (if C.Args.Length = 2 then
                       Math_Prime_Util.Arith.Inverse_Sigma0 (K, High)
                     else
                       Math_Prime_Util.Arith.Inverse_Sigma0
                         (K, Low, High));
               begin
                  if Values.Is_Empty then
                     Actual := To_Unbounded_String ("undef");
                  else
                     for I in Values.First_Index .. Values.Last_Index loop
                        if I > Values.First_Index then
                           Append (Actual, " ");
                        end if;
                        Append (Actual, Image (Values (I)));
                     end loop;
                  end if;
               end;
            end if;
            AUnit.Assertions.Assert
              (Actual = C.Result, Func & " line" & C.Line_Number'Image);
         end;
      end loop;
   end Replay;

   procedure Test_List (T : in out Test_Case'Class) is
   begin
      Replay ("inverse_sigma0");
   end Test_List;

   procedure Test_Count (T : in out Test_Case'Class) is
   begin
      Replay ("inverse_sigma0_count");
   end Test_Count;

=======
>>>>>>> origin/dev-mpuada-001
   overriding function Name (T : Arith_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Arith");
   end Name;

<<<<<<< HEAD
   overriding procedure Register_Tests (T : in out Arith_Case) is
   begin
      Registration.Register_Routine (T, Test_List'Access, "inverse_sigma0");
      Registration.Register_Routine
        (T, Test_Count'Access, "inverse_sigma0_count");
=======
   procedure Fixtures (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("arith");
      Count : Natural := 0;
      N, K, Expected : U64;
      Actual : Optional_U64;
   begin
      Assert (T.Name /= null, "named arithmetic test case");
      for C of Cases loop
         declare
            Func : constant String := To_String (C.Func);
            Context : constant String := Func & " row" &
              Positive'Image (C.Line_Number);
         begin
            if Func = "divisor_sum" or else Func = "aliquot_sum"
              or else Func = "abundance" or else Func = "sopf"
              or else Func = "sopfr"
            then
               Count := Count + 1;
               Assert (Parse_U64 (To_String (C.Args (1)), N), Context);
               Assert (not C.Error, Context & " unexpected error row");
               if Func = "abundance" then
                  --  Named skip: arith.tsv:8419, XS signed wrap at a prime
                  --  above 2**63 (upstream-findings.md finding 2).
                  if C.Line_Number = 8419 then
                     Assert
                       (Abundance (N) = 1 - I128 (N), Context & " corrected");
                  else
                     Assert
                       (Abundance (N) = I128'Value (To_String (C.Result)),
                        Context);
                  end if;
               else
                  if Func = "divisor_sum" then
                     K := 1;
                     if Natural (C.Args.Length) = 2 then
                        Assert
                          (Parse_U64 (To_String (C.Args (2)), K), Context);
                     end if;
                     Actual := Divisor_Sum (N, K);
                  elsif Func = "aliquot_sum" then
                     Actual := Aliquot_Sum (N);
                  elsif Func = "sopf" then
                     Actual := (True, Sopf (N));
                  else
                     Actual := (True, Sopfr (N));
                  end if;
                  Assert (Actual.Defined /= C.Undef, Context & " defined");
                  if Actual.Defined then
                     Assert
                       (Parse_U64 (To_String (C.Result), Expected), Context);
                     Assert (Actual.Value = Expected, Context);
                  end if;
               end if;
            end if;
         end;
      end loop;
      Assert (Count = 4126, "all five fixture functions must run");
   end Fixtures;

   procedure Boundaries (T : in out Test_Case'Class) is
      Inputs : constant array (Positive range <>) of U64 :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last];
      A, D : Optional_U64;
   begin
      Assert (T.Name /= null, "named arithmetic test case");
      for N of Inputs loop
         A := Aliquot_Sum (N);
         D := Divisor_Sum (N);
         Assert (Sopf (N) <= Sopfr (N) and then Sopfr (N) <= N,
                 "prime sums at" & U64'Image (N));
         if A.Defined then
            Assert (Abundance (N) = I128 (A.Value) - I128 (N),
                    "abundance identity");
            if D.Defined and then N > 0 then
               Assert (D.Value - N = A.Value, "aliquot identity");
            end if;
         end if;
         Assert (Divisor_Sum (N, 0).Defined, "divisor count fits");
      end loop;
      Assert (Divisor_Sum (0, U64'Last).Value = 0, "sigma zero");
      Assert (Divisor_Sum (1, U64'Last).Value = 1, "sigma one");
      Assert (Divisor_Sum (2, 63).Value = 2 ** 63 + 1, "power fits");
      Assert (not Divisor_Sum (2, 64).Defined, "power overflow");
      Assert (not Divisor_Sum (2, U64'Last).Defined, "huge exponent");
      Assert (Divisor_Sum (2 ** 63).Defined,
              "prime power sigma fits");
      Assert (Divisor_Sum (2 ** 63).Value = U64'Last, "sigma at limit");
      Assert (Aliquot_Sum (U64'Last).Value = 12_975_236_915_480_337_153,
              "aliquot fits although sigma overflows");
      Assert (Abundance (18_446_744_073_709_551_557) =
                -18_446_744_073_709_551_556, "signed wide boundary");
      Assert (not Aliquot_Sum (18_446_744_073_709_551_600).Defined,
              "aliquot overflow");
   end Boundaries;

   procedure Properties (T : in out Test_Case'Class) is
      Seed : U64 := 16#D1_7150#;
      N, Sum, Count, Square_Sum : U64;
   begin
      Assert (T.Name /= null, "named arithmetic test case");
      for Trial in 1 .. 150 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := Seed mod 2_000 + 1;
         Sum := 0;
         Count := 0;
         Square_Sum := 0;
         for D in 1 .. N loop
            if N mod D = 0 then
               Sum := Sum + D;
               Count := Count + 1;
               Square_Sum := Square_Sum + D * D;
            end if;
         end loop;
         Assert
           (Divisor_Sum (N).Value = Sum
            and then Divisor_Sum (N, 0).Value = Count
            and then Divisor_Sum (N, 2).Value = Square_Sum
            and then Aliquot_Sum (N).Value = Sum - N
            and then Abundance (N) = I128 (Sum) - 2 * I128 (N),
            "divisor laws seed=16#D1_7150# trial" & Integer'Image (Trial));
      end loop;
   end Properties;

   overriding procedure Register_Tests (T : in out Arith_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Fixtures'Access, "arith fixtures");
      Register_Routine (T, Boundaries'Access, "arith boundaries");
      Register_Routine (T, Properties'Access, "arith seeded properties");
>>>>>>> origin/dev-mpuada-001
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Arith_Case);
      return Result;
   end Suite;
end Compat_Arith;
