Port the MPU 0.75 ChaCha stream and random API to Ada.
Read the C source and seeded fixtures before choosing the API.
Keep mutable random state protected and add no dependencies.
Run focused random tests, then the repository gate.
C review confirmed PCG seed expansion and OpenBSD rejection sampling.
Added the protected stream and Linux OS entropy binding; next add fixtures.
Fixtures include negative drand scales and bigint wrappers beyond the C API.
Adjusted drand scaling; native-limit fixture skips will be named explicitly.
Added per-function compat cases and deterministic partition/bounds properties.
Starting focused tests; bigint and signed wrappers remain outside this API.
Focused build is running. Review now targets atomic calls and invalid inputs.
Focused test has not created tests/obj; checking the stalled Alire setup.
Added a two-task atomic-draw property and no-consumption edge checks.
First focused build found missing U64 operator visibility; fixed the spec.
The gate raced toolchain setup and could not find Ada; rerun after setup.
Fixed compile errors in test operator visibility and UTF-8 cipher plaintext.
The tests now spell cipher bytes as hex to avoid source encoding ambiguity.
Native fixtures passed except zero modulus, which XS rejects; fixed validation.
Test runner returns zero on assertions; inspect the printed test totals.
Library contracts can be off in dependency builds; added explicit range checks.
Review confirms seeded native streams and cipher fixture vectors match MPU.
Remaining scope: bigint/signed wrappers and additional mixed/tag fixture rows.
All 50 tests pass after native validation fixes, with zero assertions failed.
Added mixed/tag and post-irand real fixtures plus reversed-range rejection.
Mixed/tag checks pass. Blake drand follows seven bytes and one irand.
Fixed that fixture setup; the full gate is now running.
The gate prints green even with failed assertions; do not trust its exit alone.
Blake fixture setup is fixed on disk; rerunning the gate on the final code.
Used libc explicit_bzero for seed wiping to avoid volatile-copy warnings.
Final scope: all 12 requested native entry points and compat/property suites exist.
Named skips remain for unsigned bounds above U64 and signed range wrappers.
SPARK conversion/proof and complete bigint fixture coverage remain unfinished.
Final gate: green. All 50 tests passed; zero assertions failed or unexpected errors.
Stopped with native implementation tested; signed/bigint coverage and SPARK remain.
