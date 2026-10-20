Continuing the Vec port: inspect existing implementation and its partial gaps.
Prioritize full-width fixture replay, list-valued closures, and callback tests.
Compare affected algorithms with the read-only MPU reference before changes.
Run the focused Vec tests, then the repository gate; do not edit status ticks.
Reference inspection: vecslide/setbinop use scalar context; vecpairwise/vecwindow use list context. Only the latter need list-valued overloads. Fixture family has no closure rows, so add explicit AUnit cases.
Added list-returning vecpairwise/vecwindow overloads that concatenate callback results once per invocation, plus eleven separate closure compatibility tests. Focused Vec test build is running.
