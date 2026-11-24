with Ada.Assertions;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions; use AUnit.Assertions;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Fixture_Support; use Fixture_Support;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Proving;
with Math_Prime_Util.Random; use Math_Prime_Util.Random;
with Math_Prime_Util.Random_Primes; use Math_Prime_Util.Random_Primes;
package body Compat_Random_Select is
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use type Primality.Prime_Result;
   type Selection_Case is new Test_Case with null record;
   overriding function Name (T : Selection_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Selection_Case);
   overriding function Name (T : Selection_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Random_Select"));
   function Image (N : U64) return String is
     (Ada.Strings.Fixed.Trim (N'Image, Ada.Strings.Both));
   type Text_Array is array (Natural range <>) of Unbounded_String;
   procedure Shuffle_Text is new Shuffle (Unbounded_String, Text_Array);
   procedure Sample_Text is new Vecsample (Unbounded_String, Text_Array);
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

   generic
      Func : String;
      Expected_Count : Natural;
   procedure Replay (T : in out Test_Case'Class);
   procedure Replay (T : in out Test_Case'Class) is
      Count : Natural := 0;
      Family : constant String :=
        (if Func = "is_provable_prime_with_cert" then "bigint_proving"
         elsif Func = "miller_rabin_random" then "bigint_random" else "random");
   begin
      for C of For_Function (Load (Family), Func) loop
         declare
            G : Generator;
            N, K, V : U64 := 0;
            Actual : Unbounded_String;
            Factors : Factor.Factor_List;
            Flag : Boolean;
            function Arg (I : Positive) return String is
              (To_String (C.Args (I)));
            procedure Add (S : String) is
            begin
               Append (Actual, (if Length (Actual) > 0 then " " else "") & S);
            end Add;
         begin
            if Family = "random" then
               Csrand (G, [for I in 1 .. Arg (1)'Length / 2 => Byte'Value
                 ("16#" & Arg (1) (2 * I - 1 .. 2 * I) & "#")]);
            else
               Csrand (G, [1 .. 40 => 0]);
            end if;
            if Func = "is_provable_prime_with_cert" then
               if not Parse_U64 (Arg (1), N) then
                  goto Next_Row;
               end if;
               declare
                  Proof : constant Proving.Certified_Result :=
                    Proving.Is_Provable_Prime_With_Cert (N);
                  Text : String := Proof.Certificate;
               begin
                  for Ch of Text loop
                     Ch := (if Ch = ASCII.LF then '|'
                            elsif Ch = ' ' then '~' else Ch);
                  end loop;
                  Add (Image (U64 (Proof.Result)) & " " & Text);
                  Assert ((if Proof.Result = 2 then
                    Proving.Verify_Prime (Proof.Certificate)
                    else Text'Length = 0), "certificate law");
               end;
            elsif Func = "miller_rabin_random" then
               if not Parse_U64 (Arg (1), N) then
                  goto Next_Row;
               end if;
               Miller_Rabin_Random (G, N, U64'Value (Arg (2)), Flag);
               Add ((if Flag then "1" else "0"));
            elsif Func = "random_strong_prime" then
               if not C.Error then
                  goto Next_Row;
               end if;
               begin
                  Random_Strong_Prime (G, Natural'Value (Arg (2)), V);
                  Assert (False, "strong minimum bits");
               exception
                  when Ada.Assertions.Assertion_Error => Actual := C.Result;
               end;
            elsif Func = "random_factored_integer" then
               if not Parse_U64 (Arg (2), N) then
                  goto Next_Row;
               end if;
               Random_Factored_Integer (G, N, V, Factors);
               Add (Image (V));
               for I in 1 .. Factors.Count loop
                  Add (Image (Factors.Value (I)));
               end loop;
               if N = 0 then
                  Assert (V = 0 and Factors.Count = 0, "zero factors");
                  Actual := C.Result;
               end if;
            elsif Func = "randperm" then
               N := U64'Value (Arg (2));
               K := (if C.Args.Length = 3 then U64'Value (Arg (3)) else N);
               declare
                  Values : U64_Array (1 .. Natural (U64'Min (N, K)));
               begin
                  Randperm (G, N, K, Values);
                  for Value of Values loop
                     Add (Image (Value));
                  end loop;
               end;
            else
               declare
                  First : constant Positive :=
                    (if Func = "shuffle" then 2 else 3);
                  Values : Text_Array := [for I in First ..
                    Natural (C.Args.Length) => C.Args (I)];
                  Sample : Text_Array (1 .. (if Func = "shuffle" then 0 else
                    Natural (U64'Min (U64'Value (Arg (2)),
                      U64 (Values'Length)))));
               begin
                  if Func = "shuffle" then
                     Shuffle_Text (G, Values);
                     Sample := []; --  Output is Values for shuffle.
                  else
                     Sample_Text (G, U64'Value (Arg (2)), Values, Sample);
                  end if;
                  for Value of (if Func = "shuffle" then Values else Sample)
                  loop
                     Add (To_String (Value));
                  end loop;
               end;
            end if;
            if Length (Actual) = 0 and C.Undef then
               Actual := To_Unbounded_String ("undef");
            end if;
            Assert (Actual = C.Result, Func & C.Line_Number'Image);
            Count := Count + 1;
            <<Next_Row>>
         end;
      end loop;
      Assert (Count = Expected_Count, Func & " count" & Count'Image);
   end Replay;
   procedure Perm is new Replay ("randperm", 238);
   procedure Shuf is new Replay ("shuffle", 98);
   procedure Sample is new Replay ("vecsample", 112);
   procedure Strong is new Replay ("random_strong_prime", 14);
   procedure Factored is new Replay ("random_factored_integer", 112);
   procedure Miller is new Replay ("miller_rabin_random", 0);
   procedure Proof is new Replay ("is_provable_prime_with_cert", 7);
   procedure Laws (T : in out Test_Case'Class) is
      G : Generator;
      V : U64;
      Flag : Boolean;
      Factors : Factor.Factor_List;
   begin
      Csrand (G, [1 .. 40 => 0]);
      for N in 0 .. 100 loop
         declare
            Values : U64_Array (5 .. N + 4);
         begin
            Randperm (G, U64 (N), Values);
            for I in Values'Range loop
               Assert (Values (I) < U64 (N), "range seed 0");
               Assert ((for all J in Values'First .. I - 1 =>
                 Values (I) /= Values (J)), "unique seed 0");
            end loop;
         end;
      end loop;
      for N of U64_Array'[0, 1, 2, 3, 4, 341, 561, 1_373_653,
        2 ** 32 - 1, 2 ** 32 + 1, 2 ** 63 - 1, 2 ** 63 + 1, U64'Last]
      loop
         Miller_Rabin_Random (G, N, 20, Flag);
         Assert (Flag = (Primality.Is_Prime (N) = 2), "MR seed 0");
         Random_Factored_Integer (G, N, V, Factors);
         declare
            Product : U128 := 1;
         begin
            for I in 1 .. Factors.Count loop
               Product := Product * U128 (Factors.Value (I));
            end loop;
            Assert ((if N = 0 then V = 0 else Product = U128 (V)),
              "factor product seed 0");
         end;
      end loop;
   end Laws;
   overriding procedure Register_Tests (T : in out Selection_Case) is
   begin
      Registration.Register_Routine (T, Perm'Access, "randperm");
      Registration.Register_Routine (T, Shuf'Access, "shuffle");
      Registration.Register_Routine (T, Sample'Access, "vecsample");
      Registration.Register_Routine (T, Strong'Access, "strong prime");
      Registration.Register_Routine (T, Factored'Access, "factored");
      Registration.Register_Routine (T, Miller'Access, "random MR");
      Registration.Register_Routine (T, Proof'Access, "combined proof");
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
