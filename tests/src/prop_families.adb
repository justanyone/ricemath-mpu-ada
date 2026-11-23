with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Families;
with Math_Prime_Util.Powers;

package body Prop_Families is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use type U64;
   use Math_Prime_Util.Families;
   use type Lucky_Vectors.Vector;
   type Families_Case is new Test_Case with null record;
   overriding function Name (T : Families_Case)
      return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Families_Case);
   overriding function Name (T : Families_Case)
      return AUnit.Message_String is
   begin
      return AUnit.Format ("Prop_Families seed 20261020");
   end Name;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_020;
      N, V : U64;
      Left, Right : Lucky_Vectors.Vector;
   begin
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 1 + Seed mod 2_000;
         V := Nth_Lucky (N).Value;
         AUnit.Assertions.Assert
           (Is_Lucky (V) and then Lucky_Count (V) = N,
            "count/nth inverse seed 20261020");
         AUnit.Assertions.Assert
           (Lucky_Count_Lower (V) <= N and then N <= Lucky_Count_Upper (V),
            "count bounds seed 20261020");
         AUnit.Assertions.Assert
           (Nth_Lucky_Lower (N).Value <= V and
            V <= Nth_Lucky_Upper (N).Value, "nth bounds seed 20261020");
         Left := Lucky_Numbers (0, N);
         Right := Lucky_Numbers (N + 1, 2 * N);
         Left.Append (Right);
         AUnit.Assertions.Assert
           (Left = Lucky_Numbers (2 * N), "range partition");
      end loop;
      AUnit.Assertions.Assert
        (Lucky_Numbers (9, 1).Is_Empty and then Lucky_Count (0) = 0,
         "reversed and then zero ranges");
      AUnit.Assertions.Assert
        (not Is_Lucky (U64'Last) and then not Is_Lucky (2 ** 63),
         "native boundary prefilters");
      AUnit.Assertions.Assert
        (Nth_Lucky_Approx (U64'Last).Value =
           18_446_744_073_709_551_517, "estimate saturation");
   end Laws;

   procedure Power_Laws (T : in out Test_Case'Class) is
      use Math_Prime_Util.Powers;
      Seed : U64 := 20_261_123;
      N, P, C : U64;
      Count_Prime, Count_Perfect : U64 := 0;
   begin
      for X in U64 range 1 .. 1_000 loop
         if Is_Prime_Power (X) > 0 then
            Count_Prime := Count_Prime + 1;
         end if;
         if Is_Perfect_Power (X) then
            Count_Perfect := Count_Perfect + 1;
         end if;
         AUnit.Assertions.Assert
           (Prime_Power_Count (X) = Count_Prime and then
            Perfect_Power_Count (X) = Count_Perfect,
            "power membership/count seed 20261123" & X'Image);
      end loop;
      for I in 1 .. 64 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 1 + Seed mod 100_000;
         P := Next_Perfect_Power (N).Value;
         C := Perfect_Power_Count (N);
         AUnit.Assertions.Assert
           (P > N and then Is_Perfect_Power (P) and then
            Perfect_Power_Count (P) = C + 1 and then
            Nth_Perfect_Power (C + 1).Value = P,
            "perfect neighbor/nth seed 20261123" & N'Image);
         P := Next_Prime_Power (N).Value;
         C := Prime_Power_Count (N);
         AUnit.Assertions.Assert
           (P > N and then Is_Prime_Power (P) > 0 and then
            Prime_Power_Count (P) = C + 1 and then
            Nth_Prime_Power (C + 1).Value = P,
            "prime neighbor/nth seed 20261123" & N'Image);
      end loop;
      AUnit.Assertions.Assert
        (not Nth_Perfect_Power (4_297_615_582).Defined and then
         not Nth_Perfect_Power_Approx (U64'Last).Defined and then
         not Nth_Prime_Power (0).Defined and then
         not Next_Perfect_Power (U64'Last).Defined and then
         not Next_Prime_Power (U64'Last).Defined and then
         not Prev_Prime_Power (U64 (2)).Defined and then
         not Prev_Perfect_Power (U64 (0)).Defined,
         "power native boundaries");
      AUnit.Assertions.Assert
        (Is_Perfect_Power (U64 (0)) and then
         Is_Perfect_Power (U64 (1)) and then
         Perfect_Power_Count (2 ** 32) = 67_227 and then
         Perfect_Power_Count (U64'Last) = 4_297_615_581,
         "power zero and word boundaries");
   end Power_Laws;

   procedure Concurrent_Calls (T : in out Test_Case'Class) is
      task type Worker is
         entry Check (Success : out Boolean);
      end Worker;
      task body Worker is
         Valid : Boolean := True;
      begin
         for I in 1 .. 3 loop
            Valid := Valid and then Lucky_Count (5_964_377) = 376_288
              and then Nth_Lucky (123_456).Value = 1795453
              and then Is_Lucky (1795453);
         end loop;
         accept Check (Success : out Boolean) do
            Success := Valid;
         end Check;
      end Worker;
      Workers : array (1 .. 4) of Worker;
      Valid : Boolean;
   begin
      for W of Workers loop
         W.Check (Valid);
         AUnit.Assertions.Assert (Valid, "independent repeated sieves");
      end loop;
   end Concurrent_Calls;

   procedure Twin_Semi_Laws (T : in out Test_Case'Class) is
      type U64_Array is array (Positive range <>) of U64;
      Seed : U64 := 20_261_123;
      N, P, Factors, Rest, D : U64;
      Twins, Semis : Family_Vectors.Vector;
      function Trial_Prime (X : U64) return Boolean;
      function Trial_Prime (X : U64) return Boolean is
         Divisor : U64 := 2;
      begin
         if X < 2 then
            return False;
         end if;
         while Divisor <= X / Divisor loop
            if X mod Divisor = 0 then
               return False;
            end if;
            Divisor := Divisor + 1;
         end loop;
         return True;
      end Trial_Prime;
   begin
      --  Given indices around the 190-entry small table, exact nth must
      --  remain the inverse of the count after switching to estimation.
      for Index in U64 range 189 .. 201 loop
         P := Nth_Semiprime (Index).Value;
         AUnit.Assertions.Assert
           (Semiprime_Count (P) = Index
            and then Semiprime_Count (P - 1) = Index - 1,
            "semiprime small-table boundary:" & Index'Image);
      end loop;
      --  Given large singleton ranges, retain squares and reject cubes.
      for Value of U64_Array'[1_009 ** 2, 1_009 ** 3, 2 ** 32,
                              2 ** 63, U64'Last] loop
         AUnit.Assertions.Assert
           (Semi_Primes (Value, Value).Contains (Value) =
              (Value = 1_009 ** 2), "large semiprime membership");
      end loop;
      for I in 1 .. 40 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := Seed mod 400;
         Twins := Twin_Primes (N, N + 100);
         Semis := Semi_Primes (N, N + 100);
         AUnit.Assertions.Assert
           (Twin_Prime_Count (N, N + 100) = U64 (Twins.Length)
            and then Semiprime_Count (N, N + 100) = U64 (Semis.Length),
            "list/count seed 20261123");
         for X in N .. N + 100 loop
            Rest := X;
            Factors := 0;
            D := 2;
            while Rest > 1 and then D <= Rest / D loop
               while Rest mod D = 0 loop
                  Factors := Factors + 1;
                  Rest := Rest / D;
               end loop;
               D := D + 1;
            end loop;
            if Rest > 1 then
               Factors := Factors + 1;
            end if;
            AUnit.Assertions.Assert
              (Semis.Contains (X) = (Factors = 2)
               and then Twins.Contains (X) =
                 (Trial_Prime (X) and then Trial_Prime (X + 2)),
               "independent trial division seed 20261123");
         end loop;
         N := 1 + Seed mod 200;
         P := Nth_Twin_Prime (N).Value;
         AUnit.Assertions.Assert
           (Twin_Prime_Count (P) = N and then
            Twin_Prime_Count (P - 1) = N - 1,
            "twin nth inverse seed 20261123");
         P := Nth_Semiprime (N).Value;
         AUnit.Assertions.Assert
           (Semiprime_Count (P) = N and then
            Semiprime_Count (P - 1) = N - 1,
            "semi nth inverse seed 20261123");
      end loop;
      AUnit.Assertions.Assert
        (Twin_Primes (11, 11).Contains (11)
         and then Semi_Primes (49, 49).Contains (49)
         and then Semi_Primes (8, 8).Is_Empty
         and then Twin_Primes (10, 0).Is_Empty
         and then Semi_Primes (10, 0).Is_Empty
         and then Twin_Prime_Count (10, 0) = 0
         and then Semiprime_Count (10, 0) = 0,
         "inclusive partner, squares, multiplicity and reversed bounds");
      for X of U64_Array'[0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
                 2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last] loop
         AUnit.Assertions.Assert
           (Twin_Prime_Count_Approx (X) <= X
            and then Semiprime_Count_Approx (X) <= X,
            "native approximation boundaries");
      end loop;
      AUnit.Assertions.Assert
        (Twin_Primes (U64'Last - 1, U64'Last).Is_Empty
         and then Semi_Primes (U64'Last - 1, U64'Last).Is_Empty
         and then not Nth_Twin_Prime (U64'Last).Defined
         and then not Nth_Semiprime_Approx (U64'Last).Defined
         and then Nth_Semiprime_Approx (1_701_748_900_850_019_777).Value =
           18_446_744_073_709_551_601,
         "native overflow and maximum semiprime");
   end Twin_Semi_Laws;

   --  Given an empty prefix, listing must never treat the sentinel as prime.
   procedure Twin_Empty_Prefix (T : in out Test_Case'Class) is
   begin
      for High in U64 range 0 .. 2 loop
         AUnit.Assertions.Assert
           (Twin_Primes (High).Is_Empty
            and then Twin_Prime_Count (High) = 0,
            "no twin primes below three:" & High'Image);
      end loop;
      AUnit.Assertions.Assert
        (Twin_Primes (3) = Family_Vectors.To_Vector (3, 1),
         "first twin pair has lower member three");
   end Twin_Empty_Prefix;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
<<<<<<< HEAD
      Registration.Register_Routine (T, Power_Laws'Access, "power laws");
=======
      Registration.Register_Routine
        (T, Twin_Empty_Prefix'Access, "twin empty prefix");
      Registration.Register_Routine
        (T, Twin_Semi_Laws'Access, "twin and semiprime laws");
>>>>>>> origin/dev-mpuada-001
      Registration.Register_Routine (T, Laws'Access, "lucky laws");
      Registration.Register_Routine
        (T, Concurrent_Calls'Access, "concurrent repeated sieves");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Families_Case);
      return Result;
   end Suite;
end Prop_Families;
