with Ada.Assertions;
with Math_Prime_Util.Int.Wide;

--  Deterministic boundary tests for the factor128.c arithmetic foundation.
procedure Wide_Runner is
   use Math_Prime_Util;
   use type U64;
   use type U128;
   package W renames Math_Prime_Util.Int.Wide;
   procedure Check (Condition : Boolean; Message : String) is
   begin
      Ada.Assertions.Assert (Condition, Message);
   end Check;
   M : constant U128 := U128'Last;
   H : constant U128 := 2 ** 127;
   R : constant U128 := U128 (U64'Last);
   type Inputs is array (Positive range <>) of U128;
   Values : constant Inputs :=
     [0, 1, 2, 2 ** 32 - 1, 2 ** 32 + 1,
      2 ** 63 - 1, 2 ** 63 + 1, 2 ** 64 - 1,
      2 ** 64, 2 ** 64 + 1, H - 1, H, H + 1, M];
   Root : U128;
   Rejected : Boolean := False;
begin
   Check (W.Addmod (M - 1, M - 1, M) = M - 2, "add carry");
   Check (W.Addmod (0, 0, 1) = 0, "modulus one");
   Check (W.Addmod (1, 2, M) = 3, "add without carry");
   Check (W.Submod (0, M - 1, M) = 1, "subtract borrow");
   Check (W.Submod (M - 1, 1, M) = M - 2, "subtract");
   Check (W.Mulmod (M - 1, M - 1, M) = 1, "full width product");
   Check (W.Mulmod (H, H, M) = 2 ** 126, "upper bit product");
   Check (W.Mulmod (M, M, M - 1) = 1, "operand reduction");
   Check (W.Mulmod (R, R, M) = R * R, "64-bit fast path");
   Check (W.Mulmod (3, H, M) = H + 1, "operand swap");
   Check (W.Mulmod (M, M, 1) = 0, "product modulus one");
   Check (W.Gcd (0, 0) = 0, "gcd zero");
   Check (W.Gcd (M, 0) = M, "gcd zero right");
   Check (W.Gcd (0, M) = M, "gcd zero left");
   Check (W.Gcd (H, H / 2) = H / 2, "wide gcd");
   Check (W.Gcd (M, M - 1) = 1, "coprime neighbors");
   for N of Values loop
      Root := U128 (W.Sqrtint (N));
      Check (Root * Root <= N, "root lower bound");
      Check (Root = R or else (Root + 1) ** 2 > N,
             "root upper bound");
      Check (W.Is_Square (Root * Root), "root square");
      Check (W.Is_Square (N) = (Root * Root = N), "square predicate");
   end loop;
   Check (W.Sqrtint (R * R - 1) = U64'Last - 1, "below largest square");
   Check (W.Sqrtint (R * R) = U64'Last, "largest square");
   Check (not W.Is_Square (R * R + 1), "above largest square");
   begin
      Root := W.Mulmod (1, 1, 0);
   exception
      when Ada.Assertions.Assertion_Error => Rejected := True;
   end;
   Check (Rejected, "zero modulus contract");
end Wide_Runner;
