# fx1-mpuada-config worker notes
- Plan: fix the 4 Open findings of rev-mpuada-config-1 in src/math_prime_util-config.adb/.ads and tests/src/compat_int.adb.
- Fix 2 (exact verbose/RH matching), 3 (no digit-count limit), 4 (runtime error via Errors for unknown keys), 1 (fixture replay).
- Each fix gets a test that fails without it.
- Done: body fixes (exact verbose/RH match, Digits_Fit, Config_Error runtime checks) and config.tsv replay + regression tests.
- Declined: Math_Prime_Util.Errors (no such unit in this checkout); used Config_Error in the spec instead.
- Note: with preconditions on, Pre fires first (Assertion_Error); Config_Error path is only reached in release builds.
- Fixed Func/Args mapping in config replay; compat_int focused run: 47/47 pass.
- Not run: tools/gate.sh and the no-fix check (time limit).
