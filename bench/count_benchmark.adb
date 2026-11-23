with Ada.Text_IO;
with Ada.Real_Time;
with Math_Prime_Util.Count;
procedure Count_Benchmark is
   use Math_Prime_Util;
   use type Math_Prime_Util.U64;
   use Ada.Real_Time;
   N : U64 := 1;
   T : Time;
   R : U64;
begin
   for K in 1 .. 13 loop
      N := N * 10;
      T := Clock;
      R := Count.Prime_Count (N);
      Ada.Text_IO.Put_Line (U64'Image (N) & U64'Image (R) &
        Duration'Image (To_Duration (Clock - T)));
   end loop;
end Count_Benchmark;
