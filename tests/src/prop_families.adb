with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util.Families;

package body Prop_Families is
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use type U64;
   use type U128;
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

   --  Given seeded small ranges, compare with independent trial division.
   procedure Power_Laws (T : in out Test_Case'Class) is
      type U64_Array is array (Positive range <>) of U64;
      Seed : U64 := 20_261_123;
      N, Rest, D, E, Part, Kernel, Powerful, Free : U64;
      Powerful_Sum, Free_Sum, Part_Sum : U128;
      Is_Full, Is_Free : Boolean;
   begin
      for K in U64 range 0 .. 5 loop
         Powerful := 0;
         Free := 0;
         Powerful_Sum := 0;
         Free_Sum := 0;
         Part_Sum := 0;
         for X in U64 range 1 .. 180 loop
            Rest := X;
            D := 2;
            Part := 1;
            Kernel := 1;
            Is_Full := True;
            Is_Free := True;
            while Rest > 1 loop
               E := 0;
               while Rest mod D = 0 loop
                  E := E + 1;
                  Rest := Rest / D;
               end loop;
               if E > 0 then
                  Kernel := Kernel * D;
                  Is_Full := Is_Full and then E >= K;
                  Is_Free := Is_Free and then E < K;
                  if K >= 2 then
                     Part := Part * D ** Natural (E mod K);
                  else
                     Part := 0;
                  end if;
               end if;
               D := D + 1;
            end loop;
            if Is_Full then
               Powerful := Powerful + 1;
               Powerful_Sum := Powerful_Sum + U128 (X);
            end if;
            if Is_Free then
               Free := Free + 1;
               Free_Sum := Free_Sum + U128 (X);
            end if;
            Part_Sum := Part_Sum + U128 (Part);
            AUnit.Assertions.Assert
              (Is_Powerful (X, K) = Is_Full
               and then Is_Powerfree (X, K) = Is_Free
               and then Powerful_Count (X, K) = Powerful
               and then Powerfree_Count (X, K) = Free
               and then Powerfree_Sum (X, K) = Free_Sum
               and then Powerfree_Part (X, K) = Part
               and then Powerfree_Part_Sum (X, K) = Part_Sum
               and then Squarefree_Kernel (X) = Kernel,
               "independent powers K=" & K'Image & " X=" & X'Image);
            if K > 0 then
               AUnit.Assertions.Assert
                 (Sumpowerful (X, K) = Powerful_Sum,
                  "independent powerful sum");
            end if;
         end loop;
      end loop;
      for K in U64 range 2 .. 5 loop
         for I in 1 .. 16 loop
            Seed := Seed * 6_364_136_223_846_793_005 + 1;
            N := 1 + Seed mod 100;
            D := Nth_Powerful (N, K).Value;
            E := Nth_Powerfree (N, K).Value;
            AUnit.Assertions.Assert
              (Is_Powerful (D, K) and then Powerful_Count (D, K) = N
               and then Powerful_Count (D - 1, K) = N - 1
               and then Is_Powerfree (E, K)
               and then Powerfree_Count (E, K) = N
               and then Powerfree_Count (E - 1, K) = N - 1,
               "power nth/count seed 20261123");
         end loop;
         AUnit.Assertions.Assert
           (U64 (Powerful_Numbers (1, 1_000, K).Length) =
              Powerful_Count (1_000, K), "power list/count");
      end loop;
      AUnit.Assertions.Assert
        (not Is_Powerful (0) and then not Is_Powerfree (0), "zero");
      for X of U64_Array'[0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
                            2 ** 63 - 1, 2 ** 63 + 1, U64'Last] loop
         AUnit.Assertions.Assert
           (Is_Powerful (X, 64) = (X = 1)
            and then Is_Powerfree (X, 64) = (X /= 0)
            and then Powerfree_Part (X, 64) = X
            and then Powerfree_Count (X, 64) = X
            and then Powerful_Count (X, 64) = (if X = 0 then 0 else 1)
            and then Sumpowerful (X, 64) = (if X = 0 then 0 else 1)
            and then Powerfree_Sum (X, 64) = U128 (X) * (U128 (X) + 1) / 2,
            "native power boundaries");
      end loop;
      AUnit.Assertions.Assert
        (not Nth_Powerful (0).Defined
         and then not Nth_Powerfree (0).Defined
         and then not Nth_Powerfree (3, 1).Defined
         and then not Nth_Powerful (2, 64).Defined
         and then Powerful_Numbers (10, 1).Is_Empty
         and then Powerful_Numbers (0, 0).Is_Empty
         and then Sumpowerful (100, 0) = Sumpowerful (100, 1)
         and then Powerful_Numbers (1_000) = Powerful_Numbers (1, 1_000, 2)
         and then Is_Powerful (2 ** 32, 32)
         and then not Is_Powerful (2 ** 32, 33)
         and then Is_Powerful (2 ** 63, 63)
         and then not Is_Powerfree (2 ** 63, 63)
         and then Powerfree_Part (2 ** 63, 3) = 1,
         "empty ranges and undefined indices");
   end Power_Laws;

   overriding procedure Register_Tests (T : in out Families_Case) is
   begin
      Registration.Register_Routine
        (T, Power_Laws'Access, "powerful and powerfree laws");
      Registration.Register_Routine
        (T, Twin_Empty_Prefix'Access, "twin empty prefix");
      Registration.Register_Routine
        (T, Twin_Semi_Laws'Access, "twin and semiprime laws");
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
