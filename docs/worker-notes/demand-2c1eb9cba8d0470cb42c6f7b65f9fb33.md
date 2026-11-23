Implement the combinatorics work packet without changing its plan.
Inspect the current arithmetic APIs and committed combinatorics fixtures.
Add the native Ada implementation and fixture tests, then run the project gate.
Keep the authorized checkout and let the launcher manage commits.

Inspection found an existing combinatorics implementation and tests; checking completeness and running them next.
The test build could not create Alire temporary files in /run/user/1000; retrying with TMPDIR under obj. Added a regression for Stirling second-kind single-block counts above 130.
Added the stirling2 single-block fast path from util.c and named the native-API fixture exclusions. The regression build remains blocked pending Alire environment checks.
Alire now reaches the workspace with XDG_RUNTIME_DIR under obj, but the tests build reports no usable compiler. Ran the declared gate and generated only task-family status ticks through tools/status.py.
Finished: existing requested APIs and fixture tests reviewed; fixed stirling2 single-block boundaries, added regression assertions, named fixture exclusions, and generated the 12 scoped status ticks. git diff --check passes. Tests and tools/gate.sh were attempted but cannot compile because this host has no Ada compiler; no green gate is claimed.
