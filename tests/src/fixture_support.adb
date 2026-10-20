with Ada.Characters.Latin_1;
with Ada.Directories;
with Ada.Text_IO;

package body Fixture_Support is
   use type Math_Prime_Util.U128;

   function Load (Family : String) return Case_Vectors.Vector is
      File : Ada.Text_IO.File_Type;
      Path : constant String :=
        (if Ada.Directories.Exists ("tests/fixtures/" & Family & ".tsv")
         then "tests/fixtures/" else "fixtures/") & Family & ".tsv";
      Cases : Case_Vectors.Vector;
      Number : Natural := 0;
   begin
      if not Ada.Directories.Exists (Path) then
         raise Ada.Text_IO.Name_Error with Path;
      end if;
      Ada.Text_IO.Open (File, Ada.Text_IO.In_File, Path);
      while not Ada.Text_IO.End_Of_File (File) loop
         declare
            Line : constant String := Ada.Text_IO.Get_Line (File);
            First : Natural := 0;
            Second : Natural := 0;
            C : Case_Record;
         begin
            Number := Number + 1;
            if Line'Length > 0 and then Line (Line'First) /= '#' then
               for I in Line'Range loop
                  if Line (I) = Ada.Characters.Latin_1.HT then
                     if First = 0 then
                        First := I;
                     elsif Second = 0 then
                        Second := I;
                     else
                        raise Constraint_Error with "extra fixture field";
                     end if;
                  end if;
               end loop;
               if First = 0 or else Second = 0
                 or else First = Line'First
               then
                  raise Constraint_Error with "bad fixture row";
               end if;
               C.Func := To_Unbounded_String (Line (Line'First .. First - 1));
               C.Result := To_Unbounded_String (Line (Second + 1 .. Line'Last));
               C.Line_Number := Number;
               C.Undef := C.Result = "undef";
               C.Error := C.Result = "ERROR";
               declare
                  A : constant String := Line (First + 1 .. Second - 1);
                  Start : Natural := A'First;
               begin
                  for I in A'Range loop
                     if A (I) = ' ' then
                        if I > Start then
                           C.Args.Append
                             (To_Unbounded_String (A (Start .. I - 1)));
                        end if;
                        Start := I + 1;
                     end if;
                  end loop;
                  if Start <= A'Last then
                     C.Args.Append (To_Unbounded_String (A (Start .. A'Last)));
                  end if;
               end;
               Cases.Append (C);
            end if;
         end;
      end loop;
      Ada.Text_IO.Close (File);
      return Cases;
   exception
      when Constraint_Error | Ada.Text_IO.Data_Error |
           Ada.Text_IO.Device_Error | Ada.Text_IO.End_Error |
           Ada.Text_IO.Name_Error | Ada.Text_IO.Use_Error =>
         if Ada.Text_IO.Is_Open (File) then
            Ada.Text_IO.Close (File);
         end if;
         raise;
   end Load;

   function For_Function
     (Cases : Case_Vectors.Vector; Func : String)
      return Case_Vectors.Vector
   is
      Result : Case_Vectors.Vector;
   begin
      for C of Cases loop
         if C.Func = Func then
            Result.Append (C);
         end if;
      end loop;
      return Result;
   end For_Function;

   function Parse_U64 (Text : String; Value : out Math_Prime_Util.U64)
      return Boolean
   is
      N : Math_Prime_Util.U128;
   begin
      Value := 0;
      if not Parse_U128 (Text, N)
        or else N > Math_Prime_Util.U128 (Math_Prime_Util.U64'Last)
      then
         return False;
      end if;
      Value := Math_Prime_Util.U64 (N);
      return True;
   end Parse_U64;

   function Parse_U128 (Text : String; Value : out Math_Prime_Util.U128)
      return Boolean
   is
      Max : constant Math_Prime_Util.U128 := Math_Prime_Util.U128'Last;
      N : Math_Prime_Util.U128 := 0;
      D : Math_Prime_Util.U128;
   begin
      Value := 0;
      if Text'Length = 0 then
         return False;
      end if;
      for Ch of Text loop
         if Ch not in '0' .. '9' then
            return False;
         end if;
         D := Math_Prime_Util.U128 (Character'Pos (Ch) - Character'Pos ('0'));
         if N > (Max - D) / 10 then
            return False;
         end if;
         N := N * 10 + D;
      end loop;
      Value := N;
      return True;
   end Parse_U128;
end Fixture_Support;
