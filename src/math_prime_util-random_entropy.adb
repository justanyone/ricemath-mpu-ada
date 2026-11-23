with Ada.Streams;
with Ada.Streams.Stream_IO;

package body Math_Prime_Util.Random_Entropy is
   procedure Fill (Data : out Random.Byte_Array) is
      use Ada.Streams;
      package IO renames Ada.Streams.Stream_IO;
      File : IO.File_Type;
      Buffer : Stream_Element_Array (1 .. Data'Length);
      Last : Stream_Element_Offset;
   begin
      IO.Open (File, IO.In_File, "/dev/urandom");
      IO.Read (File, Buffer, Last);
      IO.Close (File);
      if Last /= Buffer'Last then
         raise Random.Entropy_Error with "short operating-system entropy read";
      end if;
      for I in Data'Range loop
         Data (I) := Random.Byte (Buffer
           (Stream_Element_Offset (I - Data'First) + 1));
      end loop;
   exception
      when IO.Name_Error | IO.Use_Error | IO.Device_Error | IO.End_Error =>
         if IO.Is_Open (File) then
            IO.Close (File);
         end if;
         raise Random.Entropy_Error with
           "operating-system entropy unavailable";
   end Fill;
end Math_Prime_Util.Random_Entropy;
