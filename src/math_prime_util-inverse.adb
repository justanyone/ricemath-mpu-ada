with Ada.Numerics.Generic_Elementary_Functions;

function Math_Prime_Util.Inverse (First, Last, Target : U64) return U64 is
      package Ef is new Ada.Numerics.Generic_Elementary_Functions (Wide);
      use Ef;
      Lo : U64 := First;
      Hi : U64 := Last;
      Mid, Rlo, Rhi, Rmid : U64;
      Iter : Natural := 0;
      function Linear return U64;
      function Linear return U64 is
         Move : U64;
         Step : Long_Float;
      begin
         if Target = Rlo then
            return Lo + 1;
         elsif Target = Rhi then
            return Hi - 1;
         end if;
         Step := Long_Float (Target - Rlo) * Long_Float (Hi - Lo) /
           Long_Float (Rhi - Rlo) + 0.5;
         if Step >= Long_Float (Hi - Lo) then
            return Hi - 1;
         end if;
         Move := U64 (Long_Float'Floor (Step));
         return Lo + U64'Max (1, Move);
      end Linear;
   begin
      Mid := Lo + (Hi - Lo) / 2;
      Rmid := Value (Mid);
      if Rmid >= Target then
         Hi := Mid;
         Rhi := Rmid;
         Rlo := Value (Lo);
         if Rlo = Target then
            return Lo;
         end if;
      else
         Lo := Mid;
         Rlo := Rmid;
         Rhi := Value (Hi);
      end if;
      while Hi - Lo > 1 and then Rhi > Target loop
         Mid := Linear;
         Iter := Iter + 1;
         if Iter mod 6 = 1 and then Iter > 1 then
            declare
               Close : constant U64 := U64
                 (Long_Float'Floor (0.003 * Long_Float (Hi - Lo) + 1.0));
            begin
               Mid := U64'Max (Lo + Close, U64'Min (Hi - Close, Mid));
            end;
         end if;
         Mid := U64'Max (Lo + 1, U64'Min (Hi - 1, Mid));
         Rmid := Value (Mid);
         if Rmid >= Target then
            Hi := Mid;
            Rhi := Rmid;
         else
            Lo := Mid;
            Rlo := Rmid;
         end if;
      end loop;
      if Rlo = Target then
         return Lo;
      elsif Hi - Lo <= 1 then
         return (if Rhi = Target then Hi else Lo);
      end if;
      --  Ridder's method preserves the reference's choice at local dips.
      while Hi - Lo > 8 loop
         declare
            X1 : U64 := Lo + (Hi - Lo) / 2;
            Rx1 : U64 := Value (X1);
            D0 : constant Long_Float := Long_Float (Target - Rlo);
            D1 : constant Long_Float := Long_Float
              (if Rx1 >= Target then Rx1 - Target else Target - Rx1);
            D2 : constant Long_Float := Long_Float (Rhi - Target + 1);
            Pos : constant Wide := Wide
              ((if Rx1 >= Target then 1.0 else -1.0) *
               Long_Float (X1 - Lo) * D1) /
              Sqrt (Wide (D1 * D1 + D0 * D2));
            Move : constant U64 := U64 (Wide'Floor (abs Pos + 0.5));
            X3 : U64 := (if Pos >= 0.0 then X1 - Move else X1 + Move);
            Rx3, Temp : U64;
         begin
            if X3 >= Hi or else X3 <= Lo or else X3 = X1 then
               if Rx1 >= Target then
                  Hi := X1;
                  Rhi := Rx1;
               else
                  Lo := X1;
                  Rlo := Rx1;
               end if;
            else
               Rx3 := Value (X3);
               if Rx1 > Rx3 then
                  Temp := X1;
                  X1 := X3;
                  X3 := Temp;
                  Temp := Rx1;
                  Rx1 := Rx3;
                  Rx3 := Temp;
               end if;
               if Rx1 >= Target then
                  Hi := X1;
                  Rhi := Rx1;
               elsif Rx3 >= Target then
                  Lo := X1;
                  Rlo := Rx1;
                  Hi := X3;
                  Rhi := Rx3;
               else
                  Lo := X3;
                  Rlo := Rx3;
               end if;
            end if;
         end;
      end loop;
      while Hi - Lo > 1 loop
         Mid := Lo + (Hi - Lo) / 2;
         if Value (Mid) < Target then
            Lo := Mid;
         else
            Hi := Mid;
         end if;
      end loop;
      return Hi;
end Math_Prime_Util.Inverse;

