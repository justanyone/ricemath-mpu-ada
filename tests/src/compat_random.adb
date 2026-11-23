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
   begin
      for I in Result'Range loop
         Result (I) := Byte'Value
           ("16#" & S (S'First + 2 * I .. S'First + 2 * I + 1) & "#");
      end loop;
      return Result;
   end Decode;

   function Hex (Data : Byte_Array) return String is
      Hex_Alphabet : constant String := "0123456789abcdef";
      Result : String (1 .. 2 * Data'Length);
   begin
      for I in 1 .. Data'Length loop
         Result (2 * I - 1) := Hex_Alphabet
           (Natural (Data (Data'First + I - 1) / 16) + 1);
         Result (2 * I) := Hex_Alphabet
           (Natural (Data (Data'First + I - 1) mod 16) + 1);
      end loop;
      return Result;
   end Hex;

   type Natural_Array is array (Positive range <>) of Natural;
   procedure Replay is
      Mixed_Bits : constant Natural_Array := [32, 64, 0, 32, 5, 32];
      Count : Natural := 0;
   begin
      for C of Load ("random") loop
         declare
            F : constant String := To_String (C.Func);
            G : Generator;
            V, A, B : U64 := 0;
            Actual : Unbounded_String;
            function Arg (I : Positive) return String is
              (To_String (C.Args (I)));
            procedure Add (S : String) is
            begin
               Append (Actual, (if Length (Actual) > 0 then " " else "") & S);
            end Add;
            procedure Bytes (Size : Natural; Discard : Boolean := False) is
               Data : Byte_Array (1 .. Size);
            begin
               Random_Bytes (G, Data);
               if not Discard then
                  Add (Hex (Data));
               end if;
            end Bytes;
         begin
            --  Other_Families: primes, shuffle, randperm, vecsample,
            --  floating rand/drand and cipher XOR belong to separate ports.
            if F in "irand" | "irand32" | "irand64" | "irand_seq" |
              "irand32_seq" | "irand64_seq" | "srand42_irand" |
              "blake_irand" | "tag_irand64" | "random_bytes" |
              "random_bytes_seq" | "srand15_random_bytes4" |
              "blake_random_bytes7" | "irand32_after_bytes" |
              "irand64_after_bytes" | "random_bytes_len_tail" |
              "blake_irand_after7" | "tag_irand_irand64" | "mixed_seq" |
              "urandomb" | "urandomm" | "urandomm_seq" | "urandomr"
              and then not
                ((F = "urandomb" and then Natural'Value (Arg (2)) > 64)
                 or else (F in "urandomm" | "urandomm_seq" | "urandomr"
                   and then not Parse_U64 (Arg (2), A))
                 or else (F = "urandomr" and then not Parse_U64 (Arg (3), B)))
            then
               --  Bigint_Or_Signed rows are excluded by the native checks.
               Csrand (G, Decode (Arg (1)));
               if F = "tag_irand_irand64" then
                  Irand (G, V);
               elsif F = "blake_irand_after7" then
                  Bytes (7, True);
               elsif F in "irand32_after_bytes" | "irand64_after_bytes" |
                 "random_bytes_len_tail"
               then
                  Bytes (Natural'Value (Arg (2)), True);
               end if;
               begin
                  for I in 1 .. (if F = "mixed_seq" then 6
                    elsif F /= "random_bytes_seq" and then
                      Ada.Strings.Fixed.Index (F, "_seq") > 0 then 20 else 1)
                  loop
                     if F in "random_bytes" | "random_bytes_seq" |
                       "srand15_random_bytes4" | "blake_random_bytes7" |
                       "random_bytes_len_tail" or else
                       (F = "mixed_seq" and then I = 3)
                     then
                        Bytes ((if F = "mixed_seq" then 3
                          elsif F = "random_bytes_len_tail" then 8
                          else Natural'Value (Arg (2))));
                     else
                        if F = "urandomr" then
                           Urandomr (G, A, B, V);
                        elsif F in "urandomm" | "urandomm_seq" then
                           Urandomm (G, A, V);
                        else
                           Urandomb (G,
                             (if F = "mixed_seq" then Mixed_Bits (I)
                             elsif F = "urandomb" then Natural'Value (Arg (2))
                             elsif Ada.Strings.Fixed.Index (F, "64") > 0
                               then 64 else 32), V);
                        end if;
                        Add (Image (V));
                     end if;
                  end loop;
               exception
                  when Ada.Assertions.Assertion_Error =>
                     AUnit.Assertions.Assert
                       (C.Error or else C.Undef, "unexpected contract error");
                     Actual := C.Result;
               end;
               Count := Count + 1;
               AUnit.Assertions.Assert (Actual = C.Result,
                 F & " line" & Positive'Image (C.Line_Number));
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Count > 600, "too few CSPRNG fixtures");
   end Replay;
   procedure Contracts is
      G, H : Generator;
      A, B : Byte_Array (17 .. 80);
      V : U64;
      Raised : Boolean;
   begin
      --  Unseeded and oversized draws must fail before consuming bytes.
      for Bits of Natural_Array'[32, 65] loop
         Raised := False;
         begin
            Urandomb (G, Bits, V);
         exception
            when Ada.Assertions.Assertion_Error => Raised := True;
         end;
         AUnit.Assertions.Assert (Raised, "invalid draw accepted");
         Csrand (G);
      end loop;
      --  Partial-word seeds, nonzero array bounds and deterministic replay.
      for Size in 0 .. 41 loop
         declare
            Seed : constant Byte_Array (1 .. Size) := [others => 0];
         begin
            Csrand (G, Seed);
            Csrand (H, Seed);
            Random_Bytes (G, A);
            Random_Bytes (H, B);
            AUnit.Assertions.Assert (A = B, "seed replay mismatch");
            if Size = 40 then
               --  chacha.c: _test_core, published ChaCha20 zero-key vector.
               AUnit.Assertions.Assert (Hex (A) =
                 "76b8e0ada0f13d90405d6ae55386bd28b" &
                 "dd219b8a08ded1aa836efcc8b770dc7da" &
                 "41597c5157488d7724e03fb8d84a376a4" &
                 "3b8f41518a11cc387b669b2ee6586", "ChaCha20 zero vector");
            end if;
         end;
      end loop;
   end Contracts;

begin
   AUnit.Assertions.Assert (T.Name.all'Length > 0, "random test has a name");
   Replay;
   Contracts;
end Compat_Random;
