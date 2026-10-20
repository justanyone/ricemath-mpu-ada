package body Math_Prime_Util.Random_Core with SPARK_Mode => On is
   use Interfaces;
   function Load (Data : String; Offset : Natural) return U32 is
      R : U32 := 0;
   begin
      for J in 0 .. 3 loop
         R := R or Shift_Left
           (U32 (Character'Pos (Data (Data'First + Offset + J))), 8 * J);
      end loop;
      return R;
   end Load;

   procedure Store (Data : in out String; Offset : Natural; V : U32) is
   begin
      for J in 0 .. 3 loop
         Data (Data'First + Offset + J) :=
           Character'Val (Shift_Right (V, 8 * J) and 255);
      end loop;
   end Store;

   procedure Quarter (A, B, C, D : in out U32) is
   begin
      A := A + B; D := Rotate_Left (D xor A, 16);
      C := C + D; B := Rotate_Left (B xor C, 12);
      A := A + B; D := Rotate_Left (D xor A, 8);
      C := C + D; B := Rotate_Left (B xor C, 7);
   end Quarter;

   procedure Expand_Seed
     (Data : String; Key : out String; Rng, Inc : out U32)
   is
      A, B, C, D, Ignore : U32;
      procedure Next (Value : out U32);
      procedure Next (Value : out U32) is
         Old : constant U32 := Rng;
         Word : U32;
      begin
         Rng := Rng * 747_796_405 + Inc;
         Word := (Shift_Right (Old, Natural (Shift_Right (Old, 28)) + 4)
                  xor Old) * 277_803_737;
         Value := Shift_Right (Word, 22) xor Word;
      end Next;
   begin
      Rng := 0;
      Inc := 0;
      Key := [others => Character'Val (0)];
      for I in 1 .. Natural'Min (Data'Length, 40) loop
         Key (I) := Data (Data'First + (I - 1));
      end loop;
      if Data'Length < 40 then
         A := Load (Key, 0); B := Load (Key, 4);
         C := Load (Key, 8); D := Load (Key, 12);
         Inc := Shift_Left (B, 1) or 1;
         Next (Ignore);
         Rng := Rng + A; Next (Ignore);
         Rng := Rng xor C; Next (Ignore);
         Rng := Rng xor D; Next (Ignore);
         for I in (Data'Length + 3) / 4 .. 9 loop
            Next (Ignore);
            Store (Key, 4 * I, Ignore);
         end loop;
      end if;
   end Expand_Seed;

   procedure Block (State : in out Words; Buffer : out String) is
      X : Words := State;
   begin
      Buffer := [others => Character'Val (0)];
      for Round in 1 .. 10 loop
         Quarter (X (0), X (4), X (8), X (12));
         Quarter (X (1), X (5), X (9), X (13));
         Quarter (X (2), X (6), X (10), X (14));
         Quarter (X (3), X (7), X (11), X (15));
         Quarter (X (0), X (5), X (10), X (15));
         Quarter (X (1), X (6), X (11), X (12));
         Quarter (X (2), X (7), X (8), X (13));
         Quarter (X (3), X (4), X (9), X (14));
      end loop;
      for I in X'Range loop
         Store (Buffer, 4 * I, X (I) + State (I));
      end loop;
      State (12) := State (12) + 1;
      if State (12) = 0 then
         State (13) := State (13) + 1;
      end if;
   end Block;
end Math_Prime_Util.Random_Core;
