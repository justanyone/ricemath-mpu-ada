with Ada.Assertions;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Int;

package body Prop_Primality is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Primality;
   use type U64;
   use type Prime_Result;
   type Primality_Case is new Test_Case with null record;
   overriding function Name (T : Primality_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Primality_Case);
   overriding function Name (T : Primality_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Primality seed 20261020");
   end Name;
   procedure Laws (T : in out Test_Case'Class);
   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, A, D : U64;
      Prime : Boolean;
   begin
      for I in 1 .. 2_000 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := Seed mod 100_000;
         Prime := N >= 2;
         D := 2;
         while D <= N / D loop
            if N mod D = 0 then
               Prime := False;
               exit;
            end if;
            D := D + 1;
         end loop;
         AUnit.Assertions.Assert
           ((Is_Prime (N) = 2) = Prime, "trial seed 20261020");
         AUnit.Assertions.Assert
           (Is_Prime (N) = Is_Prime (N), "repeat seed 20261020");
         N := Seed or 1;
         if N > 3 then
            A := Seed / 4 + 2;
            AUnit.Assertions.Assert
              (Is_Pseudoprime (N, A) =
                 (Int.Powmod (A, N - 1, N).Value = 1),
               "Montgomery vs u128 seed 20261020");
         end if;
      end loop;
      for P in U64 range 2 .. 1_000 loop
         if Is_Prime (P) = 2 then
            AUnit.Assertions.Assert
              (Is_Lucas_Pseudoprime (P) and
               Is_Strong_Lucas_Pseudoprime (P) and
               Is_Extra_Strong_Lucas_Pseudoprime (P), "prime Lucas law");
         end if;
      end loop;
   end Laws;
   procedure Boundaries (T : in out Test_Case'Class);
   procedure Boundaries (T : in out Test_Case'Class) is
      Edges : constant array (Positive range <>) of U64 :=
        (0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63 + 1, U64'Last);
      Rejected : Boolean := False;
      Value : Boolean;
   begin
      for N of Edges loop
         AUnit.Assertions.Assert
           (Is_Prime (N) = (if N = 2 then 2 else 0),
            "native boundary primality");
      end loop;
      begin
         Value := Is_Strong_Pseudoprime (17, 1);
         AUnit.Assertions.Assert (not Value, "invalid base accepted");
      exception
         when Ada.Assertions.Assertion_Error | Constraint_Error =>
            Rejected := True;
      end;
      AUnit.Assertions.Assert (Rejected, "base precondition");
      Rejected := False;
      begin
         Value := Is_Almost_Extra_Strong_Lucas_Pseudoprime (17, 0);
         AUnit.Assertions.Assert (not Value, "invalid increment accepted");
      exception
         when Ada.Assertions.Assertion_Error | Constraint_Error =>
            Rejected := True;
      end;
      AUnit.Assertions.Assert (Rejected, "increment precondition");
   end Boundaries;

   procedure Concurrent (T : in out Test_Case'Class);
   procedure Concurrent (T : in out Test_Case'Class) is
      task type Worker is
         entry Result (Passed : out Boolean);
      end Worker;
      task body Worker is
         Good : Boolean := True;
      begin
         for I in 1 .. 100 loop
            Good := Good and Is_Prime (18_446_744_073_709_551_557) = 2
              and not Is_Bpsw_Prime (U64'Last);
         end loop;
         accept Result (Passed : out Boolean) do
            Passed := Good;
         end Result;
      end Worker;
      A, B : Worker;
      First, Second : Boolean;
   begin
      A.Result (First);
      B.Result (Second);
      AUnit.Assertions.Assert (First and Second, "concurrent calls");
   end Concurrent;

   overriding procedure Register_Tests (T : in out Primality_Case) is
   begin
      Registration.Register_Routine (T, Laws'Access, "primality laws");
      Registration.Register_Routine (T, Boundaries'Access, "boundaries");
      Registration.Register_Routine (T, Concurrent'Access, "concurrency");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Primality_Case);
      return Result;
   end Suite;
end Prop_Primality;
