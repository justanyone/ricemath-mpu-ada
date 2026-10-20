Port the lucky-number routines from MPU 0.75 into Families.
Keep the reference tables and bounds. Add fixture and law tests.
Use the offline test script and gate. Leave status generation to merge.
Read the C sieve and bounds. No Families unit exists. Checking fixture limits.
Added the public API and source citations. Porting local sieve storage and formulas.
All ten routines and fixture tests are written. Running focused checks next.
Focused compile found missing U64 operator visibility; fixed it and reran.
Fixtures pass for nine functions. Count fixtures also require a two-bound overload.
Ported linear interpolation and Ridder refinement from inverse_interpolate.c.
All 134 tests passed after the count overload. Gate is running with full interpolation.
Added the reference bitmask126 sieve with its prefilter table and count tree.
Bitmask build exposed a vector API mismatch. Replaced Set_Length fills with Append.
Added concurrent repeated-call checks and changed range counts to one reference sieve.
Both sieve paths pass fixtures. Final gate includes concurrent independent calls.
Aligned is_lucky with the static 48-entry pretest and final upper-bound sieve.
Final review: no shared mutable state, no new dependency, fixtures remain unchanged.
Gate passed 135 tests. Rechecking the final static-pretest alignment before handoff.
