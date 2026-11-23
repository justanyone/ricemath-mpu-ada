Will fix the iterator author post-check findings within the existing task scope.
Read the project plan/status and inspect the iterator changes and BDD conventions.
Reduce duplication and resolve lint findings, then run focused tests and the gate.
Reused the ECM bounded runner for a parameterized iterator BDD bridge; reducing repeated registration and assertions next.
Ruff and Vulture pass for the rewritten bridge. Offline pytest-bdd installation has no cached distribution; focused Alire build is running.
