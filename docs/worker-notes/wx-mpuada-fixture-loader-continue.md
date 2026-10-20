Continue the existing fixture loader and AUnit tests.
Fix the reported Ada visibility errors and check parser boundaries.
Keep fixtures, status, dependencies, and build tools unchanged.
Run the focused test and the gate offline. Record any host blocker.
Added a separate AUnit fixture suite and exact int.tsv row checks. The first test command failed because Alire tried to clone its missing index. Replaced raw string allocations with managed strings and added decimal boundary tests.
The host has cached GNAT, gprbuild, and AUnit but no usable default index. Prepare isolated Alire settings under ignored obj/ to use the cached dependencies offline. No manifest or tool changes are needed.
The isolated index resolves AUnit offline. Alire still needs compiler release metadata to select the cached toolchain; add that metadata only under obj/ and rerun the focused test.
Offline compilation now works. It exposed string operator visibility and short-circuit style diagnostics in the new tests; fixed them and asserted zero output on rejected decimal values. Added concurrent loads and recovery after a missing f <<cut 7 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed -16 bytes)
Focused tests are still pending after the compile fixes. Check the running process before the final gate; keep all offline configuration and cached build output under ignored obj/.
