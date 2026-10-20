package body Math_Prime_Util.Lucas is
   use type U128;

   function Residue (A : I64; N : U64) return U64 is
     (U64 (I128 (A) mod I128 (N)));

   function Add (A, B, N : U64) return U64 is
     (U64 ((U128 (A) + U128 (B)) mod U128 (N)));
   function Sub (A, B, N : U64) return U64 is
     (U64 ((U128 (A) + U128 (N) - U128 (B)) mod U128 (N)));
   function Mul (A, B, N : U64) return U64 is
     (U64 (U128 (A) * U128 (B) mod U128 (N)));

   function Top_Bit (K : U64) return Natural;
   function Top_Bit (K : U64) return Natural is
      V : U64 := K;
      B : Natural := 0;
   begin
      while V > 1 loop
         V := V / 2;
         B := B + 1;
      end loop;
      return B;
   end Top_Bit;

   --  lucas_seq.c: alt_lucas_seq, the general branch for all moduli.
   function Alternate (P, Q, K, N : U64) return Residue_Pair;
   function Alternate (P, Q, K, N : U64) return Residue_Pair is
      Uh : U64 := 1;
      Vl : U64 := 2 mod N;
      Vh : U64 := P;
      Ql, Qh : U64 := 1;
      S : Natural := 0;
      Bits : U64 := K;
   begin
      while Bits mod 2 = 0 loop
         Bits := Bits / 2;
         S := S + 1;
      end loop;
      for J in reverse S + 1 .. Top_Bit (K) loop
         Ql := Mul (Ql, Qh, N);
         if (K / 2 ** J) mod 2 = 1 then
            Qh := Mul (Ql, Q, N);
            Uh := Mul (Uh, Vh, N);
            Vl := Sub (Mul (Vh, Vl, N), Mul (P, Ql, N), N);
            Vh := Sub (Mul (Vh, Vh, N), Add (Qh, Qh, N), N);
         else
            Qh := Ql;
            Uh := Sub (Mul (Uh, Vl, N), Ql, N);
            Vh := Sub (Mul (Vh, Vl, N), Mul (P, Ql, N), N);
            Vl := Sub (Mul (Vl, Vl, N), Add (Ql, Ql, N), N);
         end if;
      end loop;
      Ql := Mul (Ql, Qh, N);
      Qh := Mul (Ql, Q, N);
      Uh := Sub (Mul (Uh, Vl, N), Ql, N);
      Vl := Sub (Mul (Vh, Vl, N), Mul (P, Ql, N), N);
      Ql := Mul (Ql, Qh, N);
      for J in 1 .. S loop
         Uh := Mul (Uh, Vl, N);
         Vl := Sub (Mul (Vl, Vl, N), Add (Ql, Ql, N), N);
         Ql := Mul (Ql, Ql, N);
      end loop;
      return (Uh, Vl);
   end Alternate;

   function Lucasuvmod (P, Q : I64; K, N : U64) return Residue_Pair is
      Pm : constant U64 := Residue (P, N);
      Qm : constant U64 := Residue (Q, N);
      D, U, V, Qk, T : U64;
      Inv : Int.Optional_U64;
   begin
      if N = 1 then
         return (0, 0);
      elsif K = 0 then
         return (0, 2 mod N);
      end if;
      D := Sub (Mul (Pm, Pm, N), Mul (4, Qm, N), N);
      --  The degenerate discriminant formula requires an inverse of 2.
      if D = 0 and N mod 2 = 1 then
         T := Mul (Pm, N / 2 + 1, N);
         if T /= 0 then
            return (Mul (K, Int.Powmod (T, K - 1, N).Value, N),
                    Mul (2, Int.Powmod (T, K, N).Value, N));
         end if;
      end if;
      Inv := Int.Invmod (D, N);
      U := 1;
      V := Pm;
      if Qm = 1 and Inv.Defined then
         U := Sub (Mul (Pm, Pm, N), 2 mod N, N);
         for B in reverse 0 .. Integer (Top_Bit (K)) - 1 loop
            T := Sub (Mul (U, V, N), Pm, N);
            if (K / 2 ** B) mod 2 = 1 then
               V := T;
               U := Sub (Mul (U, U, N), 2 mod N, N);
            else
               U := T;
               V := Sub (Mul (V, V, N), 2 mod N, N);
            end if;
         end loop;
         U := Mul (Sub (Add (U, U, N), Mul (V, Pm, N), N),
                   Inv.Value, N);
      elsif N mod 2 = 0 or (Pm = 1 and Qm = N - 1) then
         return Alternate (Pm, Qm, K, N);
      else
         Qk := Qm;
         for B in reverse 0 .. Integer (Top_Bit (K)) - 1 loop
            U := Mul (U, V, N);
            V := Sub (Mul (V, V, N), Add (Qk, Qk, N), N);
            Qk := Mul (Qk, Qk, N);
            if (K / 2 ** B) mod 2 = 1 then
               T := Mul (U, D, N);
               U := Add (Mul (U, Pm, N), V, N);
               U := (if U mod 2 = 1 then N / 2 + U / 2 + 1 else U / 2);
               V := Add (Mul (V, Pm, N), T, N);
               V := (if V mod 2 = 1 then N / 2 + V / 2 + 1 else V / 2);
               Qk := Mul (Qk, Qm, N);
            end if;
         end loop;
      end if;
      return (U, V);
   end Lucasuvmod;

   function Lucasumod (P, Q : I64; K, N : U64) return U64 is
     (Lucasuvmod (P, Q, K, N).U);

   function Lucasvmod (P, Q : I64; K, N : U64) return U64 is
     (Lucasuvmod (P, Q, K, N).V);

   function Lucas_Sequence
     (N : U64; P, Q : I64; K : U64) return Sequence_Result
   is
      R : constant Residue_Pair := Lucasuvmod (P, Q, K, N);
   begin
      return (R.U, R.V, Int.Powmod (Residue (Q, N), K, N).Value);
   end Lucas_Sequence;

   function Native (V : I128) return Optional_Integer is
     (if V in -I128 (U64'Last) .. I128 (U64'Last)
      then (True, V) else (Defined => False));

   --  Keep the final square and subtraction unsigned until their sign is
   --  known. Either term may exceed the signed wide range.
   function Final_V (V, Qk : I128) return Optional_Integer;
   function Final_V (V, Qk : I128) return Optional_Integer is
      Square, Twice, Difference : U128;
   begin
      if V not in -I128 (U64'Last) .. I128 (U64'Last) then
         return (Defined => False);
      end if;
      Square := U128 (abs V) ** 2;
      Twice := U128 (abs Qk) * 2;
      if Qk < 0 then
         if Square > U128 (U64'Last) or Twice > U128 (U64'Last) then
            return (Defined => False);
         end if;
         return Native (I128 (Square) + I128 (Twice));
      elsif Square >= Twice then
         Difference := Square - Twice;
         if Difference <= U128 (U64'Last) then
            return (True, I128 (Difference));
         end if;
      else
         Difference := Twice - Square;
         if Difference <= U128 (U64'Last) then
            return (True, -I128 (Difference));
         end if;
      end if;
      return (Defined => False);
   end Final_V;

   function Lucasuv (P, Q : I64; K : U64) return Integer_Pair is
      Uh : I128 := 1;
      Vl : I128 := 2;
      Vh : I128 := I128 (P);
      Ql, Qh : I128 := 1;
      S : Natural := 0;
      Bits : U64 := K;
   begin
      if K = 0 then
         return ((True, 0), (True, 2));
      end if;
      while Bits mod 2 = 0 loop
         Bits := Bits / 2;
         S := S + 1;
      end loop;
      --  The C OVERHALF guards protect IV intermediates. Wide checked
      --  intermediates also cover the fixture's native unsigned results.
      for J in reverse S + 1 .. Top_Bit (K) loop
         Ql := Ql * Qh;
         if (K / 2 ** J) mod 2 = 1 then
            Qh := Ql * I128 (Q);
            Uh := Uh * Vh;
            Vl := Vh * Vl - I128 (P) * Ql;
            Vh := Vh * Vh - 2 * Qh;
         else
            Qh := Ql;
            Uh := Uh * Vl - Ql;
            Vh := Vh * Vl - I128 (P) * Ql;
            Vl := Vl * Vl - 2 * Ql;
         end if;
      end loop;
      Ql := Ql * Qh;
      Qh := Ql * I128 (Q);
      Uh := Uh * Vl - Ql;
      Vl := Vh * Vl - I128 (P) * Ql;
      if S > 0 then
         Ql := Ql * Qh;
      end if;
      for J in 1 .. S loop
         Uh := Uh * Vl;
         if J = S then
            return (Native (Uh), Final_V (Vl, Ql));
         end if;
         Vl := Vl * Vl - 2 * Ql;
         if J < S then
            Ql := Ql * Ql;
         end if;
      end loop;
      return (Native (Uh), Native (Vl));
   exception
      when Constraint_Error =>
         return (others => (Defined => False));
   end Lucasuv;

   function Lucasu (P, Q : I64; K : U64) return Optional_Integer is
     (Lucasuv (P, Q, K).U);

   function Lucasv (P, Q : I64; K : U64) return Optional_Integer is
     (Lucasuv (P, Q, K).V);

   --  lucas_seq.c: _calc_fib, retaining its k < 93 bound.
   procedure Calc_Fib (K : U64; A, B : out U64);
   procedure Calc_Fib (K : U64; A, B : out U64) is
      C, D : U64;
   begin
      if K <= 1 then
         A := K;
         B := 1;
         return;
      end if;
      A := 1;
      B := 1;
      for J in reverse 0 .. Integer (Top_Bit (K)) - 1 loop
         C := A * (2 * B - A);
         D := A * A + B * B;
         if (K / 2 ** J) mod 2 = 1 then
            A := D;
            B := C + D;
         else
            A := C;
            B := D;
         end if;
      end loop;
   end Calc_Fib;

   function Fibonacci (K : I64) return Optional_Integer is
      Magnitude : constant U64 := U64 (abs I128 (K));
      A, B : U64;
   begin
      if Magnitude <= 1 then
         return (True, I128 (Magnitude));
      elsif Magnitude > 93 then
         return (Defined => False);
      end if;
      Calc_Fib (Magnitude - 1, A, B);
      return (True, (if K < 0 and Magnitude mod 2 = 0
                     then -I128 (B) else I128 (B)));
   end Fibonacci;

   function Lucas_Number (K : I64) return Optional_Integer is
      Magnitude : constant U64 := U64 (abs I128 (K));
      A, B : U64;
      V : I128;
   begin
      if Magnitude <= 1 then
         return (True, (if K = -1 then -1 else I128 (2 - Magnitude)));
      elsif Magnitude > 93 then
         return (Defined => False);
      end if;
      Calc_Fib (Magnitude - 1, A, B);
      V := 2 * I128 (A) + I128 (B);
      if K < 0 and Magnitude mod 2 = 1 then
         V := -V;
      end if;
      return Native (V);
   end Lucas_Number;
end Math_Prime_Util.Lucas;
