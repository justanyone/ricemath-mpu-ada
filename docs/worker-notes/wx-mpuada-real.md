Port the MPU 0.75 real functions into Math_Prime_Util.Real.
Keep the C methods, bounds, and tables. Add fixture and property tests.
Use no new dependency. Run the focused test and the gate offline.
Leave status generation and commits to the launcher.
Read the C real algorithms and fixture domains. Start the Ada port and suite wiring.
- 2026-10-20T13:47:04Z launcher: no commit for 60 s; 121 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-real.md.
Wrote the real package with the original tables, sums, inverse iteration, and Pi spigot. Next compile fixture tests.
Focused tests cannot build: Alire tries to clone its community index and the sandbox has no network. The first source generator failed; replacing it with direct Ada source.
- 2026-10-20T13:50:06Z launcher: no commit for 60 s; 303 s elapsed. Files changed so far: docs/worker-notes/wx-mpuada-real.md, obj_real_generate.py, tests/src/all_suites.adb, tests/src/compat_real.adb, tests/src/compat_real.ads, tests/src/prop_real.adb, tests/src/prop_real.ads.
