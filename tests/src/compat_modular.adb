with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Modular;
with Math_Prime_Util.Int;
with Math_Prime_Util.Errors;

package body Compat_Modular is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use Math_Prime_Util.Modular;
   use type U64;
   use type I128;
   type Modular_Case is new Test_Case with null record;
   overriding function Name (T : Modular_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Modular_Case);

   function Image (V : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (V), Ada.Strings.Both));
   function Image (V : Int.Optional_U64) return String is
     (if V.Defined then Image (V.Value) else "undef");
   function Image (V : Root_List) return String is
      S : Unbounded_String;
   begin
      for R of V loop
         if Length (S) > 0 then
            Append (S, " ");
         end if;
         Append (S, Image (R));
      end loop;
      return (if V'Length = 0 then "undef" else To_String (S));
   end Image;

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("modular"), Func);
      N, D : U64;
      A, K : I128;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         --  Native_Tier_Only: the two sqrt and then one root fixture arguments
         --  exceeding U64 belong to the future bigint tier, not this API.
         if Parse_U64 (To_String (C.Args (Positive (C.Args.Length))), N) then
            A := I128'Value (To_String (C.Args (1)));
            K := (if Func = "rootmod" or else Func = "allrootmod" then
                    I128'Value (To_String (C.Args (2))) else 2);
            declare
               Actual : Unbounded_String;
            begin
               if Func = "sqrtmod" then
                  Actual := To_Unbounded_String (Image (Sqrtmod (A, N)));
               elsif Func = "allsqrtmod" then
                  Actual := To_Unbounded_String (Image (Allsqrtmod (A, N)));
               elsif Func = "rootmod" then
                  Actual := To_Unbounded_String (Image (Rootmod (A, K, N)));
               elsif Func = "allrootmod" then
                  Actual := To_Unbounded_String (Image (Allrootmod (A, K, N)));
               else
                  D := U64 (A);
                  declare
                     R : constant Cornacchia_Result := Cornacchia (D, N);
                  begin
                     Actual := To_Unbounded_String
                       ((if R.Defined then Image (R.X) & " " & Image (R.Y)
                         else "undef"));
                  end;
               end if;
               AUnit.Assertions.Assert
                 (Actual = C.Result, Func & " row" &
                    Positive'Image (C.Line_Number) & " expected " &
                    To_String (C.Result) & " got " & To_String (Actual));
            end;
         end if;
      end loop;
   end Replay;

   procedure Test_Sqrt (T : in out Test_Case'Class) is
   begin
      Replay ("sqrtmod");
   end Test_Sqrt;
   procedure Test_Allsqrt (T : in out Test_Case'Class) is
   begin
      Replay ("allsqrtmod");
   end Test_Allsqrt;
   procedure Test_Root (T : in out Test_Case'Class) is
   begin
      Replay ("rootmod");
   end Test_Root;
   procedure Test_Allroot (T : in out Test_Case'Class) is
   begin
      Replay ("allrootmod");
   end Test_Allroot;
   procedure Test_Cornacchia (T : in out Test_Case'Class) is
   begin
      Replay ("cornacchia");
   end Test_Cornacchia;

   procedure Check_Laws (T : in out Test_Case'Class) is
      Found : Boolean;
      Single : Int.Optional_U64;
   begin
      --  Exhaustive oracle independent of factorization and then lifting.
      for N in U64 range 1 .. 32 loop
         for K in I128 range 0 .. 6 loop
            for A in U64 range 0 .. N - 1 loop
               declare
                  Roots : constant Root_List := Allrootmod (I128 (A), K, N);
               begin
                  for X in U64 range 0 .. N - 1 loop
                     Found := False;
                     for R of Roots loop
                        Found := Found or else R = X;
                     end loop;
                     AUnit.Assertions.Assert
                       (Found = (Int.Powmod (X, U64 (K), N).Value = A),
                        "complete roots N=" & Image (N) & " A=" & Image (A));
                  end loop;
                  for I in Roots'First + 1 .. Roots'Last loop
                     AUnit.Assertions.Assert
                       (Roots (I - 1) < Roots (I), "sorted unique roots");
                  end loop;
                  Single := Rootmod (I128 (A), K, N);
                  AUnit.Assertions.Assert
                    (Single.Defined = (Roots'Length > 0), "single existence");
                  if Single.Defined then
                     AUnit.Assertions.Assert
                       (Int.Powmod (Single.Value, U64 (K), N).Value = A,
                        "single root equation");
                  end if;
               end;
            end loop;
         end loop;
      end loop;
      for N of Root_List'(2 ** 32 - 1, 2 ** 32 + 1, 2 ** 63 - 1,
                          2 ** 63 + 1, U64'Last) loop
         Single := Sqrtmod (1, N);
         AUnit.Assertions.Assert (Single.Defined and then Single.Value = 1,
                                  "native boundary square root");
      end loop;
      AUnit.Assertions.Assert
        (Allrootmod (2, -1, 4)'Length = 0, "noninvertible negative exponent");
      begin
         declare
            Roots : constant Root_List := Allrootmod (1, 0, U64'Last);
         begin
            AUnit.Assertions.Assert (Roots'Length = 0, "root cap missing");
         end;
      exception
         when Errors.Maximum_Roots_Exceeded => null;
      end;
   end Check_Laws;

   overriding function Name (T : Modular_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Modular");
   end Name;
   overriding procedure Register_Tests (T : in out Modular_Case) is
   begin
      Registration.Register_Routine (T, Test_Sqrt'Access, "sqrtmod");
      Registration.Register_Routine (T, Test_Allsqrt'Access, "allsqrtmod");
      Registration.Register_Routine (T, Test_Root'Access, "rootmod");
      Registration.Register_Routine (T, Test_Allroot'Access, "allrootmod");
      Registration.Register_Routine (T, Test_Cornacchia'Access, "cornacchia");
      Registration.Register_Routine (T, Check_Laws'Access, "exhaustive laws");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Modular_Case);
      return Result;
   end Suite;
end Compat_Modular;
