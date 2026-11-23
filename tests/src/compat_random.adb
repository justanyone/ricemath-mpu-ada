with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Random;

--  Replay the deterministic ChaCha fixtures and exercise public contracts.
procedure Compat_Random (T : in out AUnit.Test_Cases.Test_Case'Class) is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Random;
   use type U64;
   use type Byte;
   function Image (V : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (V), Ada.Strings.Both));

   function Decode (S : String) return Byte_Array is
      Result : Byte_Array (0 .. S'Length / 2 - 1);
      function Digit (C : Character) return Byte is
        (if C in '0' .. '9' then Character'Pos (C) - Character'Pos ('0')
         else Character'Pos (C) - Character'Pos ('a') + 10);
   begin
      for I in Result'Range loop
         Result (I) := 16 * Digit (S (S'First + 2 * I))
           + Digit (S (S'First + 2 * I + 1));
      end loop;
      return Result;
   end Decode;

   function Hex (Data : Byte_Array) return String is
      Hex_Alphabet : constant String := "0123456789abcdef";
      Result : String (1 .. 2 * Data'Length);
      P : Positive := 1;
   begin
      for B of Data loop
         Result (P) := Hex_Alphabet (Natural (B / 16) + 1);
         Result (P + 1) := Hex_Alphabet (Natural (B mod 16) + 1);
         P := P + 2;
      end loop;
      return Result;
   end Hex;

   procedure Replay (T : in out Test_Case'Class);
   procedure Replay (T : in out Test_Case'Class) is
      Cases : constant Case_Vectors.Vector := Load ("random");
      Count : Natural := 0;
   begin
      for C of Cases loop
         declare
            F : constant String := To_String (C.Func);
            G : Generator;
            V, A, B : U64 := 0;
            Actual : Unbounded_String;
            Checked : Boolean := True;
            function Arg (I : Positive) return String is
              (To_String (C.Args (I)));
            procedure Bytes (Length : Natural) is
               Data : Byte_Array (1 .. Length);
            begin
               Random_Bytes (G, Data);
               Actual := To_Unbounded_String (Hex (Data));
            end Bytes;
            procedure Discard (Length : Natural) is
               Data : Byte_Array (1 .. Length);
            begin
               Random_Bytes (G, Data);
               AUnit.Assertions.Assert (Data'Length = Length, "draw length");
            end Discard;
         begin
            Csrand (G, Decode (Arg (1)));
            if F in "irand" | "irand32" | "srand42_irand" |
              "blake_irand"
            then
               Irand (G, V);
               Actual := To_Unbounded_String (Image (V));
            elsif F in "irand64" | "tag_irand64" then
               Urandomb (G, 64, V);
               Actual := To_Unbounded_String (Image (V));
            elsif F in "random_bytes" | "random_bytes_seq" |
              "srand15_random_bytes4" | "blake_random_bytes7"
            then
               Bytes (Natural'Value (Arg (2)));
            elsif F in "irand32_after_bytes" | "irand64_after_bytes" |
              "random_bytes_len_tail" | "blake_irand_after7" |
              "tag_irand_irand64"
            then
               if F = "blake_irand_after7" then
                  Discard (7);
               elsif F = "tag_irand_irand64" then
                  Irand (G, V);
               else
                  Discard (Natural'Value (Arg (2)));
               end if;
               if F = "random_bytes_len_tail" then
                  Bytes (8);
               else
                  Urandomb (G, (if F in "irand64_after_bytes" |
                    "tag_irand_irand64" then 64 else 32), V);
                  Actual := To_Unbounded_String (Image (V));
               end if;
            elsif F in "irand_seq" | "irand32_seq" | "irand64_seq" |
              "urandomm_seq"
            then
               for I in 1 .. 20 loop
                  if F = "urandomm_seq" then
                     Urandomm (G, U64'Value (Arg (2)), V);
                  else
                     Urandomb (G, (if F = "irand64_seq" then 64 else 32), V);
                  end if;
                  if I > 1 then
                     Append (Actual, " ");
                  end if;
                  Append (Actual, Image (V));
               end loop;
            elsif F = "mixed_seq" then
               Irand (G, V);
               Append (Actual, Image (V) & " ");
               Urandomb (G, 64, V);
               Append (Actual, Image (V) & " ");
               declare
                  Data : Byte_Array (1 .. 3);
               begin
                  Random_Bytes (G, Data);
                  Append (Actual, Hex (Data) & " ");
               end;
               Irand (G, V);
               Append (Actual, Image (V) & " ");
               Urandomb (G, 5, V);
               Append (Actual, Image (V) & " ");
               Irand (G, V);
               Append (Actual, Image (V));
            elsif F = "urandomb" then
               --  Bigint_Bits: >64 bits belongs to the later bigint tier.
               Checked := Natural'Value (Arg (2)) <= 64;
               if Checked then
                  Urandomb (G, Natural'Value (Arg (2)), V);
                  Actual := To_Unbounded_String (Image (V));
               end if;
            elsif F = "urandomm" then
               --  Bigint_Modulus: native API accepts at most U64'Last.
               Checked := Parse_U64 (Arg (2), A);
               if Checked then
                  if C.Error then
                     begin
                        Urandomm (G, A, V);
                        AUnit.Assertions.Assert (False, "zero modulus");
                     exception
                        when Ada.Assertions.Assertion_Error => null;
                     end;
                     Actual := To_Unbounded_String ("ERROR");
                  else
                     Urandomm (G, A, V);
                     Actual := To_Unbounded_String (Image (V));
                  end if;
               end if;
            elsif F = "urandomr" then
               --  Signed_Or_Bigint_Range: unsigned native tier only.
               Checked := Parse_U64 (Arg (2), A)
                 and then Parse_U64 (Arg (3), B);
               if Checked then
                  if A > B then
                     begin
                        Urandomr (G, A, B, V);
                        AUnit.Assertions.Assert (False, "inverted range");
                     exception
                        when Ada.Assertions.Assertion_Error => null;
                     end;
                     Actual := To_Unbounded_String ("undef");
                  else
                     Urandomr (G, A, B, V);
                     Actual := To_Unbounded_String (Image (V));
                  end if;
               end if;
            else
               --  Other_Families: random primes, shuffle, randperm,
               --  vecsample, floating rand/drand and cipher plaintext XOR
               --  are outside this integer CSPRNG port. Their named rows
               --  remain in the immutable fixture for the respective ports.
               Checked := False;
            end if;
            if Checked then
               Count := Count + 1;
               AUnit.Assertions.Assert
                 (Actual = C.Result, F & " line" &
                  Positive'Image (C.Line_Number) & " expected " &
                  To_String (C.Result) & " got " & To_String (Actual));
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert
        (Count > 600, "too few CSPRNG fixtures replayed");
   end Replay;

   procedure Contracts (T : in out Test_Case'Class);
   procedure Contracts (T : in out Test_Case'Class) is
      type U64_Array is array (Positive range <>) of U64;
      G, H : Generator;
      A, B : Byte_Array (17 .. 80);
      V : U64;
      Raised : Boolean := False;
   begin
      AUnit.Assertions.Assert (not Is_Seeded (G), "new context seeded");
      begin
         Irand (G, V);
      exception
         when Ada.Assertions.Assertion_Error => Raised := True;
      end;
      AUnit.Assertions.Assert (Raised, "unseeded draw accepted");
      --  OS seed path must return a usable context; no probabilistic asserts.
      Csrand (G);
      AUnit.Assertions.Assert (Is_Seeded (G), "OS seed failed");
      Random_Bytes (G, A);
      --  Empty and partial-word seeds exercise all PCG expansion boundaries.
      for Length in 0 .. 41 loop
         declare
            Seed : constant Byte_Array (1 .. Length) := [others => 42];
         begin
            Csrand (G, Seed);
            Csrand (H, Seed);
            Random_Bytes (G, A);
            Random_Bytes (H, B);
            AUnit.Assertions.Assert (A = B, "seed replay mismatch");
         end;
      end loop;
      --  Published ChaCha20 zero-key vector (chacha.c: _test_core).
      Csrand (G, Byte_Array'(0 .. 39 => 0));
      Random_Bytes (G, A);
      AUnit.Assertions.Assert
        (Hex (A) =
         "76b8e0ada0f13d90405d6ae55386bd28b" &
         "dd219b8a08ded1aa836efcc8b770dc7da" &
         "41597c5157488d7724e03fb8d84a376a4" &
         "3b8f41518a11cc387b669b2ee6586", "ChaCha20 zero vector");
      --  Seed 42: bounded draws at each native arithmetic boundary.
      Csrand (G, [42, 0, 0, 0]);
      for N of U64_Array'[1, 2, 2 ** 32 - 1, 2 ** 32,
                          2 ** 32 + 1, 2 ** 63 - 1, 2 ** 63,
                          2 ** 63 + 1, U64'Last]
      loop
         for I in 1 .. 100 loop
            Urandomm (G, N, V);
            AUnit.Assertions.Assert
              ((if N <= 1 then V = 0 else V < N),
               "seed 42: modulo bound");
            Urandomr (G, U64'Last - N, U64'Last, V);
            AUnit.Assertions.Assert
              (V >= U64'Last - N, "seed 42: inclusive range bound");
         end loop;
      end loop;
      Csrand (G, [1, 2, 3]);
      Raised := False;
      begin
         Urandomb (G, 65, V);
      exception
         when Ada.Assertions.Assertion_Error => Raised := True;
      end;
      AUnit.Assertions.Assert (Raised, "too many bits accepted");
      Csrand (H, [1, 2, 3]);
      Urandomb (G, 0, V);
      Raised := False;
      begin
         Urandomm (G, 0, V);
      exception
         when Ada.Assertions.Assertion_Error => Raised := True;
      end;
      AUnit.Assertions.Assert (Raised, "zero modulus accepted");
      Urandomm (G, 1, V);
      Urandomr (G, U64'Last, U64'Last, V);
      Random_Bytes (G, A);
      Random_Bytes (H, B);
      AUnit.Assertions.Assert (A = B, "degenerate draw consumed bytes");
   end Contracts;

begin
   Replay (T);
   Contracts (T);
end Compat_Random;
