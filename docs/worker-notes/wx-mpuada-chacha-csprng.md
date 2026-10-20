Port the MPU 0.75 ChaCha stream and random API to Ada.
Read the C source and seeded fixtures before choosing the API.
Keep mutable random state protected and add no dependencies.
Run focused random tests, then the repository gate.
C review confirmed PCG seed expansion and OpenBSD rejection sampling.
Added the protected stream and Linux OS entropy binding; next add fixtures.
Fixtures include negative drand scales and bigint wrappers beyond the C API.
Adjusted drand scaling; native-limit fixture skips will be named explicitly.
Added per-function compat cases and deterministic partition/bounds properties.
Starting focused tests; bigint and signed wrappers remain outside this API.
Focused build is running. Review now targets atomic calls and invalid inputs.
