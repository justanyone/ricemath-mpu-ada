Continue the existing fixture loader and AUnit tests.
Fix the reported Ada visibility errors and check parser boundaries.
Keep fixtures, status, dependencies, and build tools unchanged.
Run the focused test and the gate offline. Record any host blocker.
Added a separate AUnit fixture suite and exact int.tsv row checks. The first test command failed because Alire tried to clone its missing index. Replaced raw string allocations with managed strings and added decimal boundary tests.
The host has cached GNAT, gprbuild, and AUnit but no usable default index. Prepare isolated Alire settings under ignored obj/ to use the cached dependencies offline. No manifest or tool changes are needed.
The isolated index resolves AUnit offline. Alire still needs compiler release metadata to select the cached toolchain; add that metadata only under obj/ and rerun the focused test.
