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

   procedure Replay is
      Mixed_Bits : constant array (1 .. 6) of Natural := [32, 64, 0, 32, 5, 32];
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
               if Length (Actual) > 0 then
                  Append (Actual, " ");
               end if;
               Append (Actual, S);
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
            then
               --  Bigint_Or_Signed: this API accepts unsigned native values.
               if (F = "urandomb" and then Natural'Value (Arg (2)) > 64)
                 or else (F in "urandomm" | "urandomm_seq" | "urandomr"
                   and then not Parse_U64 (Arg (2), A))
                 or else (F = "urandomr" and then not Parse_U64 (Arg (3), B))
               then
                  goto Next_Case;
               end if;
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
                           Urandomb (G, (if F = "mixed_seq" then Mixed_Bits (I)
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
                       (C.Error or else C.Undef, "unexpected contract failure");
                     Actual := C.Result;
               end;
               Count := Count + 1;
               AUnit.Assertions.Assert (Actual = C.Result,
                 F & " line" & Positive'Image (C.Line_Number));
            end if;
         end;
         <<Next_Case>>
      end loop;
      AUnit.Assertions.Assert (Count > 600, "too few CSPRNG fixtures");
   end Replay;
   procedure Contracts is
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
   AUnit.Assertions.Assert (T.Name.all'Length > 0, "random test has a name");
   Replay;
   Contracts;
end Compat_Random;
