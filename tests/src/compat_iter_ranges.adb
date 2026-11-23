with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Iter.Ranges;

package body Compat_Iter_Ranges is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Iter;
   use Math_Prime_Util.Iter.Ranges;
   use type U64;

   type Range_Case is new Test_Case with null record;
   overriding function Name (T : Range_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Range_Case);

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("iter"), Func);
      A, B, K : U64;
      Fits : Boolean;
      Got : Unbounded_String;
      Count : Natural;
      procedure Push (Token : String; Context : in out Loop_Context) is
      begin
         if Count > 0 then
            Append (Got, " ");
         end if;
         Append (Got, Token);
         Count := Count + 1;
         if Count = 2000 then
            Lastfor (Context);
         end if;
      end Push;
      procedure Scalar (Value : U64; Context : in out Loop_Context) is
      begin
         Push (Image (Value), Context);
      end Scalar;
      procedure Factored
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context)
      is
         Token : Unbounded_String := To_Unbounded_String (Image (Value)
                                                          & ":");
      begin
         for I in Factors'Range loop
            if I > Factors'First then
               Append (Token, "*");
            end if;
            Append (Token, Image (Factors (I)));
         end loop;
         Push (To_String (Token), Context);
      end Factored;
      Start : Positive;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         Got := Null_Unbounded_String;
         Count := 0;
         Start := (if Func = "foralmostprimes" then 2 else 1);
         K := 0;
         Fits := True;
         if Start = 2 then
            Fits := Parse_U64 (To_String (C.Args (1)), K);
         end if;
         Fits := Parse_U64 (To_String (C.Args (Start)), A) and then Fits;
         B := A;
         if Natural (C.Args.Length) > Start then
            Fits := Parse_U64 (To_String (C.Args (Start + 1)), B)
              and then Fits;
         end if;
         --  iter.tsv lines 94, 96, 108-109, 132, 164-165, 167-168,
         --  212-213 exceed U64 and belong to the bigint tier.
         --  Lines 214-215 are negative/text errors excluded by Ada's type.
         if Fits and then not C.Error then
            if Func = "fordivisors" then
               Fordivisors (A, Scalar'Access);
            elsif Func = "foralmostprimes" then
               if Natural (C.Args.Length) = 2 then
                  Foralmostprimes (Natural (K), A, Scalar'Access);
               else
                  Foralmostprimes (Natural (K), A, B, Scalar'Access);
               end if;
            elsif Func = "foroddcomposites" then
               if Natural (C.Args.Length) = 1 then
                  Foroddcomposites (A, Scalar'Access);
               else
                  Foroddcomposites (A, B, Scalar'Access);
               end if;
            elsif Func = "forsemiprimes" then
               if Natural (C.Args.Length) = 1 then
                  Forsemiprimes (A, Scalar'Access);
               else
                  Forsemiprimes (A, B, Scalar'Access);
               end if;
            elsif Func = "forsquarefree" then
               if Natural (C.Args.Length) = 1 then
                  Forsquarefree (A, Factored'Access);
               else
                  Forsquarefree (A, B, Factored'Access);
               end if;
            elsif Func = "forsquarefreeint" then
               if Natural (C.Args.Length) = 1 then
                  Forsquarefreeint (A, Scalar'Access);
               else
                  Forsquarefreeint (A, B, Scalar'Access);
               end if;
            end if;
            AUnit.Assertions.Assert
              (To_String (Got) = To_String (C.Result),
               Func & " expected " & To_String (C.Result)
               & " got " & To_String (Got));
         end if;
      end loop;
   end Replay;

   procedure Check_Odd (T : in out Test_Case'Class) is
   begin
      Replay ("foroddcomposites");
   end Check_Odd;
   procedure Check_Semi (T : in out Test_Case'Class) is
   begin
      Replay ("forsemiprimes");
   end Check_Semi;
   procedure Check_Almost (T : in out Test_Case'Class) is
   begin
      Replay ("foralmostprimes");
   end Check_Almost;
   procedure Check_Square (T : in out Test_Case'Class) is
   begin
      Replay ("forsquarefree");
   end Check_Square;
   procedure Check_Square_Int (T : in out Test_Case'Class) is
   begin
      Replay ("forsquarefreeint");
   end Check_Square_Int;
   procedure Check_Divisors (T : in out Test_Case'Class) is
   begin
      Replay ("fordivisors");
   end Check_Divisors;

   procedure Check_Lastfor (T : in out Test_Case'Class) is
      Count : Natural := 0;
      First : U64 := 0;
      procedure Stop (Value : U64; Context : in out Loop_Context) is
      begin
         Count := Count + 1;
         First := Value;
         Lastfor (Context);
      end Stop;
      procedure Stop_Factors
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context) is
      begin
         AUnit.Assertions.Assert (Factors'Length = 0, "one has no factors");
         Stop (Value, Context);
      end Stop_Factors;
      procedure Check (Expected : U64) is
      begin
         AUnit.Assertions.Assert
           (Count = 1 and then First = Expected, "Lastfor stops range");
         Count := 0;
      end Check;
   begin
      Foroddcomposites (10000, Stop'Access);
      Check (9);
      Forsemiprimes (10000, Stop'Access);
      Check (4);
      Foralmostprimes (3, 10000, Stop'Access);
      Check (8);
      Forsquarefree (0, 3, Stop_Factors'Access);
      Check (1);
      Forsquarefreeint (0, 3, Stop'Access);
      Check (1);
      Fordivisors (360, Stop'Access);
      Check (1);
   end Check_Lastfor;

   overriding function Name (T : Range_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Iter_Ranges"));

   overriding procedure Register_Tests (T : in out Range_Case) is
   begin
      Registration.Register_Routine (T, Check_Odd'Access, "odd composites");
      Registration.Register_Routine (T, Check_Semi'Access, "semiprimes");
      Registration.Register_Routine (T, Check_Almost'Access, "almost primes");
      Registration.Register_Routine (T, Check_Square'Access, "squarefree");
      Registration.Register_Routine
        (T, Check_Square_Int'Access, "squarefree integers");
      Registration.Register_Routine (T, Check_Divisors'Access, "divisors");
      Registration.Register_Routine (T, Check_Lastfor'Access, "lastfor");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Range_Case);
      return Result;
   end Suite;
end Compat_Iter_Ranges;
