Continuing the Vec port: inspect existing implementation and its partial gaps.
Prioritize full-width fixture replay, list-valued closures, and callback tests.
Compare affected algorithms with the read-only MPU reference before changes.
Run the focused Vec tests, then the repository gate; do not edit status ticks.
Reference inspection: vecslide/setbinop use scalar context; vecpairwise/vecwindow use list context. Only the latter need list-valued overloads. Fixture family has no closure rows, so add explicit AUnit cases.
Added list-returning vecpairwise/vecwindow overloads that concatenate callback results once per invocation, plus eleven separate closure compatibility tests. Focused Vec test build is running.
Focused tests blocked before compilation: missing lockfiles and Alire configuration trigger an unavailable network index clone. Host has cached GNAT, GPRbuild and AUnit; investigating a workspace-only offline configuration without changing  <<cut 21 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed -3 bytes)
Configured a temporary index under ignored obj/ using cached AUnit sources and the host toolchain PATH; repository manifests remain unchanged. Retrying the prescribed test script with that offline configuration.
Offline focused run passed all 75 tests. Added checked I128 arithmetic overloads and a dedicated replay path for sum/product/prefix/min/max so full unsigned 64-bit fixture inputs are no longer skipped as non-I64; arbitrary precision product <<cut 26 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed 2 bytes)
Full-width arithmetic replay passed. Added property checks for list concatenation on non-one-based arrays, identity-window reconstruction, large steps, and short-circuit callback counts. Original scalar overload fixture replay is retained a <<cut 35 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed 11 bytes)
Final validation: tools/gate.sh printed == gate: green; all 76 tests passed, including the eleven individual callback tests and list/short-circuit laws. git diff --check passed. Gate used the workspace-only cached index and installed toolch <<cut 62 chars by kit>>
NOTES: PARTIAL, not READY. Full-width arithmetic fixtures now replay through checked I128 overloads, but I64-only vector/set replay still skips out-of-range inputs, and products beyond I128 remain excluded. Existing non-reference algorithm  <<cut 177 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed 190 bytes)
