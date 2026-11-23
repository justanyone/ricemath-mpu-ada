Inspect the existing prime-count port and the author post-check findings.
Reduce the implementation change to the 400-line budget while retaining the requested behavior.
Investigate the gnatcheck report failure and run the declared gate plus focused tests.
Keep all work inside this checkout; leave commit and push operations to the launcher.
Reduced sparse lookup data to the first MPU table and lowered LMO crossover to 300,000; next verify the kernel at that boundary. gnatcheck is absent from the Alire environment.
Initial builds found no Ada compiler on PATH; supplied the already installed Alire GNAT bin directory without changing settings. Removed duplicate declarations and per-word count storage; property inputs now cover the reduced crossover.
Kept only MPU step_counts_0 beside its sole LMO caller, removed the unused standalone benchmark source, restored GNAT-required local specs, and reused bit counting instead of maintaining duplicate word counts. Focused checks and checked rebuild are running.
The lower crossover exposed four focused failures: when KM equals C, an empty Remove call counts the same phi segment twice. Removed that redundant call; each leaf loop initializes its own counts. Rechecking the failing fixtures and boundary properties next.
Removing the empty call alone did not fix KM=C. Kept LMO above 216^3, where M>=324 and KM>C, plus the MPU 3,000,000 anchor; added both crossover neighbors to the deterministic sieve comparison. Current code delta excluding notes is 391 net lines.
