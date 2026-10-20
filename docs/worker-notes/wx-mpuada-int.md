Implement the integer core with native Ada contracts and SPARK mode.
Read the MPU algorithms and replay the committed integer fixtures.
Add deterministic algebraic tests and run the focused tests and gate.
Do not change fixtures, tooling, dependencies, or generated status.

Reference and fixture shape inspected; implementing the core and test dispatch.
- 2026-10-20T11:26:12Z launcher: no commit for 61 s; 91 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-int.md.
Core written with wide modular products and explicit undefined results; adding fixture tests.
Fixture replay and seeded laws written; focused test build started.
Focused tests blocked: Alire tries to bootstrap its community index without network. Checking offline toolchain availability.
Alire lacks an index and lockfiles here; cached toolchain and AUnit exist. Testing an offline local configuration under obj.
Offline index moved outside the Alire settings tree; retrying the focused build with cached GNAT on PATH.
Five-minute checkpoint: implementation and tests exist; resolving local build project paths before compilation.
Local dependency resolution works; compiler selection still needs cached toolchain metadata.
Cached toolchains selected through the local index. Waiting for compiler diagnostics.
About five minutes remain. Local build configured; correcting the root port generator, then rerunning fixture replay and gate.
First full replay: 22 tests pass; four failures expose K=0 API semantics, error-row handling, and base-two logarithms. Fixing these before the gate.
Fixture failures reproduced and corrected: zero exponents, error rows, and base greater than the argument.
