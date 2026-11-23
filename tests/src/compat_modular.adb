with AUnit.Assertions;
with AUnit.Test_Cases;
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded;
with Fixture_Support;
with Math_Prime_Util.Modular;
with Math_Prime_Util.Int;
with Math_Prime_Util.Errors;

package body Compat_Modular is
   use AUnit.Test_Cases;
   use Fixture_Support;
   use Ada.Strings.Unbounded;
   use Math_Prime_Util;
   use Math_Prime_Util.Modular;
   use type U64;
   use type I128;

   type Modular_Case is new Test_Case with null record;
   overriding function Name (T : Modular_Case) return AUnit.Message_String;
   overriding procedure Register_Tests (T : in out Modular_Case);

   subtype Optional_U64 is Int.Optional_U64;

   function Image (V : U64) return String is
     (Ada.Strings.Fixed.Trim (U64'Image (V), Ada.Strings.Both));
   function Image (V : Int.Optional_U64) return String is
     (if V.Defined then Image (V.Value) else "undef");
   function Image (V : Root_List) return String is
      S : Unbounded_String;
   begin
      for R of V loop
         if Length (S) > 0 then
            Append (S, " ");
         end if;
         Append (S, Image (R));
      end loop;
      return (if V'Length = 0 then "undef" else To_String (S));
   end Image;

   function Signed_Input (Text : String; V : out I128) return Boolean is
      Negative : constant Boolean := Text (Text'First) = '-';
      First : constant Positive := Text'First + (if Negative then 1 else 0);
      Magnitude : U64;
   begin
      if not Parse_U64 (Text (First .. Text'Last), Magnitude) then
         V := 0;
         return False;
      end if;
      V := (if Negative then -I128 (Magnitude) else I128 (Magnitude));
      return True;
   end Signed_Input;

   procedure Replay_Roots (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("modular"), Func);
      N, D : U64;
      A, K : I128;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         --  Native_Tier_Only: the two sqrt and then one root fixture arguments
         --  exceeding U64 belong to the future bigint tier, not this API.
         if Parse_U64 (To_String (C.Args (Positive (C.Args.Length))), N) then
            A := I128'Value (To_String (C.Args (1)));
            K := (if Func = "rootmod" or else Func = "allrootmod" then
                    I128'Value (To_String (C.Args (2))) else 2);
            declare
               Actual : Unbounded_String;
            begin
               if Func = "sqrtmod" then
                  Actual := To_Unbounded_String (Image (Sqrtmod (A, N)));
               elsif Func = "allsqrtmod" then
                  Actual := To_Unbounded_String (Image (Allsqrtmod (A, N)));
               elsif Func = "rootmod" then
                  Actual := To_Unbounded_String (Image (Rootmod (A, K, N)));
               elsif Func = "allrootmod" then
                  Actual := To_Unbounded_String (Image (Allrootmod (A, K, N)));
               else
                  D := U64 (A);
                  declare
                     R : constant Cornacchia_Result := Cornacchia (D, N);
                  begin
                     Actual := To_Unbounded_String
                       ((if R.Defined then Image (R.X) & " " & Image (R.Y)
                         else "undef"));
                  end;
               end if;
               AUnit.Assertions.Assert
                 (Actual = C.Result, Func & " row" &
                    Positive'Image (C.Line_Number) & " expected " &
                    To_String (C.Result) & " got " & To_String (Actual));
            end;
         end if;
      end loop;
   end Replay_Roots;

   procedure Test_Sqrt (T : in out Test_Case'Class) is
   begin
      Replay_Roots ("sqrtmod");
   end Test_Sqrt;
   procedure Test_Allsqrt (T : in out Test_Case'Class) is
   begin
      Replay_Roots ("allsqrtmod");
   end Test_Allsqrt;
   procedure Test_Root (T : in out Test_Case'Class) is
   begin
      Replay_Roots ("rootmod");
   end Test_Root;
   procedure Test_Allroot (T : in out Test_Case'Class) is
   begin
      Replay_Roots ("allrootmod");
   end Test_Allroot;
   procedure Test_Cornacchia (T : in out Test_Case'Class) is
   begin
      Replay_Roots ("cornacchia");
   end Test_Cornacchia;

   procedure Check_Laws (T : in out Test_Case'Class) is
      Found : Boolean;
      Single : Int.Optional_U64;
   begin
      --  Exhaustive oracle independent of factorization and then lifting.
      for N in U64 range 1 .. 32 loop
         for K in I128 range 0 .. 6 loop
            for A in U64 range 0 .. N - 1 loop
               declare
                  Roots : constant Root_List := Allrootmod (I128 (A), K, N);
               begin
                  for X in U64 range 0 .. N - 1 loop
                     Found := False;
                     for R of Roots loop
                        Found := Found or else R = X;
                     end loop;
                     AUnit.Assertions.Assert
                       (Found = (Int.Powmod (X, U64 (K), N).Value = A),
                        "complete roots N=" & Image (N) & " A=" & Image (A));
                  end loop;
                  for I in Roots'First + 1 .. Roots'Last loop
                     AUnit.Assertions.Assert
                       (Roots (I - 1) < Roots (I), "sorted unique roots");
                  end loop;
                  Single := Rootmod (I128 (A), K, N);
                  AUnit.Assertions.Assert
                    (Single.Defined = (Roots'Length > 0), "single existence");
                  if Single.Defined then
                     AUnit.Assertions.Assert
                       (Int.Powmod (Single.Value, U64 (K), N).Value = A,
                        "single root equation");
                  end if;
               end;
            end loop;
         end loop;
      end loop;
      for N of Root_List'[2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
                          2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last] loop
         Single := Sqrtmod (1, N);
         AUnit.Assertions.Assert (Single.Defined and then Single.Value = 1,
                                  "native boundary square root");
      end loop;
      AUnit.Assertions.Assert
        (Sqrtmod (I128'First, 1).Value = 0 and then
         Sqrtmod (I128'Last, 1).Value = 0 and then
         Sqrtmod (I128 (2) ** 64, 1).Value = 0,
         "wide signed input reduction");
      declare
         R : constant Cornacchia_Result := Cornacchia (1, 2 ** 54);
      begin
         AUnit.Assertions.Assert
           (R.Defined and then R.X = 2 ** 27 and then R.Y = 0,
            "large composite Cornacchia fallback");
      end;
      AUnit.Assertions.Assert
        (Allrootmod (2, -1, 4)'Length = 0, "noninvertible negative exponent");
      begin
         declare
            Roots : constant Root_List := Allrootmod (1, 0, U64'Last);
         begin
            AUnit.Assertions.Assert (Roots'Length = 0, "root cap missing");
         end;
      exception
         when Errors.Maximum_Roots_Exceeded => null;
      end;
   end Check_Laws;

   procedure Replay_Helpers (Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load ("modular"), Func);
      A : array (1 .. 3) of U64 := [others => 0];
      N, K : I128 := 0;
      Fits, Expected_Fits : Boolean;
      Expected : U64 := 0;
      R : Optional_U64;
      Count : Natural := 0;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         Fits := True;
         if Func = "binomialmod" then
            Fits := Signed_Input (To_String (C.Args (1)), N)
              and then Signed_Input (To_String (C.Args (2)), K)
              and then Parse_U64 (To_String (C.Args (3)), A (3));
         else
            for I in 1 .. Natural (C.Args.Length) loop
               Fits := Parse_U64 (To_String (C.Args (I)), A (I)) and then Fits;
            end loop;
         end if;
         --  Native-tier skip: znlog modulus 1000000000000000000117;
         --  factorialmod modulus 18446744082299486209; binomialmod N
         --  36893488147419103231; pisano_period inputs above U64'Last
         --  (74505805969238281250 and 265252859812191058636308480000000).
         --  Native inputs whose period overflows are checked as undefined.
         if Fits then
            AUnit.Assertions.Assert (not C.Error, "unexpected error row");
            if Func = "znlog" then
               R := Znlog (A (1), A (2), A (3));
            elsif Func = "factorialmod" then
               R := Factorialmod (A (1), A (2));
            elsif Func = "binomialmod" then
               R := Binomialmod (N, K, A (3));
            else
               R := Pisano_Period (A (1));
            end if;
            Expected_Fits := not C.Undef and then
              Parse_U64 (To_String (C.Result), Expected);
            AUnit.Assertions.Assert
              (R.Defined = Expected_Fits and then
               (not Expected_Fits or else R.Value = Expected),
               Func & " row" & Positive'Image (C.Line_Number)
               & " expected " & To_String (C.Result)
               & (if R.Defined then " got" & U64'Image (R.Value)
                  else " got undef"));
            Count := Count + 1;
         end if;
      end loop;
      AUnit.Assertions.Assert (Count > 0, "no native rows " & Func);
   end Replay_Helpers;

   procedure Check_Znlog (T : in out Test_Case'Class) is
   begin
      Replay_Helpers ("znlog");
   end Check_Znlog;

   procedure Check_Factorialmod (T : in out Test_Case'Class) is
   begin
      Replay_Helpers ("factorialmod");
   end Check_Factorialmod;

   procedure Check_Binomialmod (T : in out Test_Case'Class) is
   begin
      Replay_Helpers ("binomialmod");
   end Check_Binomialmod;

   procedure Check_Pisano (T : in out Test_Case'Class) is
   begin
      Replay_Helpers ("pisano_period");
   end Check_Pisano;

   procedure Check_Edges (T : in out Test_Case'Class) is
      Edges : constant array (Positive range <>) of U64 :=
        [0, 1, 2, 2 ** 32 - 1, 2 ** 32, 2 ** 32 + 1,
         2 ** 63 - 1, 2 ** 63, 2 ** 63 + 1, U64'Last];
      R : Optional_U64;
   begin
      AUnit.Assertions.Assert (not Znlog (1, 2, 0).Defined, "log mod zero");
      AUnit.Assertions.Assert
        (not Factorialmod (0, 0).Defined, "factorial mod zero");
      AUnit.Assertions.Assert
        (not Binomialmod (0, 0, 0).Defined, "binomial mod zero");
      for N of Edges loop
         R := Factorialmod (N, 1);
         AUnit.Assertions.Assert (R.Defined and then R.Value = 0,
                                  "factorial modulo one");
         R := Factorialmod (N, U64'Max (N, 1));
         AUnit.Assertions.Assert (R.Defined and then R.Value = 0,
                                  "factorial N >= modulus");
         R := Binomialmod (I128 (N), 1, 97);
         AUnit.Assertions.Assert
           (R.Defined and then R.Value = N mod 97, "choose one");
         R := Znlog (1, N, 97);
         AUnit.Assertions.Assert (R.Defined and then R.Value = 0,
                                  "zero exponent");
      end loop;
   end Check_Edges;

   procedure Check_Properties (T : in out Test_Case'Class) is
      R : Optional_U64;
      V, Least : U64;
      Found : Boolean;
      F0, F1, Next, Period : U64;
   begin
      --  Exhaustive small semigroups check absence and least exponents.
      for M in U64 range 1 .. 24 loop
         for G in U64 range 0 .. M - 1 loop
            for A in U64 range 0 .. M - 1 loop
               V := 1 mod M;
               Found := False;
               Least := 0;
               for X in U64 range 0 .. M loop
                  if V = A then
                     Found := True;
                     Least := X;
                     exit;
                  end if;
                  V := (V * G) mod M;
               end loop;
               R := Znlog (A, G, M);
               AUnit.Assertions.Assert
                 (R.Defined = Found and then
                  (not Found or else R.Value = Least),
                  "least log small semigroup");
            end loop;
         end loop;
      end loop;
      for M in U64 range 2 .. 100 loop
         F0 := 0;
         F1 := 1;
         Period := 0;
         loop
            Next := (F0 + F1) mod M;
            F0 := F1;
            F1 := Next;
            Period := Period + 1;
            exit when F0 = 0 and then F1 = 1;
         end loop;
         R := Pisano_Period (M);
         AUnit.Assertions.Assert
           (R.Defined and then R.Value = Period, "least Fibonacci period");
      end loop;
      R := Binomialmod (-1, 7, 13);
      AUnit.Assertions.Assert
        (R.Defined and then R.Value = 12, "negative binomial sign");
      R := Binomialmod (-1, 8, 13);
      AUnit.Assertions.Assert
        (R.Defined and then R.Value = 1, "even negative binomial sign");
   end Check_Properties;

   procedure Replay_Residues (Family, Func : String) is
      Cases : constant Case_Vectors.Vector :=
        For_Function (Load (Family), Func);
      Actual : Unbounded_String;
      Fits : Boolean;
      Count : Natural := 0;
      N : U64;
   begin
      AUnit.Assertions.Assert (not Cases.Is_Empty, "missing " & Func);
      for C of Cases loop
         declare
            Args : array (1 .. Natural (C.Args.Length)) of I128;
            R : Optional_U64;
         begin
            Fits := True;
            for I in Args'Range loop
               Fits := Signed_Input (To_String (C.Args (I)), Args (I))
                 and then Fits;
            end loop;
            --  modular native-tier skips (input magnitude > U64):
            --  rows 3072, 33762, 33818, 33874, 33930, 33986, 34042.
            --  rows 34098, 34154, 34210, 34266, 34322, 34378, 34434.
            --  rows 34490, 34546, 34602, 34658, 34714, 34770, 34826.
            --  rows 34882, 34938, 34994, 35050, 35106, 35162, 35218.
            --  rows 35274, 35330, 35386, 35442, 35498, 35554, 35610.
            --  rows 35666, 35722, 35778, 35834, 35890, 35946, 36002.
            --  rows 36058, 36114, 36170, 36226, 36282, 36338, 36394.
            --  rows 36450, 36506, 36562, 36618, 36674, 36730, 36786.
            --  rows 36842, 36898, 36954, 37010, 37066, 37122, 37178.
            --  rows 37234, 37290, 37346, 37402, 37458, 37514, 37570.
            --  rows 37626, 37682, 37738, 37794, 37850, 37906, 37962.
            --  rows 38018, 38074, 38130, 38186, 38242, 38298, 38354.
            --  rows 38410, 38466, 38522, 38578, 38634, 38690, 38746.
            --  rows 38753, 38760, 38767, 38774, 38781, 38788, 38795.
            --  rows 38802, 38809, 38816, 38823, 38830, 38837, 38844.
            --  rows 38851, 38858, 38865, 38872, 38879, 38886, 38893.
            --  rows 38900, 38907, 38914, 38921, 38928, 38935, 38942.
            --  rows 38949, 38956, 38963, 38970, 38977, 38984, 38991.
            --  rows 38998, 39005, 39012, 39019, 39026, 39033, 39040.
            --  rows 39047, 39054, 39061, 39068, 39075, 39082, 39089.
            --  rows 39096, 39103, 39110, 39117, 39124, 39131, 39138.
            --  rows 39145, 39152, 39159, 39166, 39173, 39180, 39187.
            --  rows 39194, 39201, 39208, 39215, 39222, 39229, 39236.
            --  rows 39243, 39250, 39257, 39264, 39271, 39278, 39285.
            --  rows 39292, 39299, 39306, 39362, 39418, 39474, 39530.
            --  rows 39586, 39642, 39698, 39754, 39810, 39866, 39873.
            if Fits then
               if Func = "chinese" or else Func = "chinese2" then
                  declare
                     Pairs : Congruence_List (1 .. Args'Length / 2);
                     CRT : Chinese_Result;
                  begin
                     for I in Pairs'Range loop
                        Pairs (I) := (Args (2 * I - 1),
                                      U64 (abs Args (2 * I)));
                     end loop;
                     if Func = "chinese" then
                        Actual := To_Unbounded_String (Image (Chinese (Pairs)));
                     else
                        CRT := Chinese2 (Pairs);
                        Actual := To_Unbounded_String
                          ((if CRT.Defined then Image (CRT.Remainder) & " "
                            & Image (CRT.Modulus) else "undef"));
                     end if;
                  end;
               elsif Func = "kronecker" then
                  Actual := To_Unbounded_String
                    (Ada.Strings.Fixed.Trim
                       (Symbol'Image (Kronecker (Args (1), Args (2))),
                        Ada.Strings.Both));
               elsif Func = "is_fundamental" then
                  Actual := To_Unbounded_String
                    ((if Is_Fundamental (Args (1)) then "1" else "0"));
               else
                  N := U64 (abs Args (Args'Last));
                  if Func = "is_primitive_root" then
                     Actual := To_Unbounded_String
                       ((if N = 0 then "undef"
                         elsif Is_Primitive_Root (Args (1), N) then "1"
                         else "0"));
                  elsif Func = "is_qr" then
                     Actual := To_Unbounded_String
                       ((if Is_Qr (Args (1), N) then "1" else "0"));
                  else
                     if Func = "znorder" then
                        R := Znorder (Args (1), N);
                     elsif Func = "znprimroot" then
                        R := Znprimroot (N);
                     elsif Func = "qnr" then
                        R := Qnr (N);
                     else
                        R := Divmod (Args (1), Args (2), N);
                     end if;
                     Actual := To_Unbounded_String (Image (R));
                  end if;
               end if;
               AUnit.Assertions.Assert
                 (Actual = C.Result, Family & " " & Func & " row" &
                  Positive'Image (C.Line_Number) & " expected " &
                  To_String (C.Result) & " got " & To_String (Actual));
               Count := Count + 1;
            end if;
         end;
      end loop;
      AUnit.Assertions.Assert (Count > 0, "no native rows " & Func);
   end Replay_Residues;

   procedure Check_Kronecker (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "kronecker");
   end Check_Kronecker;

   procedure Check_Chinese (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "chinese");
   end Check_Chinese;

   procedure Check_Chinese2 (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "chinese2");
   end Check_Chinese2;

   procedure Check_Znorder (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "znorder");
      Replay_Residues ("modular", "znorder");
   end Check_Znorder;

   procedure Check_Znprimroot (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "znprimroot");
   end Check_Znprimroot;

   procedure Check_Is_Primitive_Root (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "is_primitive_root");
   end Check_Is_Primitive_Root;

   procedure Check_Qnr (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "qnr");
   end Check_Qnr;

   procedure Check_Is_Qr (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "is_qr");
   end Check_Is_Qr;

   procedure Check_Is_Fundamental (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("arith", "is_fundamental");
   end Check_Is_Fundamental;

   procedure Check_Divmod (T : in out Test_Case'Class) is
   begin
      Replay_Residues ("modular", "divmod");
   end Check_Divmod;

   procedure Residue_Laws (T : in out Test_Case'Class) is
      Seed : U64 := 20_261_123;
      A, N : U64;
      R : Optional_U64;
      Found : Boolean;
   begin
      for M in U64 range 1 .. 64 loop
         R := Znprimroot (M);
         if R.Defined then
            AUnit.Assertions.Assert
              (Is_Primitive_Root (I128 (R.Value), M), "root generates");
         end if;
         for V in U64 range 0 .. M - 1 loop
            Found := False;
            for X in U64 range 0 .. M - 1 loop
               Found := Found or else X * X mod M = V;
            end loop;
            AUnit.Assertions.Assert
              (Is_Qr (I128 (V), M) = Found, "square residue enumeration");
         end loop;
      end loop;
      for P of Root_List'[3, 5, 7, 11, 13, 17, 19, 23, 97] loop
         R := Qnr (P);
         AUnit.Assertions.Assert
           (R.Defined and then not Is_Qr (I128 (R.Value), P),
            "nonresidue of odd prime");
      end loop;
      for I in 1 .. 100 loop
         Seed := Seed * 6_364_136_223_846_793_005 + 1;
         N := 2 + Seed mod 1000;
         A := Seed / 1000 mod N;
         R := Znorder (I128 (A), N);
         AUnit.Assertions.Assert
           (R.Defined = (Int.Gcd (A, N) = 1), "order seed 20261123");
         if R.Defined then
            AUnit.Assertions.Assert
              (Int.Powmod (A, R.Value, N).Value = 1,
               "order power seed 20261123");
            for K in U64 range 1 .. R.Value - 1 loop
               AUnit.Assertions.Assert
                 (Int.Powmod (A, K, N).Value /= 1, "least order");
            end loop;
         end if;
         declare
            Pairs : constant Congruence_List :=
              [(I128 (Seed), 12), (I128 (Seed), 18)];
            CRT : constant Chinese_Result := Chinese2 (Pairs);
         begin
            AUnit.Assertions.Assert
              (CRT.Defined and then CRT.Modulus = 36, "CRT existence");
            for C of Pairs loop
               AUnit.Assertions.Assert
                 (CRT.Remainder mod C.Modulus =
                    U64 (C.Residue mod I128 (C.Modulus)),
                  "CRT congruence seed 20261123");
            end loop;
         end;
      end loop;
      AUnit.Assertions.Assert
        (not Chinese2 ([(1, U64'Last), (1, 2)]).Defined, "LCM overflow");
      AUnit.Assertions.Assert
        (not Is_Primitive_Root (2, 0), "zero modulus generator");
   end Residue_Laws;

   overriding function Name (T : Modular_Case) return AUnit.Message_String is
   begin
      return AUnit.Format ("Compat_Modular");
   end Name;
   overriding procedure Register_Tests (T : in out Modular_Case) is
   begin
      Registration.Register_Routine (T, Test_Sqrt'Access, "sqrtmod");
      Registration.Register_Routine (T, Test_Allsqrt'Access, "allsqrtmod");
      Registration.Register_Routine (T, Test_Root'Access, "rootmod");
      Registration.Register_Routine (T, Test_Allroot'Access, "allrootmod");
      Registration.Register_Routine (T, Test_Cornacchia'Access, "cornacchia");
      Registration.Register_Routine (T, Check_Laws'Access, "exhaustive laws");
      Registration.Register_Routine (T, Check_Znlog'Access, "znlog");
      Registration.Register_Routine
        (T, Check_Factorialmod'Access, "factorialmod");
      Registration.Register_Routine
        (T, Check_Binomialmod'Access, "binomialmod");
      Registration.Register_Routine (T, Check_Pisano'Access, "pisano_period");
      Registration.Register_Routine (T, Check_Edges'Access, "modular edges");
      Registration.Register_Routine
        (T, Check_Properties'Access, "modular properties");
      Registration.Register_Routine
        (T, Check_Kronecker'Access, "kronecker");
      Registration.Register_Routine
        (T, Check_Chinese'Access, "chinese");
      Registration.Register_Routine
        (T, Check_Chinese2'Access, "chinese2");
      Registration.Register_Routine
        (T, Check_Znorder'Access, "znorder");
      Registration.Register_Routine
        (T, Check_Znprimroot'Access, "znprimroot");
      Registration.Register_Routine
        (T, Check_Is_Primitive_Root'Access, "is_primitive_root");
      Registration.Register_Routine
        (T, Check_Qnr'Access, "qnr");
      Registration.Register_Routine
        (T, Check_Is_Qr'Access, "is_qr");
      Registration.Register_Routine
        (T, Check_Is_Fundamental'Access, "is_fundamental");
      Registration.Register_Routine
        (T, Check_Divmod'Access, "divmod");
      Registration.Register_Routine
        (T, Residue_Laws'Access, "residue laws seed 20261123");
   end Register_Tests;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
        new AUnit.Test_Suites.Test_Suite;
   begin
      Result.Add_Test (new Modular_Case);
      return Result;
   end Suite;
end Compat_Modular;
