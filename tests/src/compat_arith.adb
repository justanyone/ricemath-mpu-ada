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
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Arith;
   use Math_Prime_Util.Int;
   use type U64;

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

   overriding function Name (T : Arith_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Arith");
   end Name;

   overriding procedure Register_Tests (T : in out Arith_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Euler_Phi'Access, "euler_phi");
      Registration.Register_Routine
        (T, Test_Jordan_Totient'Access, "jordan_totient");
      Registration.Register_Routine (T, Test_Moebius'Access, "moebius");
      Registration.Register_Routine (T, Test_Mertens'Access, "mertens");
      Registration.Register_Routine (T, Test_Liouville'Access, "liouville");
      Registration.Register_Routine
        (T, Test_Exp_Mangoldt'Access, "exp_mangoldt");
      Registration.Register_Routine
        (T, Test_Properties'Access, "arithmetic identities and boundaries");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Arith_Case);
      return Result;
   end Suite;
end Compat_Arith;
