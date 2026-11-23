Implement the six block-taking Vec predicates as Ada generic subprograms.
Read the plan and existing vector conventions, then translate the XS semantics.
Add cited compatibility cases and deterministic laws in compat_vec.adb.
Run focused vector tests and the declared gate; record toolchain limits if any.
Read XS vecnone and aliases: callbacks short circuit in order; kept existing Big_Integer vector API and added six generic declarations/bodies with callback-free contracts.
Added separate AUnit tests for all six functions, cited upstream integer cases and reference-array exclusions, seeded complement/index laws, integer boundaries, and short-circuit call-order checks. Next run focused tests.
Focused test initially failed before compilation: Alire used unwritable /run/user/1000. TMPDIR alone did not fix it; setting XDG_RUNTIME_DIR under obj/tmp started the build.
Focused build remains pending with no terminal output; reviewed contracts to avoid repeated callback calls and parenthesized Boolean negations in law assertions for Ada syntax.
Compilation succeeded but linking exposed the known GNAT 16 cross-profile vector-reference finalizer issue. Replaced element iteration in generic bodies with indexed Element copies, matching prop_sieve's existing workaround; rerunning focused tests.
Added explicit no-callback assertions for every empty-input operation. The indexed-copy rebuild is running; the next validation is the project gate.
Reviewed the final generic loops and tests; no callback is invoked by a contract, and not-found first values are initialized to zero. Waiting for focused command completion before the gate.
Indexed-copy bodies linked successfully; focused command reached test execution. Started declared gate with temporary directories redirected inside obj; diff whitespace check passed.
The stock test runner does not implement the passed filter, so it runs all suites. Added an untracked build-only Vec runner under obj for a genuinely focused AUnit run while the declared gate proceeds.
Gate development build passed. Build-only focused runner initially used the wrong AUnit generic signature; corrected it to the repository runner's signature. Release gate build is underway.
Validation is still active: waiting for full-suite and gate results; temporary focused Vec runner will run once gate compilation completes.
- 2026-11-23T22:49:02Z launcher: no commit for 60 s; 461 s elapsed. Files changed so far: docs/worker-notes/demand-d2d68b3ee904480abc05d5dbdfc0023a.md, src/math_prime_util-vec.adb, src/math_prime_util-vec.ads, tests/src/compat_vec.adb.
Validation is still active: waiting for full-suite and gate results; temporary focused Vec runner will run once gate compilation completes.
Validation is still active: waiting for full-suite and gate results; temporary focused Vec runner will run once gate compilation completes.
Finished: focused Vec runner passed all 44 tests within its 55-second timeout; tools/test.sh completed with 348/348 passing; tools/gate.sh passed development/release builds and 348/348 tests, printing == gate: green. No generated STATUS.md edits.
