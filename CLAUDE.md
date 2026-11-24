# ricemath-mpu-ada guidance for Claude

Read [AGENTS.md](AGENTS.md) for the working rules (Ada conventions, gate, test practices, process),
[PLAN.md](PLAN.md) for the design and phases, and [STATUS.md](STATUS.md) for the per-function checklist and the
Alire publishing checklist.

Quick rules:
- Ada 2022, Alire for everything (`alr build`, `alr test`, `alr exec -- ...`). Check `which alr gnat` before assuming
  the toolchain exists; if it is missing, say so and stop that step instead of guessing results.
- Oracle = `reference/mpu/` (MPU 0.75, read-only) and `tests/fixtures/*.tsv` (from the Rust port in
  `../math-prime-util`). The finished Rust code is a second reference for any algorithm.
- Run `tools/gate.sh` before calling anything ready. Do not claim a test, proof or coverage number you did not run.
- Never run `alr publish`, tag a release, or handle a GitHub token: publishing is the owner's step.
- Use `nice -n 10` for builds and test runs. Smallest edit that does the job; commit after each step.
