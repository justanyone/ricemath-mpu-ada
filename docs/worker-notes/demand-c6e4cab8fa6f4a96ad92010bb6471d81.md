I will inspect the existing random-number port and the GNATcheck gate failure.
I will make the smallest correction supported by the failing check and preserve the authorized scope.
I will run the focused checks and project gate, and record any toolchain limitations.
GNATcheck is absent from Alire PATH and no report-producing invocation exists in this repository; the provided report-error cannot identify an Ada lint violation.
Compat_Random was not registered. I added its AUnit registration and am rebuilding the tests to validate the existing port.
The AUnit registration builds successfully. A temporary runner under tests/obj executes only Version_Suite, including the random fixtures; the project gate is also running.
The random spec, body, and compat test remain exactly 400 lines; no generated STATUS.md edits or lint suppressions were made.
