with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Factor.Classes;
with Math_Prime_Util.Primality;

package body Compat_Factor_Classes is
   use AUnit.Test_Cases;
   use Ada.Strings.Unbounded;
   use Fixture_Support;
   use Math_Prime_Util;
   use Math_Prime_Util.Factor.Classes;
   use type U64;
   use type Primality.Prime_Result;

   type Classes_Case is new Test_Case with null record;
   overriding function Name (T : Classes_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Classes_Case);

   overriding function Name (T : Classes_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Factor_Classes");
   end Name;

   procedure Replay (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("factor"), Func);
      N, K, Expected, Got : U64;
      Native : Boolean;
      Checked : Natural := 0;
   begin
      --  Skipped factor.tsv rows: inputs exceed U64.
      --  1642, 1643, 1644, 1645, 1646, 1818, 1819, 1820, 1821.
      --  1822, 1834, 1835, 1836, 1837, 1838.
      --  Skipped factor.tsv rows: signed inputs are outside U64.
      --  7171, 7172, 7176, 7177, 7181, 7182, 7186, 7187, 7191.
      --  7192, 7196, 7197, 7201, 7202, 7206, 7207, 7211, 7212.
      --  7216, 7217, 7221, 7222, 7226, 7227, 7231, 7232, 7236.
      --  7237, 7241, 7242, 7246, 7247, 7251, 7252, 7256, 7257.
      --  7261, 7262, 7266, 7267, 7271, 7272, 7276, 7277, 7281.
      --  7282, 7286, 7287, 7291, 7292, 7296, 7297, 7301, 7302.
      --  7306, 7307, 7310, 7311, 7312, 7313, 7314, 7315, 7316.
      --  7317, 7318, 7319, 7320, 7321, 7322, 7323, 7324, 7325.
      --  7326, 7327, 7328, 7329, 7351, 7352, 7353, 7354, 7355.
      --  7356, 7357, 7358, 7359, 7360, 21799, 21800, 21803, 21804.
      --  21807, 21808, 21811, 21812, 21815, 21816, 21819, 21820, 21823.
      --  21824, 21827, 21828, 21831, 21832, 21835, 21836, 21839, 21840.
      --  21843, 21844, 21847, 21848, 21851, 21852, 21855, 21856, 21859.
      --  21860, 21863, 21864, 21867, 21868, 21871, 21872, 21875, 21876.
      --  21879, 21880, 21883, 21884, 21887, 21888, 21891, 21892, 21895.
      --  21896, 21899, 21900, 21903, 21904, 21907, 21908, 21911, 21912.
      --  21915, 21916, 21919, 21920, 21923, 21924, 21927, 21928, 21931.
      --  21932, 21935, 21936, 21939, 21940, 21943, 21944, 21947, 21948.
      --  21951, 21952, 21955, 21956, 21959, 21960, 21963, 21964, 21967.
      --  21968, 21971, 21972, 21975, 21976, 21979, 21980, 21983, 21984.
      --  21987, 21988, 21991, 21992, 21995, 21996, 21999, 22000, 22003.
      --  22004, 22007, 22008, 22011, 22012, 22015, 22016, 22019, 22020.
      --  22023, 22024, 22027, 22028, 22031, 22032, 22035, 22036, 22039.
      --  22040, 22043, 22044, 22047, 22048, 22051, 22052, 22055, 22056.
      --  22059, 22060, 22063, 22064, 22067, 22068, 22071, 22072, 22075.
      --  22076, 22079, 22080, 22083, 22084, 22087, 22088, 22091, 22092.
      --  22095, 22096, 22099, 22100, 22103, 22104, 22107, 22108, 22111.
      --  22112, 22115, 22116, 22119, 22120, 22123, 22124, 22127, 22128.
      --  22131, 22132, 22135, 22136, 22139, 22140, 22143, 22144, 22147.
      --  22148, 22151, 22152, 22155, 22156, 22159, 22160, 22163, 22164.
      --  22167, 22168, 22171, 22172, 22175, 22176, 22179, 22180, 22183.
      --  22184, 22187, 22188, 22191, 22192, 22195, 22196, 22199, 22200.
      --  22203, 22204, 22207, 22208, 22211, 22212, 22215, 22216, 22219.
      --  22220, 22223, 22224, 22227, 22228, 22231, 22232, 22235, 22236.
      --  22239, 22240, 22243, 22244, 22247, 22248, 22251, 22252, 22255.
      --  22256, 22259, 22260, 22263, 22264, 22267, 22268, 22271, 22272.
      --  22275, 22276, 22279, 22280, 22283, 22284, 22287, 22288, 22291.
      --  22292, 22295, 22296, 22299, 22300, 22303, 22304, 22307, 22308.
      --  22311, 22312, 22315, 22316, 22319, 22320, 22323, 22324, 22327.
      --  22328, 22331, 22332, 22335, 22336, 22339, 22340, 22343, 22344.
      --  22347, 22348, 22351, 22352, 22355, 22356, 22359, 22360, 22363.
      --  22364, 22367, 22368, 22371, 22372, 22375, 22376, 22379, 22380.
      --  22383, 22384, 22387, 22388, 22391, 22392, 22395, 22396, 22399.
      --  22400, 22403, 22404, 22407, 22408, 22411, 22412, 22415, 22416.
      --  22419, 22420, 22423, 22424, 22427, 22428, 22431, 22432, 22435.
      --  22436, 22439, 22440, 22443, 22444, 22447, 22448, 22451, 22452.
      --  22455, 22456, 22459, 22460, 22463, 22464, 22467, 22468, 22471.
      --  22472, 22475, 22476, 22479, 22480, 22483, 22484, 22487, 22488.
      --  22491, 22492, 22495, 22496, 22499, 22500, 22503, 22504, 22507.
      --  22508, 22511, 22512, 22515, 22516, 22519, 22520, 22523, 22524.
      --  22527, 22528, 22531, 22532, 22535, 22536, 22539, 22540, 22543.
      --  22544, 22547, 22548, 22551, 22552, 22555, 22556, 22559, 22560.
      --  22563, 22564, 22567, 22568, 22571, 22572, 22575, 22576, 22579.
      --  22580, 22583, 22584, 22587, 22588, 22591, 22592, 22595, 22596.
      --  22599, 22600, 22603, 22604, 22607, 22608, 22611, 22612, 22615.
      --  22616, 22619, 22620, 22623, 22624, 22627, 22628, 22631, 22632.
      --  22635, 22636, 22639, 22640, 22643, 22644, 22647, 22648, 22651.
      --  22652, 22655, 22656, 22659, 22660, 22663, 22664, 22667, 22668.
      --  22671, 22672, 22675, 22676, 22679, 22680, 22683, 22684, 22687.
      --  22688, 22691, 22692, 22695, 22696, 22699, 22700, 22703, 22704.
      --  22707, 22708, 22711, 22712, 22715, 22716, 22719, 22720, 22723.
      --  22724, 22727, 22728, 22731, 22732, 22735, 22736, 22739, 22740.
      --  22743, 22744, 22747, 22748, 22751, 22752, 22755, 22756, 22759.
      --  22760, 22763, 22764, 22767, 22768, 22771, 22772, 22775, 22776.
      --  22779, 22780, 22783, 22784, 22787, 22788, 22791, 22792, 22795.
      --  22796, 22799, 22800, 22803, 22804, 22807, 22808, 22811, 22812.
      --  22815, 22816, 22819, 22820, 22823, 22824, 22827, 22828, 22831.
      --  22832, 22835, 22836, 22839, 22840, 22843, 22844, 22847, 22848.
      --  22851, 22852, 22855, 22856, 22859, 22860, 22863, 22864, 22867.
      --  22868, 22871, 22872, 22875, 22876, 22879, 22880, 22883, 22884.
      --  22887, 22888, 22891, 22892, 22895, 22896, 22899, 22900, 22903.
      --  22904, 22907, 22908, 22911, 22912, 22915, 22916, 22919, 22920.
      --  22923, 22924, 22927, 22928, 22931, 22932, 22935, 22936, 22939.
      --  22940, 22943, 22944, 22947, 22948, 22951, 22952, 22955, 22956.
      --  22959, 22960, 22963, 22964, 22967, 22968, 22971, 22972.
      for C of Cases loop
         Native := Parse_U64 (To_String (C.Args (1)), N);
         K := 0;
         if Natural (C.Args.Length) = 2 then
            Native := Parse_U64 (To_String (C.Args (2)), K) and Native;
         end if;
         if Native and then Parse_U64 (To_String (C.Result), Expected) then
            if Func = "is_carmichael" then
               Got := Boolean'Pos (Is_Carmichael (N));
            elsif Func = "is_quasi_carmichael" then
               Got := Is_Quasi_Carmichael (N);
            elsif Func = "is_cyclic" then
               Got := Boolean'Pos (Is_Cyclic (N));
            elsif Func = "is_perfect_number" then
               Got := Boolean'Pos (Is_Perfect_Number (N));
            elsif Func = "is_practical" then
               Got := Boolean'Pos (Is_Practical (N));
            elsif Func = "is_smooth" then
               Got := Boolean'Pos (Is_Smooth (N, K));
            elsif Func = "is_rough" then
               Got := Boolean'Pos (Is_Rough (N, K));
            elsif Func = "smooth_count" then
               Got := Smooth_Count (N, K);
            elsif Func = "rough_count" then
               Got := Rough_Count (N, K);
            else
               raise Program_Error;
            end if;
            AUnit.Assertions.Assert
              (Got = Expected, Func & " row" & C.Line_Number'Image
               & " expected" & Expected'Image & " got" & Got'Image);
            Checked := Checked + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Checked > 0, Func & " native rows replayed");
   end Replay;

   procedure Check_Is_Carmichael (T : in out Test_Case'Class) is
   begin
      Replay ("is_carmichael");
   end Check_Is_Carmichael;

   procedure Check_Is_Quasi_Carmichael (T : in out Test_Case'Class) is
   begin
      Replay ("is_quasi_carmichael");
   end Check_Is_Quasi_Carmichael;

   procedure Check_Is_Cyclic (T : in out Test_Case'Class) is
   begin
      Replay ("is_cyclic");
   end Check_Is_Cyclic;

   procedure Check_Is_Perfect_Number (T : in out Test_Case'Class) is
   begin
      Replay ("is_perfect_number");
   end Check_Is_Perfect_Number;

   procedure Check_Is_Practical (T : in out Test_Case'Class) is
   begin
      Replay ("is_practical");
   end Check_Is_Practical;

   procedure Check_Is_Smooth (T : in out Test_Case'Class) is
   begin
      Replay ("is_smooth");
   end Check_Is_Smooth;

   procedure Check_Is_Rough (T : in out Test_Case'Class) is
   begin
      Replay ("is_rough");
   end Check_Is_Rough;

   procedure Check_Smooth_Count (T : in out Test_Case'Class) is
   begin
      Replay ("smooth_count");
   end Check_Smooth_Count;

   procedure Check_Rough_Count (T : in out Test_Case'Class) is
   begin
      Replay ("rough_count");
   end Check_Rough_Count;

   procedure Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_123;
      N, K, Smooth, Rough : U64;
   begin
      for Trial in 1 .. 256 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 2 + Seed mod 100_000;
         K := Seed mod 100;
         declare
            F : constant Factor.Factor_List := Factor.Factor (N);
         begin
            AUnit.Assertions.Assert
              (Is_Smooth (N, K) = (F.Value (F.Count) <= K),
               "largest factor seed 20261123 trial" & Trial'Image);
            AUnit.Assertions.Assert
              (Is_Rough (N, K) = (F.Value (1) >= K),
               "smallest factor seed 20261123 trial" & Trial'Image);
         end;
      end loop;
      for Bound in U64 range 0 .. 30 loop
         Smooth := 0;
         Rough := 0;
         for Value in U64 range 0 .. 200 loop
            if Value > 0 then
               Smooth := Smooth + Boolean'Pos (Is_Smooth (Value, Bound));
               Rough := Rough + Boolean'Pos (Is_Rough (Value, Bound));
            end if;
            AUnit.Assertions.Assert
              (Smooth_Count (Value, Bound) = Smooth,
               "smooth prefix" & Value'Image & Bound'Image);
            AUnit.Assertions.Assert
              (Rough_Count (Value, Bound) = Rough,
               "rough prefix" & Value'Image & Bound'Image);
         end loop;
      end loop;
      for Value in U64 range 0 .. 20_000 loop
         if Is_Carmichael (Value) then
            declare
               F : constant Factor.Factor_List := Factor.Factor (Value);
            begin
               AUnit.Assertions.Assert
                 (Value mod 2 = 1 and then F.Count >= 3
                  and then Primality.Is_Prime (Value) = 0,
                  "Carmichael odd composite");
               for I in 2 .. F.Count loop
                  AUnit.Assertions.Assert
                    (F.Value (I) /= F.Value (I - 1),
                     "Carmichael square free");
               end loop;
            end;
         end if;
      end loop;
   end Laws;

   procedure Boundaries (T : in out Test_Case'Class) is
      Inputs : constant array (Positive range <>) of U64 :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63 + 1, U64'Last];
   begin
      for N of Inputs loop
         AUnit.Assertions.Assert
           (Is_Smooth (N, U64'Last), "maximum smooth bound");
         AUnit.Assertions.Assert
           (Is_Rough (N, 0), "zero rough bound");
         AUnit.Assertions.Assert
           (Smooth_Count (N, U64'Last) = N, "all smooth");
         AUnit.Assertions.Assert
           (Rough_Count (N, 0) = N, "all rough");
      end loop;
      AUnit.Assertions.Assert
        (Is_Quasi_Carmichael (777_923) = 7, "base count, not Boolean");
      AUnit.Assertions.Assert
        (Is_Practical (18_446_744_073_709_551_600),
         "practical sigma exceeds U64");
   end Boundaries;

   overriding procedure Register_Tests (T : in out Classes_Case) is
   begin
      Registration.Register_Routine
        (T, Check_Is_Carmichael'Access, "is_carmichael");
      Registration.Register_Routine
        (T, Check_Is_Quasi_Carmichael'Access, "is_quasi_carmichael");
      Registration.Register_Routine
        (T, Check_Is_Cyclic'Access, "is_cyclic");
      Registration.Register_Routine
        (T, Check_Is_Perfect_Number'Access, "is_perfect_number");
      Registration.Register_Routine
        (T, Check_Is_Practical'Access, "is_practical");
      Registration.Register_Routine
        (T, Check_Is_Smooth'Access, "is_smooth");
      Registration.Register_Routine
        (T, Check_Is_Rough'Access, "is_rough");
      Registration.Register_Routine
        (T, Check_Smooth_Count'Access, "smooth_count");
      Registration.Register_Routine
        (T, Check_Rough_Count'Access, "rough_count");
      Registration.Register_Routine (T, Laws'Access, "factor class laws");
      Registration.Register_Routine (T, Boundaries'Access, "boundaries");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Classes_Case);
      return Result;
   end Suite;
end Compat_Factor_Classes;
