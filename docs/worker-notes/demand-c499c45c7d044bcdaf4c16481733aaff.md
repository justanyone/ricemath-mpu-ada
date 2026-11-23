Resolve the merge conflict in tests/src/compat_factor.adb.
Preserve the factoring checks added by both branches and follow project guidance.
Run focused validation with the available Alire toolchain, without network fetches.
Leave the resolved files for the launcher to commit; do not write git metadata.
Resolved the registration conflict by retaining U128 boundary checks and both ECM fixture/edge checks; preparing offline focused validation.
Conflict markers are absent and git diff --check passed. Alire failed creating a temporary file under /run/user/1000; retrying with TMPDIR under tests/obj.
Redirecting XDG_RUNTIME_DIR to tests/obj allowed Alire to build using available dependencies; compilation is underway.
The Alire test build passed (51 seconds); running Compat_Factor with a 60-second timeout.
Dedicated ECM runner passed both fixture and edge tests (2/2); the resolved test crate builds successfully.
Finished: both sides retained, no conflict markers, whitespace check and Alire build passed, ECM tests passed 2/2. The main runner invocation timed out after 60 seconds without output; full gate remains unverified. Launcher owns the commit.
