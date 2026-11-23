package body Math_Prime_Util.Count.Tables is
   type Counts is array (Natural range <>) of U64;
   Steps_0 : constant Counts :=
     [208, 134, 115, 102, 97, 91, 77, 89, 74, 65, 74, 67,
      64, 66, 64, 52, 57, 59, 63, 56, 44, 52, 44, 55,
      46, 50, 44, 46, 41, 44, 52, 49, 34, 42, 39, 31,
      43, 34, 37, 37, 43, 36, 39, 32, 30, 46, 37, 27,
      29, 38, 44, 27, 22, 35, 22, 25, 28, 30, 34, 37,
      22, 34, 27, 25, 28, 29, 21, 24, 24, 41, 20, 22,
      21, 30, 25, 21, 42, 6, 17, 20, 28, 26, 32, 20,
      16, 18, 20, 17, 26, 28, 26, 15, 19, 26, 20, 0,
      27, 4, 23, 5];
   procedure Lookup (N : U64; Anchor, Value : out U64) is
      Last : constant Natural := Natural (U64'Min
        (N / 3000, U64 (Steps_0'Length)));
   begin
      Anchor := U64 (Last) * 3000;
      Value := (if Last = 0 then 0 else 3);
      for K in 1 .. Last loop
         Value := Value + 219 + Steps_0 (K - 1);
      end loop;
   end Lookup;
end Math_Prime_Util.Count.Tables;
