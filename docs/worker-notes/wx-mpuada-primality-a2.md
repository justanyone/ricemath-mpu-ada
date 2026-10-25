Reassess the existing primality implementation and merged dependencies.
Complete missing algorithms and fixture coverage in the task paths.
Run the focused primality tests, then the repository gate offline.
Leave random Miller-Rabin deferred until the random module exists.
Existing primality spec, body, compatibility tests and property tests are present.
Checking current coverage and build before choosing the smallest fix.
Focused test blocked by default Alire temporary path; retry with TMPDIR under obj.
TMPDIR alone did not move Alire runtime files; set XDG_RUNTIME_DIR inside obj too.
Found validation tests that catch their own assertion; tighten them before finishing.
Alire then tried to initialize an unavailable community index; offline build is blocked.
All requested deterministic public functions already exist; random Miller-Rabin remains deferred.
Fixed validation checks so they cannot catch their own AUnit assertion failures.
Added invalid bases 0 and 1, invalid increments 0, 257 and U64 Last, and valid endpoints.
The runner ignores its filter argument; no whole-suite execution has occurred because builds fail first.
