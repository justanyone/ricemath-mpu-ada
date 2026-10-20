Continuing the existing ChaCha CSPRNG port; inspect its current code first.
Complete signed and bigint fixture coverage using the repository's APIs.
Convert arithmetic to SPARK where feasible and check available proof tools.
Run focused random tests and the final gate; do not change status or fixtures.
Inspected native code and located the PP bigint rejection algorithm; implementing standard-library bigint overloads and removing fixture skips.
Focused baseline test started; confirmed bigint wrapper uses byte sampling and upper-tail rejection, not the native lower-tail rejection.
Baseline tests blocked: Alire tries to initialize the community index offline. Bigint API and exact replay checks are now written; checking local toolchain configuration before retrying.
Offline Alire settings avoid network; the empty index cannot resolve cached AUnit yet. Building a temporary local index under obj from the installed release metadata.
Local index resolves AUnit offline, but Alire still cannot determine compiler version. Diagnosing external compiler selection; no dependencies or tooling changed in tracked files.
