Scope: port the combinatorics functions and their fixture tests.
First check the existing API and reference algorithms.
Use existing dependencies and run focused tests, then the gate.
Record any unfinished functions and toolchain blockers here.
The checkout has only the integer core. Start with factorial and binomial ports and fixture replay; the full group exceeds this session.
- 2026-10-20T12:36:52Z launcher: no commit for 60 s; 121 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-combinat.md.
Added eight native routines with C citations and contracts. Added per-function fixture replay and deterministic algebraic tests. Signed and bigint input rows are named omissions.
Focused tests stopped before compilation: Alire tried to fetch its community index, but this sandbox has no network. Checking the installed offline toolchain next.
Review: Catalan now keeps the C central-binomial method with U128 intermediates, so native results 34 through 36 are not lost. Fixed the property boundary array type.
No lockfiles are present. The test run cannot resolve AUnit offline. Preparing the final gate and recording partial scope.
The gate stopped at build-development with the same index DNS failure. It did not print green. Neither new Ada code nor tests were compiled on this host.
Remaining functions: stirling, fubini, falling_factorial, rising_factorial, powersum, integer_complexity, bernfrac, harmfrac, consecutive_integer_lcm, frobenius_number, is_congruent_number, is_polygonal, is_pillai, is_happy, hclassno, numto <<cut 41 chars by kit>>
Remaining API work: signed binomial inputs and full fixture coverage. Native overflow expectations use Parse_U64 on the unchanged bigint fixture results. Out-of-domain signed and bigint input rows are explicitly skipped in the test source.
Validation still needed: compile, fixture and property runs, SPARK proof, coverage, and mutation checks. No state or concurrency code was introduced. Repeated calls and unsigned boundaries are tested; zero multifactorial step checks its pre <<cut 10 chars by kit>>
Stopped with a partial implementation of eight functions. No dependencies, tools, fixtures, status ticks, or git metadata were changed. The launcher owns commits and pushes.

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed 3 bytes)
