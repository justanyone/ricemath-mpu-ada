# MPUADA-FACTOR

Fix the failing `math_prime_util_tests` gprbuild (exit 4 / compilation failed) on branch task/mpuada-factor-20261123-x against base dev-mpuada-001.

Plan: read the test project and the prime-util sources the context pack points at, reproduce the compile error, fix only the code that makes those tests fail, then rerun the focused gprbuild and the rest of the gate if it stays fast.

Guardrails: no Petri change, no settings files, no logfile reads, no git writes, no full-board reads. Keep deletions if the head removed a file and port additions onto the replacement.
