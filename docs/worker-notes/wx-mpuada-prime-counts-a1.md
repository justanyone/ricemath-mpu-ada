# wx-mpuada-prime-counts-a1

Port prime_counts.c, lmo.c, lehmer.c, legendre_phi.c, prime_count_cache.c, prime_count_tables.h, prime_sums.c into Math_Prime_Util.Count. Dependencies are now on origin/dev-mpuada-001. First step: read the existing count spec/body and compat tests, then fill only what the count fixture still needs.

- t0: notes written; next is size check of named files and the current count API.
- t1: Count package, compat tests, and suite wiring are already on the merged head. Fixed prime_count_lower coefficient -3.0 for 300071 .. 299999 (C branch). Next: time Prime_Count and run tools/test.sh.
- t2: spot checks match fixtures (pi(10^10)=455052511 in 0.03s, nth, bounds, phi(2^32,20), sum). No tools/bench_vs_perl.pl. Next: tools/test.sh.


- 2026-10-25T04:58:20Z launcher: no commit for 61 s; 91 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-prime-counts-a1.md.
- 2026-10-25T04:59:20Z launcher: no commit for 60 s; 151 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-prime-counts-a1.md.
- 2026-10-25T05:00:20Z launcher: no commit for 60 s; 211 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-prime-counts-a1.md.
- 2026-10-25T05:01:22Z launcher: no commit for 62 s; 274 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-prime-counts-a1.md.
- 2026-10-25T05:04:24Z launcher: no commit for 61 s; 455 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-prime-counts-a1.md, src/math_prime_util-count.adb.
