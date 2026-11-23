I will inspect the existing random-number port and the GNATcheck gate failure.
I will make the smallest correction supported by the failing check and preserve the authorized scope.
I will run the focused checks and project gate, and record any toolchain limitations.
GNATcheck is absent from Alire PATH and no report-producing invocation exists in this repository; the provided report-error cannot identify an Ada lint violation.
Compat_Random was not registered. I added its AUnit registration and am rebuilding the tests to validate the existing port.
The AUnit registration builds successfully. A temporary runner under tests/obj executes only Version_Suite, including the random fixtures; the project gate is also running.
The random spec, body, and compat test remain exactly 400 lines; no generated STATUS.md edits or lint suppressions were made.
The baseline gate passed all 202 tests, including random fixtures already registered through Test_Fixture_Support. My initial registration search was too narrow; I removed the duplicate Version_Suite registration.
The focused runner also passed the 731 native random fixture cases and contracts. No Ada defect was reproduced; the remaining GNATcheck report failure is an unavailable-tool issue.
Validation result: tools/gate.sh printed == gate: green with 202/202 passing; focused random checks passed. All source changes were reverted after confirming the existing registration.
The author post-check cannot be repaired in task source: alr -n exec -- gnatcheck --version reports executable not found, and no GNATcheck report configuration exists in the checkout. The external checker/report collector must be available to repeat that check.
- 2026-11-23T09:30:50Z launcher: no commit for 60 s; 240 s elapsed. Files changed so far: docs/worker-notes/demand-c6e4cab8fa6f4a96ad92010bb6471d81.md, tests/src/compat_random.adb.
