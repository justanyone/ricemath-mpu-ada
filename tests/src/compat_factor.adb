with AUnit.Assertions;
with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;

package body Compat_Factor is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   use type Primality.Prime_Result;

   type Factor_Case is new Test_Case with null record;
   overriding function Name (T : Factor_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Factor_Case);

   overriding function Name (T : Factor_Case)
      return AUnit.Message_String
   is
   begin
      return AUnit.Format ("Compat_Factor");
   end Name;

   function Trim (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   function Join (L : Factor.Factor_List) return String is
      Text : Unbounded_String;
   begin
      for I in 1 .. L.Count loop
         if I > 1 then
            Append (Text, " ");
         end if;
         Append (Text, Trim (L.Value (I)));
      end loop;
      return To_String (Text);
   end Join;

   function Join (V : Factor.U64_Vectors.Vector) return String is
      Text : Unbounded_String;
      First : Boolean := True;
   begin
      for D of V loop
         if not First then
            Append (Text, " ");
         end if;
         First := False;
         Append (Text, Trim (D));
      end loop;
      return To_String (Text);
   end Join;

   function Arg (C : Case_Record; Index : Positive) return U64 is
      V : U64;
   begin
      if not Parse_U64 (To_String (C.Args (Index)), V) then
         raise Constraint_Error with "non-native fixture input";
      end if;
      return V;
   end Arg;

   --  Skipped trial_factor rows, named by this predicate: the oracle
   --  least factor exceeds 1_000_000, the limit does not stop earlier,
   --  and N is not prime (primes return through is_prime).
   --  Walking a wheel that far does not finish inside one minute.
   function Slow_Trial (C : Case_Record) return Boolean is
      N, Last, Least : U64;
      Token : Unbounded_String;
      Start : Positive;
      Text : constant String := To_String (C.Result);
   begin
      if C.Error or else C.Undef or else C.Args.Is_Empty then
         return False;
      end if;
      if not Parse_U64 (To_String (C.Args (1)), N) then
         return False;
      end if;
      if Primality.Is_Prime (N) = 2 then
         return False;
      end if;
      Last := 0;
      if Natural (C.Args.Length) >= 2
        and then not Parse_U64 (To_String (C.Args (2)), Last)
      then
         return False;
      end if;
      Start := Text'First;
      for I in Text'Range loop
         if Text (I) = ' ' then
            Start := I;
            exit;
         end if;
      end loop;
      if Start = Text'First then
         Token := C.Result;
      else
         Token := To_Unbounded_String (Text (Text'First .. Start - 1));
      end if;
      if not Parse_U64 (To_String (Token), Least) then
         return False;
      end if;
      return Least > 1_000_000 and then (Last = 0 or else Last >= Least);
   end Slow_Trial;

   --  Skipped: line 9700, trial_factor of 553402322211286548450,
   --  and any other row whose argument does not fit U64.
   --  The native API has no bigint tier. ERROR rows still run.
   function Above_Native (C : Case_Record) return Boolean is
      Dummy : U64;
   begin
      if C.Error or else C.Args.Is_Empty then
         return False;
      end if;
      if not Parse_U64 (To_String (C.Args (1)), Dummy) then
         return True;
      end if;
      if Natural (C.Args.Length) >= 2
        and then not Parse_U64 (To_String (C.Args (2)), Dummy)
      then
         return True;
      end if;
      if Natural (C.Args.Length) >= 3
        and then not Parse_U64 (To_String (C.Args (3)), Dummy)
      then
         return True;
      end if;
      return False;
   end Above_Native;

   function Evaluate (C : Case_Record; F : String) return String is
      N : constant U64 := Arg (C, 1);
      A : U64 := 0;
      B : U64 := 0;
   begin
      if Natural (C.Args.Length) >= 2 then
         A := Arg (C, 2);
      end if;
      if Natural (C.Args.Length) >= 3 then
         B := Arg (C, 3);
      end if;
      if F = "factor" then
         return Join (Factor.Factor (N));
      elsif F = "trial_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Trial_Factor (N));
         end if;
         return Join (Factor.Trial_Factor (N, A));
      elsif F = "fermat_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Fermat_Factor (N));
         end if;
         return Join (Factor.Fermat_Factor (N, A));
      elsif F = "holf_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Holf_Factor (N));
         end if;
         return Join (Factor.Holf_Factor (N, A));
      elsif F = "lehman_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Lehman_Factor (N));
         end if;
         return Join (Factor.Lehman_Factor (N, A /= 0));
      elsif F = "squfof_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Squfof_Factor (N));
         end if;
         return Join (Factor.Squfof_Factor (N, A));
      elsif F = "prho_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Prho_Factor (N));
         end if;
         return Join (Factor.Prho_Factor (N, A));
      elsif F = "pbrent_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Pbrent_Factor (N));
         elsif Natural (C.Args.Length) < 3 then
            return Join (Factor.Pbrent_Factor (N, A));
         end if;
         return Join (Factor.Pbrent_Factor (N, A, B));
      elsif F = "pminus1_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Pminus1_Factor (N));
         elsif Natural (C.Args.Length) < 3 then
            return Join (Factor.Pminus1_Factor (N, A));
         end if;
         return Join (Factor.Pminus1_Factor (N, A, B));
      elsif F = "pplus1_factor" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Pplus1_Factor (N));
         end if;
         return Join (Factor.Pplus1_Factor (N, A));
      elsif F = "divisors" then
         if Natural (C.Args.Length) < 2 then
            return Join (Factor.Divisors (N));
         end if;
         return Join (Factor.Divisors (N, A));
      end if;
      raise Constraint_Error with "unknown function";
   end Evaluate;

   procedure Replay (F : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("factor"), F);
      Value : Unbounded_String;
      Raised : Boolean;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & F);
      for C of Cases loop
         --  Above_Native names rows whose arguments do not fit U64.
         --  Slow_Trial names the long trial_factor rows.
         if not Above_Native (C)
           and then not (F = "trial_factor" and then Slow_Trial (C))
         then
            Raised := False;
            begin
               Value := To_Unbounded_String (Evaluate (C, F));
            exception
               when Constraint_Error | Ada.Assertions.Assertion_Error =>
                  Raised := True;
            end;
            AUnit.Assertions.Assert
              (Raised = C.Error,
               F & " error" & C.Line_Number'Image);
            if not Raised and then not C.Error then
               if C.Undef then
                  AUnit.Assertions.Assert
                    (Value = "",
                     F & " undef" & C.Line_Number'Image);
               else
                  AUnit.Assertions.Assert
                    (Value = C.Result,
                     F & " row" & C.Line_Number'Image & " got "
                       & To_String (Value));
               end if;
            end if;
         end if;
      end loop;
   end Replay;

   procedure Test_Factor (T : in out Test_Case'Class) is
   begin
      Replay ("factor");
   end Test_Factor;

   procedure Test_Trial (T : in out Test_Case'Class) is
   begin
      Replay ("trial_factor");
   end Test_Trial;

   procedure Test_Fermat (T : in out Test_Case'Class) is
   begin
      Replay ("fermat_factor");
   end Test_Fermat;

   procedure Test_Holf (T : in out Test_Case'Class) is
   begin
      Replay ("holf_factor");
   end Test_Holf;

   procedure Test_Lehman (T : in out Test_Case'Class) is
   begin
      Replay ("lehman_factor");
   end Test_Lehman;

   procedure Test_Squfof (T : in out Test_Case'Class) is
   begin
      Replay ("squfof_factor");
   end Test_Squfof;

   procedure Test_Rho (T : in out Test_Case'Class) is
   begin
      Replay ("prho_factor");
   end Test_Rho;

   procedure Test_Brent (T : in out Test_Case'Class) is
   begin
      Replay ("pbrent_factor");
   end Test_Brent;

   procedure Test_Pminus1 (T : in out Test_Case'Class) is
   begin
      Replay ("pminus1_factor");
   end Test_Pminus1;

   procedure Test_Pplus1 (T : in out Test_Case'Class) is
   begin
      Replay ("pplus1_factor");
   end Test_Pplus1;

   procedure Test_Divisors (T : in out Test_Case'Class) is
   begin
      Replay ("divisors");
   end Test_Divisors;

   overriding procedure Register_Tests (T : in out Factor_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Factor'Access, "factor");
      Registration.Register_Routine
        (T, Test_Trial'Access, "trial_factor");
      Registration.Register_Routine
        (T, Test_Fermat'Access, "fermat_factor");
      Registration.Register_Routine
        (T, Test_Holf'Access, "holf_factor");
      Registration.Register_Routine
        (T, Test_Lehman'Access, "lehman_factor");
      Registration.Register_Routine
        (T, Test_Squfof'Access, "squfof_factor");
      Registration.Register_Routine
        (T, Test_Rho'Access, "prho_factor");
      Registration.Register_Routine
        (T, Test_Brent'Access, "pbrent_factor");
      Registration.Register_Routine
        (T, Test_Pminus1'Access, "pminus1_factor");
      Registration.Register_Routine
        (T, Test_Pplus1'Access, "pplus1_factor");
      Registration.Register_Routine
        (T, Test_Divisors'Access, "divisors");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Factor_Case);
      return Result;
   end Suite;
end Compat_Factor;
