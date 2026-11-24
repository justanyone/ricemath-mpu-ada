with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Proving;
with Math_Prime_Util.Random;
with Math_Prime_Util.Random_Primes;

package body Compat_Random_Select is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Random;
   use Math_Prime_Util.Random_Primes;
   use type Primality.Prime_Result;
   type Selection_Case is new Test_Case with null record;
   overriding function Name (T : Selection_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Selection_Case);
   overriding function Name (T : Selection_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Random_Select"));
   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (N'Image, Ada.Strings.Both));
   function Decode (S : String) return Byte_Array is
     ([for I in 1 .. S'Length / 2 => Byte'Value
       ("16#" & S (S'First + 2 * (I - 1) .. S'First + 2 * I - 1) & "#")]);
   type Text_Array is array (Natural range <>) of Unbounded_String;
   procedure Shuffle_Text is new Shuffle (Unbounded_String, Text_Array);
   procedure Sample_Text is new Vecsample (Unbounded_String, Text_Array);
   procedure Shuffle_Numbers is new Shuffle (U64, U64_Array);

   --  random.tsv: bigint-only rows skipped by name/line:
   --  195, 196, 197, 198, 199, 240, 427, 428, 429, 430, 431, 472, 659, 660,
   --  661, 662, 663, 704, 891, 892, 893, 894, 895, 936, 1123, 1124, 1125,
   --  1126, 1127, 1168, 1355, 1356, 1357, 1358, 1359, 1400, 1587, 1588,
   --  1589, 1590, 1591, 1632, 1819, 1820, 1821, 1822, 1823, 1864, 2051,
   --  2052, 2053, 2054, 2055, 2096, 2283, 2284, 2285, 2286, 2287, 2328,
   --  2515, 2516, 2517, 2518, 2519, 2560, 2747, 2748, 2749, 2750, 2751,
   --  2792, 2979, 2980, 2981, 2982, 2983, 3024, 3211, 3212, 3213, 3214,
   --  3215, 3256.
   --  bigint_random.tsv: bigint-only rows skipped by name/line:
   --  15, 16, 20, 21, 24.
   --  bigint_proving.tsv: bigint-only rows skipped by name/line:
   --  2, 9, 16, 23, 30, 37, 44, 51, 58, 65, 72, 84, 91, 98, 106, 113, 120,
   --  127, 134, 141, 148, 156, 163, 170, 173, 176, 179, 182, 185, 188, 191,
   --  194, 209.

   procedure Replay (Func : String; Expected_Count : Natural) is
      Count : Natural := 0;
   begin
      for C of For_Function (Load ("random"), Func) loop
         declare
            G : Generator;
            N, K, V : U64 := 0;
            Actual : Unbounded_String;
            Factors : Factor.Factor_List;
            function Arg (I : Positive) return String is
              (To_String (C.Args (I)));
            procedure Add (S : String) is
            begin
               Append (Actual, (if Length (Actual) > 0 then " " else "") & S);
            end Add;
         begin
            Csrand (G, Decode (Arg (1)));
            if Func = "random_strong_prime" then
               if C.Error then
                  declare
                     Rejected : Boolean := False;
                  begin
                     begin
                        Random_Strong_Prime (G, Natural'Value (Arg (2)), V);
                     exception
                        when Ada.Assertions.Assertion_Error =>
                           Rejected := True;
                     end;
                     AUnit.Assertions.Assert (Rejected, "strong minimum bits");
                  end;
                  Count := Count + 1;
               end if;
            elsif Func = "random_factored_integer" then
               if Parse_U64 (Arg (2), N) then
                  Random_Factored_Integer (G, N, V, Factors);
                  Add (Image (V));
                  for I in 1 .. Factors.Count loop
                     Add (Image (Factors.Value (I)));
                  end loop;
                  Count := Count + 1;
               end if;
            elsif Func = "randperm" then
               AUnit.Assertions.Assert (Parse_U64 (Arg (2), N), "native N");
               K := N;
               if Natural (C.Args.Length) = 3 then
                  AUnit.Assertions.Assert (Parse_U64 (Arg (3), K), "native K");
               end if;
               declare
                  Values : U64_Array (1 .. Natural (U64'Min (N, K)));
               begin
                  if Natural (C.Args.Length) = 2 then
                     Randperm (G, N, Values);
                  else
                     Randperm (G, N, K, Values);
                  end if;
                  for Value of Values loop
                     Add (Image (Value));
                  end loop;
               end;
               Count := Count + 1;
            else
               declare
                  First : constant Positive :=
                    (if Func = "shuffle" then 2 else 3);
                  Values : Text_Array
                    (1 .. Natural (C.Args.Length) - First + 1);
               begin
                  for I in Values'Range loop
                     Values (I) := C.Args (First + I - 1);
                  end loop;
                  if Func = "shuffle" then
                     Shuffle_Text (G, Values);
                     for Value of Values loop
                        Add (To_String (Value));
                     end loop;
                  else
                     AUnit.Assertions.Assert
                       (Parse_U64 (Arg (2), K), "sample count");
                     declare
                        Sample : Text_Array
                          (1 .. Natural (U64'Min (K, U64 (Values'Length))));
                     begin
                        Sample_Text (G, K, Values, Sample);
                        for Value of Sample loop
                           Add (To_String (Value));
                        end loop;
                     end;
                  end if;
               end;
               Count := Count + 1;
            end if;
            if Length (Actual) = 0 and then C.Undef then
               Actual := To_Unbounded_String ("undef");
            end if;
            if Func /= "random_strong_prime" and then
              not (Func = "random_factored_integer" and then N = 0)
            then
               AUnit.Assertions.Assert (Actual = C.Result,
                 Func & " line" & C.Line_Number'Image & " actual " &
                 To_String (Actual) & " expected " & To_String (C.Result));
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Count = Expected_Count,
        Func & " fixture count" & Count'Image);
   end Replay;

   procedure Test_Randperm (T : in out Test_Case'Class) is
   begin
      Replay ("randperm", 238);
   end Test_Randperm;
   procedure Test_Shuffle (T : in out Test_Case'Class) is
   begin
      Replay ("shuffle", 98);
   end Test_Shuffle;
   procedure Test_Vecsample (T : in out Test_Case'Class) is
   begin
      Replay ("vecsample", 112);
   end Test_Vecsample;
   procedure Test_Strong (T : in out Test_Case'Class) is
      G : Generator;
      V : U64;
      Rejected : Boolean := False;
   begin
      Replay ("random_strong_prime", 14);
      Csrand (G, [1 .. 40 => 0]);
      begin
         Random_Strong_Prime (G, 128, V);
      exception
         when Constraint_Error => Rejected := True;
      end;
      AUnit.Assertions.Assert (Rejected, "strong prime needs bigint");
   end Test_Strong;
   procedure Test_Factored (T : in out Test_Case'Class) is
   begin
      Replay ("random_factored_integer", 112);
   end Test_Factored;

   procedure Test_Miller (T : in out Test_Case'Class) is
      G : Generator;
      V : Boolean;
      N : U64;
      Count : Natural := 0;
      Edges : constant U64_Array :=
        [0, 1, 2, 3, 4, 5, 9, 341, 561, 1_373_653,
         2 ** 32 - 1, 2 ** 32 + 1, 2 ** 63 - 1, 2 ** 63 + 1,
         U64'Last, 18_446_744_073_709_551_557];
   begin
      Csrand (G, [1 .. 40 => 0]);
      for C of For_Function (Load ("bigint_random"), "miller_rabin_random")
      loop
         if Parse_U64 (To_String (C.Args (1)), N) then
            Miller_Rabin_Random (G, N, Positive'Value
              (To_String (C.Args (2))), V);
            AUnit.Assertions.Assert
              ((if V then "1" else "0") = To_String (C.Result), "MR row");
            Count := Count + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Count = 0, "all MR fixture inputs are bigint");
      for Value of Edges loop
         Miller_Rabin_Random (G, Value, 20, V);
         AUnit.Assertions.Assert (V = (Primality.Is_Prime (Value) = 2),
           "MR seed 0 N=" & Image (Value));
      end loop;
   end Test_Miller;

   function Encode (S : String) return String is
      Result : String := S;
   begin
      for C of Result loop
         if C = ASCII.LF then
            C := '|';
         elsif C = ' ' then
            C := '~';
         end if;
      end loop;
      return Result;
   end Encode;

   procedure Test_Proving (T : in out Test_Case'Class) is
      N : U64;
      Count : Natural := 0;
   begin
      for C of For_Function (Load ("bigint_proving"),
        "is_provable_prime_with_cert")
      loop
         if Parse_U64 (To_String (C.Args (1)), N) then
            declare
               Proof : constant Proving.Certified_Result :=
                 Proving.Is_Provable_Prime_With_Cert (N);
               Actual : constant String := Image (U64 (Proof.Result)) &
                 " " & Encode (Proof.Certificate);
            begin
               AUnit.Assertions.Assert (Actual = To_String (C.Result),
                 "combined proof line" & C.Line_Number'Image);
               AUnit.Assertions.Assert
                 ((if Proof.Result = 2 then
                     Proving.Verify_Prime (Proof.Certificate)
                   else Proof.Certificate'Length = 0), "certificate law");
            end;
            Count := Count + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Count = 7, "native combined proof count");
   end Test_Proving;

   procedure Laws (T : in out Test_Case'Class) is
      G : Generator;
      V : U64;
      Factors : Factor.Factor_List;
      Bounds : constant U64_Array :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63 + 1, U64'Last];
   begin
      Csrand (G, [1 .. 40 => 0]);
      for N in 0 .. 100 loop
         declare
            Values : U64_Array (5 .. N + 4);
            Seen : array (0 .. N) of Boolean := [others => False];
         begin
            Randperm (G, U64 (N), Values);
            Shuffle_Numbers (G, Values);
            for Value of Values loop
               AUnit.Assertions.Assert (Value < U64 (N), "range seed 0");
               AUnit.Assertions.Assert (not Seen (Natural (Value)),
                 "permutation uniqueness seed 0");
               Seen (Natural (Value)) := True;
            end loop;
         end;
      end loop;
      for N of Bounds loop
         for Trial in 1 .. 5 loop
            Random_Factored_Integer (G, N, V, Factors);
            declare
               Product : U128 := 1;
            begin
               for I in 1 .. Factors.Count loop
                  AUnit.Assertions.Assert
                    (Primality.Is_Prime (Factors.Value (I)) = 2,
                     "prime factor seed 0");
                  Product := Product * U128 (Factors.Value (I));
               end loop;
               AUnit.Assertions.Assert
                 ((if N = 0 then V = 0 and then Factors.Count = 0
                   else Product = U128 (V) and then V in 1 .. N),
                  "factor product seed 0");
               declare
                  Proof : constant Proving.Certified_Result :=
                    Proving.Is_Provable_Prime_With_Cert (V);
               begin
                  AUnit.Assertions.Assert
                    ((if Proof.Result = 2 then
                        Proving.Verify_Prime (Proof.Certificate)
                      else Proof.Certificate'Length = 0), "proof seed 0");
               end;
            end;
         end loop;
      end loop;
   end Laws;

   overriding procedure Register_Tests (T : in out Selection_Case) is
   begin
      Registration.Register_Routine (T, Test_Randperm'Access, "randperm");
      Registration.Register_Routine (T, Test_Shuffle'Access, "shuffle");
      Registration.Register_Routine (T, Test_Vecsample'Access, "vecsample");
      Registration.Register_Routine (T, Test_Strong'Access, "strong prime");
      Registration.Register_Routine (T, Test_Factored'Access, "factored");
      Registration.Register_Routine (T, Test_Miller'Access, "random MR");
      Registration.Register_Routine (T, Test_Proving'Access, "combined proof");
      Registration.Register_Routine (T, Laws'Access, "laws seed 0");
   end Register_Tests;
   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Selection_Case);
      return Result;
   end Suite;
end Compat_Random_Select;
