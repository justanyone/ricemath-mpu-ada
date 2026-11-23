Implement the combinatorics work packet without changing its plan.
Inspect the current arithmetic APIs and committed combinatorics fixtures.
Add the native Ada implementation and fixture tests, then run the project gate.
Keep the authorized checkout and let the launcher manage commits.

Inspection found an existing combinatorics implementation and tests; checking completeness and running them next.
The test build could not create Alire temporary files in /run/user/1000; retrying with TMPDIR under obj. Added a regression for Stirling second-kind single-block counts above 130.
Added the stirling2 single-block fast path from util.c and named the native-API fixture exclusions. The regression build remains blocked pending Alire environment checks.
