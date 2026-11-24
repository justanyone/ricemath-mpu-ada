with Interfaces;
with Math_Prime_Util.Count;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Random_Primes with SPARK_Mode => On is
   use type Primality.Prime_Result;
   use type U128;
   function Prime (N : U64) return Boolean is
     (Primality.Is_Prime (N) = 2);

   procedure Shuffle (G : in out Generator; Values : in out Element_Array) is
      Offset : U64;
      J : Natural;
      V : Element_Type;
   begin
      for I in Values'First .. Values'Last - 1 loop
         Urandomm (G, U64 (Values'Last - I) + 1, Offset);
         J := I + Natural (Offset);
         V := Values (J);
         Values (J) := Values (I);
         Values (I) := V;
      end loop;
   end Shuffle;
   procedure Shuffle_Numbers is new Shuffle (U64, U64_Array);
   procedure Randperm
     (G : in out Generator; N, K : U64; Values : out U64_Array)
   is
      Size : constant Natural := Values'Length;
      J, M : U64;
      Capacity : Positive := 16;
   begin
      if K >= N then
         Values := [for Index in Values'Range => U64 (Index - Values'First)];
         Shuffle_Numbers (G, Values);
      elsif Size > 0 then
         --  util.c: randperm_sparse_fy_hash. A sparse identity map also
         --  implements the small-map and dense FY paths with identical draws.
         while Capacity / 2 < Size loop
            Capacity := Capacity * 2;
         end loop;
         declare
            Keys, Vals : U64_Array (0 .. Capacity - 1) := [others => 0];
            function Slot (Key : U64) return Natural;
            function Slot (Key : U64) return Natural is
               H : Natural := Natural (Key mod U64 (Capacity));
            begin
               while Keys (H) /= 0 and then Keys (H) /= Key + 1 loop
                  H := (H + 1) mod Capacity;
               end loop;
               return H;
            end Slot;
            function Get (Key : U64) return U64 is
              (if Keys (Slot (Key)) = 0 then Key else Vals (Slot (Key)));
            H : Natural;
         begin
            for Index in 0 .. Size - 1 loop
               Urandomm (G, N - U64 (Index), J);
               J := U64 (Index) + J;
               Values (Values'First + Index) := Get (J);
               M := Get (U64 (Index));
               if J /= U64 (Index) then
                  H := Slot (J);
                  Keys (H) := J + 1;
                  Vals (H) := M;
               end if;
            end loop;
         end;
      end if;
   end Randperm;
   procedure Randperm
     (G : in out Generator; N : U64; Values : out U64_Array) is
   begin
      Randperm (G, N, N, Values);
   end Randperm;
   procedure Vecsample
     (G : in out Generator; K : U64; Values : Element_Array;
      Sample : out Element_Array)
   is
      Indices : U64_Array (Sample'Range);
   begin
      Randperm (G, U64 (Values'Length), K, Indices);
      for I in Sample'Range loop
         Sample (I) := Values (Values'First +
           (if Indices (I) = 0 then Values'Length - 1
            else Natural (Indices (I) - 1)));
      end loop;
   end Vecsample;
   procedure Random_Factored_Integer
     (G : in out Generator; N : U64; Value : out U64;
      Factors : out Factor.Factor_List) is
   begin
      if N = 0 then
         Value := 0;
         Factors := (Count => 0, Value => [others => 0]);
      else
         Urandomm (G, N, Value);
         Value := Value + 1;
         Factors := Factor.Factor (Value);
      end if;
   end Random_Factored_Integer;
   procedure Miller_Rabin_Random
     (G : in out Generator; N : U64; K : U64 := 1;
      Value : out Boolean)
   is
      Base : U64;
   begin
      if N < 4 or else K >= 3 * (N / 4) then
         Value := Prime (N);
         return;
      end if;
      Value := False;
      for I in 1 .. K loop
         Urandomm (G, N - 3, Base);
         if not Primality.Is_Strong_Pseudoprime (N, Base + 2) then
            return;
         end if;
      end loop;
      Value := True;
   end Miller_Rabin_Random;
   procedure Random_Strong_Prime
     (G : in out Generator; Bits : Natural; Value : out U64) is
   begin
      Value := 0;
      if Is_Seeded (G) and then Bits >= 128 then
         raise Constraint_Error with "strong primes require the bigint tier";
      end if;
      raise Constraint_Error with "strong primes require at least 128 bits";
   end Random_Strong_Prime;
   --  random_prime.c: random_prime. Tighten bounds before rejection sampling.
   procedure Random_Prime
     (G : in out Generator; Low, High : U64; Value : out Int.Optional_U64)
   is
      Max_Prime : constant U64 := 18_446_744_073_709_551_557;
      Lo, Hi, N : U64;
      Edge : Int.Optional_U64;
   begin
      Value := (Defined => False);
      if Low > High or else High < 2 or else Low > Max_Prime then
         return;
      end if;
      Lo := 2;
      if Low > 2 then
         Edge := Sieve.Next_Prime (Low - 1);
         if not Edge.Defined then
            return;
         end if;
         Lo := Edge.Value;
      end if;
      Hi := Max_Prime;
      if High < Max_Prime then
         Edge := Sieve.Prev_Prime (High + 1);
         Hi := Edge.Value;
      end if;
      if Lo > Hi then
         return;
      end if;
      if Lo = 2 then
         Lo := 1;
      end if;
      loop
         Urandomm (G, (Hi - Lo) / 2 + 1, N);
         N := Lo + 2 * N;
         if N = 1 or else Prime (N) then
            Value := (True, (if N = 1 then 2 else N));
            return;
         end if;
      end loop;
   end Random_Prime;

   procedure Random_Prime
     (G : in out Generator; High : U64; Value : out Int.Optional_U64) is
   begin
      Random_Prime (G, 2, High, Value);
   end Random_Prime;

   --  random_prime.c: random_nbit_prime.
   procedure Random_Nbit_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
   is
      Start, Span : U64;
   begin
      if Bits <= 4 then
         Urandomb (G, 1, Value);
         case Bits is
            when 2 => Value := (if Value = 1 then 2 else 3);
            when 3 => Value := (if Value = 1 then 5 else 7);
            when others => Value := (if Value = 1 then 11 else 13);
         end case;
      elsif Bits <= 9 then
         case Bits is
            when 5 => Start := 7; Span := 5;
            when 6 => Start := 12; Span := 7;
            when 7 => Start := 19; Span := 13;
            when 8 => Start := 32; Span := 23;
            when others => Start := 55; Span := 43;
         end case;
         Urandomm (G, Span, Value);
         Value := Count.Nth_Prime (Start + Value);
      else
         loop
            Urandomb (G, Bits - 2, Value);
            Value := 2 ** (Bits - 1) + 1 + 2 * Value;
            exit when Prime (Value);
         end loop;
      end if;
   end Random_Nbit_Prime;

   --  random_prime.c: random_ndigit_prime.
   procedure Random_Ndigit_Prime
     (G : in out Generator; Digit_Count : Natural; Value : out U64)
   is
      Start, Span, Lo, Hi : U64;
   begin
      if Digit_Count <= 3 then
         case Digit_Count is
            when 1 => Start := 1; Span := 4;
            when 2 => Start := 5; Span := 21;
            when others => Start := 26; Span := 143;
         end case;
         Urandomm (G, Span, Value);
         Value := Count.Nth_Prime (Start + Value);
      else
         Lo := 10 ** (Digit_Count - 1) + 1;
         Hi := 10 * Lo - 11;
         loop
            Urandomm (G, (Hi - Lo) / 2 + 1, Value);
            Value := Lo + 2 * Value;
            exit when Prime (Value);
         end loop;
      end if;
   end Random_Ndigit_Prime;

   --  random_prime.c: random_safe_prime, preserving small tables and mask.
   procedure Random_Safe_Prime
     (G : in out Generator; Bits : Natural; Value : out U64)
   is
      P : U64;
      Mask : constant U64 := 14_079;
   begin
      case Bits is
         when 3 | 6 | 7 =>
            Urandomm (G, 2, P);
            case Bits is
               when 3 => Value := (if P = 0 then 5 else 7);
               when 6 => Value := (if P = 0 then 47 else 59);
               when others => Value := (if P = 0 then 83 else 107);
            end case;
         when 4 => Value := 11;
         when 5 => Value := 23;
         when others =>
            loop
               Urandomb (G, Bits - 3, P);
               P := 2 ** (Bits - 2) + 1 + 2 * P;
               Value := 2 * P + 1;
               exit when (Mask and 2 ** Natural (P mod 15)) = 0
                 and then P mod 7 not in 0 | 3
                 and then Prime (P) and then Prime (Value);
            end loop;
      end case;
   end Random_Safe_Prime;

   --  random_prime.c: random_semiprime.
   procedure Random_Semiprime
     (G : in out Generator; Bits : Natural; Value : out U64)
   is
      Small : constant array (Natural range <>) of U64 :=
        [35, 35, 49, 65, 77, 91, 143, 143, 169, 299, 319, 341, 377, 403];
      P, Q : U64;
   begin
      if Bits <= 5 then
         Value := (if Bits = 4 then 9 else 21);
      elsif Bits <= 9 then
         Urandomm (G, (if Bits = 9 then 5 else 3), P);
         Value := Small (3 * (Bits - 6) + Natural (P));
      else
         loop
            Random_Nbit_Prime (G, Bits / 2, P);
            Random_Nbit_Prime (G, Bits - Bits / 2, Q);
            Value := P * Q;
            exit when Value >= 2 ** (Bits - 1);
         end loop;
      end if;
   end Random_Semiprime;

   --  random_prime.c: random_unrestricted_semiprime.
   procedure Random_Unrestricted_Semiprime
     (G : in out Generator; Bits : Natural; Value : out U64)
   is
      Small : constant array (Natural range <>) of U64 :=
        [4, 6, 9, 10, 14, 15, 21, 22, 25, 26, 33, 34, 35, 38, 39,
         46, 49, 51, 55, 57, 58, 62, 65, 69, 74, 77, 82, 85, 86, 87,
         91, 93, 94, 95, 106, 111, 115, 118, 119, 121, 122, 123];
      Start, Span : Natural;
   begin
      if Bits <= 7 then
         case Bits is
            when 3 => Start := 0; Span := 2;
            when 4 => Start := 2; Span := 4;
            when 5 => Start := 6; Span := 4;
            when 6 => Start := 10; Span := 12;
            when others => Start := 22; Span := 20;
         end case;
         Urandomm (G, U64 (Span), Value);
         Value := Small (Start + Natural (Value));
      else
         loop
            Urandomb (G, Bits - 1, Value);
            Value := 2 ** (Bits - 1) + Value;
            exit when Factor.Factor (Value).Count = 2;
         end loop;
      end if;
   end Random_Unrestricted_Semiprime;

   --  RandomPrimes.pm: random_maurer_prime / random_proven_prime.
   --  MPU uses deterministic native primality through 64 bits.
   procedure Random_Maurer_Prime
     (G : in out Generator; Bits : Natural; Value : out U64) is
   begin
      Random_Nbit_Prime (G, Bits, Value);
   end Random_Maurer_Prime;
   procedure Random_Proven_Prime
     (G : in out Generator; Bits : Natural; Value : out U64) is
   begin
      Random_Nbit_Prime (G, Bits, Value);
   end Random_Proven_Prime;

   subtype Digest is Byte_Array (0 .. 31);
   subtype Seed_Bytes is Byte_Array (0 .. 63);
   --  SHA-256 for fixed 512-bit seeds in RandomPrimes.pm.
   --  Two compression blocks: seed, then the SHA padding and 512-bit length.
   function Hash (Seed : Seed_Bytes) return Digest;
   function Hash (Seed : Seed_Bytes) return Digest is
      use Interfaces;
      K : constant array (Natural range 0 .. 63) of Word :=
        [16#428A2F98#, 16#71374491#, 16#B5C0FBCF#, 16#E9B5DBA5#,
         16#3956C25B#, 16#59F111F1#, 16#923F82A4#, 16#AB1C5ED5#,
         16#D807AA98#, 16#12835B01#, 16#243185BE#, 16#550C7DC3#,
         16#72BE5D74#, 16#80DEB1FE#, 16#9BDC06A7#, 16#C19BF174#,
         16#E49B69C1#, 16#EFBE4786#, 16#0FC19DC6#, 16#240CA1CC#,
         16#2DE92C6F#, 16#4A7484AA#, 16#5CB0A9DC#, 16#76F988DA#,
         16#983E5152#, 16#A831C66D#, 16#B00327C8#, 16#BF597FC7#,
         16#C6E00BF3#, 16#D5A79147#, 16#06CA6351#, 16#14292967#,
         16#27B70A85#, 16#2E1B2138#, 16#4D2C6DFC#, 16#53380D13#,
         16#650A7354#, 16#766A0ABB#, 16#81C2C92E#, 16#92722C85#,
         16#A2BFE8A1#, 16#A81A664B#, 16#C24B8B70#, 16#C76C51A3#,
         16#D192E819#, 16#D6990624#, 16#F40E3585#, 16#106AA070#,
         16#19A4C116#, 16#1E376C08#, 16#2748774C#, 16#34B0BCB5#,
         16#391C0CB3#, 16#4ED8AA4A#, 16#5B9CCA4F#, 16#682E6FF3#,
         16#748F82EE#, 16#78A5636F#, 16#84C87814#, 16#8CC70208#,
         16#90BEFFFA#, 16#A4506CEB#, 16#BEF9A3F7#, 16#C67178F2#];
      type Hash_State is array (Natural range 0 .. 7) of Word;
      H : Hash_State :=
        [16#6A09E667#, 16#BB67AE85#, 16#3C6EF372#, 16#A54FF53A#,
         16#510E527F#, 16#9B05688C#, 16#1F83D9AB#, 16#5BE0CD19#];
      X : Hash_State;
      W : array (Natural range 0 .. 63) of Word;
      S0, S1, T1, T2 : Word;
      Result : Digest;
   begin
      for Block in 0 .. 1 loop
         W := [others => 0];
         if Block = 0 then
            for I in 0 .. 15 loop
               for J in 0 .. 3 loop
                  W (I) := Shift_Left (W (I), 8) or Word (Seed (4 * I + J));
               end loop;
            end loop;
         else
            W (0) := 16#80000000#;
            W (15) := 512;
         end if;
         for I in 16 .. 63 loop
            S0 := Rotate_Right (W (I - 15), 7)
              xor Rotate_Right (W (I - 15), 18)
              xor Shift_Right (W (I - 15), 3);
            S1 := Rotate_Right (W (I - 2), 17)
              xor Rotate_Right (W (I - 2), 19)
              xor Shift_Right (W (I - 2), 10);
            W (I) := W (I - 16) + S0 + W (I - 7) + S1;
         end loop;
         X := H;
         for I in W'Range loop
            S1 := Rotate_Right (X (4), 6) xor Rotate_Right (X (4), 11)
              xor Rotate_Right (X (4), 25);
            T1 := X (7) + S1 + ((X (4) and X (5)) xor
              ((not X (4)) and X (6))) + K (I) + W (I);
            S0 := Rotate_Right (X (0), 2) xor Rotate_Right (X (0), 13)
              xor Rotate_Right (X (0), 22);
            T2 := S0 + ((X (0) and X (1)) xor (X (0) and X (2))
              xor (X (1) and X (2)));
            X := [T1 + T2, X (0), X (1), X (2),
                  X (3) + T1, X (4), X (5), X (6)];
         end loop;
         for I in H'Range loop
            H (I) := H (I) + X (I);
         end loop;
      end loop;
      for I in Result'Range loop
         Result (I) := Byte (Shift_Right (H (I / 4), 24 - 8 * (I mod 4))
           and 255);
      end loop;
      return Result;
   end Hash;

   --  RandomPrimes.pm: _seed_plus_one (big-endian, wrapping at 512 bits).
   procedure Increment (Seed : in out Seed_Bytes);
   procedure Increment (Seed : in out Seed_Bytes) is
   begin
      for I in reverse Seed'Range loop
         Seed (I) := Seed (I) + 1;
         exit when Seed (I) /= 0;
      end loop;
   end Increment;

   function Residue (Data : Digest; Modulus : U64) return U64
     with Pre => Modulus > 0;
   function Residue (Data : Digest; Modulus : U64) return U64 is
      R : U128 := 0;
   begin
      for B of Data loop
         R := (256 * R + U128 (B)) mod U128 (Modulus);
      end loop;
      return U64 (R);
   end Residue;

   --  RandomPrimes.pm: _ST_Random_prime. Native recursion still follows FIPS
   --  seed evolution and the Pocklington witness, including rejected trials.
   procedure Shawe_Taylor
     (Bits : Natural; Seed : in out Seed_Bytes;
      Counter : in out Natural; Value : out U64)
     with Pre => Bits in 2 .. 64;
   procedure Shawe_Taylor
     (Bits : Natural; Seed : in out Seed_Bytes;
      Counter : in out Natural; Value : out U64)
   is
      H, H1 : Digest;
      C0, X, A, Z : U64;
      T, Candidate : U128;
      Old_Counter : Natural;
      Lower : constant U64 := 2 ** (Bits - 1);
   begin
      if Bits <= 32 then
         loop
            H := Hash (Seed);
            Increment (Seed);
            H1 := Hash (Seed);
            Increment (Seed);
            X := 0;
            for I in 28 .. 31 loop
               X := 256 * X + U64 (H (I) xor H1 (I));
            end loop;
            Value := (X mod Lower) or Lower or 1;
            Counter := Counter + 1;
            exit when Prime (Value);
            if Counter > 10_000 + 16 * Bits then
               raise Generation_Error with "Shawe-Taylor retry limit";
            end if;
         end loop;
      else
         Shawe_Taylor ((Bits + 1) / 2 + 1, Seed, Counter, C0);
         Old_Counter := Counter;
         H := Hash (Seed);
         Increment (Seed);
         X := Lower + Residue (H, Lower);
         T := (U128 (X) + 2 * U128 (C0) - 1) / (2 * U128 (C0));
         loop
            Candidate := 2 * T * U128 (C0) + 1;
            if Candidate >= 2 ** Bits then
               T := (U128 (Lower) + 2 * U128 (C0) - 1)
                 / (2 * U128 (C0));
               Candidate := 2 * T * U128 (C0) + 1;
            end if;
            Value := U64 (Candidate);
            Counter := Counter + 1;
            H := Hash (Seed);
            Increment (Seed);
            if Prime (Value) then
               A := 2 + Residue (H, Value - 3);
               Z := Int.Powmod (A, U64 (2 * T), Value).Value;
               if Int.Gcd ((if Z = 0 then Value - 1 else Z - 1), Value) = 1
                 and then Int.Powmod (Z, C0, Value).Value = 1
               then
                  return;
               end if;
            end if;
            if Counter > Old_Counter + 10_000 + 16 * Bits then
               raise Generation_Error with "Shawe-Taylor retry limit";
            end if;
            T := T + 1;
         end loop;
      end if;
   end Shawe_Taylor;

   function Verify_Certificate (Certificate : Prime_Certificate) return Boolean
   is (Prime (Certificate.N));

   procedure Random_Maurer_Prime_With_Cert
     (G : in out Generator; Bits : Natural; Value : out U64;
      Certificate : out Prime_Certificate) is
   begin
      Random_Nbit_Prime (G, Bits, Value);
      Certificate := (N => Value);
   end Random_Maurer_Prime_With_Cert;

   procedure Random_Proven_Prime_With_Cert
     (G : in out Generator; Bits : Natural; Value : out U64;
      Certificate : out Prime_Certificate) is
   begin
      Random_Maurer_Prime_With_Cert (G, Bits, Value, Certificate);
   end Random_Proven_Prime_With_Cert;

   procedure Random_Shawe_Taylor_Prime
     (G : in out Generator; Bits : Natural; Value : out U64) is
   begin
      Random_Nbit_Prime (G, Bits, Value);
   end Random_Shawe_Taylor_Prime;

   procedure Random_Shawe_Taylor_Prime_With_Cert
     (G : in out Generator; Bits : Natural; Value : out U64;
      Certificate : out Prime_Certificate)
   is
      Seed : Seed_Bytes;
      Counter : Natural := 0;
   begin
      Random_Bytes (G, Seed);
      Shawe_Taylor (Bits, Seed, Counter, Value);
      Certificate := (N => Value);
   end Random_Shawe_Taylor_Prime_With_Cert;
end Math_Prime_Util.Random_Primes;
