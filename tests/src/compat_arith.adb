with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Arith;
with Math_Prime_Util.Int;

package body Compat_Arith is
   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Arith;
   use Math_Prime_Util.Int;
   use type U64;
   use type I128;
   use type AUnit.Message_String;

   type Arith_Case is new Test_Case with null record;
   overriding function Name (T : Arith_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Arith_Case);

   function Image (N : I128) return String is
     (Ada.Strings.Fixed.Trim (I128'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("arith"), Func);
      A, B, Value : I128;
      Actual : Unbounded_String;
      R : Optional_U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, Func & " has fixtures");
      for C of Cases loop
         Actual := Null_Unbounded_String;
         begin
            A := I128'Value (To_String (C.Args (1)));
            B := (if Natural (C.Args.Length) = 2 then
                    I128'Value (To_String (C.Args (2))) else A);
            if Func = "jordan_totient" then
               R := Jordan_Totient (U64 (A), U64 (B));
               Actual := To_Unbounded_String
                 ((if R.Defined then Image (I128 (R.Value)) else "undef"));
            elsif Func = "mertens" then
               if A < 0 or else B < 0 then
                  raise Constraint_Error;
               end if;
               Value := (if Natural (C.Args.Length) = 2 then
                           Mertens (U64 (A), U64 (B)) else Mertens (U64 (A)));
               Actual := To_Unbounded_String (Image (Value));
            elsif B < A then
               Actual := To_Unbounded_String ("undef");
            else
               --  Perl's range forms expand into the same scalar API. I128
               --  keeps both negative endpoints and U64'Last exact.
               for N in A .. B loop
                  if Func = "euler_phi" then
                     Value := I128 (Euler_Phi (N));
                  elsif Func = "moebius" then
                     Value := I128 (Moebius (N));
                  elsif Func = "liouville" then
                     Value := I128 (Liouville (U64 (N)));
                  else
                     Value := I128 (Exp_Mangoldt (U64 (N)));
                  end if;
                  if Length (Actual) > 0 then
                     Actual := Actual & " ";
                  end if;
                  Actual := Actual & Image (Value);
               end loop;
            end if;
         exception
            when Constraint_Error | Ada.Assertions.Assertion_Error =>
               Actual := To_Unbounded_String ("ERROR");
         end;
         AUnit.Assertions.Assert
           (Actual = C.Result,
            Func & Positive'Image (C.Line_Number) & ": " &
            To_String (Actual) & " expected " & To_String (C.Result));
      end loop;
   end Replay;

   procedure Test_Euler_Phi (T : in out Test_Case'Class) is
   begin
      Replay ("euler_phi");
   end Test_Euler_Phi;

   procedure Test_Jordan_Totient (T : in out Test_Case'Class) is
   begin
      Replay ("jordan_totient");
   end Test_Jordan_Totient;

   procedure Test_Moebius (T : in out Test_Case'Class) is
   begin
      Replay ("moebius");
   end Test_Moebius;

   procedure Test_Mertens (T : in out Test_Case'Class) is
   begin
      Replay ("mertens");
   end Test_Mertens;

   procedure Test_Liouville (T : in out Test_Case'Class) is
   begin
      Replay ("liouville");
   end Test_Liouville;

   procedure Test_Exp_Mangoldt (T : in out Test_Case'Class) is
   begin
      Replay ("exp_mangoldt");
   end Test_Exp_Mangoldt;

   procedure Test_Properties (T : in out Test_Case'Class) is
      Sum_Phi : U64;
      Sum_Mu : Integer;
      Running : I128 := 0;
      R : Optional_U64;
   begin
      --  Exhaustive small inputs: sum_{d|n} phi(d)=n and
      --  sum_{d|n} mu(d)=[n=1]; M(n)-M(n-1)=mu(n).
      for N in U64 range 1 .. 200 loop
         Sum_Phi := 0;
         Sum_Mu := 0;
         for D in U64 range 1 .. N loop
            if N mod D = 0 then
               Sum_Phi := Sum_Phi + Euler_Phi (I128 (D));
               Sum_Mu := Sum_Mu + Moebius (I128 (D));
            end if;
         end loop;
         AUnit.Assertions.Assert (Sum_Phi = N, "phi divisor identity");
         AUnit.Assertions.Assert
           (Sum_Mu = (if N = 1 then 1 else 0), "mu divisor identity");
         Running := Running + I128 (Moebius (I128 (N)));
         AUnit.Assertions.Assert (Mertens (N) = Running, "Mertens prefix");
         R := Jordan_Totient (1, N);
         AUnit.Assertions.Assert
           (R.Defined and then R.Value = Euler_Phi (I128 (N)), "J1=phi");
      end loop;
      R := Jordan_Totient (64, 2);
      AUnit.Assertions.Assert
        (R.Defined and then R.Value = U64'Last, "J64(2) native boundary");
      AUnit.Assertions.Assert
        (not Jordan_Totient (65, 2).Defined, "Jordan overflow");
      AUnit.Assertions.Assert
        (not Jordan_Totient (64, 4).Defined, "Jordan repeated overflow");
      AUnit.Assertions.Assert (Mertens (0) = 0, "empty prefix");
      AUnit.Assertions.Assert (Mertens (10, 5) = 0, "empty range");
      AUnit.Assertions.Assert (Liouville (0) = -1, "liouville zero");
      AUnit.Assertions.Assert (Moebius (0) = 0, "mu zero");
      AUnit.Assertions.Assert (Exp_Mangoldt (0) = 1, "Mangoldt zero");
   end Test_Properties;

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

   overriding function Name (T : Arith_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Arith");
   end Name;

   overriding procedure Register_Tests (T : in out Arith_Case) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (T, Test_Euler_Phi'Access, "euler_phi");
      Register_Routine (T, Test_Jordan_Totient'Access, "jordan_totient");
      Register_Routine (T, Test_Moebius'Access, "moebius");
      Register_Routine (T, Test_Mertens'Access, "mertens");
      Register_Routine (T, Test_Liouville'Access, "liouville");
      Register_Routine (T, Test_Exp_Mangoldt'Access, "exp_mangoldt");
      Register_Routine
        (T, Test_Properties'Access, "arithmetic identities and boundaries");
      Register_Routine (T, Fixtures'Access, "arith fixtures");
      Register_Routine (T, Boundaries'Access, "arith boundaries");
      Register_Routine (T, Properties'Access, "arith seeded properties");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Arith_Case);
      return Result;
   end Suite;
end Compat_Arith;
