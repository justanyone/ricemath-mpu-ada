Reassess the existing Combinat implementation and its dependencies.
Keep the existing API and fix only gaps in this task.
Run the focused combinatorics tests, then the repository gate offline.
Do not change fixtures, tooling, status ticks, or git metadata.
Existing implementation and fixture suites found. Focused tests started.
Alire could not write its runtime temp file. Retrying with runtime and temp paths under obj.
Review found missing permutation assertions and unchecked cache deallocation outside Int. Checking reference behavior before fixing.
Added regression assertions for wrapped permutation ranks, repeated round trips, and invalid permutations.
Reference XS.xs:numtoperm explicitly reduces K modulo N!. Regression test is in place; waiting for offline build.
Fixed rank wrapping and contracts. Replaced unchecked frees with controlled vectors. Alire tried to deploy the toolchain; offline validation remains blocked.
Added visibility for optional-value equality in the new regression. Toolchain now builds; resolving compiler diagnostics before the gate.
Container instantiations need signed indices. Converted vector indices to Natural within the existing memory bounds.
Permutation regression and container changes are ready for focused validation. Full SPARK conversion and broad API-domain review remain outside this small repair.
Changed sources compile successfully. The runner appears to ignore filters; the requested focused invocation is running the aggregate suite.
