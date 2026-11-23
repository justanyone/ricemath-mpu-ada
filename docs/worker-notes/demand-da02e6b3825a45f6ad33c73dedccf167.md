Implement the almost-prime and omega-prime family APIs from MPU 0.75.
Read the plan, existing family support, fixtures, and C algorithms before editing.
Add deterministic fixture coverage and public contracts; preserve generated STATUS.md.
Run focused tests and the declared gate, recording any toolchain limitations.
Read C recursive construction and counting; factor package is absent, so use existing prime and integer primitives. Next implement exact lists/counts/nth and replay their fixtures.
Implemented exact recursive lists/counts/nth and narrow factor sieving. Alire needs XDG_RUNTIME_DIR redirected into obj/tmp on this host; checking compilation next.
Exact fixture replay written. First build fails because Alire/gprbuild cannot locate an Ada compiler; checking local toolchain availability while adding bounds and edge coverage.
- 2026-11-23T08:47:36Z launcher: no commit for 60 s; 271 s elapsed. Files changed so far: docs/worker-notes/demand-da02e6b3825a45f6ad33c73dedccf167.md, src/math_prime_util-families.adb, src/math_prime_util-families.ads, tests/src/compat_families.adb.
- 2026-11-23T08:48:36Z launcher: no commit for 60 s; 331 s elapsed. Files changed so far: docs/worker-notes/demand-da02e6b3825a45f6ad33c73dedccf167.md, src/math_prime_util-families.adb, src/math_prime_util-families.ads, tests/src/compat_families.adb.
Located installed GNAT and restored build via PATH. Compilation succeeded; linking exposed a container reference issue in the new test iterator, changed to Element access. Count bounds and estimates are now ported.
