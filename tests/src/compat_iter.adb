with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Int;
with Math_Prime_Util.Iter;

package body Compat_Iter is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Iter;
   use type U64;

   type Iter_Case is new Test_Case with null record;
   overriding function Name (T : Iter_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Iter_Case);

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("iter"), Func);
      A, B : U64;
      Fits : Boolean;
      Got : Unbounded_String;
      Count : Natural;
      Options : Partition_Options;
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
      procedure Tuple
        (Values : Value_Array; Context : in out Loop_Context)
      is
         Token : Unbounded_String;
      begin
         for V of Values loop
            if Length (Token) > 0 then
               Append (Token, (if Func = "forpart" then "+" else ","));
            end if;
            Append (Token, Image (V));
         end loop;
         Push ((if Values'Length = 0 then "()" else To_String (Token)),
               Context);
      end Tuple;
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
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         Got := Null_Unbounded_String;
         Count := 0;
         A := 2;
         Fits := True;
         if not C.Args.Is_Empty then
            Fits := Parse_U64 (To_String (C.Args (1)), A);
         end if;
         B := A;
         Options := (others => <>);
         if Func = "forpart" then
            for I in 2 .. Natural (C.Args.Length) loop
               declare
                  Token : constant String := To_String (C.Args (I));
                  Sep : constant Natural :=
                    Ada.Strings.Fixed.Index (Token, "=");
                  V : U64;
               begin
                  if Sep = 0 or else
                    not Parse_U64 (Token (Sep + 1 .. Token'Last), V)
                    or else V > U64 (Natural'Last)
                  then
                     Fits := False;
                  else
                     declare
                        Key : constant String := Token (1 .. Sep - 1);
                     begin
                        if Key = "n" then
                           Options.Nmin := Natural (V);
                           Options.Nmax := Natural (V);
                        elsif Key = "nmin" then
                           Options.Nmin := Natural (V);
                        elsif Key = "nmax" then
                           Options.Nmax := Natural (V);
                        elsif Key = "amin" then
                           Options.Amin := Natural (V);
                        elsif Key = "amax" then
                           Options.Amax := Natural (V);
                        elsif Key = "prime" then
                           Options.Prime :=
                             (if V = 0 then Nonprime_Part else Prime_Part);
                        else
                           raise Constraint_Error with "unknown option";
                        end if;
                     end;
                  end if;
               end;
            end loop;
         elsif Natural (C.Args.Length) > 1 then
            Fits := Parse_U64 (To_String (C.Args (2)), B) and Fits;
         end if;
         --  Skipped ERROR rows: undef, negative, fractional and text inputs
         --  cannot reach these typed Ada APIs. Bigint inputs require the
         --  bigint tier. Prime streams crossing U64 are skipped as a whole.
         if Func = "prime_iterator" and then not C.Error then
            declare
               Tokens : constant String := To_String (C.Result);
               Start : Positive := Tokens'First;
               Dummy : U64;
            begin
               for I in Tokens'Range loop
                  if Tokens (I) = ' ' then
                     Fits := Parse_U64 (Tokens (Start .. I - 1), Dummy)
                       and Fits;
                     Start := I + 1;
                  end if;
               end loop;
               Fits := Parse_U64 (Tokens (Start .. Tokens'Last), Dummy)
                 and Fits;
            end;
         end if;
         if Fits and then not C.Error then
            if Func = "forprimes" then
               if Natural (C.Args.Length) = 1 then
                  Forprimes (A, Scalar'Access);
               else
                  Forprimes (A, B, Scalar'Access);
               end if;
            elsif Func = "forcomposites" then
               if Natural (C.Args.Length) = 1 then
                  Forcomposites (A, Scalar'Access);
               else
                  Forcomposites (A, B, Scalar'Access);
               end if;
            elsif Func = "forfactored" then
               if Natural (C.Args.Length) = 1 then
                  Forfactored (A, Factored'Access);
               else
                  Forfactored (A, B, Factored'Access);
               end if;
            elsif Func = "forpart" then
               Forpart (Natural (A), Tuple'Access, Options);
            elsif Func = "forcomb" then
               if Natural (C.Args.Length) = 1 then
                  Forcomb (Natural (A), Tuple'Access);
               else
                  Forcomb (Natural (A), Natural (B), Tuple'Access);
               end if;
            elsif Func = "forperm" then
               Forperm (Natural (A), Tuple'Access);
            elsif Func = "prime_iterator" then
               declare
                  Cursor : Prime_Cursor := Prime_Iterator (A);
                  Value : Int.Optional_U64;
               begin
                  for I in 1 .. 50 loop
                     Next (Cursor, Value);
                     AUnit.Assertions.Assert (Value.Defined, "cursor ended");
                     if I > 1 then
                        Append (Got, " ");
                     end if;
                     Append (Got, Image (Value.Value));
                  end loop;
               end;
            end if;
            AUnit.Assertions.Assert
              (Got = C.Result, Func & Positive'Image (C.Line_Number)
               & " got " & To_String (Got));
         end if;
      end loop;
   end Replay;

   procedure Check_Fixtures (T : in out Test_Case'Class) is
   begin
      --  Skipped families outside the named task APIs: foroddcomposites,
      --  foralmostprimes, forsemiprimes, forsquarefree, forsquarefreeint,
      --  fordivisors, forcomp, forderange, formultiperm, forsetproduct.
      --  Skipped prime_iterator_object and pio_* rows: Perl identity and
      --  the extended object API are not the native cursor interface.
      Replay ("forprimes");
      Replay ("forcomposites");
      Replay ("forfactored");
      Replay ("forpart");
      Replay ("forcomb");
      Replay ("forperm");
      Replay ("prime_iterator");
   end Check_Fixtures;

   procedure Check_Control (T : in out Test_Case'Class) is
      Rows : constant Case_Vectors.Vector := Load ("iter");
      Got : Unbounded_String;
      Count : Natural;
      Outer_Value : U64;
      Inactive : Loop_Context;
      Raised : Boolean := False;
      Selected : Boolean;
      Callback_Error : exception;
      procedure Push (Value : U64) is
      begin
         if Length (Got) > 0 then
            Append (Got, " ");
         end if;
         Append (Got, Image (Value));
      end Push;
      procedure Inner (Value : U64; Context : in out Loop_Context) is
      begin
         if Value mod Outer_Value = 1 then
            Lastfor (Context);
            Push (Value);
         end if;
      end Inner;
      procedure Outer (Value : U64; Context : in out Loop_Context) is
      begin
         Outer_Value := Value;
         Forprimes (1000, Inner'Access);
      end Outer;
      procedure Outer_Composite
        (Value : U64; Context : in out Loop_Context) is
      begin
         Outer_Value := Value;
         Forcomposites (1000, Inner'Access);
      end Outer_Composite;
      procedure Parts (Values : Value_Array; Context : in out Loop_Context) is
      begin
         if Values'Length < 4 then
            Lastfor (Context);
         else
            Count := Count + 1;
         end if;
      end Parts;
      procedure Combination
        (Values : Value_Array; Context : in out Loop_Context)
      is
         Sum : U64 := 0;
      begin
         for V of Values loop
            Sum := Sum + V;
         end loop;
         if Sum > 11 then
            Lastfor (Context);
         else
            Count := Count + 1;
         end if;
      end Combination;
      procedure Permutation
        (Values : Value_Array; Context : in out Loop_Context) is
      begin
         if Values (4) = 5 then
            Lastfor (Context);
         else
            Count := Count + 1;
         end if;
      end Permutation;
      procedure First (Value : U64; Context : in out Loop_Context) is
      begin
         Push (Value);
         Lastfor (Context);
      end First;
      procedure First_Tuple
        (Values : Value_Array; Context : in out Loop_Context) is
      begin
         Count := Count + 1;
         Lastfor (Context);
      end First_Tuple;
      procedure First_Factored
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context) is
      begin
         Count := Count + 1;
         Lastfor (Context);
      end First_Factored;
      procedure Fail (Value : U64; Context : in out Loop_Context) is
      begin
         raise Callback_Error;
      end Fail;
      procedure Catch_Inner
        (Value : U64; Context : in out Loop_Context) is
      begin
         begin
            Forprimes (10, Fail'Access);
         exception
            when Callback_Error => null;
         end;
         Count := Count + 1;
         Lastfor (Context);
      end Catch_Inner;
   begin
      for C of Rows loop
         Selected := True;
         Got := Null_Unbounded_String;
         Count := 0;
         if C.Func = "lastfor_forprimes_forprimes" then
            Forprimes (100, Outer'Access);
         elsif C.Func = "lastfor_forprimes_forcomposites" then
            Forprimes (100, Outer_Composite'Access);
         elsif C.Func = "lastfor_forpart_len4" then
            Forpart (7, Parts'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forcomb_sum11" then
            Forcomb (7, 4, Combination'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forperm_pos3_is5" then
            Forperm (7, Permutation'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forpart_0" then
            Forpart (0, First_Tuple'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forcomb_0" then
            Forcomb (0, First_Tuple'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forcomb_3_0" then
            Forcomb (3, 0, First_Tuple'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forperm_0" then
            Forperm (0, First_Tuple'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forfactored_0_3" then
            Forfactored (0, 3, First_Factored'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_inner_die_outer_ok" then
            Forprimes (20, Catch_Inner'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_outside_loop" or else
           C.Func = "lastfor_after_callback_die"
         then
            if C.Func = "lastfor_after_callback_die" then
               begin
                  Forprimes (10, Fail'Access);
               exception
                  when Callback_Error => null;
               end;
            end if;
            Raised := False;
            begin
               Lastfor (Inactive);
            exception
               when Constraint_Error => Raised := True;
            end;
            AUnit.Assertions.Assert (Raised, "inactive context accepted");
            Got := To_Unbounded_String ("ERROR");
         else
            --  Other lastfor rows exercise families outside this task.
            Selected := False;
         end if;
         if Selected then
            AUnit.Assertions.Assert
              (Got = C.Result, To_String (C.Func) & " got " & To_String (Got));
         end if;
      end loop;
      --  Boundary intervals never wrap, even when a callback stops early.
      Got := Null_Unbounded_String;
      Forcomposites (U64'Last, U64'Last, First'Access);
      AUnit.Assertions.Assert (Got = Image (U64'Last), "last composite");
      declare
         Cursor : Prime_Cursor := Prime_Iterator (18446744073709551557);
         Value : Int.Optional_U64;
      begin
         Next (Cursor, Value);
         AUnit.Assertions.Assert
           (Value.Defined and then Value.Value = 18446744073709551557,
            "largest prime");
         for I in 1 .. 2 loop
            Next (Cursor, Value);
            AUnit.Assertions.Assert (not Value.Defined, "cursor wrapped");
         end loop;
      end;
   end Check_Control;

   overriding function Name (T : Iter_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Iter"));

   overriding procedure Register_Tests (T : in out Iter_Case) is
   begin
      Registration.Register_Routine (T, Check_Fixtures'Access, "fixtures");
      Registration.Register_Routine (T, Check_Control'Access, "control");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Iter_Case);
      return Result;
   end Suite;
end Compat_Iter;
