with Interfaces;

package body Math_Prime_Util.Sieve is
   use type Interfaces.Unsigned_8;
   subtype Byte is Interfaces.Unsigned_8;
   package Byte_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => Byte);
   --  sieve.h: wheel30 and masktab30, one bit per coprime residue.
   Wheel : constant array (Natural range 0 .. 7) of U64 :=
     [1, 7, 11, 13, 17, 19, 23, 29];
   Masks : constant array (U64 range 0 .. 29) of Byte :=
     [0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 4, 0, 8, 0,
      0, 0, 16, 0, 32, 0, 0, 0, 64, 0, 0, 0, 0, 0, 128];
   Segment_Bytes : constant U64 := 32 * 1024 - 16;

   function Clear (Bits : Byte_Vectors.Vector; N : U64) return Boolean is
     (Masks (N mod 30) /= 0 and then
      (Bits (Natural (N / 30)) and Masks (N mod 30)) = 0);

   --  sieve.c: create_wheel / mark_primes. Start at max(p*p, first
   --  multiple in the segment). The quotient bound avoids wraparound.
   procedure Mark
     (Bits : in out Byte_Vectors.Vector; Base, Last, P : U64)
   is
      First : U64 := Base / P;
      M : U64;
      I : Natural;
   begin
      if Base mod P /= 0 then
         First := First + 1;
      end if;
      First := U64'Max (First, P);
      if First > Last / P then
         return;
      end if;
      M := First * P;
      loop
         I := Natural ((M - Base) / 30);
         Bits.Replace_Element (I, Bits (I) or Masks (M mod 30));
         exit when Last - M < P;
         M := M + P;
      end loop;
   end Mark;

   --  sieve.c: sieve_erat30. The primary mod-30 Eratosthenes sieve.
   function Build (N : U64) return Byte_Vectors.Vector is
      Bits : Byte_Vectors.Vector;
      P : U64;
      Limit : constant U64 := Int.Sqrtint (N);
   begin
      Bits.Set_Length (Ada.Containers.Count_Type (N / 30 + 1));
      for I in Bits.First_Index .. Bits.Last_Index loop
         Bits.Replace_Element (I, 0);
      end loop;
      Bits.Replace_Element (0, 1);
      for D in U64 range 0 .. Limit / 30 loop
         for R of Wheel loop
            P := D * 30 + R;
            if P >= 7 and P <= Limit and then Clear (Bits, P) then
               Mark (Bits, 0, N, P);
            end if;
         end loop;
      end loop;
      return Bits;
   end Build;

   protected Cache is
      procedure Ensure (N : U64);
      procedure Snapshot (N : U64; Bits : out Byte_Vectors.Vector);
      procedure Release;
   private
      Bound : U64 := 0;
      Data : Byte_Vectors.Vector;
   end Cache;

   protected body Cache is
      procedure Ensure (N : U64) is
      begin
         if Data.Is_Empty or else N > Bound then
            --  Build before replacing so failed allocation keeps old data.
            Data := Build (N);
            Bound := N;
         end if;
      end Ensure;

      procedure Snapshot (N : U64; Bits : out Byte_Vectors.Vector) is
      begin
         Ensure (N);
         Bits := Data;
      end Snapshot;

      procedure Release is
         Empty : Byte_Vectors.Vector;
      begin
         Data.Move (Empty);
         Bound := 0;
      end Release;
   end Cache;

   procedure Prime_Precalc (N : U64) is
   begin
      Cache.Ensure (N);
   end Prime_Precalc;

   procedure Prime_Memfree is
   begin
      Cache.Release;
   end Prime_Memfree;

   function Primes (Low, High : U64) return Prime_Vectors.Vector is
      Result : Prime_Vectors.Vector;
      Primary, Segment : Byte_Vectors.Vector;
      Base, Last, P, Candidate : U64;
      Limit : constant U64 := Int.Sqrtint (High);
   begin
      if Low > High or High < 2 then
         return Result;
      end if;
      for Small of Prime_Vectors.Vector'([2, 3, 5]) loop
         if Small >= Low and Small <= High then
            Result.Append (Small);
         end if;
      end loop;
      if High < 7 then
         return Result;
      end if;
      Cache.Snapshot (Limit, Primary);
      Base := (Low / 30) * 30;
      loop
         Last := Base + U64'Min (High - Base, Segment_Bytes * 30 - 1);
         Segment.Set_Length
           (Ada.Containers.Count_Type ((Last - Base) / 30 + 1));
         for I in Segment.First_Index .. Segment.Last_Index loop
            Segment.Replace_Element (I, 0);
         end loop;
         for D in U64 range 0 .. Limit / 30 loop
            for R of Wheel loop
               P := D * 30 + R;
               if P >= 7 and P <= Limit and then Clear (Primary, P) then
                  Mark (Segment, Base, Last, P);
               end if;
            end loop;
         end loop;
         for I in Segment.First_Index .. Segment.Last_Index loop
            for R of Wheel loop
               Candidate := U64 (I) * 30 + R;
               if Candidate <= Last - Base then
                  Candidate := Base + Candidate;
                  if Candidate >= U64'Max (Low, 7) and then
                    (Segment (I) and Masks (R)) = 0
                  then
                     Result.Append (Candidate);
                  end if;
               end if;
            end loop;
         end loop;
         exit when Last = High;
         Base := Last + 1;
      end loop;
      return Result;
   end Primes;

   function Primes (High : U64) return Prime_Vectors.Vector is
     (Primes (2, High));

   function Sum_Primes (Low, High : U64) return Int.Optional_U64 is
      Sum : U64 := 0;
   begin
      for P of Primes (Low, High) loop
         if P > U64'Last - Sum then
            return (Defined => False);
         end if;
         Sum := Sum + P;
      end loop;
      return (Defined => True, Value => Sum);
   end Sum_Primes;
end Math_Prime_Util.Sieve;
