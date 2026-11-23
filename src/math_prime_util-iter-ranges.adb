with Ada.Containers.Vectors;
with Math_Prime_Util.Factor;
with Math_Prime_Util.Families;
with Math_Prime_Util.Sieve;

package body Math_Prime_Util.Iter.Ranges is
   use type U128;
   --  XS.xs: foroddcomposites. Enumerate gaps between segmented primes.
   procedure Foroddcomposites
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      First : U64 := U64'Max (9, Low);
      Last, C : U64;
   begin
      if First mod 2 = 0 then
         First := First + 1;
      end if;
      while First <= High loop
         Last := First + U64'Min (High - First, 30 * 32_768 - 1);
         C := First;
         for P of Sieve.Primes (First, Last) loop
            while C < P loop
               Process (C, Context);
               exit when Context.Stop;
               C := C + 2;
            end loop;
            exit when Context.Stop;
            --  An odd prime can be the largest native prime; +2 still fits.
            C := P + 2;
         end loop;
         exit when Context.Stop;
         while C <= Last loop
            Process (C, Context);
            exit when Context.Stop or else Last - C < 2;
            C := C + 2;
         end loop;
         exit when Context.Stop or else Last = High;
         First := Last + 1;
         if First mod 2 = 0 then
            exit when First = High;
            First := First + 1;
         end if;
      end loop;
   end Foroddcomposites;

   procedure Foroddcomposites
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context)) is
   begin
      Foroddcomposites (9, High, Process);
   end Foroddcomposites;

   procedure Foralmostprimes
     (K : Natural; Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      First, Last, Bound : U64;
      Reduced_K : Natural := K;
      Shift : Natural := 0;
      Power : U64;
      Segment_Size : U64;
   begin
      if K = 0 or else K >= 64 or else Low > High then
         return;
      end if;
      First := U64'Max (Low, 2 ** K);
      if First > High then
         return;
      end if;
      --  XS.xs: strip forced powers of two before generating the segment.
      if K > 40 then
         Shift := K - 40;
      end if;
      while K - Shift > 1 and then High / 2 ** Shift < 3 ** (K - Shift)
      loop
         Shift := Shift + 1;
      end loop;
      First := First / 2 ** Shift +
        (if First mod 2 ** Shift = 0 then 0 else 1);
      Bound := High / 2 ** Shift;
      Reduced_K := K - Shift;
      Power := 3 ** Reduced_K;
      while First <= Bound loop
         Segment_Size := 65_536 * 256;
         if Reduced_K > 12 then
            Segment_Size := Segment_Size * 16;
         end if;
         if Reduced_K > 18 or else U128 (First) > 9 * U128 (Power) then
            Segment_Size := Segment_Size * 4;
         end if;
         if Reduced_K > 24 or else U128 (First) > 81 * U128 (Power) then
            Segment_Size := Segment_Size * 3;
         end if;
         Last := First + U64'Min (Bound - First, Segment_Size - 1);
         if Reduced_K = 1 then
            for V of Sieve.Primes (First, Last) loop
               Process (V * 2 ** Shift, Context);
               exit when Context.Stop;
            end loop;
         else
            for V of Families.Almost_Primes (Reduced_K, First, Last) loop
               Process (V * 2 ** Shift, Context);
               exit when Context.Stop;
            end loop;
         end if;
         exit when Context.Stop or else Last = Bound;
         First := Last + 1;
      end loop;
   end Foralmostprimes;

   procedure Foralmostprimes
     (K : Natural; High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context)) is
   begin
      Foralmostprimes (K, 1, High, Process);
   end Foralmostprimes;

   procedure Forsemiprimes
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      First : U64 := U64'Max (4, Low);
      Bound : constant U64 := U64'Min (High, 18_446_744_073_709_551_601);
      Last : U64;
   begin
      --  XS.xs: forsemiprimes uses individual tests for short ranges.
      if First > Bound then
         return;
      end if;
      if Bound - First < 200 then
         loop
            if Factor.Factor (First).Count = 2 then
               Process (First, Context);
            end if;
            exit when Context.Stop or else First = Bound;
            First := First + 1;
         end loop;
         return;
      end if;
      while First <= Bound loop
         Last := First + U64'Min (Bound - First, 50_000_000 - 1);
         declare
            subtype Factor_Count is Natural range 0 .. 128;
            package Count_Vectors is new Ada.Containers.Vectors
              (Index_Type => Natural, Element_Type => Factor_Count);
            Counts : Count_Vectors.Vector;
            Root : constant U64 := Int.Sqrtint (Last);
            Q, Offset : U64;
            procedure Mark (Start, Step : U64);

            procedure Mark (Start, Step : U64) is
            begin
               Offset := (if First mod Step = 0 then 0
                          else Step - First mod Step);
               if Start > First then
                  Offset := U64'Max (Offset, Start - First);
               end if;
               while Offset <= Last - First loop
                  Counts (Natural (Offset)) := Counts (Natural (Offset)) + 1;
                  exit when Step > Last - First - Offset;
                  Offset := Offset + Step;
               end loop;
            end Mark;
         begin
            Counts.Append
              (0, Ada.Containers.Count_Type (Last - First + 1));
            --  semi_primes.c: range_semiprime_sieve / MARKSEMI. A number
            --  marked exactly once is semiprime; prime squares start at p*p.
            for P of Sieve.Primes (Root) loop
               Q := P * P;
               Mark (Q, P);
               if Q <= Last / 2 then
                  Mark (2 * Q, Q);
               end if;
            end loop;
            for I in Counts.First_Index .. Counts.Last_Index loop
               if Counts (I) = 1 then
                  Process (First + U64 (I), Context);
               end if;
               exit when Context.Stop;
            end loop;
         end;
         exit when Context.Stop or else Last = Bound;
         First := Last + 1;
      end loop;
   end Forsemiprimes;

   procedure Forsemiprimes
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context)) is
   begin
      Forsemiprimes (4, High, Process);
   end Forsemiprimes;

   procedure Forsquarefree
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      First : U64 := U64'Max (1, Low);
      F : Factor.Factor_List;
      Values : Value_Array (1 .. 64);
      Square_Free : Boolean;
   begin
      if First > High then
         return;
      end if;
      if First = 1 then
         Process (1, Values (1 .. 0), Context);
         First := 2;
      end if;
      if Context.Stop or else First > High then
         return;
      end if;
      if High - First < 100 then
         --  factor.c: factor_range_init / factor_range_next short path.
         loop
            F := Factor.Factor (First);
            Square_Free := True;
            for I in 1 .. F.Count loop
               Values (I) := F.Value (I);
               if I > 1 and then F.Value (I) = F.Value (I - 1) then
                  Square_Free := False;
               end if;
            end loop;
            if Square_Free then
               Process (First, Values (1 .. F.Count), Context);
            end if;
            exit when Context.Stop or else First = High;
            First := First + 1;
         end loop;
      else
         --  factor.c: _vec_factor. Sieve square multiples and collect prime
         --  factors in chunks, then factor residuals after a cube-root sieve.
         while First <= High loop
            declare
               Last : constant U64 :=
                 First + U64'Min (High - First, 256 * 1024 - 1);
               subtype Index is Natural range 0 .. Natural (Last - First);
               type Factor_Entry is record
                  Product : U64 := 1;
                  Count : Natural range 0 .. 15 := 0;
                  Factors : Value_Array (1 .. 15) := [others => 0];
               end record;
               package Entry_Vectors is new Ada.Containers.Vectors
                 (Index_Type => Natural, Element_Type => Factor_Entry);
               Data : Entry_Vectors.Vector;
               Root : constant U64 := Int.Sqrtint (Last);
               Full : constant Boolean := Root < 10_000_000
                 or else (Root < 35_000_000 and then Last - First > 900)
                 or else (Root < 100_000_000 and then Last - First > 1700)
                 or else (Root < 350_000_000 and then Last - First > 3400)
                 or else (Root < 1_000_000_000 and then Last - First > 5500)
                 or else (Root < 3_500_000_000 and then Last - First > 17000)
                 or else Last - First > 19000;
               Limit : constant U64 :=
                 (if Full then Root else Int.Rootint (Last, 3));
               Offset, Q : U64;
            begin
               Data.Set_Length (Ada.Containers.Count_Type (Last - First + 1));
               for P of Sieve.Primes (Limit) loop
                  Q := P * P;
                  Offset := (if First mod Q = 0 then 0
                             else Q - First mod Q);
                  while Offset <= Last - First loop
                     Data (Natural (Offset)).Product := 0;
                     exit when Q > Last - First - Offset;
                     Offset := Offset + Q;
                  end loop;
                  Offset := (if First mod P = 0 then 0
                             else P - First mod P);
                  while Offset <= Last - First loop
                     declare
                        E : Factor_Entry renames Data (Natural (Offset));
                     begin
                        if E.Product > 0 then
                           E.Count := E.Count + 1;
                           E.Factors (E.Count) := P;
                           E.Product := E.Product * P;
                        end if;
                     end;
                     exit when P > Last - First - Offset;
                     Offset := Offset + P;
                  end loop;
               end loop;
               for I in Index loop
                  declare
                     E : Factor_Entry renames Data (I);
                     N : constant U64 := First + U64 (I);
                     Remain : U64;
                  begin
                     if E.Product > 0 then
                        Remain := N / E.Product;
                        if Remain > 1 then
                           F := Factor.Factor (Remain);
                           for J in 1 .. F.Count loop
                              if J > 1 and then
                                F.Value (J) = F.Value (J - 1)
                              then
                                 E.Product := 0;
                              end if;
                              E.Count := E.Count + 1;
                              E.Factors (E.Count) := F.Value (J);
                           end loop;
                        end if;
                        if E.Product > 0 then
                           Process (N, E.Factors (1 .. E.Count), Context);
                        end if;
                     end if;
                  end;
                  exit when Context.Stop;
               end loop;
               exit when Context.Stop or else Last = High;
               First := Last + 1;
            end;
         end loop;
      end if;
   end Forsquarefree;

   procedure Forsquarefree
     (High : U64;
      Process : not null access procedure
        (Value : U64; Factors : Value_Array;
         Context : in out Loop_Context)) is
   begin
      Forsquarefree (1, High, Process);
   end Forsquarefree;

   procedure Forsquarefreeint
     (Low, High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
      First : U64 := U64'Max (1, Low);
   begin
      if First > High then
         return;
      end if;
      --  XS.xs visits one before allocating or sieving the remaining range.
      if First = 1 then
         Process (1, Context);
         First := 2;
      end if;
      if Context.Stop then
         return;
      end if;
      while First <= High loop
         declare
            Last : constant U64 :=
              First + U64'Min (High - First, 65_536 * 256 - 1);
            package Flag_Vectors is new Ada.Containers.Vectors
              (Index_Type => Natural, Element_Type => Boolean);
            Flags : Flag_Vectors.Vector;
            Root : constant U64 := Int.Sqrtint (Last);
            --  The prime sieve uses odd slots in a fixed-size segment.
            --  Local arrays avoid a controlled-container operation for every
            --  marked multiple; only the square-free result uses a vector.
            type Prime_Flags is array (Natural range 0 .. 1_048_575)
              of Boolean;
            Composite : Prime_Flags;
            Base_Primes : constant Sieve.Prime_Vectors.Vector :=
              Sieve.Primes (Int.Sqrtint (Root));
            Prime_Low : U64 := 3;
            Prime_High, Q, Offset, Multiple : U64;
            Length : Natural;
            procedure Mark_Square (P : U64);

            procedure Mark_Square (P : U64) is
            begin
               Q := P * P;
               Offset := (if First mod Q = 0 then 0
                          else Q - First mod Q);
               while Offset <= Last - First loop
                  Flags (Natural (Offset)) := False;
                  exit when Q > Last - First - Offset;
                  Offset := Offset + Q;
               end loop;
            end Mark_Square;
         begin
            Flags.Append
              (True, Ada.Containers.Count_Type (Last - First + 1));
            --  util.c: range_issquarefree. Sieve prime-square multiples.
            --  Prime generation remains a segmented Eratosthenes sieve.
            if Root >= 2 then
               Mark_Square (2);
            end if;
            while Prime_Low <= Root loop
               Prime_High := Prime_Low +
                 U64'Min (Root - Prime_Low, 2 * Composite'Last);
               Length := Natural ((Prime_High - Prime_Low) / 2);
               Composite := [others => False];
               for P of Base_Primes loop
                  exit when P > Prime_High / P;
                  if P > 2 then
                     Multiple := Prime_Low / P +
                       (if Prime_Low mod P = 0 then 0 else 1);
                     Multiple := U64'Max (P, Multiple);
                     if Multiple mod 2 = 0 then
                        Multiple := Multiple + 1;
                     end if;
                     Offset := (Multiple * P - Prime_Low) / 2;
                     while Offset <= U64 (Length) loop
                        Composite (Natural (Offset)) := True;
                        Offset := Offset + P;
                     end loop;
                  end if;
               end loop;
               for I in 0 .. Length loop
                  if not Composite (I) then
                     Mark_Square (Prime_Low + 2 * U64 (I));
                  end if;
               end loop;
               exit when Root - Prime_Low <= 2 * U64 (Length) + 1;
               Prime_Low := Prime_Low + 2 * U64 (Length) + 2;
            end loop;
            for I in Flags.First_Index .. Flags.Last_Index loop
               if Flags (I) then
                  Process (First + U64 (I), Context);
               end if;
               exit when Context.Stop;
            end loop;
            exit when Context.Stop or else Last = High;
            First := Last + 1;
         end;
      end loop;
   end Forsquarefreeint;

   procedure Forsquarefreeint
     (High : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context)) is
   begin
      Forsquarefreeint (1, High, Process);
   end Forsquarefreeint;

   procedure Fordivisors
     (N : U64;
      Process : not null access procedure
        (Value : U64; Context : in out Loop_Context))
   is
      Context : Loop_Context := (Active => True, Stop => False);
   begin
      for D of Factor.Divisors (N) loop
         Process (D, Context);
         exit when Context.Stop;
      end loop;
   end Fordivisors;
end Math_Prime_Util.Iter.Ranges;
