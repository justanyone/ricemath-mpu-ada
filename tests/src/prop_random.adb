with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Assertions;
with Interfaces;
with Math_Prime_Util.Random;

package body Prop_Random is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Random;
   use type U64;
   type U64_Array is array (Positive range <>) of U64;
   use type Interfaces.Unsigned_32;
   type Random_Case is new Test_Case with null record;
   overriding function Name (T : Random_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Random_Case);

   procedure Laws (T : in out Test_Case'Class);
   procedure Laws (T : in out Test_Case'Class) is
      Whole : String (1 .. 2048);
      Raised : Boolean := False;
      Part_1 : String (1 .. 1);
      Part_2 : String (1 .. 63);
      Part_3 : String (1 .. 960);
      Part_4 : String (1 .. 1024);
   begin
      Srand (42);
      Whole := Random_Bytes (Whole'Length);
      Srand (42);
      Part_1 := Random_Bytes (1);
      Part_2 := Random_Bytes (63);
      Part_3 := Random_Bytes (960);
      Part_4 := Random_Bytes (1024);
      AUnit.Assertions.Assert
        (Part_1 & Part_2 & Part_3 & Part_4 = Whole,
         "seed 42: partition invariance");
      Srand (42);
      declare
         First : constant U64 := Irand64;
         Second : constant U64 := Irand64;
         task type Reader is
            entry Start;
            entry Get (Value : out U64);
         end Reader;
         task body Reader is
            Draw : U64;
         begin
            accept Start;
            Draw := Irand64;
            accept Get (Value : out U64) do
               Value := Draw;
            end Get;
         end Reader;
         A, B : Reader;
         X, Y : U64;
      begin
         Srand (42);
         A.Start; B.Start;
         A.Get (X); B.Get (Y);
         AUnit.Assertions.Assert
           ((X = First and then Y = Second) or else
            (Y = First and then X = Second), "atomic concurrent calls");
      end;
      for Bits in 0 .. 64 loop
         Srand (42);
         declare
            Value : constant U64 := Urandomb (Bits);
         begin
            AUnit.Assertions.Assert
              (Bits = 64 or else Value < 2 ** Bits, "seed 42: bit bound");
         end;
      end loop;
      for Bound of U64_Array'
        ([1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
          2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last])
      loop
         for I in 1 .. 32 loop
            AUnit.Assertions.Assert
              (Urandomm (Bound) < Bound, "seed 42: boundary modulus");
            AUnit.Assertions.Assert
              (Urandomr (U64'Last - Bound, U64'Last) >= U64'Last - Bound,
               "seed 42: upper interval boundary");
         end loop;
      end loop;
      for I in 1 .. 1000 loop
         AUnit.Assertions.Assert
           (Urandomm (17) < 17 and then Urandomr (7, 31) in 7 .. 31,
            "seed 42: interval bounds");
      end loop;
      begin
         declare
            Invalid : constant U64 := Urandomb (65);
         begin
            AUnit.Assertions.Assert (Invalid = 0, "invalid bits accepted");
         end;
      exception
         when Ada.Assertions.Assertion_Error | Constraint_Error =>
            Raised := True;
      end;
      AUnit.Assertions.Assert (Raised, "bits precondition");
      Srand (42);
      AUnit.Assertions.Assert
        (Urandomm (1) = 0 and then
         Urandomb (0) = 0 and then Urandomr (9, 9) = 9 and then
         Random_Bytes (0)'Length = 0 and then Irand = 445_265_827,
         "seed 42: degenerate calls consume no bytes");
   end Laws;

   overriding function Name (T : Random_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Random");
   end Name;

   overriding procedure Register_Tests (T : in out Random_Case) is
   begin
      Registration.Register_Routine (T, Laws'Access, "stream laws seed 42");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Random_Case);
      return Result;
   end Suite;
end Prop_Random;
