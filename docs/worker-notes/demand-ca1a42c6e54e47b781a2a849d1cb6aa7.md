I will inspect the existing folds implementation and the reported author checks.
I will keep the task scope and reduce changed files through existing test registration where possible.
I will run focused tests and the declared gate, then record any environment limitations.
Reduced the folds tests to a standalone suite function, removing the fourth new Ada file while retaining all cases.
Ada accessibility prevents a standalone function from registering local callbacks. Reused Compat_Vec with a nested Folds suite instead, retaining all tests and reducing new Ada files to two.
The Alire environment provides neither gnatcheck nor gnatformat; running the declared compiler/test gate and checking the relocated test layout directly.
Focused tests are still building; the relocated suite has no lines over 79 columns and git diff --check is clean.
- 2026-11-24T00:04:12Z launcher: no commit for 60 s; 210 s elapsed. Files changed so far: docs/worker-notes/demand-ca1a42c6e54e47b781a2a849d1cb6aa7.md, src/math_prime_util-vec-folds.adb, src/math_prime_util-vec-folds.ads, tests/src/compat_vec.adb.
Focused tests remain in the Alire build phase without returned diagnostics; waiting for completion before starting the gate.
tools/test.sh Compat_Vec_Folds passed all 366 tests (the runner does not restrict by that argument). The declared gate is now running; new files are the two library units plus these notes.
Development/release builds and test build passed. Removed two redundant use clauses introduced by nesting; full gate tests are running.
- 2026-11-24T00:07:12Z launcher: no commit for 60 s; 391 s elapsed. Files changed so far: docs/worker-notes/demand-ca1a42c6e54e47b781a2a849d1cb6aa7.md, src/math_prime_util-vec-folds.adb, src/math_prime_util-vec-folds.ads, tests/src/compat_vec.adb.
