# fx1-mpuada-config worker notes
- Plan: fix the 4 Open findings of rev-mpuada-config-1 in src/math_prime_util-config.adb/.ads and tests/src/compat_int.adb.
- Fix 2 (exact verbose/RH matching), 3 (no digit-count limit), 4 (runtime error via Errors for unknown keys), 1 (fixture replay).
- Each fix gets a test that fails without it.
