Implement Vec.Folds generic operations using the MPU reference semantics.
Read the project plan, current vector API, and fixture/test conventions first.
Add compatibility and edge tests, then run focused tests and the configured gate.
Keep the parent Vec API and generated STATUS.md unchanged.
Read XS/PP semantics; added native generic API with list-returning pair/window callbacks and canonical Cartesian set operation. Next add reference and fixture tests.
- 2026-11-23T23:53:56Z launcher: no commit for 60 s; 150 s elapsed. Files changed so far: docs/worker-notes/demand-ca1a42c6e54e47b781a2a849d1cb6aa7.md, src/math_prime_util-vec-folds.adb, src/math_prime_util-vec-folds.ads.
Added five operation tests and nine native bigint_sets fixture rows; named all non-native skips. Alire requires XDG_RUNTIME_DIR under obj/tmp on this worker; building now.
Development library build passed. Focused AUnit build is running; checks include empty/singleton lists, list and empty callback returns, arbitrary bounds, huge steps, canonical callback order, and input snapshots.
