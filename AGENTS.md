# AGENTS.md: ricemath-mpu-ada

Ada port of Perl's Math::Prime::Util (MPU) 0.75. Read PLAN.md first, then STATUS.md. This file holds the rules
for every agent session and worker subtask in this repo. CLAUDE.md points here.

## Ground rules

- Follow established Ada conventions unless the owner says otherwise: Ada_Case identifiers, one spec/body per
  unit, hierarchical child packages (`Math_Prime_Util.Factor`), `.ads`/`.adb` naming from the unit name,
  Ada 2022, the Ada Style Guide / GNAT style (`-gnaty`) for layout. The Rust port's rule applies here too: the
  library should look native to Ada users.
- The oracle is MPU 0.75 (`reference/mpu/`, read-only, never edit) and the committed fixtures
  (`tests/fixtures/*.tsv`, copied from the Rust port). Tests never call Perl.
- A port commit cites the C function it translates (file and function) in the commit text.
- Where MPU is mathematically wrong, assert the correct value, skip the row with a named comment, and add it to
  `docs/upstream-findings.md`. Never edit a fixture to make a test pass.
- Work branch is `dev-mpuada-NNN`; `main` holds releases only. Do not push to `main`.

## Toolchain (use Alire; no system-wide installs)

- `alr build`, `alr test`, `alr exec -- <command>`; pinned dependencies live in `alire.lock`.
- Gate: `tools/gate.sh` must be green before a head is ready. It runs, in order: format check, gnatcheck,
  build with `-gnatwa -gnatwe -gnaty` in the debug profile, `alr test` with `-gnata` (contracts on), gnatprove on
  the SPARK packages, GNATcoverage thresholds, GNATdoc. Keep `tools/gate.sh` and `.github/workflows/ci.yml` in
  step: same steps, same switches.
- Workers may be offline: build and test must not fetch. Run `alr update` once on a connected host after an
  `alire.toml` change and commit `alire.lock`.
- Run local test runs and builds at `nice -n 10`.

## Code practices

- Every public subprogram has a spec comment (what, units, errors) and `Pre`/`Post` aspects where the contract is
  checkable. Preconditions raise `Constraint_Error`/`Assertion_Error` under `-gnata`; documented MPU `croak`
  cases raise the exceptions in `Math_Prime_Util.Errors`. No bare `when others =>` handlers; no `pragma Suppress`
  or `pragma Unreferenced` to hide a warning; no `Unchecked_Conversion` or `Unchecked_Deallocation` outside
  `Math_Prime_Util.Int` (and each one needs a comment and a test).
- Use strong types: `U64` / `U128` are modular types, indices and counts use constrained subtypes. Modular
  arithmetic overflow is intended only in the types declared modular; everything else must not overflow.
- Packages that do arithmetic on 64/128-bit values are written in the SPARK subset (`SPARK_Mode => On`) and
  proved with `gnatprove --level=2` with no unproved checks. Do not add `pragma Assume` without a comment and an
  owner-visible note in the PR text.
- Shared state (the sieve cache) is a protected object. No other package-level mutable state.
- Release builds drop checks (`-gnatp`) only after the checked build passes; tests never run with checks off.
- Take performance claims from `bench/` runs on the same host against the C build, not from reading code.

## Test practices (target: exceptionally good coverage)

1. Compat tests: one AUnit test unit per MPU `t/*.t` family, named `Compat_<Family>`, replaying
   `tests/fixtures/<family>.tsv` exactly. A new function ships with its fixture rows in the same PR.
2. Contracts run as assertions in every test build (`-gnata`).
3. Property tests (`Prop_<Family>`): seeded generator, seed printed on failure, laws listed in PLAN.md section 7.
4. Edge inputs for every integer function: 0, 1, 2, 2^32±1, 2^63±1, 2^64-1, 128-bit boundaries.
5. Coverage: GNATcoverage statement ≥ 95% and decision ≥ 90% per package. Add tests, not exemptions; an
   exemption needs a source comment with the reason.
6. Mutation checks on changed packages (`tools/mutate.py`) are nightly; log survivors in
   `docs/mutation-testing.md`, reasoning each as equivalent or killing it with a test.
7. A bug fix starts with a failing test that reproduces it.
8. Tests are deterministic and offline, finish in the gate's time budget, and write only under the build
   directory (`obj/`), never under `/tmp` or the source tree.

## Process

- STATUS.md ticks come from `tools/status.py` after a merge; do not edit the function lines by hand.
  The release/publishing checklist at the top of STATUS.md is edited by hand.
- Keep changes to the smallest edit that does the job; start work at once; no features beyond the task.
- Commit after each completed step with a message that says what and why. Do not commit `obj/`, `lib/`,
  `bin/`, `alire/`, `config/`, `.codegraph/`, or coverage output.
- Publishing to Alire is an owner-run step (PLAN.md section 3). Never run `alr publish`, push a release tag,
  or put a token in the repo or in a command line.
- Licence: `GPL-1.0-or-later OR Artistic-1.0-Perl`, with the NOTICE statement of changes. Keep `NOTICE` correct
  when third-party material is added.
