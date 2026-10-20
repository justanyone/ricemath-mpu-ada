Continuing the Vec port: inspect existing implementation and its partial gaps.
Prioritize full-width fixture replay, list-valued closures, and callback tests.
Compare affected algorithms with the read-only MPU reference before changes.
Run the focused Vec tests, then the repository gate; do not edit status ticks.
Reference inspection: vecslide/setbinop use scalar context; vecpairwise/vecwindow use list context. Only the latter need list-valued overloads. Fixture family has no closure rows, so add explicit AUnit cases.
Added list-returning vecpairwise/vecwindow overloads that concatenate callback results once per invocation, plus eleven separate closure compatibility tests. Focused Vec test build is running.
Focused tests blocked before compilation: missing lockfiles and Alire configuration trigger an unavailable network index clone. Host has cached GNAT, GPRbuild and AUnit; investigating a workspace-only offline configuration without changing  <<cut 21 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed -3 bytes)
