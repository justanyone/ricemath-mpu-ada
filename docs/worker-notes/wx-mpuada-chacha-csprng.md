Port the MPU 0.75 ChaCha stream and random API to Ada.
Read the C source and seeded fixtures before choosing the API.
Keep mutable random state protected and add no dependencies.
Run focused random tests, then the repository gate.
C review confirmed PCG seed expansion and OpenBSD rejection sampling.
Added the protected stream and Linux OS entropy binding; next add fixtures.
