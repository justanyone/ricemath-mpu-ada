Resolve the merge conflict in tests/src/compat_vec.adb while preserving both branches' test coverage.
Read PLAN.md and STATUS.md, then inspect the conflicting test registration and implementations.
Keep changes limited to the conflict resolution and this required work record.
Run focused vector tests and the configured project gate; record any toolchain limitations.
The sole conflict joins fold/window/set test declarations with base predicate tests; retained both, including their existing registrations. Starting checked builds and gate verification.
Alire initially failed because /run/user/1000 is unwritable; setting TMPDIR and XDG_RUNTIME_DIR under obj/worker-tmp lets the checked build proceed. The configured gate has been launched with the same environment.
Confirmed all eight base predicate registrations and all six branch fold/window/set registrations remain in Compat_Vec. Builds are progressing with existing style warnings; no unrelated source edits are needed.
Development build passed. Release compilation is in progress; checked tests will run next through the gate. No additional conflict or source change has appeared.
Checked test compilation now uses the pinned AUnit dependency and the validation profile. Release and validation builds continue; the conflict resolution retains both test suites without modifying fixtures.
Validation compilation has reached the AUnit compatibility units, including both merged test families. The gate remains in progress; existing compiler warnings have not stopped builds.
