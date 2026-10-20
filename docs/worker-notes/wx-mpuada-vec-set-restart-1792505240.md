Review the existing Vec API, C sources, and fixture tests.
Check dependencies without adding crates or changing build tools.
Run focused Vec tests, fix reproducible gaps, then run the gate.
Keep all edits in this worktree; leave commits to the launcher.
Existing API and suites cover the requested names. Focused Vec build is running; review now checks C algorithms and fixture exclusions.
Baseline: all 76 tests pass. The runner ignores filter arguments. Added an upper-index-bound regression to check Ada array bounds before changing the implementation.
Regression reproduced Constraint_Error in Merge at Positive last. Use zero-based merge offsets and subtract before adding array bounds in vector callbacks and extraction.
Aligned set relations with the C intersection-count merge and sum-free checks with pair sums plus binary search. These changes remove temporary relation vectors and repeated linear membership scans.
Gate is green with 77 tests, including the previously failing regression. Reviewing remaining C sort dispatch: existing sort uses insertion for all lengths; added independent boundary cases before porting its dispatch.
Ported the C sort dispatch: quicksort below 400, insertion cutoff 16, median-of-nine partition, heap fallback, and signed byte radix above the cutoff. Added seeded oracle tests across dispatch bounds.
The first gate passed. Additional sort work is now under test; no dependencies or build scripts changed. Remaining review targets are hash-based uniqueness/Sidon checks and proof coverage.
Sort regression caught checked conversion of negative I64 to U64. Replaced it with U64 Mod and retained the C Storage_Error fallback to quicksort.
