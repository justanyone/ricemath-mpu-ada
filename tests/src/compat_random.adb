with AUnit.Assertions;
with Ada.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Interfaces;
with Math_Prime_Util.Random;

package body Compat_Random is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Random;
   use type U64;
   use type Interfaces.Unsigned_8;
   use type Interfaces.Unsigned_32;
   type Random_Case is new Test_Case with null record;
   overriding function Name (T : Random_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Random_Case);

   function Image (V : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (V), Ada.Strings.Both));

   function Decode (Hex : String) return String is
      Result : String (1 .. Hex'Length / 2);
   begin
      for I in Result'Range loop
         Result (I) := Character'Val (Natural'Value
           ("16#" & Hex (Hex'First + 2 * I - 2 ..
                        Hex'First + 2 * I - 1) & "#"));
      end loop;
      return Result;
   end Decode;

   function Encode (Data : String) return String is
      Hex : constant String := "0123456789abcdef";
      Result : String (1 .. 2 * Data'Length);
      J : Natural := 0;
   begin
      for Ch of Data loop
         Result (2 * J + 1) := Hex (Character'Pos (Ch) / 16 + 1);
         Result (2 * J + 2) := Hex (Character'Pos (Ch) mod 16 + 1);
         J := J + 1;
      end loop;
      return Result;
   end Encode;

   procedure Check_Real (Actual : Long_Float; Expected : String) is
      Value : constant Long_Float := Long_Float'Value (Expected);
   begin
      AUnit.Assertions.Assert
        (abs (Actual - Value) <= 6.0E-15 * Long_Float'Max (1.0, abs Value),
         "real expected " & Expected & " got " & Long_Float'Image (Actual));
   end Check_Real;

   procedure Replay (Family : String) is
      Cases : constant Case_Vectors.Vector := Load ("random");
      Count : Natural := 0;
      Dummy : Unbounded_String;
      Value, Bound, Low, High : U64;
      Raised : Boolean;
      Plain : constant String := Decode
        ("4e6f772049e280996d206e6f7420676f6e6e61206d616b652061206c6f74" &
         "206f66206578747261766167616e7420636c61696d7320666f7220746869" &
         "73206c6974746c65206d616368696e652e20537572652c206974e280996c" &
         "6c206368616e676520796f75722077686f6c65206c69666520666f722074" &
         "6865206265747465722c206275742074686174e280997320616c6c2e");
   begin
      for C of Cases loop
         declare
            F : constant String := To_String (C.Func);
            Expected : constant String := To_String (C.Result);
            Selected : constant Boolean :=
              (if Family = "random_bytes" then
                 F = "random_bytes" or else F = "random_bytes_seq" or else
                 F = "random_bytes_len_tail" or else
                 F = "srand15_random_bytes4" or else
                 F = "blake_random_bytes7" or else
                 Ada.Strings.Fixed.Index (F, "cipher_") = 1
               elsif Family = "irand" then
                 F = "irand" or else F = "irand_seq" or else
                 F = "blake_irand" or else F = "blake_irand_after7" or else
                 F = "srand42_irand"
               elsif Family = "urandomb" then
                 F = "urandomb" or else F = "mixed_seq"
               elsif Family = "rand" then
                 F = "rand" or else F = "tag_irand_irand32_rand"
               elsif Family = "irand64" then
                 F = "irand64" or else F = "irand64_seq" or else
                 F = "irand64_after_bytes" or else F = "tag_irand64" or else
                 F = "tag_irand_irand64"
               elsif Family = "drand" then
                 F = "drand" or else F = "drand_seq" or else
                 F = "blake_drand_after_irand"
               else F = Family or else F = Family & "_seq" or else
                 F = Family & "_after_bytes");
         begin
            if Selected then
               Csrand (Decode (To_String (C.Args (1))));
               Count := Count + 1;
               if F = "mixed_seq" then
                  Dummy := To_Unbounded_String (Image (U64 (Irand32)));
                  Append (Dummy, " " & Image (Irand64));
                  Append (Dummy, " " & Encode (Random_Bytes (3)));
                  Append (Dummy, " " & Image (U64 (Irand32)));
                  Append (Dummy, " " & Image (Urandomb (5)));
                  Append (Dummy, " " & Image (Urandomm (2 ** 32)));
                  AUnit.Assertions.Assert
                    (To_String (Dummy) = Expected, "mixed_seq " & Expected);
               elsif F = "tag_irand_irand32_rand" then
                  declare
                     A : constant String := Image (U64 (Irand));
                     B : constant String := Image (U64 (Irand32));
                     Prefix : constant String := A & " " & B & " ";
                  begin
                     AUnit.Assertions.Assert
                       (Expected (1 .. Prefix'Length) = Prefix, F);
                     Check_Real
                       (Rand, Expected (Prefix'Length + 1 .. Expected'Last));
                  end;
               elsif F = "blake_drand_after_irand" then
                  Value := U64 (Irand);
                  Check_Real (Drand, Expected);
               elsif C.Undef and then F = "urandomr" then
                  Raised := False;
                  begin
                     Value := Urandomr
                       (U64'Value (To_String (C.Args (2))),
                        U64'Value (To_String (C.Args (3))));
                  exception
                     when Constraint_Error | Ada.Assertions.Assertion_Error =>
                        Raised := True;
                  end;
                  AUnit.Assertions.Assert (Raised, "reversed bounds rejected");
               elsif C.Error and then F = "urandomm" then
                  Raised := False;
                  begin
                     Value := Urandomm (0);
                  exception
                     when Constraint_Error | Ada.Assertions.Assertion_Error =>
                        Raised := True;
                  end;
                  AUnit.Assertions.Assert (Raised, "zero modulus rejected");
               elsif F = "urandomb" then
                  --  Bigint_Urandomb: the Perl bigint wrapper exceeds U64.
                  if Natural'Value (To_String (C.Args (2))) <= 64 then
                     Value := Urandomb
                       (Natural'Value (To_String (C.Args (2))));
                     AUnit.Assertions.Assert
                       (Image (Value) = Expected, F & Expected);
                  end if;
               elsif F = "urandomm" or else F = "urandomm_seq" then
                  --  Bigint_Urandomm: bounds above U64 need the bigint tier.
                  if Parse_U64 (To_String (C.Args (2)), Bound) then
                     if F = "urandomm" then
                        AUnit.Assertions.Assert
                          (Image (Urandomm (Bound)) = Expected, F & Expected);
                     else
                        declare
                           Tokens : constant String_Vectors.Vector :=
                             C.Args;
                        begin
                           Dummy := To_Unbounded_String (Image
                             (Urandomm (U64'Value (To_String (Tokens (2))))));
                           for I in 2 .. 20 loop
                              Append (Dummy, " " & Image (Urandomm (Bound)));
                           end loop;
                           AUnit.Assertions.Assert
                             (To_String (Dummy) = Expected, F);
                        end;
                     end if;
                  end if;
               elsif F = "urandomr" then
                  --  Signed_And_Bigint_Ranges require a separate API tier.
                  if Parse_U64 (To_String (C.Args (2)), Low) and then
                    Parse_U64 (To_String (C.Args (3)), High) and then
                    Low <= High
                  then
                     AUnit.Assertions.Assert
                       (Image (Urandomr (Low, High)) = Expected, F & Expected);
                  end if;
               elsif F = "drand" or else F = "rand" then
                  Check_Real
                    ((if F = "rand" then Rand else Drand
                      ((if Natural (C.Args.Length) = 1 then 1.0 else
                        Long_Float'Value (To_String (C.Args (2)))))),
                     Expected);
               elsif F = "drand_seq" then
                  declare
                     Start : Positive := Expected'First;
                     Stop : Natural;
                  begin
                     while Start <= Expected'Last loop
                        Stop := Ada.Strings.Fixed.Index
                          (Expected, " ", Start);
                        if Stop = 0 then
                           Stop := Expected'Last + 1;
                        end if;
                        Check_Real (Drand, Expected (Start .. Stop - 1));
                        Start := Stop + 1;
                     end loop;
                  end;
               elsif Family = "random_bytes" then
                  if Ada.Strings.Fixed.Index (F, "cipher_") = 1 then
                     declare
                        Data : String := Random_Bytes (Plain'Length);
                     begin
                        for I in Data'Range loop
                           Data (I) := Character'Val
                             (Interfaces.Unsigned_8 (Character'Pos (Data (I)))
                              xor Interfaces.Unsigned_8
                                (Character'Pos (Plain (I))));
                        end loop;
                        if F (F'Last) = 'L' then
                           Value := 0;
                           for I in 1 .. 4 loop
                              Value := Value + U64 (Character'Pos (Data (I)))
                                * 2 ** (8 * (I - 1));
                           end loop;
                           AUnit.Assertions.Assert
                             (Image (Value) = Expected, F);
                        else
                           AUnit.Assertions.Assert
                             (Encode (Data) = Expected, F);
                        end if;
                     end;
                  elsif F = "random_bytes_len_tail" then
                     Dummy := To_Unbounded_String (Random_Bytes
                       (Natural'Value (To_String (C.Args (2)))));
                     AUnit.Assertions.Assert
                       (Encode (Random_Bytes (8)) = Expected, F);
                  else
                     AUnit.Assertions.Assert
                       (Encode (Random_Bytes
                         (Natural'Value (To_String (C.Args (2))))) =
                        Expected, F & " row" & C.Line_Number'Image);
                  end if;
               else
                  if Ada.Strings.Fixed.Index (F, "_after_bytes") > 0 then
                     Dummy := To_Unbounded_String (Random_Bytes
                       (Natural'Value (To_String (C.Args (2)))));
                  elsif F = "tag_irand_irand64" then
                     Value := U64 (Irand);
                  elsif F = "blake_irand_after7" then
                     Dummy := To_Unbounded_String (Random_Bytes (7));
                  end if;
                  Dummy := Null_Unbounded_String;
                  for I in 1 .. (if Ada.Strings.Fixed.Index (F, "_seq") > 0
                                 then 20 else 1)
                  loop
                     Value := (if Family = "irand64" then Irand64
                               elsif Family = "irand32" then U64 (Irand32)
                               else U64 (Irand));
                     if I > 1 then
                        Append (Dummy, " ");
                     end if;
                     Append (Dummy, Image (Value));
                  end loop;
                  AUnit.Assertions.Assert
                    (To_String (Dummy) = Expected, F & " row" &
                     C.Line_Number'Image);
               end if;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Count > 0, "missing " & Family);
   end Replay;

   procedure Test_Csrand (T : in out Test_Case'Class);
   procedure Test_Csrand (T : in out Test_Case'Class) is
      A, B : Unbounded_String;
   begin
      Csrand;
      Csrand ("repeat seed");
      A := To_Unbounded_String (Random_Bytes (128));
      Csrand ("repeat seed");
      B := To_Unbounded_String (Random_Bytes (128));
      AUnit.Assertions.Assert (A = B, "reseed repeats");
   end Test_Csrand;

   procedure Test_Srand (T : in out Test_Case'Class);
   procedure Test_Srand (T : in out Test_Case'Class) is
   begin
      Srand (42);
      AUnit.Assertions.Assert (Irand = 445_265_827, "srand 42");
   end Test_Srand;

   procedure Test_Rand (T : in out Test_Case'Class);
   procedure Test_Rand (T : in out Test_Case'Class) is
   begin
      Replay ("rand");
   end Test_Rand;

   procedure Test_Irand (T : in out Test_Case'Class);
   procedure Test_Irand (T : in out Test_Case'Class) is
   begin
      Replay ("irand");
   end Test_Irand;

   procedure Test_Irand32 (T : in out Test_Case'Class);
   procedure Test_Irand32 (T : in out Test_Case'Class) is
   begin
      Replay ("irand32");
   end Test_Irand32;

   procedure Test_Irand64 (T : in out Test_Case'Class);
   procedure Test_Irand64 (T : in out Test_Case'Class) is
   begin
      Replay ("irand64");
   end Test_Irand64;

   procedure Test_Drand (T : in out Test_Case'Class);
   procedure Test_Drand (T : in out Test_Case'Class) is
   begin
      Replay ("drand");
   end Test_Drand;

   procedure Test_Random_Bytes (T : in out Test_Case'Class);
   procedure Test_Random_Bytes (T : in out Test_Case'Class) is
   begin
      Replay ("random_bytes");
   end Test_Random_Bytes;

   procedure Test_Entropy_Bytes (T : in out Test_Case'Class);
   procedure Test_Entropy_Bytes (T : in out Test_Case'Class) is
   begin
      AUnit.Assertions.Assert
        (Entropy_Bytes (0)'Length = 0 and then
         Entropy_Bytes (40)'Length = 40, "entropy lengths");
   end Test_Entropy_Bytes;

   procedure Test_Urandomb (T : in out Test_Case'Class);
   procedure Test_Urandomb (T : in out Test_Case'Class) is
   begin
      Replay ("urandomb");
   end Test_Urandomb;

   procedure Test_Urandomm (T : in out Test_Case'Class);
   procedure Test_Urandomm (T : in out Test_Case'Class) is
   begin
      Replay ("urandomm");
   end Test_Urandomm;

   procedure Test_Urandomr (T : in out Test_Case'Class);
   procedure Test_Urandomr (T : in out Test_Case'Class) is
   begin
      Replay ("urandomr");
   end Test_Urandomr;

   overriding function Name (T : Random_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Random");
   end Name;

   overriding procedure Register_Tests (T : in out Random_Case) is
   begin
      Registration.Register_Routine
        (T, Test_Csrand'Access, "csrand");
      Registration.Register_Routine
        (T, Test_Srand'Access, "srand");
      Registration.Register_Routine
        (T, Test_Rand'Access, "rand");
      Registration.Register_Routine
        (T, Test_Irand'Access, "irand");
      Registration.Register_Routine
        (T, Test_Irand32'Access, "irand32");
      Registration.Register_Routine
        (T, Test_Irand64'Access, "irand64");
      Registration.Register_Routine
        (T, Test_Drand'Access, "drand");
      Registration.Register_Routine
        (T, Test_Random_Bytes'Access, "random_bytes");
      Registration.Register_Routine
        (T, Test_Entropy_Bytes'Access, "entropy_bytes");
      Registration.Register_Routine
        (T, Test_Urandomb'Access, "urandomb");
      Registration.Register_Routine
        (T, Test_Urandomm'Access, "urandomm");
      Registration.Register_Routine
        (T, Test_Urandomr'Access, "urandomr");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Random_Case);
      return Result;
   end Suite;
end Compat_Random;
