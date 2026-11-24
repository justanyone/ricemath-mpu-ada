with AUnit.Assertions;
with AUnit.Test_Cases;
with Math_Prime_Util;
with Math_Prime_Util.Int;
with Math_Prime_Util.Bit_Positions;

package body Compat_Bit_Positions is
   use AUnit.Assertions;
   use AUnit.Test_Cases;
   use Math_Prime_Util;
   use Math_Prime_Util.Bit_Positions;
   use type U64;
   use type Int.Optional_U64;

   type U64_Array is array (Positive range <>) of U64;

   type Bit_Case is new Test_Case with null record;
   overriding function Name (T : Bit_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Bit_Case);
   overriding function Name (T : Bit_Case) return AUnit.Message_String is
     (AUnit.Format ("Compat_Bit_Positions"));

   procedure Set_Bits (T : in out Test_Case'Class) is
      Mask : U64 := 1;
   begin
      --  Given zero/all ones, when setting each position, then preserve
      --  all other bits and report undefined beyond the native width.
      for I in U64 range 0 .. 64 loop
         if I < 64 then
            Assert (Bitset (0, I) = (True, Mask), "set zero" & I'Image);
            Assert (Bitset (U64'Last, I) = (True, U64'Last),
                    "set ones" & I'Image);
            Mask := Mask * 2;
         else
            Assert (not Bitset (0, I).Defined
                    and then not Bitset (U64'Last, I).Defined, "set 64");
         end if;
      end loop;
      Assert (Bitset (8, 1) = (True, 10), "bitset example");
   end Set_Bits;

   procedure Clear_Bits (T : in out Test_Case'Class) is
      Mask : U64 := 1;
   begin
      for I in U64 range 0 .. 64 loop
         Assert (Bitclear (0, I) = 0, "clear zero" & I'Image);
         Assert (Bitclear (U64'Last, I) = U64'Last - Mask,
                 "clear ones" & I'Image);
         Mask := Mask * 2;
      end loop;
   end Clear_Bits;

   procedure Flip_Bits (T : in out Test_Case'Class) is
      Mask : U64 := 1;
   begin
      for I in U64 range 0 .. 64 loop
         if I < 64 then
            Assert (Bitflip (0, I) = (True, Mask), "flip zero" & I'Image);
            Assert (Bitflip (U64'Last, I) = (True, U64'Last - Mask),
                    "flip ones" & I'Image);
            Mask := Mask * 2;
         else
            Assert (not Bitflip (0, I).Defined
                    and then not Bitflip (U64'Last, I).Defined, "flip 64");
         end if;
      end loop;
   end Flip_Bits;

   procedure Test_Bits (T : in out Test_Case'Class) is
   begin
      for I in U64 range 0 .. 64 loop
         Assert (not Bittest (0, I), "test zero" & I'Image);
         Assert (Bittest (U64'Last, I) = (I < 64), "test ones" & I'Image);
      end loop;
   end Test_Bits;

   procedure Scan_Zeros (T : in out Test_Case'Class) is
   begin
      for I in U64 range 0 .. 64 loop
         Assert (Bitscan0 (0, I) = I, "scan zero in zero" & I'Image);
         Assert (Bitscan0 (U64'Last, I) = 64,
                 "scan zero in ones" & I'Image);
      end loop;
      Assert (Bitscan0 (11, 0) = 2, "bitscan0 example");
   end Scan_Zeros;

   procedure Scan_Ones (T : in out Test_Case'Class) is
   begin
      for I in U64 range 0 .. 64 loop
         Assert (not Bitscan1 (0, I).Defined, "scan one in zero" & I'Image);
         if I < 64 then
            Assert (Bitscan1 (U64'Last, I) = (True, I),
                    "scan one in ones" & I'Image);
         else
            Assert (not Bitscan1 (U64'Last, I).Defined, "scan one at 64");
         end if;
      end loop;
      Assert (Bitscan1 (10, 2) = (True, 3), "bitscan1 example");
   end Scan_Ones;

   procedure Mixed_Bits (T : in out Test_Case'Class) is
      Mask : U64 := 1;
      Set_Value, Clear_Value, Scan_Zero, Scan_One : U64;
      Is_Set : Boolean;
   begin
      --  Given each single bit and its complement, when scanning from
      --  every start, then return that bit only if it is still in range.
      for I in U64 range 0 .. 63 loop
         for Start in U64 range 0 .. 64 loop
            Assert (Bitscan0 (not Mask, Start) =
                      (if Start <= I then I else 64),
                    "single zero scan" & I'Image & Start'Image);
            Assert (Bitscan1 (Mask, Start) =
                      (if Start <= I then (True, I) else (Defined => False)),
                    "single one scan" & I'Image & Start'Image);
         end loop;
         Assert (Bitclear (Mask, I) = 0, "clear single bit");
         Assert (Bitflip (Mask, I) = (True, 0), "flip single bit");
         Assert (Bitset (not Mask, I) = (True, U64'Last), "set single zero");
         Mask := Mask * 2;
      end loop;
      for N of U64_Array'(0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
                         2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last,
                         16#5555_5555_5555_5555#,
                         16#AAAA_AAAA_AAAA_AAAA#)
      loop
         --  Use division and addition as an independent oracle for masks.
         Mask := 1;
         for I in U64 range 0 .. 64 loop
            Is_Set := I < 64 and then (N / Mask) mod 2 = 1;
            Assert (Bittest (N, I) = Is_Set,
                    "mixed test" & N'Image & I'Image);
            Clear_Value := (if Is_Set then N - Mask else N);
            Assert (Bitclear (N, I) = Clear_Value,
                    "mixed clear" & N'Image & I'Image);
            if I < 64 then
               Set_Value := (if Is_Set then N else N + Mask);
               Assert (Bitset (N, I) = (True, Set_Value),
                       "mixed set" & N'Image & I'Image);
               Assert (Bitflip (N, I) =
                         (True, (if Is_Set then Clear_Value else Set_Value)),
                       "mixed flip" & N'Image & I'Image);
            else
               Assert (not Bitset (N, I).Defined
                       and then not Bitflip (N, I).Defined,
                       "mixed undefined at 64");
            end if;
            Scan_Zero := I;
            while Scan_Zero < 64
              and then (N / 2 ** Natural (Scan_Zero)) mod 2 = 1
            loop
               Scan_Zero := Scan_Zero + 1;
            end loop;
            Scan_One := I;
            while Scan_One < 64
              and then (N / 2 ** Natural (Scan_One)) mod 2 = 0
            loop
               Scan_One := Scan_One + 1;
            end loop;
            Assert (Bitscan0 (N, I) = Scan_Zero,
                    "mixed zero scan" & N'Image & I'Image);
            Assert (Bitscan1 (N, I) =
                      (if Scan_One < 64 then (True, Scan_One)
                       else (Defined => False)),
                    "mixed one scan" & N'Image & I'Image);
            Mask := Mask * 2;
         end loop;
         for I of U64_Array'(65, 2 ** 32, 2 ** 63, U64'Last) loop
            Assert (not Bitset (N, I).Defined, "large set index");
            Assert (Bitclear (N, I) = N, "large clear index");
            Assert (not Bitflip (N, I).Defined, "large flip index");
            Assert (not Bittest (N, I), "large test index");
            Assert (Bitscan0 (N, I) = I, "large zero scan start");
            Assert (not Bitscan1 (N, I).Defined, "large one scan start");
         end loop;
      end loop;
   end Mixed_Bits;

   overriding procedure Register_Tests (T : in out Bit_Case) is
   begin
      Registration.Register_Routine (T, Set_Bits'Access, "bitset");
      Registration.Register_Routine (T, Clear_Bits'Access, "bitclear");
      Registration.Register_Routine (T, Flip_Bits'Access, "bitflip");
      Registration.Register_Routine (T, Test_Bits'Access, "bittest");
      Registration.Register_Routine (T, Scan_Zeros'Access, "bitscan0");
      Registration.Register_Routine (T, Scan_Ones'Access, "bitscan1");
      Registration.Register_Routine (T, Mixed_Bits'Access, "mixed bits");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Bit_Case);
      return Result;
   end Suite;
end Compat_Bit_Positions;
