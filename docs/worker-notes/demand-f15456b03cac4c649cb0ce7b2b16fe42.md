Plan: inspect the current Ada package layout and the MPU Goldbach/family sources.
Implement the requested standalone Goldbach package and family predicates using existing primality APIs.
Connect fixture rows to Ada compatibility tests without changing fixtures or generated STATUS.md.
Run focused tests and the project gate if the local toolchain permits.
Found existing Goldbach implementation and suites; fixed replay truncation so every Goldbach fixture row runs.
Next identify the requested prime-family predicates precisely from fixture names and extend coverage/API within the existing package structure.
Extended Goldbach replay to all rows and added is_ramanujan_prime to Families with fixture registration.
Alire build failed before compilation because its /run/user/1000 temp file could not be created; no gprbuild/gnatmake executable is available. Next perform static file/syntax review and record the limitation.
