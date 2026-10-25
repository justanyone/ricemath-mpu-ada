# MPUADA-PRIMALITY worker notes

Port primality.c (Miller-Rabin, BPSW, Lucas, Frobenius, is_prime) into Math_Prime_Util.Primality. Dependencies are on origin/dev-mpuada-001. miller_rabin_random stays unimplemented (needs the random module). Fixture family primality.tsv drives compat tests; algebraic laws go in prop_primality.adb.

Next: read AGENTS.md, PLAN.md §§2,5,7, existing primality/lucas/intmont units, then implement the missing functions and tests.
Read plan, spec, and body. Functions are already present and use Intmont.Powmod. miller_rabin_random is absent on purpose. Running tools/test.sh Compat_Primality (runner ignores the filter and runs the suite).
alr failed to create /run/user/1000 temp files. Retry with XDG_RUNTIME_DIR=/tmp and TMPDIR=/tmp.
- 2026-10-25T04:12:07Z launcher: no commit for 61 s; 91 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality-a1.md.
- 2026-10-25T04:13:07Z launcher: no commit for 60 s; 151 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality-a1.md.
- 2026-10-25T04:14:07Z launcher: no commit for 60 s; 211 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality-a1.md.
- 2026-10-25T04:15:09Z launcher: no commit for 61 s; 272 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality-a1.md.
- 2026-10-25T04:17:09Z launcher: no commit for 60 s; 392 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality-a1.md.
- 2026-10-25T04:18:10Z launcher: no commit for 61 s; 454 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality-a1.md.
