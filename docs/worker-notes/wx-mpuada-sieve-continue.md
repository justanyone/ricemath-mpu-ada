Continue the existing sieve port and preserve the fixture files.
Check the current API and reference algorithms before filling gaps.
Add regression coverage for boundaries, cache resets, and repeated calls.
Run focused sieve tests, then the repository gate, offline.
Read the current port and reference paths. Missing primality dependencies require a local native primality helper; next implement navigation and partial sieve tests.
Added strict prime navigation, native boundary handling, partial sieve offsets, and cluster checks. Focused fixture tests now exercise all new public functions; large prefix sums remain pending.
Focused test could not compile: Alire tried to create its community index and DNS is unavailable. Checking installed offline toolchain settings before the final gate.
About five minutes remain. Native APIs and fixture dispatch are written. Offline validation is blocked by absent checkout Alire state; locating cached dependency setup.
Gate also stops at Alire index initialization. Added boundary and round-trip tests. The full optimized C sum and cluster residue paths still need work.
Built a worktree-local offline Alire index from the installed AUnit release. Retrying the repository test script with the installed compilers on PATH; no dependency or tooling files changed.
The offline dependency resolves, but Alire cannot select a compiler from the minimal index. Checking installed toolchain metadata rather than repeating that failure.
Offline compiler selection now succeeds after adding installed toolchain metadata to the local index. The focused test script is compiling the port.
Compilation reproduced the reported GNAT vector reference finalizer link defect. Trying an explicit no-inline directive on the public vector reference operations.
The no-inline directive was not legal on a nested instance. Replaced it with an explicit constant-reference lifetime in Sum_Primes to force finalizer emission without changing the API.
An explicit reference lifetime did not fix GNAT linking. Moved the public vector instance to a library-level sibling unit and kept the existing Prime_Vectors API as a rename.
The standalone generic still omitted its finalizer with optimization. Testing unit-local Optimize (Off) for the container only; arithmetic sieve code keeps normal optimization.
Container workarounds did not fix the compiler defect. Removed them. Tests now use Element copies instead of implicit references across mixed build profiles. Sum_Primes now streams bounded segments.
Tests now link and run: 33 passed, 4 assertions failed. Correcting undef navigation spelling, enforcing cluster validation in release dependencies, and fixing the partial-sieve property expectation.
Navigation now returns Optional_U64 for MPU undef. Added explicit input checks so release dependencies reject invalid offsets and overflowing widths. The gate script can print green despite AUnit assertion failures; inspect totals as well.
Validation: all 37 AUnit tests passed, including all navigation, range, and cluster fixture rows. Large prefix sum rows are explicitly skipped in Compat_Sieve.
Remaining: port the C prefill/marking optimizations, BPSW dependency, optimized cluster residue path, and sum tables; then remove large-prefix skips and replay every row.
The test runner ignores the requested filter and does not return failure status for failed assertions. Checked AUnit totals directly; tools were left unchanged.
Offline validation uses ALIRE_SETTINGS_DIR=$PWD/obj/alire-settings with a local index built from installed package metadata. No manifest dependency, fixture, status, or tooling edits were made.
Final gate: 37 successful tests, zero assertions or unexpected errors, and == gate: green. Stop as PARTIAL; full large-prefix fixture coverage and faithful optimized C paths remain.
