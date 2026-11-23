Implement the MPU ChaCha random family using the existing Ada conventions and fixtures.
Read the plan, status, oracle, and test registration before choosing the smallest implementation.
Keep generated STATUS.md unchanged and stay within the requested Ada line budget.
Run focused random tests and the declared gate; record any environmental blockers here.
Checked existing ChaCha, PCG seed expansion, entropy binding, and fixture dispatch against the C oracle; building baseline tests before selecting a regression.
Alire initially failed creating its runtime temporary file; setting XDG_RUNTIME_DIR to obj/tmp permits the offline build. Added stream-preservation checks for empty bytes, zero bits, modulus one and singleton ranges.
The checked tests build succeeded. The existing gate contains development/release builds and AUnit only; additional proof/coverage/documentation executables are absent from the Alire environment.
Tightened replay to exactly 731 native CSPRNG rows, with named exclusions retained. Kept all three Ada files at 400 lines total by combining no-op checks with seed replay. Preparing an ignored focused runner under tests/obj.
Focused runner compiled successfully and is now executing all 731 fixture rows plus contracts. Started the declared tools/gate.sh with runtime temporaries confined to obj/tmp.
Focused random suite passed: 731 fixture rows and contracts in 0.095 seconds. Development and release builds passed; full AUnit gate is running. Oracle references: chacha.c chacha_core/chacha_rand_bytes/chacha_irand32/64; csprng.c csprng_seed/urandomb/urandomm32/64; entropy.c get_entropy_bytes.
The first complete AUnit run passed all 202 tests with zero failures or errors. The gate is running the rebuilt suite containing the strengthened fixture-count and no-op assertions.
Full gate still running after successful builds; no further code changes are needed. Proof and coverage cannot be run here because the installed Alire environment lacks those tools; the declared gate itself does not invoke them.
