Vec/set port: inspect the existing API, fixture format, and MPU algorithms.
Implement native Ada vector and integer set operations with contracts.
Add compatibility and property coverage, then run the focused test and gate.
Keep the fixtures, generated status, dependencies, and build tools unchanged.
The checkout has only Int; Vec is new. Fixtures include bigint and string cases.
Start with exact signed set operations and stable vector helpers; no new crates.
Added signed vectors, insertion sorting, set merge, relations, and predicates.
Set relation direction follows xs_set_relation: subset tests B inside A.
- 2026-10-20T12:52:16Z launcher: no commit for 60 s; 181 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-vec-set.md.
Added fixture replay per implemented function, with named bigint skips.
Added seeded set laws, duplicate insert, shifted bounds, and invalid set checks.
Focused test build started. Callback operations and arithmetic vectors remain.
The current Sidon predicate uses exact wide comparisons; hash port is pending.
Focused test stopped before compilation: Alire has no index in this sandbox.
The cached compiler and AUnit exist; investigate offline resolution only.
Offline index resolves cached AUnit; compiler external metadata needs setup.
No manifest or tooling changes were made. Continue validation within obj.
Offline Alire cannot select gnat_external despite working host binaries.
Stop retrying that resolver; run a compiler check and the required gate.
About five minutes remain: prioritize a correct partial port and clear limits.
Vec now passes gcc -gnat2022 -gnata -gnaty -gnatwa -gnatwe compilation.
Gate builds development and release, then fails tests compiler resolution.
Existing Int style messages were observed and left outside task scope.
NOTES: Partial implementation. Missing arithmetic, frequency, extraction,
closures, windows, sumset, and full-width fixture support. Sorting uses the
reference insertion kernel, not its complete production sort dispatch.
Sidon and sumfree results use wide exhaustive checks; hashed/binary-search
reference methods remain to be ported. No performance claim or SPARK proof.
Gate did not reach green: test crate cannot resolve its external compiler.
Final: implementation and two suites are on disk; launcher owns commits.
Strict library compilation passed; runtime tests and gate remain unverified.
No fixtures, status ticks, manifests, or repository build tools were changed.
Both test bodies passed compile-only checks using cached AUnit headers.
Added local helper declarations to resolve the new test GNAT style messages.
Runtime assertions have not run; fixture results are not claimed as passing.
