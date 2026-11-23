with Interfaces;
with Math_Prime_Util.Count;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Random_Primes with SPARK_Mode => On is
   use type Primality.Prime_Result;
   use type U128;
   function Prime (N : U64) return Boolean is
     (Primality.Is_Prime (N) = 2);

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
         Value := Count.Nth_Prime (Start + Value).Value;
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
     (G : in out Generator; Digits : Natural; Value : out U64)
   is
      Start, Span, Lo, Hi : U64;
   begin
      if Digits <= 3 then
         case Digits is
            when 1 => Start := 1; Span := 4;
            when 2 => Start := 5; Span := 21;
            when others => Start := 26; Span := 143;
         end case;
         Urandomm (G, Span, Value);
         Value := Count.Nth_Prime (Start + Value).Value;
      else
         Lo := 10 ** (Digits - 1) + 1;
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
