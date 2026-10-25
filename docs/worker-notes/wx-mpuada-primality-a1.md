# MPUADA-PRIMALITY worker notes

Port primality.c (Miller-Rabin, BPSW, Lucas, Frobenius, is_prime) into Math_Prime_Util.Primality. Dependencies are on origin/dev-mpuada-001. miller_rabin_random stays unimplemented (needs the random module). Fixture family primality.tsv drives compat tests; algebraic laws go in prop_primality.adb.

Next: read AGENTS.md, PLAN.md §§2,5,7, existing primality/lucas/intmont units, then implement the missing functions and tests.
