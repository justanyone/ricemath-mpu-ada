with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Int;
with Math_Prime_Util.Iter;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

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
               Append (Token, (if Func = "forpart" or else Func = "forcomp"
                            then "+" else ","));
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
         if Func = "forpart" or else Func = "forcomp" then
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
         elsif Func /= "formultiperm" and then Func /= "forsetproduct"
           and then Natural (C.Args.Length) > 1 then
            Fits := Parse_U64 (To_String (C.Args (2)), B) and then Fits;
         end if;
         --  Skipped ERROR rows: undef, negative, fractional and text inputs
         --  cannot reach these typed Ada APIs. Bigint inputs require the
         --  bigint tier. Prime streams crossing U64 are skipped as a whole.
         if (Func = "prime_iterator" or else
             Func = "prime_iterator_object_iterate")
           and then not C.Error then
            declare
               Tokens : constant String := To_String (C.Result);
               Start : Positive := Tokens'First;
               Dummy : U64;
            begin
               for I in Tokens'Range loop
                  if Tokens (I) = ' ' then
                     Fits := Parse_U64 (Tokens (Start .. I - 1), Dummy)
                       and then Fits;
                     Start := I + 1;
                  end if;
               end loop;
               Fits := Parse_U64 (Tokens (Start .. Tokens'Last), Dummy)
                 and then Fits;
            end;
         end if;
         if Func = "formultiperm" or else Func = "forsetproduct" then
            Fits := True;
            for Arg of C.Args loop
               if Arg /= "|" then
                  Fits := Parse_U64 (To_String (Arg), B) and then Fits;
               end if;
            end loop;
         end if;
         --  iter.tsv 468,471: text multisets; 484,488: text products.
         --  iter.tsv 475,490: Perl array-reference errors are unrepresentable.
         --  iter.tsv 372,374,376,378: invalid typed composition options.
         --  iter.tsv 537,540,543: object streams exceed U64.
         --  iter.tsv 546,549,552: invalid typed object starts.
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
            elsif Func = "forcomp" then
               Forcomp (Natural (A), Tuple'Access, Options);
            elsif Func = "forderange" then
               Forderange (Natural (A), Tuple'Access);
            elsif Func = "formultiperm" or else Func = "forsetproduct" then
               declare
                  Items : Value_Array (1 .. Natural (C.Args.Length));
                  Length : Natural := 0;
                  Lists : Value_List_Vectors.Vector;
               begin
                  for Arg of C.Args loop
                     if Arg = "|" then
                        Lists.Append (Items (1 .. Length));
                        Length := 0;
                     else
                        Length := Length + 1;
                        Items (Length) := U64'Value (To_String (Arg));
                     end if;
                  end loop;
                  if Func = "formultiperm" then
                     Formultiperm (Items (1 .. Length), Tuple'Access);
                  else
                     if not C.Args.Is_Empty then
                        Lists.Append (Items (1 .. Length));
                     end if;
                     Forsetproduct (Lists, Tuple'Access);
                  end if;
               end;
            elsif Func = "prime_iterator_object_iterate" then
               declare
                  Cursor : Prime_Object := Prime_Iterator_Object (A);
                  P : Int.Optional_U64;
               begin
                  for I in 1 .. 50 loop
                     Iterate (Cursor, P);
                     AUnit.Assertions.Assert (P.Defined, "object ended");
                     if I > 1 then
                        Append (Got, " ");
                     end if;
                     Append (Got, Image (P.Value));
                  end loop;
               end;
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
      --  iter.tsv 494,497,500,503,506,509,512,515,518,521,524,527,
      --  530,533,536,539,542: Perl object address strings have no Ada value.
      --  Their numeric companions are replayed below. 545,548,551 are
      --  invalid typed starts. Other families are outside this task.
      Replay ("forprimes");
      Replay ("forcomposites");
      Replay ("forfactored");
      Replay ("forpart");
      Replay ("forcomb");
      Replay ("forperm");
      Replay ("prime_iterator");
   end Check_Fixtures;

   procedure Check_Forcomp (T : in out Test_Case'Class) is
   begin
      Replay ("forcomp");
   end Check_Forcomp;

   procedure Check_Forderange (T : in out Test_Case'Class) is
   begin
      Replay ("forderange");
   end Check_Forderange;

   procedure Check_Formultiperm (T : in out Test_Case'Class) is
   begin
      Replay ("formultiperm");
   end Check_Formultiperm;

   procedure Check_Forsetproduct (T : in out Test_Case'Class) is
   begin
      Replay ("forsetproduct");
   end Check_Forsetproduct;

   procedure Check_Object (T : in out Test_Case'Class) is
      Cursor : Prime_Object := Prime_Iterator_Object;
      P : Int.Optional_U64;
      procedure Expect (N : U64);

      procedure Expect (N : U64) is
      begin
         P := Value (Cursor);
         AUnit.Assertions.Assert
           (P.Defined and then P.Value = N, "object value " & Image (N));
      end Expect;
   begin
      --  iter.tsv 554..560: next, prev, peek, iterate and rewind sequence.
      for I in 1 .. 10 loop
         Next (Cursor);
      end loop;
      Expect (31);
      Prev (Cursor);
      Expect (29);
      P := Peek (Cursor);
      AUnit.Assertions.Assert (P.Defined and then P.Value = 31, "peek");
      Expect (29);
      Iterate (Cursor, P);
      AUnit.Assertions.Assert (P.Defined and then P.Value = 29, "iterate");
      Iterate (Cursor, P);
      AUnit.Assertions.Assert (P.Defined and then P.Value = 31, "iterate 2");
      Rewind (Cursor);
      for I in 1 .. 3 loop
         Next (Cursor);
      end loop;
      Prev (Cursor);
      Expect (5);
      for N in 0 .. 2 loop
         Rewind (Cursor, U64 (N));
         Prev (Cursor);
         Expect (2);
      end loop;
      --  561,562 require bigint successors: assert native exhaustion.
      --  563..591 cover NumSeq methods beyond the six requested operations.
      Rewind (Cursor, 18446744073709551557);
      Expect (18446744073709551557);
      Next (Cursor);
      P := Value (Cursor);
      AUnit.Assertions.Assert (not P.Defined, "object wrapped");
      Next (Cursor);
      P := Peek (Cursor);
      AUnit.Assertions.Assert (not P.Defined, "exhausted peek");
      Prev (Cursor);
      Expect (18446744073709551557);
      Rewind (Cursor, U64'Last);
      P := Value (Cursor);
      AUnit.Assertions.Assert (not P.Defined, "rewind beyond prime");
      Replay ("prime_iterator_object_iterate");
   end Check_Object;

   procedure Check_Print (T : in out Test_Case'Class) is
      File : Ada.Text_IO.File_Type;
      Path : constant String := "obj/iter-primes.txt";
      procedure Check (Low, High : U64);

      procedure Check (Low, High : U64) is
         Expected : constant Sieve.Prime_Vectors.Vector :=
           Sieve.Primes (Low, High);
      begin
         Ada.Text_IO.Create (File, Ada.Text_IO.Out_File, Path);
         Print_Primes (Low, High, File);
         Ada.Text_IO.Close (File);
         Ada.Text_IO.Open (File, Ada.Text_IO.In_File, Path);
         for P of Expected loop
            AUnit.Assertions.Assert
              (not Ada.Text_IO.End_Of_File (File), "missing printed prime");
            AUnit.Assertions.Assert
              (Ada.Text_IO.Get_Line (File) = Image (P), "printed prime");
         end loop;
         AUnit.Assertions.Assert
           (Ada.Text_IO.End_Of_File (File), "extra printed prime");
         Ada.Text_IO.Close (File);
      end Check;
   begin
      Check (0, 30);
      Check (31, 31);
      Check (90, 120);
      Check (20, 10);
      Check (0, 1);
   end Check_Print;

   procedure Check_New_Control (T : in out Test_Case'Class) is
      Calls : Natural := 0;
      Lists : Value_List_Vectors.Vector;
      Callback_Error : exception;
      Raised : Boolean;
      Got : Unbounded_String;
      procedure Stop
        (Values : Value_Array; Context : in out Loop_Context);
      procedure Fail
        (Values : Value_Array; Context : in out Loop_Context);
      procedure Collect
        (Values : Value_Array; Context : in out Loop_Context);

      procedure Stop
        (Values : Value_Array; Context : in out Loop_Context) is
      begin
         Calls := Calls + 1;
         Lastfor (Context);
      end Stop;

      procedure Fail
        (Values : Value_Array; Context : in out Loop_Context) is
      begin
         raise Callback_Error;
      end Fail;

      procedure Collect
        (Values : Value_Array; Context : in out Loop_Context) is
      begin
         for V of Values loop
            Append (Got, Image (V) & " ");
         end loop;
      end Collect;
   begin
      --  Each new loop stops after its first callback.
      Forcomp (12, Stop'Access);
      Forderange (8, Stop'Access);
      Formultiperm ([1, 1, 2, 2], Stop'Access);
      Lists.Append (Value_Array'(3 .. 4 => U64'Last));
      Lists.Append (Value_Array'[0, 1]);
      Forsetproduct (Lists, Stop'Access);
      AUnit.Assertions.Assert (Calls = 4, "new loop lastfor");
      --  Exceptions propagate and leave later loops independently usable.
      for Kind in 1 .. 4 loop
         Raised := False;
         begin
            case Kind is
               when 1 => Forcomp (4, Fail'Access);
               when 2 => Forderange (4, Fail'Access);
               when 3 => Formultiperm ([1, 2], Fail'Access);
               when 4 => Forsetproduct (Lists, Fail'Access);
            end case;
         exception
            when Callback_Error => Raised := True;
         end;
         AUnit.Assertions.Assert (Raised, "callback exception swallowed");
      end loop;
      Calls := 0;
      Forsetproduct (Lists, Stop'Access);
      AUnit.Assertions.Assert (Calls = 1, "loop after callback exception");
      --  Numeric Perl hash keys sort by decimal spelling, not magnitude.
      Formultiperm ([2, 10], Collect'Access);
      AUnit.Assertions.Assert (Got = "10 2 2 10 ", "multiset key order");
      Got := Null_Unbounded_String;
      Formultiperm (Value_Array'(4 .. 5 => U64'Last), Collect'Access);
      AUnit.Assertions.Assert
        (Got = Image (U64'Last) & " " & Image (U64'Last) & " ",
         "nonstandard multiset bounds");
      Print_Primes (1, 0);
   end Check_New_Control;

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
      procedure First_Over_100
        (Value : U64; Context : in out Loop_Context) is
      begin
         if Value > 100 then
            Push (Value);
            Lastfor (Context);
         end if;
      end First_Over_100;
      procedure Composite_Over_2000
        (Value : U64; Context : in out Loop_Context) is
      begin
         Got := To_Unbounded_String (Image (Value));
         if Value > 2000 then
            Lastfor (Context);
         end if;
      end Composite_Over_2000;
      procedure Composite_Value
        (Value : U64; Context : in out Loop_Context) is
      begin
         Push (Value);
      end Composite_Value;
      procedure Stop_Outer
        (Value : U64; Context : in out Loop_Context) is
      begin
         if Value >= 7 then
            Lastfor (Context);
         end if;
         Push (Value);
         Forcomposites (Value, Composite_Value'Access);
      end Stop_Outer;
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
         elsif C.Func = "lastfor_nested_ge7" then
            Forprimes (20, Stop_Outer'Access);
         elsif C.Func = "lastfor_forprimes_first_gt_100" then
            Forprimes (1000, First_Over_100'Access);
         elsif C.Func = "lastfor_forcomposites_gt2000" then
            Forcomposites (20000, Composite_Over_2000'Access);
         elsif C.Func = "lastfor_forpart_len4" then
            Forpart (7, Parts'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forcomp_len4" then
            Forcomp (7, Parts'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forderange_pos3_is5" then
            Forderange (7, Permutation'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forcomp_0" then
            Forcomp (0, First_Tuple'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_forderange_0" then
            Forderange (0, First_Tuple'Access);
            Got := To_Unbounded_String (Image (U64 (Count)));
         elsif C.Func = "lastfor_formultiperm_empty" then
            Formultiperm ((1 .. 0 => 0), First_Tuple'Access);
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

   procedure Check_Properties (T : in out Test_Case'Class) is
      use type U128;
      use type Primality.Prime_Result;
      Seed : U64 := 16#4954_4552#;
      Expected_N : U64;
      Expected_Length : Natural;
      Count : Natural;
      procedure Factors_Check
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context)
      is
         Product : U128 := 1;
      begin
         for I in Factors'Range loop
            AUnit.Assertions.Assert
              (Primality.Is_Prime (Factors (I)) /= 0,
               "prime factor, seed 0x49544552");
            Product := Product * U128 (Factors (I));
            AUnit.Assertions.Assert
              (I = Factors'First or else Factors (I - 1) <= Factors (I),
               "sorted factors, seed 0x49544552");
         end loop;
         AUnit.Assertions.Assert
           (Product = U128 (Value), "factor product, seed 0x49544552");
         Count := Count + 1;
      end Factors_Check;
      procedure Partition_Check
        (Values : Value_Array; Context : in out Loop_Context)
      is
         Sum : U64 := 0;
      begin
         for I in Values'Range loop
            Sum := Sum + Values (I);
            AUnit.Assertions.Assert
              (Values (I) > 0 and then
               (I = Values'First or else Values (I - 1) <= Values (I)),
               "ordered partition, seed 0x49544552");
         end loop;
         AUnit.Assertions.Assert (Sum = Expected_N, "partition sum");
         Count := Count + 1;
      end Partition_Check;
      procedure Combination_Check
        (Values : Value_Array; Context : in out Loop_Context) is
      begin
         AUnit.Assertions.Assert
           (Values'Length = Expected_Length, "combination length");
         for I in Values'Range loop
            AUnit.Assertions.Assert
              (Values (I) < Expected_N and then
               (I = Values'First or else Values (I - 1) < Values (I)),
               "combination order, seed 0x49544552");
         end loop;
         Count := Count + 1;
      end Combination_Check;
      procedure No_Value (Value : U64; Context : in out Loop_Context) is
      begin
         Count := Count + 1;
      end No_Value;
   begin
      for I in 1 .. 32 loop
         Seed := Seed * 6364136223846793005 + 1;
         Expected_N := Seed mod 100000 + 1;
         Count := 0;
         Forfactored (Expected_N, Expected_N, Factors_Check'Access);
         AUnit.Assertions.Assert (Count = 1, "single factored value");
      end loop;
      for N in 0 .. 12 loop
         Expected_N := U64 (N);
         Count := 0;
         Forpart (N, Partition_Check'Access);
         AUnit.Assertions.Assert (Count > 0, "missing partitions");
         for K in 0 .. N loop
            Expected_Length := K;
            Count := 0;
            Forcomb (N, K, Combination_Check'Access);
            AUnit.Assertions.Assert (Count > 0, "missing combinations");
         end loop;
      end loop;
      Count := 0;
      Forprimes (0, No_Value'Access);
      Forprimes (U64'Last, 0, No_Value'Access);
      Forcomposites (3, No_Value'Access);
      Forcomposites (U64'Last, 0, No_Value'Access);
      Forfactored (0, Factors_Check'Access);
      Forfactored (2, 1, Factors_Check'Access);
      AUnit.Assertions.Assert (Count = 0, "empty ranges visited");
   end Check_Properties;

   overriding function Name (T : Iter_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Iter"));

   overriding procedure Register_Tests (T : in out Iter_Case) is
   begin
      Registration.Register_Routine (T, Check_Fixtures'Access, "fixtures");
      Registration.Register_Routine (T, Check_Forcomp'Access, "forcomp");
      Registration.Register_Routine
        (T, Check_Forderange'Access, "forderange");
      Registration.Register_Routine
        (T, Check_Formultiperm'Access, "formultiperm");
      Registration.Register_Routine
        (T, Check_Forsetproduct'Access, "forsetproduct");
      Registration.Register_Routine (T, Check_Object'Access, "object");
      Registration.Register_Routine (T, Check_Print'Access, "print_primes");
      Registration.Register_Routine
        (T, Check_New_Control'Access, "new_control");
      Registration.Register_Routine (T, Check_Control'Access, "control");
      Registration.Register_Routine
        (T, Check_Properties'Access, "properties");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Iter_Case);
      return Result;
   end Suite;
end Compat_Iter;
