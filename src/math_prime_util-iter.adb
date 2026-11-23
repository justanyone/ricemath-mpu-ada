with Math_Prime_Util.Primality;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Iter is
   use type Primality.Prime_Result;

   procedure Lastfor (Context : in out Loop_Context) is
   begin
      if not Context.Active then
         raise Constraint_Error with "lastfor called outside a loop";
      end if;
      Context.Stop := True;
   end Lastfor;

   function Prime_Iterator (Start : U64 := 2) return Prime_Cursor is
   begin
      if Start <= 2 then
         return (Pending => (Defined => True, Value => 2));
      else
         return (Pending => Sieve.Next_Prime (Start - 1));
      end if;
   end Prime_Iterator;

   procedure Next
     (Cursor : in out Prime_Cursor; Value : out Int.Optional_U64) is
   begin
      Value := Cursor.Pending;
      if Cursor.Pending.Defined then
         Cursor.Pending := Sieve.Next_Prime (Cursor.Pending.Value);
      end if;
   end Next;

   function Prime_Iterator_Object (Start : U64 := 2) return Prime_Object is
     (Current => Prime_Iterator (Start).Pending);

   function Value (Cursor : Prime_Object) return Int.Optional_U64 is
     (Cursor.Current);

   function Peek (Cursor : Prime_Object) return Int.Optional_U64 is
     (if Cursor.Current.Defined then
         Sieve.Next_Prime (Cursor.Current.Value)
      else (Defined => False));

   procedure Next (Cursor : in out Prime_Object) is
   begin
      Cursor.Current := Peek (Cursor);
   end Next;

   procedure Prev (Cursor : in out Prime_Object) is
   begin
      if not Cursor.Current.Defined then
         Cursor.Current := Sieve.Prev_Prime (U64'Last);
      elsif Cursor.Current.Value > 2 then
         Cursor.Current := Sieve.Prev_Prime (Cursor.Current.Value);
      end if;
   end Prev;

   procedure Rewind (Cursor : in out Prime_Object; Start : U64 := 2) is
   begin
      Cursor.Current := Prime_Iterator (Start).Pending;
   end Rewind;

   procedure Iterate
     (Cursor : in out Prime_Object; Result : out Int.Optional_U64) is
   begin
      Result := Cursor.Current;
      Next (Cursor);
   end Iterate;

   procedure Print_Primes
     (Low, High : U64; File : Ada.Text_IO.File_Type)
   is
      pragma SPARK_Mode (Off);
      package Number_IO is new Ada.Text_IO.Modular_IO (U64);
      Cursor : Prime_Cursor := Prime_Iterator (Low);
      P : Int.Optional_U64;
   begin
      loop
         P := Cursor.Pending;
         exit when not P.Defined or else P.Value > High;
         Number_IO.Put (File, P.Value, Width => 0);
         Ada.Text_IO.New_Line (File);
         Next (Cursor, P);
      end loop;
   end Print_Primes;

   procedure Print_Primes (Low, High : U64) is
      pragma SPARK_Mode (Off);
   begin
      Print_Primes (Low, High, Ada.Text_IO.Standard_Output);
   end Print_Primes;

   procedure Forprimes
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Cursor : Prime_Cursor;
      Value : Int.Optional_U64;
   begin
      if Low > High or else High < 2 then
         return;
      end if;
      Cursor := Prime_Iterator (Low);
      loop
         --  Do not compute the successor until after the callback.
         Value := Cursor.Pending;
         exit when not Value.Defined or else Value.Value > High;
         Process (Value.Value, Context);
         exit when Context.Stop or else Value.Value = High;
         Next (Cursor, Value);
      end loop;
   end Forprimes;

   procedure Forprimes
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context)) is
   begin
      Forprimes (2, High, Process);
   end Forprimes;

   procedure Forcomposites
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Value : U64 := U64'Max (4, Low);
   begin
      if Value > High then
         return;
      end if;
      loop
         if Primality.Is_Prime (Value) = 0 then
            Process (Value, Context);
         end if;
         exit when Context.Stop or else Value = High;
         Value := Value + 1;
      end loop;
   end Forcomposites;

   procedure Forcomposites
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context)) is
   begin
      Forcomposites (4, High, Process);
   end Forcomposites;

   --  factor.c: prho_factor. Deterministic rho splitting, used until the
   --  separate Factor package is available. All products use mulmod.
   function Split (N : U64) return U64
     with Pre => N >= 4,
          Post => Split'Result > 1 and then Split'Result < N
            and then N mod Split'Result = 0;

   function Split (N : U64) return U64 is
      X, Y, D : U64;
      C : U64 := 1;
      function Step (V : U64) return U64;

      function Step (V : U64) return U64 is
      begin
         return Int.Addmod (Int.Mulmod (V, V, N).Value, C, N).Value;
      end Step;
   begin
      if N mod 2 = 0 then
         return 2;
      end if;
      loop
         X := 2;
         Y := 2;
         loop
            X := Step (X);
            Y := Step (Step (Y));
            D := Int.Gcd ((if X >= Y then X - Y else Y - X), N);
            exit when D /= 1;
         end loop;
         if D /= N then
            return D;
         end if;
         C := (if C = N - 1 then 1 else C + 1);
      end loop;
   end Split;

   procedure Forfactored
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Value : U64 := U64'Max (1, Low);
      Factors : Value_Array (1 .. 64);
      Count : Natural range 0 .. 64 := 0;
      procedure Factor (N : U64);

      procedure Factor (N : U64) is
         D : U64;
      begin
         if N = 1 then
            return;
         elsif Primality.Is_Prime (N) /= 0 then
            Count := Count + 1;
            Factors (Count) := N;
         else
            D := Split (N);
            Factor (D);
            Factor (N / D);
         end if;
      end Factor;
      Temp : U64;
      J : Positive;
   begin
      if Value > High then
         return;
      end if;
      loop
         Count := 0;
         Factor (Value);
         for I in 2 .. Count loop
            Temp := Factors (I);
            J := I;
            while J > 1 and then Factors (J - 1) > Temp loop
               Factors (J) := Factors (J - 1);
               J := J - 1;
            end loop;
            Factors (J) := Temp;
         end loop;
         Process (Value, Factors (1 .. Count), Context);
         exit when Context.Stop or else Value = High;
         Value := Value + 1;
      end loop;
   end Forfactored;

   procedure Forfactored
     (High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context)) is
   begin
      Forfactored (1, High, Process);
   end Forfactored;

   procedure Forpart
     (N : Natural;
      Process : not null access procedure
        (Parts : Value_Array; Context : in out Loop_Context);
      Options : Partition_Options := (others => <>))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Parts : Value_Array (1 .. N);
      Min_Length : constant Natural := Natural'Max (1, Options.Nmin);
      Max_Length : constant Natural := Natural'Min (N, Options.Nmax);
      Min_Part : constant Natural := Natural'Max (1, Options.Amin);
      Max_Part : constant Natural := Natural'Min (N, Options.Amax);
      procedure Visit (Remaining, Minimum, Length : Natural);

      procedure Visit (Remaining, Minimum, Length : Natural) is
      begin
         if Remaining = 0 then
            if Length >= Min_Length then
               Process (Parts (1 .. Length), Context);
            end if;
         elsif Length < Max_Length then
            for P in Minimum .. Natural'Min (Remaining, Max_Part) loop
               if Options.Prime = Any_Part or else
                 ((Primality.Is_Prime (U64 (P)) /= 0) =
                  (Options.Prime = Prime_Part))
               then
                  Parts (Length + 1) := U64 (P);
                  Visit (Remaining - P, P, Length + 1);
                  exit when Context.Stop;
               end if;
            end loop;
         end if;
      end Visit;
   begin
      if N = 0 then
         if Options.Nmin <= 1 then
            Process (Parts, Context);
         end if;
      elsif Min_Length <= Max_Length then
         Visit (N, Min_Part, 0);
      end if;
   end Forpart;

   --  XS.xs: forcomb, lexical subset traversal with one shared context.
   procedure Combinations
     (N, K : Natural; Context : in out Loop_Context;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
     with Pre => K <= N;

   procedure Combinations
     (N, K : Natural; Context : in out Loop_Context;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Values : Value_Array (1 .. K);
      procedure Visit (First, Length : Natural);

      procedure Visit (First, Length : Natural) is
      begin
         if Length = K then
            Process (Values, Context);
         elsif K - Length <= N - First then
            for V in First .. N - (K - Length) loop
               Values (Length + 1) := U64 (V);
               Visit (V + 1, Length + 1);
               exit when Context.Stop;
            end loop;
         end if;
      end Visit;
   begin
      Visit (0, 0);
   end Combinations;

   procedure Forcomb
     (N, K : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
   begin
      if K <= N then
         Combinations (N, K, Context, Process);
      end if;
   end Forcomb;

   procedure Forcomb
     (N : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
   begin
      for K in 0 .. N loop
         Combinations (N, K, Context, Process);
         exit when Context.Stop;
      end loop;
   end Forcomb;

   procedure Forperm
     (N : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Values : Value_Array (1 .. N);
      Used : array (1 .. N) of Boolean := (others => False);
      procedure Visit (Length : Natural);

      procedure Visit (Length : Natural) is
      begin
         if Length = N then
            Process (Values, Context);
         else
            for V in 1 .. N loop
               if not Used (V) then
                  Used (V) := True;
                  Values (Length + 1) := U64 (V - 1);
                  Visit (Length + 1);
                  Used (V) := False;
                  exit when Context.Stop;
               end if;
            end loop;
         end if;
      end Visit;
   begin
      Visit (0);
   end Forperm;
   procedure Forcomp
     (N : Natural;
      Process : not null access procedure
        (Parts : Value_Array; Context : in out Loop_Context);
      Options : Partition_Options := (others => <>))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Parts : Value_Array (1 .. Natural'Max (2, N));
      K : Natural := 1;
      X, Y : U64;
      Min_Part : constant Natural := Natural'Max (1, Options.Amin);
      Min_Length : constant Natural := Natural'Max (1, Options.Nmin);
      Max_Length : constant Natural := Natural'Min (N, Options.Nmax);
      Max_Part : constant Natural := Natural'Min (N, Options.Amax);
      Accept : Boolean;
   begin
      if N = 0 then
         if Options.Nmin <= 1 then
            Process (Parts (1 .. 0), Context);
         end if;
         return;
      elsif Min_Length > Max_Length or else Min_Part > Max_Part then
         return;
      end if;
      --  PP.pm: _forcompositions, iterative lexical composition traversal.
      Parts (1) := U64 (Min_Part - 1);
      Parts (2) := U64 (N - Min_Part + 1);
      while K /= 0 loop
         X := Parts (K) + 1;
         Y := Parts (K + 1) - 1;
         K := K - 1;
         while Y >= 1 loop
            Parts (K + 1) := X;
            X := 1;
            Y := Y - 1;
            K := K + 1;
         end loop;
         Parts (K + 1) := X + Y;
         while K >= Max_Length loop
            Parts (K) := Parts (K) + Parts (K + 1);
            K := K - 1;
         end loop;
         exit when Parts (1) > U64 (Max_Part);
         Accept := K + 1 >= Min_Length;
         for I in 1 .. K + 1 loop
            Accept := Accept and then Parts (I) >= U64 (Min_Part)
              and then Parts (I) <= U64 (Max_Part);
            if Options.Prime /= Any_Part then
               Accept := Accept and then
                 ((Primality.Is_Prime (Parts (I)) /= 0) =
                  (Options.Prime = Prime_Part));
            end if;
         end loop;
         if Accept then
            Process (Parts (1 .. K + 1), Context);
         end if;
         exit when Context.Stop;
      end loop;
   end Forcomp;

   procedure Forderange
     (N : Natural;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Values : Value_Array (1 .. N);
      Used : array (1 .. N) of Boolean := (others => False);
      procedure Visit (Length : Natural);

      procedure Visit (Length : Natural) is
      begin
         if Length = N then
            Process (Values, Context);
         else
            for V in 1 .. N loop
               if not Used (V) and then V /= Length + 1 then
                  Used (V) := True;
                  Values (Length + 1) := U64 (V - 1);
                  Visit (Length + 1);
                  Used (V) := False;
                  exit when Context.Stop;
               end if;
            end loop;
         end if;
      end Visit;
   begin
      Visit (0);
   end Forderange;

   procedure Formultiperm
     (Items : Value_Array;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      Keys : Value_Array (1 .. Items'Length) := Items;
      Counts : array (Keys'Range) of Natural := (others => 0);
      Values : Value_Array (Keys'Range);
      Distinct : Natural := 0;
      Temp : U64;
      J : Positive;
      procedure Visit (Length : Natural);

      procedure Visit (Length : Natural) is
      begin
         if Length = Values'Length then
            Process (Values, Context);
         else
            for I in 1 .. Distinct loop
               if Counts (I) > 0 then
                  Counts (I) := Counts (I) - 1;
                  Values (Length + 1) := Keys (I);
                  Visit (Length + 1);
                  Counts (I) := Counts (I) + 1;
                  exit when Context.Stop;
               end if;
            end loop;
         end if;
      end Visit;
   begin
      --  Perl sorts hash keys as strings, including numeric values.
      for I in 2 .. Keys'Last loop
         Temp := Keys (I);
         J := I;
         while J > 1 and then U64'Image (Keys (J - 1)) > U64'Image (Temp)
         loop
            Keys (J) := Keys (J - 1);
            J := J - 1;
         end loop;
         Keys (J) := Temp;
      end loop;
      for I in Keys'Range loop
         if Distinct = 0 or else Keys (I) /= Keys (Distinct) then
            Distinct := Distinct + 1;
            Keys (Distinct) := Keys (I);
         end if;
         Counts (Distinct) := Counts (Distinct) + 1;
      end loop;
      Visit (0);
   end Formultiperm;

   procedure Forsetproduct
     (Lists : Value_List_Vectors.Vector;
      Process : not null access procedure
        (Values : Value_Array; Context : in out Loop_Context))
   is
      Snapshot : constant Value_List_Vectors.Vector := Lists;
      Context : Loop_Context := (Active => True, Stop => False);
      Values : Value_Array (1 .. Natural (Snapshot.Length));
      Indices : array (Values'Range) of Positive;
      I : Natural;
   begin
      if Snapshot.Is_Empty then
         return;
      end if;
      for J in Values'Range loop
         if Snapshot (J)'Length = 0 then
            return;
         end if;
         Indices (J) := Snapshot (J)'First;
      end loop;
      loop
         for J in Values'Range loop
            Values (J) := Snapshot (J) (Indices (J));
         end loop;
         Process (Values, Context);
         exit when Context.Stop;
         I := Values'Last;
         while I > 0 loop
            if Indices (I) < Snapshot (I)'Last then
               Indices (I) := Indices (I) + 1;
               exit;
            end if;
            Indices (I) := Snapshot (I)'First;
            I := I - 1;
         end loop;
         exit when I = 0;
      end loop;
   end Forsetproduct;
end Math_Prime_Util.Iter;
