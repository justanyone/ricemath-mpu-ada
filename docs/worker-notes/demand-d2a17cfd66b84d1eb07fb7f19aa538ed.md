# MPUADA-PRIME-COUNT-USES-THE-LMO-METHOD-FROM-MPU-SO-COUNTS

Intent: Prime_Count must use the MPU LMO/Lehmer method (lmo.c, lehmer.c, prime_count_tables.h) so counts reach 2^64. Raise Prime_Count_Limit and Nth_Prime_Limit from 2e13/3e11 to the U64 range C supports, un-skip the 18 prime_count and 17 nth_prime fixture rows, and record the 10^k benchmark to 10^13.

The launcher says origin/dev-mpuada-001 is already in this branch, so first verify whether LMO is already ported and only fix failing tests.

Next: locate Prime_Count, limits, skipped fixture rows, and the LMO/Lehmer sources.
