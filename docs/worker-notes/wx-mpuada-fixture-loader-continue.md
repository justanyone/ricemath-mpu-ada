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
Compilation succeeds, but the test runner did not finish promptly. Stopped it and reran with a short timeout and temporary progress output to isolate the runtime wait before the final gate.
Concurrent test reproduced a real loader failure: GNAT rejects simultaneous default Text_IO opens of the same file. Use shared=no for independent read streams and keep task loading after activation so a failed reader reports instead of stal <<cut 16 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed -8 bytes)
Focused run passes all five tests with zero failures and zero errors, including concurrent fixture reads. Decimal overflow is rejected without wrapping. Run the final gate with the isolated offline settings; leave STATUS.md unchanged as req <<cut 6 chars by kit>>

KIT NOTE, NOT FILE CONTENT: this output was shortened by the kit; the file on disk is whole; show a part with sed -n A,Bp FILE (kit removed -17 bytes)
