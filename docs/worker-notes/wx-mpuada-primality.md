Reassess the primality API and arithmetic dependencies.
Port the available C algorithms with Ada contracts and fixture tests.
Run the focused test command and the gate offline.
Leave random Miller-Rabin pending and keep STATUS.md unchanged.
Found existing Lucas helpers; no Intmont package exists. Reviewing native MR and Lucas paths.
Implementing Fermat, Euler, Miller-Rabin, Lucas variants and BPSW first; advanced Frobenius and recurrence tests remain pending.
- 2026-10-20T17:19:16Z launcher: no commit for 60 s; 122 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-primality.md.
Added 13 predicates, portable Montgomery power, fixture replay and seeded laws. Run focused tests next.
Focused tests stopped before compilation: Alire tried to clone its community index and DNS is unavailable. Checking offline toolchain configuration next.
About five minutes remain. Alire uses an empty /tmp home and has no selected toolchain. Offline compilation is blocked.
Added native boundary, precondition and concurrent-call tests. Unknown Mersenne results now use an optional Boolean.
Gate failed at build-development with the same offline Alire index error. Neither command reached Ada compilation or AUnit.
Pending: Perrin, Catalan, all three Frobenius tests, Chen and delicate primes. Miller_Rabin_Random remains unimplemented until Random exists.
Pending validation: compiler checks, all fixture rows, SPARK proof, coverage and a green gate. No performance claim is made.
Is_Prime currently delegates to the native is_prob_prime path; the separate C cache fast path remains to be assessed. No Errors package exists in this checkout; parameter-search limit failures use Constraint_Error.
Stopped with 13 public predicates and registered tests on disk. STATUS.md, fixtures, dependencies and build tools were not edited. No git write or push was run.
