Implement the six filtered iterator ranges in a new Iter.Ranges child.
Read the native iterator and upstream segment algorithms to preserve behavior.
Add fixture compatibility and Lastfor tests, then run focused tests and gate.
Keep the parent iterator spec and generated STATUS.md unchanged.
Read XS loop dispatch and factor-range sieve; added the public child spec without changing the parent.
Implemented segmented ranges and fixture replay, including explicit bigint skip lines and six Lastfor checks. Starting focused build/tests.
Focused test launch required obj creation and XDG_RUNTIME_DIR redirection because Alire defaults outside the writable checkout; build now running.
Focused build remains pending with no compiler output; checking Alire verbose diagnostics before further validation.
Implemented the dedicated MARKSEMI range sieve and moved square-free flags to heap-backed bounded storage; compiler/test diagnostics pending.
Development library build succeeded. Fixed fixture diagnostic typo, segment-end odd-composite handling, and added XS almost-prime power-of-two reduction.
Corrected vector initialization and reran the focused suite; retaining upstream segmented algorithms and all native boundary rows.
Gate development build passed; release build is running. Added empty/reversed ranges, K=63 reduction, and a factor-segment boundary test.
Square-free integer loop now visits one before allocation, matching XS Lastfor behavior; waiting for focused results and gate.
Gate release and tests builds passed. Native square-free U64 fixture is still running and may conflict with the owner one-minute test limit; checking isolated execution controls.
The stock AUnit runner also starts tests for --help, indicating CLI filter arguments are ignored. Added a dedicated focused runner to measure this package independently.
Stopped duplicate unfiltered test jobs. Corrected focused-runner source path after the first gprbuild attempt reported it missing.
Focused runner compilation is active; gate is still in the full existing test suite. No parent spec, fixtures, tools, or generated STATUS changes.
Dedicated package runner built successfully and is running with a 60-second timeout. Line-length and git whitespace checks passed.
Full gate tests and bounded focused run remain active; no additional implementation changes while collecting results.
Awaiting the focused timeout verdict before deciding whether the exact upstream square-free sieve meets the owner runtime guardrail.
Focused suite timed out at 60.02 seconds. Added named-routine selection to the dedicated runner to isolate runtime instead of weakening fixture coverage.
Replaced controlled-vector operations inside the prime segment sieve with a fixed odd-slot array, retaining segmented Eratosthenes and prime-square marking to reduce runtime without per-value square-free tests.
Rebuilding optimized square-free sieve and running the selected edge test. Stopped the earlier gate run because it used the pre-optimization library.
Selected edge test passed in 0.42 seconds, including chunk crossing and K=63. Correcting one U64 conversion in the optimized prime-segment bound.
Added Lastfor checks for short and segmented square-free factor paths and for the integer sieve after two; optimized focused run is in progress.
Restored the XS native semiprime narrow-range threshold ladder, preventing huge sieving-prime allocation for short high ranges; preparing the final gate run.
Square-free integer fixture replay passed in 39.54 seconds, including U64 maximum. The optimized segment buffer satisfies the one-minute guardrail without skipping native rows.
Final development and release builds passed after threshold and Lastfor changes; final gate test build/run remains in progress.
All eight focused tests passed in 36.44 seconds: six fixture groups, Lastfor, and edges. Final gate is running the complete repository suite.
Rebuilt the focused runner against the final threshold and Lastfor changes; final focused rerun and repository gate are active.
Final focused run passed all eight tests in 31.12 seconds with no failed assertions or unexpected errors. Awaiting the full gate test summary.
- 2026-11-23T22:55:53Z launcher: no commit for 60 s; 1034 s elapsed. Files changed so far: docs/worker-notes/demand-2ee1af7e9ada4107b3f0895b8cb0bacc.md, src/math_prime_util-iter-ranges.adb, src/math_prime_util-iter-ranges.ads, tests/src/all_suites.adb, tests/src/compat_iter_ranges.adb, tests/src/compat_iter_ranges.ads, tests/src/iter_ranges_runner.adb.
Final source-fidelity review restored the C semiprime small-value table and bounded prime segments (including the initial 30000 cut), with a Lastfor test for the table path.
Restarted focused and full gate validation after restoring semiprime source details; whitespace and 79-column checks remain clean.
- 2026-11-23T22:57:54Z launcher: no commit for 60 s; 1155 s elapsed. Files changed so far: docs/worker-notes/demand-2ee1af7e9ada4107b3f0895b8cb0bacc.md, src/math_prime_util-iter-ranges.adb, src/math_prime_util-iter-ranges.ads, tests/src/all_suites.adb, tests/src/compat_iter_ranges.adb, tests/src/compat_iter_ranges.ads, tests/src/iter_ranges_runner.adb.
Final semiprime table/segment version passed all eight focused tests in 33.14 seconds. All three gate build stages passed; the full repository test stage is running.
Full gate remains in tests-run with no summary yet; final focused suite is green at 33.14 seconds and source files remain unchanged.
The full repository gate is still running. Checking the required SPARK proof tool independently while preserving the tested code.
SPARK proof could not run: alr exec reports gnatprove is not in PATH. No tool installation or dependency change attempted; full gate tests remain active.
Finished: tools/gate.sh printed == gate: green; all 348 repository tests passed. Final focused suite: 8/8 in 33.14 seconds. SPARK proof remains unverified because gnatprove is unavailable; no source work remains.
