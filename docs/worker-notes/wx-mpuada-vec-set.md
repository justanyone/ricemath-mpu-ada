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
