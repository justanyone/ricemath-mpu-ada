with Ada.Assertions;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with AUnit.Assertions;
with AUnit.Test_Cases;
with Fixture_Support;
with Math_Prime_Util.Random;
with Math_Prime_Util.Random_Primes;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Int;
with Math_Prime_Util.Factor;
--  Replay the deterministic ChaCha fixtures and exercise public contracts.
procedure Compat_Random (T : in out AUnit.Test_Cases.Test_Case'Class) is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Random;
   use type Byte;
   use type U64;
   function Image (V : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (V), Ada.Strings.Both));
   function Decode (S : String) return Byte_Array is
     ([for I in 1 .. S'Length / 2 => Byte'Value
       ("16#" & S (S'First + 2 * (I - 1) .. S'First + 2 * I - 1) & "#")]);
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
   type U64_Array is array (Positive range <>) of U64;
   type Natural_Array is array (Positive range <>) of Natural;
   procedure Replay is
      Mixed_Bits : constant Natural_Array := [32, 64, 0, 32, 5, 32];
      Count : Natural := 0;
   begin
      for C of Load ("random") loop
         declare
            F : constant String := To_String (C.Func);
            function Has (S : String) return Boolean is
              (Ada.Strings.Fixed.Index (F, S) > 0);
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
            --  cipher XOR belong to separate ports.
            if ((Has ("irand") and then F not in
                 "tag_irand_irand32_rand" | "blake_drand_after_irand")
              or else Has ("random_bytes")
              or else F in "urandomb" | "urandomm" | "urandomm_seq" |
                "urandomr" | "mixed_seq")
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
                      Has ("_seq") then 20 else 1)
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
                        elsif Has ("irand64") then
                           Irand64 (G, V);
                        elsif Has ("irand32") then
                           Irand32 (G, V);
                        else
                           Urandomb (G,
                             (if F = "mixed_seq" then Mixed_Bits (I)
                             elsif F = "urandomb" then Natural'Value (Arg (2))
                             elsif Has ("64")
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
      AUnit.Assertions.Assert (Count = 731, "CSPRNG fixture count changed");
   end Replay;
   --  Given the seeded float fixtures, when each output is drawn, then its
   --  15 significant decimal digits match the committed oracle spelling.
   procedure Float_Replay is
      Count : Natural := 0;
   begin
      for C of Load ("random") loop
         declare
            F : constant String := To_String (C.Func);
            G : Generator;
            V : Long_Float;
            Discard : U64;
            Scale : Long_Float := 0.0;
            Expected : constant String := To_String (C.Result);
            Start : Positive := Expected'First;
         begin
            if F in "rand" | "drand" | "drand_seq" |
              "tag_irand_irand32_rand" | "blake_drand_after_irand"
            then
               Csrand (G, Decode (To_String (C.Args (1))));
               if F = "tag_irand_irand32_rand" then
                  Irand (G, Discard);
                  AUnit.Assertions.Assert
                    (Discard = 1_951_677_399, "tag irand");
                  Irand32 (G, Discard);
                  AUnit.Assertions.Assert
                    (Discard = 598_936_225, "tag irand32");
                  Start := Ada.Strings.Fixed.Index (Expected, " ") + 1;
                  Start := Ada.Strings.Fixed.Index
                    (Expected, " ", Start) + 1;
               elsif F = "blake_drand_after_irand" then
                  declare
                     Prefix : Byte_Array (1 .. 7);
                  begin
                     Random_Bytes (G, Prefix);
                  end;
                  Irand (G, Discard);
               end if;
               if Natural (C.Args.Length) = 2 then
                  Scale := Long_Float'Value (To_String (C.Args (2)));
               end if;
               loop
                  declare
                     Stop : Natural := Ada.Strings.Fixed.Index
                       (Expected, " ", Start);
                     Want : Long_Float;
                     Unit : Long_Float := 1.0;
                  begin
                     if Stop = 0 then
                        Stop := Expected'Last + 1;
                     end if;
                     Want := Long_Float'Value (Expected (Start .. Stop - 1));
                     if F in "rand" | "tag_irand_irand32_rand" then
                        Rand (G, V, Scale);
                     else
                        Drand (G, V, Scale);
                     end if;
                     while abs Want < Unit loop
                        Unit := Unit / 10.0;
                     end loop;
                     AUnit.Assertions.Assert
                       (abs (V - Want) <= Unit * 5.1E-15,
                        F & " line" & Positive'Image (C.Line_Number));
                     exit when Stop > Expected'Last;
                     Start := Stop + 1;
                  end;
               end loop;
               Count := Count + 1;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Count = 72, "float fixture coverage");
   end Float_Replay;

   --  Given integer seeds, when srand and rand repeat, then every binary64
   --  output repeats exactly; the first sequence also has exact MPU vectors.
   procedure Output_Properties is
      G, H : Generator;
      Seed_Value, A, B : U64;
      X, Y : Long_Float;
      Raised : Boolean;
      Empty : Byte_Array (1 .. 0);
      First, Second : Byte_Array (17 .. 1040);
      type Float_Array is array (Positive range <>) of Long_Float;
      --  csprng.c drand64 binary64 results for seed 15, independently
      --  computed from the committed irand64_seq words using Python float.
      Exact : constant Float_Array :=
        [16#1.0c2daa914cd66# * 2.0 ** (-5),
         16#1.b394e4d70b006# * 2.0 ** (-3),
         16#1.8ab77465f450a# * 2.0 ** (-3),
         16#1.a80407613fb13# * 2.0 ** (-3),
         16#1.0977e5e6509cc# * 2.0 ** (-1),
         16#1.f573b238b9689# * 2.0 ** (-2),
         16#1.efbfe7067c85f# * 2.0 ** (-1),
         16#1.812af525fce80# * 2.0 ** (-1),
         16#1.5af4fd8f12ada# * 2.0 ** (-3),
         16#1.46a6acfef6bb2# * 2.0 ** (-2),
         16#1.12cc3d3798458# * 2.0 ** (-1),
         16#1.397ca08a5939f# * 2.0 ** (-3),
         16#1.f03afafcab823# * 2.0 ** (-1),
         16#1.c40d9a2c5d675# * 2.0 ** (-2),
         16#1.3adaf4d4c9fc3# * 2.0 ** (-2),
         16#1.58a0e392bb1fb# * 2.0 ** (-1),
         16#1.18f9fca8968c7# * 2.0 ** (-4),
         16#1.1beb62628a4f6# * 2.0 ** (-3),
         16#1.2ffffc1e8ef2b# * 2.0 ** (-1),
         16#1.54e0c511544f2# * 2.0 ** (-2)];
   begin
      for Draw in 1 .. 4 loop
         Raised := False;
         begin
            case Draw is
               when 1 => Irand32 (G, A);
               when 2 => Irand64 (G, A);
               when 3 => Drand (G, X);
               when others => Rand (G, X);
            end case;
         exception
            when Ada.Assertions.Assertion_Error => Raised := True;
         end;
         AUnit.Assertions.Assert (Raised, "unseeded output accepted");
      end loop;
      Srand (G, 15, Seed_Value);
      AUnit.Assertions.Assert (Seed_Value = 15, "srand seed return");
      for Want of Exact loop
         Drand (G, X);
         AUnit.Assertions.Assert (X = Want, "exact binary64 seed 15");
      end loop;
      for Seed of U64_Array'[0, 1, 2, 2 ** 32 - 1, 2 ** 32,
        2 ** 32 + 1, 2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last]
      loop
         Srand (G, Seed, Seed_Value);
         Srand (H, Seed, A);
         AUnit.Assertions.Assert (Seed_Value = Seed and then A = Seed,
           "srand native boundary return");
         for I in 1 .. 300 loop
            Rand (G, X);
            Rand (H, Y);
            AUnit.Assertions.Assert (X = Y and then X >= 0.0 and then X < 1.0,
              "srand/rand repeat across buffer boundary");
         end loop;
      end loop;
      Srand (G, 42, Seed_Value);
      Irand32 (G, A);
      AUnit.Assertions.Assert (A = 445_265_827, "srand 42 fixture");
      Srand (G, 15, Seed_Value);
      Csrand (H, Decode ("0f000000"));
      for Scale of Float_Array'[0.0, 1.0, 10.0, -10.0] loop
         Rand (G, X, Scale);
         Drand (H, Y, Scale);
         AUnit.Assertions.Assert (X = Y, "rand/drand aliases");
      end loop;
      Entropy_Bytes (Empty);
      for Size of Natural_Array'[1, 2, 255, 256, 257, 1025] loop
         declare
            Data : Byte_Array (0 .. Size + 1) := [others => 165];
         begin
            Entropy_Bytes (Data (1 .. Size));
            AUnit.Assertions.Assert
              (Data'Length = Size + 2 and then
               Data (0) = 165 and then Data (Size + 1) = 165,
               "entropy requested length and slice bounds");
         end;
      end loop;
      Entropy_Bytes (First);
      Entropy_Bytes (Second);
      AUnit.Assertions.Assert (First /= Second, "independent OS entropy");
      Srand (G, Seed_Value);
      Srand (H, Seed_Value, A);
      Irand64 (G, A);
      Irand64 (H, B);
      AUnit.Assertions.Assert (A = B, "OS srand returns reusable seed");
   end Output_Properties;

   --  Given random.tsv and a seeded generator, replay every native row.
   procedure Prime_Replay is
      use Math_Prime_Util.Random_Primes;
      Count : Natural := 0;
   begin
      for C of Load ("random") loop
         declare
            F : constant String := To_String (C.Func);
            G : Generator;
            A, B, V : U64 := 0;
            R : Math_Prime_Util.Int.Optional_U64;
            Actual : Unbounded_String;
            Fits : Boolean := True;
            function Arg (I : Positive) return String is
              (To_String (C.Args (I)));
         begin
            if F in "random_prime" | "random_prime_seq" |
              "random_nbit_prime" | "random_nbit_prime_seq" |
              "random_ndigit_prime" | "random_safe_prime" |
              "random_semiprime" | "random_semiprime_seq" |
              "random_unrestricted_semiprime"
            then
               --  Typed_Arguments: Perl undef, negative and nonnumeric bounds
               --  have no U64 representation; test Ada contracts separately.
               Fits := Parse_U64 (Arg (2), A);
               if F in "random_prime" | "random_prime_seq" then
                  if Natural (C.Args.Length) = 3 then
                     Fits := Parse_U64 (Arg (3), B) and then Fits;
                  else
                     B := A;
                     A := 2;
                  end if;
               elsif F = "random_ndigit_prime" then
                  --  Bigint_Digits: 20..30 digits use the Perl bigint path.
                  Fits := Fits and then A <= 19;
               else
                  --  Bigint_Bits: 65..128-bit primes and semiprimes belong
                  --  to PLAN phase 9. random_strong_prime starts at 128 bits
                  --  and has no native entry point, so its rows are deferred.
                  Fits := Fits and then A <= 64;
               end if;
               if Fits then
                  Csrand (G, Decode (Arg (1)));
                  begin
                     for I in 1 .. (if F = "random_semiprime_seq" then 10
                       elsif F in "random_prime_seq" | "random_nbit_prime_seq"
                         then 20 else 1)
                     loop
                        if F in "random_prime" | "random_prime_seq" then
                           Random_Prime (G, A, B, R);
                           if R.Defined then
                              V := R.Value;
                           else
                              Actual := To_Unbounded_String ("undef");
                              exit;
                           end if;
                        elsif F in "random_nbit_prime" |
                          "random_nbit_prime_seq"
                        then
                           Random_Nbit_Prime (G, Natural (A), V);
                        elsif F = "random_ndigit_prime" then
                           Random_Ndigit_Prime (G, Natural (A), V);
                        elsif F = "random_safe_prime" then
                           Random_Safe_Prime (G, Natural (A), V);
                        elsif F in "random_semiprime" | "random_semiprime_seq"
                        then
                           Random_Semiprime (G, Natural (A), V);
                        else
                           Random_Unrestricted_Semiprime (G, Natural (A), V);
                        end if;
                        Append (Actual,
                          (if Length (Actual) > 0 then " " else "") &
                          Image (V));
                     end loop;
                  exception
                     when Ada.Assertions.Assertion_Error =>
                        AUnit.Assertions.Assert (C.Error,
                          "unexpected prime contract error: " & F);
                        Actual := C.Result;
                  end;
                  Count := Count + 1;
                  AUnit.Assertions.Assert (Actual = C.Result,
                    F & " line" & Positive'Image (C.Line_Number) &
                    " actual " & To_String (Actual) &
                    " expected " & To_String (C.Result));
               end if;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Count = 1_420, "prime fixture coverage");
   end Prime_Replay;

   procedure Prime_Properties is
      use Math_Prime_Util.Random_Primes;
      G, H : Generator;
      Seed : constant Byte_Array (0 .. 39) := [others => 0];
      A, B : U64;
      C : Prime_Certificate;
      R : Math_Prime_Util.Int.Optional_U64;
      Raised : Boolean;
   begin
      Csrand (G, Seed);
      for Bits in 2 .. 64 loop
         Csrand (G, Seed);
         Csrand (H, Seed);
         Random_Maurer_Prime (G, Bits, A);
         Random_Nbit_Prime (H, Bits, B);
         AUnit.Assertions.Assert (A = B, "native Maurer seed 0");
         Csrand (G, Seed);
         Random_Proven_Prime (G, Bits, A);
         AUnit.Assertions.Assert (A = B, "native proven seed 0");
         Csrand (G, Seed);
         Random_Shawe_Taylor_Prime (G, Bits, A);
         AUnit.Assertions.Assert (A = B, "native Shawe-Taylor seed 0");
         Random_Maurer_Prime_With_Cert (G, Bits, A, C);
         AUnit.Assertions.Assert (C.N = A and then Verify_Certificate (C),
           "Maurer certificate seed 0");
         Random_Proven_Prime_With_Cert (G, Bits, A, C);
         AUnit.Assertions.Assert (C.N = A and then Verify_Certificate (C),
           "proven certificate seed 0");
         Random_Shawe_Taylor_Prime_With_Cert (G, Bits, A, C);
         AUnit.Assertions.Assert (C.N = A and then Verify_Certificate (C)
           and then A >= 2 ** (Bits - 1)
           and then (if Bits < 64 then A < 2 ** Bits),
           "Shawe-Taylor certificate seed 0 bits" & Natural'Image (Bits));
         if Bits >= 4 then
            Random_Semiprime (G, Bits, A);
            AUnit.Assertions.Assert
              (Math_Prime_Util.Factor.Factor (A).Count = 2,
              "balanced semiprime seed 0");
         end if;
      end loop;
      --  Independent Python hashlib SHA-256 plus integer Pocklington
      --  calculation, starting from the ChaCha20 zero-key first block.
      declare
         Bits : constant Natural_Array := [2, 3, 16, 32, 33, 48, 63, 64];
         Expected : constant U64_Array :=
           [3, 5, 61_153, 3_212_153_221, 7_674_027_583,
            166_985_117_868_383, 8_565_169_370_267_104_537,
            13_176_855_219_435_377_117];
      begin
         for I in Bits'Range loop
            Csrand (G, Seed);
            Random_Shawe_Taylor_Prime_With_Cert (G, Bits (I), A, C);
            AUnit.Assertions.Assert (A = Expected (I),
              "independent Shawe-Taylor vector bits" &
              Natural'Image (Bits (I)));
         end loop;
      end;
      for N of U64_Array'[0, 1, 4, 9, U64'Last] loop
         AUnit.Assertions.Assert (not Verify_Certificate ((N => N)),
           "composite certificate accepted");
      end loop;
      Random_Prime (G, U64'Last, U64'Last, R);
      AUnit.Assertions.Assert (not R.Defined, "empty upper interval");
      for N of U64_Array'[2 ** 32 - 1, 2 ** 32 + 1,
        2 ** 63 - 1, 2 ** 63 + 1]
      loop
         Random_Prime (G, N, N + 256, R);
         AUnit.Assertions.Assert (R.Defined and then
           Math_Prime_Util.Primality.Is_Prime (R.Value) = 2,
           "boundary interval");
      end loop;
      for Bits of Natural_Array'[0, 1, 65, 128] loop
         Raised := False;
         begin
            Random_Nbit_Prime (G, Bits, A);
         exception
            when Ada.Assertions.Assertion_Error => Raised := True;
         end;
         AUnit.Assertions.Assert (Raised, "invalid prime bit size accepted");
      end loop;
   end Prime_Properties;

   procedure Contracts is
      G, H : Generator;
      A, B : Byte_Array (17 .. 80);
      V : U64;
      Raised : Boolean;
      Empty : Byte_Array (1 .. 0);
   begin
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
      for Size in 0 .. 41 loop
         declare
            Seed : constant Byte_Array (1 .. Size) := [others => 0];
         begin
            Csrand (G, Seed);
            Csrand (H, Seed);
            Random_Bytes (G, Empty);
            Urandomb (G, 0, V);
            Urandomm (G, 1, V);
            Urandomr (G, U64'Last, U64'Last, V);
            Random_Bytes (G, A);
            Random_Bytes (H, B);
            AUnit.Assertions.Assert (A = B, "seed replay mismatch");
            if Size = 40 then
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
   Float_Replay;
   Output_Properties;
   Prime_Replay;
   Prime_Properties;
end Compat_Random;
