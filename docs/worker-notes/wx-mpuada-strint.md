Port the Digits API from MPU 0.75 within this worktree.
Read the C algorithms and fixture format before choosing types.
Add compatibility and algebraic tests through the existing suite.
Run the focused test script and the final gate; record blockers here.
The checkout lacks reference/mpu/strint.c and strint.h. Available util.c digit and Zeckendorf algorithms will be translated; signed helper semantics are checked against fixtures.
API uses checked signed 128-bit results and unsigned digit magnitudes. Tests will explicitly name any fixture beyond this tier.
Implemented digit conversion, roots, Zeckendorf, and checked integer operations. Next: fixture dispatch and compilation.
