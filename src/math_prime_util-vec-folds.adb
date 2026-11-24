with Ada.Containers.Vectors;
with Ada.Containers.Generic_Array_Sort;

package body Math_Prime_Util.Vec.Folds with SPARK_Mode => On is
   package Results is new Ada.Containers.Vectors
     (Index_Type => Positive, Element_Type => U64);

   function To_Array (Items : Results.Vector) return Value_Array is
     ([for V of Items => V]);

   function Canonical (Items : Value_Array) return Value_Array is
      Sorted : Value_Array := Items;
      Count : Natural := 0;
      procedure Sort is new Ada.Containers.Generic_Array_Sort
        (Positive, U64, Value_Array);
   begin
      Sort (Sorted);
      for V of Sorted loop
         if Count = 0 or else Sorted (Sorted'First + (Count - 1)) /= V then
            Sorted (Sorted'First + Count) := V;
            Count := Count + 1;
         end if;
      end loop;
      return Sorted (Sorted'First .. Sorted'First + (Count - 1));
   end Canonical;

   function Vecreduce (Items : Value_Array) return Int.Optional_U64 is
      Acc : U64;
   begin
      if Items'Length = 0 then
         return (Defined => False);
      end if;
      Acc := Items (Items'First);
      for Offset in 1 .. Items'Length - 1 loop
         Acc := Block (Acc, Items (Items'First + Offset));
      end loop;
      return (Defined => True, Value => Acc);
   end Vecreduce;

   function Vecslide (Items : Value_Array) return Value_Array is
     ([for Offset in 1 .. Items'Length - 1 =>
         Block (Items (Items'First + (Offset - 1)),
                Items (Items'First + Offset))]);

   function Vecpairwise (Left, Right : Value_Array) return Value_Array is
      Result : Results.Vector;
   begin
      for Offset in 0 .. Natural'Min (Left'Length, Right'Length) - 1 loop
         for V of Block (Left (Left'First + Offset),
                         Right (Right'First + Offset))
         loop
            Result.Append (V);
         end loop;
      end loop;
      return To_Array (Result);
   end Vecpairwise;

   function Vecwindow
     (Step, Size : Positive; Items : Value_Array) return Value_Array
   is
      Result : Results.Vector;
      Offset : Natural := 0;
   begin
      if Size > Items'Length then
         return [];
      end if;
      loop
         for V of Block (Items (Items'First + Offset ..
                                Items'First + Offset + (Size - 1)))
         loop
            Result.Append (V);
         end loop;
         exit when Step > Items'Length - Size - Offset;
         Offset := Offset + Step;
      end loop;
      return To_Array (Result);
   end Vecwindow;

   function Setbinop
     (Left : Value_Array; Right : access constant Value_Array := null)
      return Value_Array
   is
      A : constant Value_Array := Canonical (Left);
      B : constant Value_Array :=
        (if Right = null then A else Canonical (Right.all));
      Result : Results.Vector;
   begin
      for X of A loop
         for Y of B loop
            Result.Append (Block (X, Y));
         end loop;
      end loop;
      return Canonical (To_Array (Result));
   end Setbinop;
end Math_Prime_Util.Vec.Folds;
