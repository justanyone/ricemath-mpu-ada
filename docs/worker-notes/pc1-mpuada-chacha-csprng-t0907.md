Continuing the existing ChaCha CSPRNG port; inspect its current code first.
Complete signed and bigint fixture coverage using the repository's APIs.
Convert arithmetic to SPARK where feasible and check available proof tools.
Run focused random tests and the final gate; do not change status or fixtures.
Inspected native code and located the PP bigint rejection algorithm; implementing standard-library bigint overloads and removing fixture skips.
Focused baseline test started; confirmed bigint wrapper uses byte sampling and upper-tail rejection, not the native lower-tail rejection.
Baseline tests blocked: Alire tries to initialize the community index offline. Bigint API and exact replay checks are now written; checking local toolchain configuration before retrying.
Offline Alire settings avoid network; the empty index cannot resolve cached AUnit yet. Building a temporary local index under obj from the installed release metadata.
Local index resolves AUnit offline, but Alire still cannot determine compiler version. Diagnosing external compiler selection; no dependencies or tooling changed in tracked files.
Compiler executable works (GNAT 16.1.0); Alire requires toolchain release metadata in its isolated index. Adding cached metadata to the temporary obj index.
Isolated offline toolchain selection succeeded; focused random test build is running with the new bigint replay assertions.
Bigint overload exposed an ambiguous zero-bit property expression; qualified the native result explicitly and reran focused tests.
Native properties now disambiguate overloaded results. Preparing a SPARK arithmetic core so OS I/O and secret wiping remain outside the proof boundary.
Expanded fixture replay found real mismatches in bigint sampling; native tests and cipher vectors pass. Checking dispatch semantics before changing the bigint algorithm.
SPARK core extracted and compilation passes. Expanded replay exposes bigint outputs using a different fallback stream; investigating the committed reference implementation rather than guessing an algorithm.
Fixture bigint values do not come from the native stream bytes. PP fallback uses its own ChaCha stream; comparing its seed expansion and buffering to preserve the oracle exactly.
