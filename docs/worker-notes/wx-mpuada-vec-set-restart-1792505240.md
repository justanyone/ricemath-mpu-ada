Review the existing Vec API, C sources, and fixture tests.
Check dependencies without adding crates or changing build tools.
Run focused Vec tests, fix reproducible gaps, then run the gate.
Keep all edits in this worktree; leave commits to the launcher.
Existing API and suites cover the requested names. Focused Vec build is running; review now checks C algorithms and fixture exclusions.
Baseline: all 76 tests pass. The runner ignores filter arguments. Added an upper-index-bound regression to check Ada array bounds before changing the implementation.
