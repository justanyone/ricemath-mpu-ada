Port MPU prime counting with its count tables and widen supported inputs.
Read the existing count implementation and the read-only C reference first.
Run focused count tests, then the gate, and inspect the runner failure count.
Record benchmark results and any incomplete work here for the launcher.
The checkout has no Count package, count suite, or bench directory; the named Lucy baseline is absent. Implement a standalone Lehmer count package and focused tests against this tree.
Added local-storage Lehmer stages and translated all seven immutable MPU sparse tables. Full native inputs may require large square-root sieves; performance and proof remain to check.
Focused test first failed before compilation: Alire could not create its /run/user temporary file. Retrying with TMPDIR under obj. Registered fixture replay and a 10^1 through 10^13 timing test.
XDG_RUNTIME_DIR fixed temporary-file creation, but Alire then attempted to initialize an unavailable community index. Offline test execution is blocked before compilation; inspect the installed toolchain configuration and run the required gate next.
The required gate also stops in build-development at the missing offline Alire index. No runner count or benchmark timing is available. Fixed Phi(0,a) in static review; remaining time is for source review and clear scope notes.
Found installed GNAT/GPRbuild and cached AUnit. Created an ignored obj-only local index to avoid network and external writes. Alire now reaches dependency resolution but reports an unknown math_prime_util build profile; resolve workspace state next.
Offline Alire now builds with installed tools and a local cached AUnit origin. Compilation reaches the new packages; inspect their diagnostics next. Existing units emit many GNAT 16 style warnings.
About five minutes remain in the work budget. The offline toolchain compiles the new units after operator visibility fixes. Full U64 fixture replay and SPARK proof are still incomplete; do not treat this head as accepted.
The test command's filter arguments are ignored by this checkout's runner: it ran all 188 tests, with 188 successful, 0 failed assertions, and 0 unexpected errors. The gate is running offline. Add concurrent repeated-count checks before the final gate test build.
Gate and benchmark evidence (checked Ada build, seconds; no C comparison):
Lehmer 10^ 1 seconds 0.000001000
Lehmer 10^ 2 seconds 0.000000000
Lehmer 10^ 3 seconds 0.000002000
Lehmer 10^ 4 seconds 0.000003000
Lehmer 10^ 5 seconds 0.000004000
Lehmer 10^ 6 seconds 0.000013000
Lehmer 10^ 7 seconds 0.000029000
Lehmer 10^ 8 seconds 0.005827000
Lehmer 10^ 9 seconds 0.017259000
Lehmer 10^ 10 seconds 0.080331000
Lehmer 10^ 11 seconds 0.459200000
Lehmer 10^ 12 seconds 2.868139000
Lehmer 10^ 13 seconds 18.086292000
Gate printed green and its runner reported 188/188 successful, 0 failures and 0 errors. The 10^13 count took 18.086292 seconds. Expanded fixture replay through the prior 2e13 range and added concurrent repeated calls plus rejection of overflowing nth indices; revalidate these final tests.
Remaining acceptance work: replay the 18 large prime_count rows and 17 large nth_prime rows, restore the missing baseline API as needed, and prove the arithmetic packages in SPARK. This port uses sqrt(N) storage and recursive Lehmer counts; the large native range still needs practical validation.
Launcher commit citation: MPU 0.75 lehmer.c:lehmer_prime_count and prime_count_tables.h:NSTEP_SEARCH/APPLY_TABLES. Benchmark 10^13 = 346065536839 in 18.086292 checked-Ada seconds; all powers 10^1 through 10^13 matched. No same-host C comparison was run.
Added a bounded local prefix count cache for MPU Lehmer stage 3. It avoids repeated binary searches for small counts while keeping memory bounded independently of the full U64 square-root sieve. Rerun the gate to validate this final library change.
Final gate after the bounded count cache and concurrent/input tests: development and release builds pass; tests pass; == gate: green.
Lehmer 10^ 1 seconds 0.000001000
Lehmer 10^ 2 seconds 0.000001000
Lehmer 10^ 3 seconds 0.000001000
Lehmer 10^ 4 seconds 0.000003000
Lehmer 10^ 5 seconds 0.000004000
Lehmer 10^ 6 seconds 0.000012000
Lehmer 10^ 7 seconds 0.000029000
Lehmer 10^ 8 seconds 0.003705000
Lehmer 10^ 9 seconds 0.006182000
Lehmer 10^ 10 seconds 0.018099000
Lehmer 10^ 11 seconds 0.091565000
Lehmer 10^ 12 seconds 0.516600000
Lehmer 10^ 13 seconds 3.316049000
Total Tests Run:   188
Successful Tests:  188
Failed Assertions: 0
Unexpected Errors: 0
Use the final benchmark above in the launcher commit message: 10^13 = 346065536839 in 3.316049 checked-Ada seconds. The earlier 18.086292 result predates the prefix cache.
Final result is partial. The absent prior Count implementation prevents a minimal limit-change diff. Large native fixture replay (18 count and 17 nth rows), practical full-range validation, and SPARK proof remain. No git writes or pushes were run.
