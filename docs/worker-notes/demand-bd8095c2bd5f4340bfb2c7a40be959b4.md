I will port the Goldbach routines and the requested small prime-family predicates from the vendored MPU reference.
I will first check the prerequisite primality implementation and existing fixture test architecture.
I will add a standalone Goldbach package, public predicate APIs, and fixture coverage within the task scope.
I will run focused tests and the declared project gate if the local toolchain permits.
Inspection found Goldbach implemented inside Families and its fixture replay already wired. I am checking task-listed functions against reference and status before extracting the package.
Extracted Goldbach declarations and algorithms into their own child package. I am switching fixture replay to that API and will compile/run the family compatibility suite next.
Alire reached local tests after setting XDG_RUNTIME_DIR=/tmp; they failed. I am inspecting the project-local test log to address source or fixture issues.
- 2026-11-23T08:52:57Z launcher: no commit for 60 s; 241 s elapsed. Files changed so far: STATUS.md, docs/worker-notes/demand-bd8095c2bd5f4340bfb2c7a40be959b4.md, src/math_prime_util-families.adb, src/math_prime_util-families.ads, src/math_prime_util-goldbach.adb, src/math_prime_util-goldbach.ads, tests/src/all_suites.adb, tests/src/compat_families.adb, tests/src/compat_goldbach.adb, tests/src/compat_goldbach.ads.
All library and test targets compile and link after moving Goldbach to its own package. The full test runner is executing now; then I will record the gate outcome and inspect the final diff.
