with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Arith;

package body Compat_Arith is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use type U64;
   type Arith_Case is new Test_Case with null record;
   overriding function Name (T : Arith_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Arith_Case);

   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (N), Ada.Strings.Both));

   procedure Replay (Func : String) is
      Rows : constant Case_Vectors.Vector :=
        For_Function (Load ("arith"), Func);
   begin
      AUnit.Assertions.Assert (not Rows.Is_Empty, "missing " & Func);
      for C of Rows loop
         declare
            K, Low, High : U64 := 0;
            Actual : Unbounded_String;
         begin
            AUnit.Assertions.Assert
              (Parse_U64 (To_String (C.Args (1)), K), "parse k");
            if C.Args.Length = 2 then
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (2)), High), "parse high");
               Low := (if K = 1 then 0 else 1);
            else
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (2)), Low), "parse low");
               AUnit.Assertions.Assert
                 (Parse_U64 (To_String (C.Args (3)), High), "parse high");
            end if;
            if Func = "inverse_sigma0_count" then
               Actual := To_Unbounded_String
                 (Image
                    ((if C.Args.Length = 2 then
                        Math_Prime_Util.Arith.Inverse_Sigma0_Count (K, High)
                      else
                        Math_Prime_Util.Arith.Inverse_Sigma0_Count
                          (K, Low, High))));
            else
               declare
                  Values : constant Math_Prime_Util.Arith.U64_Vectors.Vector :=
                    (if C.Args.Length = 2 then
                       Math_Prime_Util.Arith.Inverse_Sigma0 (K, High)
                     else
                       Math_Prime_Util.Arith.Inverse_Sigma0
                         (K, Low, High));
               begin
                  if Values.Is_Empty then
                     Actual := To_Unbounded_String ("undef");
                  else
                     for I in Values.First_Index .. Values.Last_Index loop
                        if I > Values.First_Index then
                           Append (Actual, " ");
                        end if;
                        Append (Actual, Image (Values (I)));
                     end loop;
                  end if;
               end;
            end if;
            AUnit.Assertions.Assert
              (Actual = C.Result, Func & " line" & C.Line_Number'Image);
         end;
      end loop;
   end Replay;

   procedure Test_List (T : in out Test_Case'Class) is
   begin
      Replay ("inverse_sigma0");
   end Test_List;

   procedure Test_Count (T : in out Test_Case'Class) is
   begin
      Replay ("inverse_sigma0_count");
   end Test_Count;

   overriding function Name (T : Arith_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Arith");
   end Name;

   overriding procedure Register_Tests (T : in out Arith_Case) is
   begin
      Registration.Register_Routine (T, Test_List'Access, "inverse_sigma0");
      Registration.Register_Routine
        (T, Test_Count'Access, "inverse_sigma0_count");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Arith_Case);
      return Result;
   end Suite;
end Compat_Arith;
