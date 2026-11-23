# MPUADA-PRIME-POWERS

Port prime-power and perfect-power functions from reference/mpu/prime_powers.c and perfect_powers.c into Math_Prime_Util.Families, then replay tests/fixtures/families.tsv in compat_families.adb.

Why: STATUS.md still has those functions unticked, and families.ads has lucky, Ramanujan, twin, and semiprime only. The launcher note says the base already contains origin/dev-mpuada-001, so I will verify what is already present and fill only the missing port and its tests.

Next: list the fixture function names, read the C entry points, and match the twin/semiprime port style.
Tried the families spec and both C files: prime and perfect powers are not ported yet. Fixtures live in families.tsv. A few rows are past the C UV/IV domain (2^64 or bigint negatives) and will be named skips.
Next: add the subprograms to Math_Prime_Util.Families and replay them from compat_families.adb.
- 2026-11-23T13:39:20Z launcher: no commit for 60 s; 120 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:40:20Z launcher: no commit for 60 s; 180 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:41:20Z launcher: no commit for 60 s; 240 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:42:20Z launcher: no commit for 60 s; 301 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:43:20Z launcher: no commit for 60 s; 361 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:44:21Z launcher: no commit for 60 s; 421 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:45:21Z launcher: no commit for 60 s; 481 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:46:21Z launcher: no commit for 60 s; 541 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:47:21Z launcher: no commit for 60 s; 602 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:48:21Z launcher: no commit for 60 s; 662 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:49:22Z launcher: no commit for 60 s; 722 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:50:22Z launcher: no commit for 60 s; 782 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:51:22Z launcher: no commit for 60 s; 843 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:52:22Z launcher: no commit for 60 s; 903 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:53:22Z launcher: no commit for 60 s; 963 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:54:23Z launcher: no commit for 60 s; 1023 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md.
- 2026-11-23T13:56:23Z launcher: no commit for 60 s; 1143 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md, src/math_prime_util-families.ads.
- 2026-11-23T13:57:23Z launcher: no commit for 60 s; 1204 s elapsed. Files changed so far: docs/worker-notes/demand-81b894cbec2e48a0b05daf3ac8a34d88.md, src/math_prime_util-families.ads.
