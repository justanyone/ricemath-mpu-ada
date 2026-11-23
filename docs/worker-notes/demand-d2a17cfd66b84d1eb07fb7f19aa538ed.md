# MPUADA-PRIME-COUNT-USES-THE-LMO-METHOD-FROM-MPU-SO-COUNTS

Intent: Prime_Count must use the MPU LMO/Lehmer method (lmo.c, lehmer.c, prime_count_tables.h) so counts reach 2^64. Raise Prime_Count_Limit and Nth_Prime_Limit from 2e13/3e11 to the U64 range C supports, un-skip the 18 prime_count and 17 nth_prime fixture rows, and record the 10^k benchmark to 10^13.

The launcher says origin/dev-mpuada-001 is already in this branch, so first verify whether LMO is already ported and only fix failing tests.

Next: locate Prime_Count, limits, skipped fixture rows, and the LMO/Lehmer sources.
Lucy Prime_Count is still the body; limits are 2e13 and 3e11. Fixture prime_count rows above 2e13 are six narrow ranges (the test now calls them). Single-arg rows stop at 10^13 and 2^44, which Lucy cannot finish in the gate. Porting lmo.c plus prime_count_tables.h, crossover 66e6, and raising limits to U64'Last and MPU_MAX_PRIME_IDX.
- 2026-11-23T14:25:57Z launcher: no commit for 60 s; 91 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:26:57Z launcher: no commit for 60 s; 151 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:27:57Z launcher: no commit for 60 s; 211 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:28:57Z launcher: no commit for 60 s; 271 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:29:57Z launcher: no commit for 60 s; 331 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:30:58Z launcher: no commit for 60 s; 392 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:31:58Z launcher: no commit for 60 s; 452 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:32:58Z launcher: no commit for 60 s; 512 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:33:58Z launcher: no commit for 60 s; 572 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:34:58Z launcher: no commit for 60 s; 632 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:35:59Z launcher: no commit for 60 s; 693 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:36:59Z launcher: no commit for 60 s; 753 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:37:59Z launcher: no commit for 60 s; 813 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:38:59Z launcher: no commit for 60 s; 873 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:39:59Z launcher: no commit for 60 s; 934 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:41:00Z launcher: no commit for 60 s; 994 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:42:00Z launcher: no commit for 60 s; 1054 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:43:00Z launcher: no commit for 60 s; 1114 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md.
- 2026-11-23T14:44:30Z launcher: no commit for 60 s; 1204 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md, src/math_prime_util-count-tables.adb.
- 2026-11-23T14:46:01Z launcher: no commit for 60 s; 1295 s elapsed. Files changed so far: docs/worker-notes/demand-d2a17cfd66b84d1eb07fb7f19aa538ed.md, src/math_prime_util-count-tables.adb.
