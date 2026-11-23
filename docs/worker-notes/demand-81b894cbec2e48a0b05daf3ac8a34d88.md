# MPUADA-PRIME-POWERS

Port prime-power and perfect-power functions from reference/mpu/prime_powers.c and perfect_powers.c into Math_Prime_Util.Families, then replay tests/fixtures/families.tsv in compat_families.adb.

Why: STATUS.md still has those functions unticked, and families.ads has lucky, Ramanujan, twin, and semiprime only. The launcher note says the base already contains origin/dev-mpuada-001, so I will verify what is already present and fill only the missing port and its tests.

Next: list the fixture function names, read the C entry points, and match the twin/semiprime port style.
