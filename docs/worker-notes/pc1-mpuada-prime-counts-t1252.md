Continuing the partial Count port; inspect existing implementations first.
Implement missing count bounds, approximations and Chebyshev APIs from MPU.
Extend compatibility and property tests, then run focused tests and gate.
Preserve fixtures and generated status; record remaining algorithm gaps honestly.
Inspected prior bounded Lucy implementation and MPU bounds; adding faithful analytic APIs before attempting larger algorithm changes.
The C source uses existing real.c Li/RiemannR routines for estimates; Ada Real is available. Large native estimates require extended precision to match fixtures exactly; keep this limitation visible.
- 2026-10-20T17:54:40Z launcher: no commit for 60 s; 122 s elapsed. Files changed so far: docs/worker-notes/pc1-mpuada-prime-counts-t1252.md, src/math_prime_util-count.ads.
Added six analytic APIs and both Chebyshev APIs plus individual fixture tests. Running focused validation; LMO, large tables and proof remain.
Focused test blocked before compilation: Alire has no configured offline community index and DNS is unavailable. Checking installed toolchain locations; no dependency or tooling files changed.
About five minutes remain. Offline Alire configuration now works, but AUnit is unresolved without an index. Attempting to use the preinstalled AUnit project through GPR_PROJECT_PATH; no test result yet.
Copied installed AUnit into ignored obj/ to keep all build writes in this worktree. Added count/nth inverse, bound and phi parity properties. Added native Chebyshev endpoint constants from real.c.
