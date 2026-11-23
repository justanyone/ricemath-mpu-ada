with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Families;
with Math_Prime_Util.Int;
with Math_Prime_Util.Powers;
with Math_Prime_Util.Count;

package body Compat_Families is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   use Math_Prime_Util.Families;
   use Math_Prime_Util.Powers;
   use type Int.I128;
   type Families_Case is new Test_Case with null record;
   overriding function Name (T : Families_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Families_Case);
   overriding function Name (T : Families_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Families");
   end Name;

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));
   function Image (N : Int.Optional_U64) return String is
     (if N.Defined then Image (N.Value) else "undef");

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("families"), Func);
      N : U64;
      Got : Unbounded_String;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         N := U64'Value (To_String (C.Args (1)));
         Got := Null_Unbounded_String;
         if Func = "lucky_numbers" then
            declare
               V : constant Lucky_Vectors.Vector :=
                 (if Natural (C.Args.Length) = 1 then Lucky_Numbers (N)
                  else Lucky_Numbers
                    (N, U64'Value (To_String (C.Args (2)))));
            begin
               for J in V.First_Index .. V.Last_Index loop
                  if Length (Got) > 0 then
                     Append (Got, " ");
                  end if;
                  Append (Got, Image (V.Element (J)));
               end loop;
               if V.Is_Empty then
                  Got := To_Unbounded_String ("undef");
               end if;
            end;
         elsif Func = "is_lucky" then
            Got := To_Unbounded_String ((if Is_Lucky (N) then "1" else "0"));
         elsif Func = "lucky_count" then
            Got := To_Unbounded_String
              (Image ((if Natural (C.Args.Length) = 1 then Lucky_Count (N)
                       else Lucky_Count
                         (N, U64'Value (To_String (C.Args (2)))))));
         elsif Func = "lucky_count_approx" then
            Got := To_Unbounded_String (Image (Lucky_Count_Approx (N)));
         elsif Func = "lucky_count_lower" then
            Got := To_Unbounded_String (Image (Lucky_Count_Lower (N)));
         elsif Func = "lucky_count_upper" then
            Got := To_Unbounded_String (Image (Lucky_Count_Upper (N)));
         elsif Func = "nth_lucky" then
            Got := To_Unbounded_String (Image (Nth_Lucky (N)));
         elsif Func = "nth_lucky_approx" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Approx (N)));
         elsif Func = "nth_lucky_lower" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Lower (N)));
         elsif Func = "nth_lucky_upper" then
            Got := To_Unbounded_String (Image (Nth_Lucky_Upper (N)));
         end if;
         AUnit.Assertions.Assert
           (Got = C.Result, Func & " line" & C.Line_Number'Image &
            " expected " & To_String (C.Result) & " got " & To_String (Got));
      end loop;
   end Replay;

   --  Native_Tier: rows outside U64 (arguments or results) await bigint.
   --  Count_Limit: exact prime counts use the existing Count precondition.
   --  Each skipped native overflow is asserted undefined below.
   procedure Replay_Powers (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("families"), Func);
      N, H, Expected : U64;
      Signed : Int.I128;
      Got : Unbounded_String;
      O : Int.Optional_U64;
      Skip : Boolean;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         Signed := Int.I128'Value (To_String (C.Args (1)));
         Skip := Signed not in
           -Int.I128 (U64'Last) .. Int.I128 (U64'Last);
         N := (if Signed < 0 or Skip then 0 else U64 (Signed));
         H := (if C.Args.Last_Index = 2 then
                 U64'Value (To_String (C.Args (2))) else N);
         if Func = "prime_power_count" and then
           H > Math_Prime_Util.Count.Prime_Count_Limit
         then
            Skip := True;
         end if;
         --  Bigint_Index: MPU dispatches larger perfect-power indices to PP.
         if Ada.Strings.Fixed.Index (Func, "nth_perfect_power") = 1 and then
           N > 4_297_615_581
         then
            Skip := True;
         end if;
         --  Signed_Overflow: the next odd-power magnitude must fit U64.
         if Func = "prev_perfect_power" and then
           Signed < -18_446_724_184_312_856_124
         then
            Skip := True;
         end if;
         Got := Null_Unbounded_String;
         O := (Defined => False);
         if not Skip then
            if Func = "prime_powers" then
               declare
                  V : constant Lucky_Vectors.Vector :=
                    (if C.Args.Last_Index = 1 then Prime_Powers (N)
                     else Prime_Powers (N, H));
               begin
                  for J in V.First_Index .. V.Last_Index loop
                     if Length (Got) > 0 then
                        Append (Got, " ");
                     end if;
                     Append (Got, Image (V.Element (J)));
                  end loop;
                  if V.Is_Empty then
                     Got := To_Unbounded_String ("undef");
                  end if;
               end;
            elsif Func = "is_prime_power_root" then
               declare
                  P : constant Prime_Power_Result := Prime_Power (N);
               begin
                  Got := To_Unbounded_String
                    (Image (P.Exponent) & " " & Image (P.Prime));
               end;
            elsif Func = "is_prime_power" then
               Got := To_Unbounded_String (Image (Is_Prime_Power (N)));
            elsif Func = "is_perfect_power" then
               Got := To_Unbounded_String
                 ((if Is_Perfect_Power (Signed) then "1" else "0"));
            elsif (Func = "next_perfect_power" and Signed < 0) or else
              (Func = "prev_perfect_power" and Signed <= 0)
            then
               Got := To_Unbounded_String (Ada.Strings.Fixed.Trim
                 (Int.I128'Image
                   ((if Func = "next_perfect_power" then
                       Next_Perfect_Power (Signed)
                     else Prev_Perfect_Power (Signed))), Ada.Strings.Both));
            elsif Func = "next_prime_power" then
               O := Next_Prime_Power (N);
            elsif Func = "prev_prime_power" then
               O := Prev_Prime_Power (N);
            elsif Func = "prime_power_count" then
               Got := To_Unbounded_String (Image ((if C.Args.Last_Index = 1 then Prime_Power_Count (N)
                  else Prime_Power_Count (N, H))));
            elsif Func = "prime_power_count_approx" then
               Got := To_Unbounded_String (Image (Prime_Power_Count_Approx (N)));
            elsif Func = "prime_power_count_lower" then
               Got := To_Unbounded_String (Image (Prime_Power_Count_Lower (N)));
            elsif Func = "prime_power_count_upper" then
               Got := To_Unbounded_String (Image (Prime_Power_Count_Upper (N)));
            elsif Func = "nth_prime_power" then
               O := Nth_Prime_Power (N);
            elsif Func = "nth_prime_power_approx" then
               O := Nth_Prime_Power_Approx (N);
            elsif Func = "nth_prime_power_lower" then
               O := Nth_Prime_Power_Lower (N);
            elsif Func = "nth_prime_power_upper" then
               O := Nth_Prime_Power_Upper (N);
            elsif Func = "next_perfect_power" then
               O := Next_Perfect_Power (N);
            elsif Func = "prev_perfect_power" then
               O := Prev_Perfect_Power (N);
            elsif Func = "perfect_power_count" then
               Got := To_Unbounded_String (Image ((if C.Args.Last_Index = 1 then Perfect_Power_Count (N)
                  else Perfect_Power_Count (N, H))));
            elsif Func = "perfect_power_count_approx" then
               Got := To_Unbounded_String (Image (Perfect_Power_Count_Approx (N)));
            elsif Func = "perfect_power_count_lower" then
               Got := To_Unbounded_String (Image (Perfect_Power_Count_Lower (N)));
            elsif Func = "perfect_power_count_upper" then
               Got := To_Unbounded_String (Image (Perfect_Power_Count_Upper (N)));
            elsif Func = "nth_perfect_power" then
               O := Nth_Perfect_Power (N);
            elsif Func = "nth_perfect_power_approx" then
               O := Nth_Perfect_Power_Approx (N);
            elsif Func = "nth_perfect_power_lower" then
               O := Nth_Perfect_Power_Lower (N);
            elsif Func = "nth_perfect_power_upper" then
               O := Nth_Perfect_Power_Upper (N);
            end if;
            if Length (Got) = 0 then
               Got := To_Unbounded_String (Image (O));
               if not C.Undef and then
                 not Parse_U64 (To_String (C.Result), Expected)
               then
                  AUnit.Assertions.Assert
                    (not O.Defined, Func & " native overflow");
                  Skip := True;
               end if;
            end if;
            --  MPU_Li_Rounding: maximum-U64 bound rows use a less accurate
            --  logarithmic integral. See docs/upstream-findings.md.
            if N = U64'Last and then
              (Func = "prime_power_count_lower" or else
               Func = "prime_power_count_upper")
            then
               AUnit.Assertions.Assert
                 (To_String (Got) =
                    (if Func = "prime_power_count_lower" then
                       "425656284125562281" else "425656284319202055"),
                  "corrected Li power bound");
               Skip := True;
            end if;
            if not Skip then
               AUnit.Assertions.Assert
                 (Got = C.Result, Func & " line" & C.Line_Number'Image &
                  " expected " & To_String (C.Result) &
                  " got " & To_String (Got));
            end if;
         end if;
      end loop;
   end Replay_Powers;

   procedure Test_Prime_Powers (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prime_powers");
   end Test_Prime_Powers;

   procedure Test_Is_Prime_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("is_prime_power");
   end Test_Is_Prime_Power;

   procedure Test_Next_Prime_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("next_prime_power");
   end Test_Next_Prime_Power;

   procedure Test_Prev_Prime_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prev_prime_power");
   end Test_Prev_Prime_Power;

   procedure Test_Is_Prime_Power_Root (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("is_prime_power_root");
   end Test_Is_Prime_Power_Root;

   procedure Test_Prime_Power_Count (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prime_power_count");
   end Test_Prime_Power_Count;

   procedure Test_Prime_Power_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prime_power_count_approx");
   end Test_Prime_Power_Count_Approx;

   procedure Test_Prime_Power_Count_Lower (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prime_power_count_lower");
   end Test_Prime_Power_Count_Lower;

   procedure Test_Prime_Power_Count_Upper (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prime_power_count_upper");
   end Test_Prime_Power_Count_Upper;

   procedure Test_Nth_Prime_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_prime_power");
   end Test_Nth_Prime_Power;

   procedure Test_Nth_Prime_Power_Approx (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_prime_power_approx");
   end Test_Nth_Prime_Power_Approx;

   procedure Test_Nth_Prime_Power_Lower (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_prime_power_lower");
   end Test_Nth_Prime_Power_Lower;

   procedure Test_Nth_Prime_Power_Upper (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_prime_power_upper");
   end Test_Nth_Prime_Power_Upper;

   procedure Test_Is_Perfect_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("is_perfect_power");
   end Test_Is_Perfect_Power;

   procedure Test_Next_Perfect_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("next_perfect_power");
   end Test_Next_Perfect_Power;

   procedure Test_Prev_Perfect_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("prev_perfect_power");
   end Test_Prev_Perfect_Power;

   procedure Test_Perfect_Power_Count (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("perfect_power_count");
   end Test_Perfect_Power_Count;

   procedure Test_Perfect_Power_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("perfect_power_count_approx");
   end Test_Perfect_Power_Count_Approx;

   procedure Test_Perfect_Power_Count_Lower (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("perfect_power_count_lower");
   end Test_Perfect_Power_Count_Lower;

   procedure Test_Perfect_Power_Count_Upper (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("perfect_power_count_upper");
   end Test_Perfect_Power_Count_Upper;

   procedure Test_Nth_Perfect_Power (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_perfect_power");
   end Test_Nth_Perfect_Power;

   procedure Test_Nth_Perfect_Power_Approx (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_perfect_power_approx");
   end Test_Nth_Perfect_Power_Approx;

   procedure Test_Nth_Perfect_Power_Lower (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_perfect_power_lower");
   end Test_Nth_Perfect_Power_Lower;

   procedure Test_Nth_Perfect_Power_Upper (T : in out Test_Case'Class) is
   begin
      Replay_Powers ("nth_perfect_power_upper");
   end Test_Nth_Perfect_Power_Upper;

   procedure Test_Lucky_Numbers (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_numbers");
   end Test_Lucky_Numbers;

   procedure Test_Is_Lucky (T : in out Test_Case'Class) is
   begin
      Replay ("is_lucky");
   end Test_Is_Lucky;

   procedure Test_Lucky_Count (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count");
   end Test_Lucky_Count;

   procedure Test_Lucky_Count_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_approx");
   end Test_Lucky_Count_Approx;

   procedure Test_Lucky_Count_Lower (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_lower");
   end Test_Lucky_Count_Lower;

   procedure Test_Lucky_Count_Upper (T : in out Test_Case'Class) is
   begin
      Replay ("lucky_count_upper");
   end Test_Lucky_Count_Upper;

   procedure Test_Nth_Lucky (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky");
   end Test_Nth_Lucky;

   procedure Test_Nth_Lucky_Approx (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_approx");
   end Test_Nth_Lucky_Approx;

   procedure Test_Nth_Lucky_Lower (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_lower");
   end Test_Nth_Lucky_Lower;

   procedure Test_Nth_Lucky_Upper (T : in out Test_Case'Class) is
   begin
      Replay ("nth_lucky_upper");
   end Test_Nth_Lucky_Upper;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Lucky_Numbers'Access, "lucky_numbers");
      Registration.Register_Routine
        (T, Test_Is_Lucky'Access, "is_lucky");
      Registration.Register_Routine
        (T, Test_Lucky_Count'Access, "lucky_count");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Approx'Access, "lucky_count_approx");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Lower'Access, "lucky_count_lower");
      Registration.Register_Routine
        (T, Test_Lucky_Count_Upper'Access, "lucky_count_upper");
      Registration.Register_Routine
        (T, Test_Nth_Lucky'Access, "nth_lucky");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Approx'Access, "nth_lucky_approx");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Lower'Access, "nth_lucky_lower");
      Registration.Register_Routine
        (T, Test_Nth_Lucky_Upper'Access, "nth_lucky_upper");
      Registration.Register_Routine
        (T, Test_Prime_Powers'Access, "prime_powers");
      Registration.Register_Routine
        (T, Test_Is_Prime_Power'Access, "is_prime_power");
      Registration.Register_Routine
        (T, Test_Next_Prime_Power'Access, "next_prime_power");
      Registration.Register_Routine
        (T, Test_Prev_Prime_Power'Access, "prev_prime_power");
      Registration.Register_Routine
        (T, Test_Is_Prime_Power_Root'Access, "is_prime_power_root");
      Registration.Register_Routine
        (T, Test_Prime_Power_Count'Access, "prime_power_count");
      Registration.Register_Routine
        (T, Test_Prime_Power_Count_Approx'Access, "prime_power_count_approx");
      Registration.Register_Routine
        (T, Test_Prime_Power_Count_Lower'Access, "prime_power_count_lower");
      Registration.Register_Routine
        (T, Test_Prime_Power_Count_Upper'Access, "prime_power_count_upper");
      Registration.Register_Routine
        (T, Test_Nth_Prime_Power'Access, "nth_prime_power");
      Registration.Register_Routine
        (T, Test_Nth_Prime_Power_Approx'Access, "nth_prime_power_approx");
      Registration.Register_Routine
        (T, Test_Nth_Prime_Power_Lower'Access, "nth_prime_power_lower");
      Registration.Register_Routine
        (T, Test_Nth_Prime_Power_Upper'Access, "nth_prime_power_upper");
      Registration.Register_Routine
        (T, Test_Is_Perfect_Power'Access, "is_perfect_power");
      Registration.Register_Routine
        (T, Test_Next_Perfect_Power'Access, "next_perfect_power");
      Registration.Register_Routine
        (T, Test_Prev_Perfect_Power'Access, "prev_perfect_power");
      Registration.Register_Routine
        (T, Test_Perfect_Power_Count'Access, "perfect_power_count");
      Registration.Register_Routine
        (T, Test_Perfect_Power_Count_Approx'Access, "perfect_power_count_approx");
      Registration.Register_Routine
        (T, Test_Perfect_Power_Count_Lower'Access, "perfect_power_count_lower");
      Registration.Register_Routine
        (T, Test_Perfect_Power_Count_Upper'Access, "perfect_power_count_upper");
      Registration.Register_Routine
        (T, Test_Nth_Perfect_Power'Access, "nth_perfect_power");
      Registration.Register_Routine
        (T, Test_Nth_Perfect_Power_Approx'Access, "nth_perfect_power_approx");
      Registration.Register_Routine
        (T, Test_Nth_Perfect_Power_Lower'Access, "nth_perfect_power_lower");
      Registration.Register_Routine
        (T, Test_Nth_Perfect_Power_Upper'Access, "nth_perfect_power_upper");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Families_Case);
      return Result;
   end Suite;
end Compat_Families;
