# ricemath-mpu-ada: full port of Perl's Math::Prime::Util to Ada

Status: plan v1, 2026-10-19. Nothing below is built yet. This plan copies the structure of the finished Rust port
(`justanyone/math-prime-util`, its PLAN.md, `tools/gate.sh`, `.github/workflows/ci.yml`, `docs/mutation-testing.md`)
and changes what Ada needs changed. Items marked **VERIFY** are facts I could not confirm on this host (no Ada
toolchain is installed yet); phase 0 confirms each one before anything depends on it.

## 1. What is being ported

Reference: Math::Prime::Util (MPU) 0.75 by Dana Jacobsen, https://github.com/danaj/Math-Prime-Util
(commit 581c217bb530c4343edec182df72036623c9ceea). 428 exported names, ~49 C files (~36,000 lines), 141 Perl test
files. The Rust port already ported all 428 names, so the Ada port has two extra sources besides MPU itself:

- the Rust crate's oracle fixtures (`tests/fixtures/*.tsv`, 279,306 rows recorded from MPU 0.75): reuse them
  unchanged as the Ada compat spec; do not regenerate unless a family is missing;
- the Rust code as a readable second translation of the C (check against the C, not instead of it).

Vendor MPU 0.75 read-only under `reference/mpu/` (plain copy, not a submodule: offline workers cannot see submodules).

## 2. Decisions (defaults; owner can override)

| Topic | Default | Why |
|---|---|---|
| License | `GPL-1.0-or-later OR Artistic-1.0-Perl` (LICENSE already copied from the Rust port) | A port of MPU's C is a derivative; same terms as MPU and the Rust port. Alire's `licenses` field takes an SPDX expression: **VERIFY** it accepts this one; fallback is `Artistic-1.0-Perl` plus a note. |
| Crate name | `math_prime_util` (Alire names are lowercase with underscores) | Matches the Perl and Rust names. Open question for the owner: `ricemath_mpu` would match the repo name. Names are first come, first served on the index, so decide before the first publish. |
| Ada package root | `Math_Prime_Util` with child packages (section 5) | Ada convention: hierarchical children, Ada_Case, one spec/body pair per unit. |
| Language level | Ada 2022 (`-gnat2022`), GNAT FSF 13+ from Alire | Needs `Ada.Numerics.Big_Numbers.Big_Integers` (added in Ada 2022) for the bigint tier. **VERIFY** the Alire GNAT version. |
| Integers | `Interfaces.Unsigned_64` (named `U64`) native tier; 128-bit tier via GNAT's `Interfaces.Unsigned_128` or a hand-written pair type | **VERIFY** which exists in the Alire GNAT. Tests must pass either way. |
| Bigint | Phase 9+, behind a separate Alire crate/variant: `Big_Integers` from the standard library first; a GMP binding only if the benchmark demands it | Mirrors Rust: native first, bigint additive. |
| API shape | Ada-idiomatic with MPU names kept in Ada_Case: functions return values; MPU `croak` becomes a documented exception in `Math_Prime_Util.Errors` (and a `Pre` aspect where the caller can check); MPU `undef` becomes a discriminated `Option` type or a `Boolean` out parameter. The `for*` family becomes generic procedures with an access-to-subprogram or generic formal procedure, plus cursor-style iterators (Ada 2012 iterator aspects). | Rust used Result/Option/iterators; these are the Ada equivalents. |
| Perf bar | Native path within 1.5x of MPU's C (GNAT compiles through GCC, so 1.2x as in Rust is the goal, 1.5x the gate). Slower functions become issues, not blocks. | GCC backend makes parity realistic. |
| Coverage gate | 95% statement coverage and 90% decision coverage per package (GNATcoverage), enforced in CI | Same numbers as the Rust gate. |
| Workers | SkyBuild board rows per phase/module (project onboarding is a later owner step; not part of this PR) | Same as Rust. |

## 3. How Ada distributes libraries (CPAN / PyPI equivalent) and how to publish

**The registry is Alire** (https://alire.ada.dev), the package manager for Ada and SPARK. A library is a *crate*.
There is no CPAN-style upload: a crate release is a small manifest in the community index
(https://github.com/alire-project/alire-index) that points at a source archive in your own git host. Publishing =
tag a release, then open a pull request against the index. Users then run `alr with math_prime_util`.
There is no docs.rs equivalent: generate API docs with GNATdoc and host them on GitHub Pages (phase 0 item).
Sources: [Alire publishing steps](https://docs.adacore.com/live/wave/alire/html/alire/alire_indexes.html),
[alr-publish(1)](https://dyn.manpages.debian.org/trixie/alire/alr-publish.1); read `doc/publishing.md` in
https://github.com/alire-project/alire for the current flow before the first publish (the details below came from
secondary sources and may differ by `alr` version).

One-time setup (the owner does this; I cannot):
1. Install Alire: download `alr` from https://github.com/alire-project/alire/releases (or `apt install alire` on
   distributions that package it), put it on `PATH`, run `alr version`.
2. First `alr` command offers to install a toolchain: choose a recent `gnat_native` and `gprbuild`.
3. Create a GitHub personal access token with the `repo` scope (needed by `alr publish` to fork the index,
   push a branch, and open the pull request). Keep it out of the repo.

Per release:
1. Set `version` in `alire.toml` (semantic versioning, `0.1.0` first). Required metadata: `description`,
   `licenses`, `authors`, `maintainers`, `maintainers-logins` (GitHub login: `justanyone`), `website`, `tags`.
2. `alr build --release`, `alr test`, and the whole of `tools/gate.sh` green.
3. Commit, push, tag: `git tag -a v0.1.0 -m "0.1.0" && git push origin v0.1.0`.
4. `alr publish` (it checks the manifest, builds from the pushed tag, writes the index manifest, and offers to
   fork alire-index and open a **draft** pull request). `alr publish --status` lists your open submissions;
   `alr publish --cancel <num> --reason <text>` withdraws one.
5. The index CI builds the crate on several platforms; fix on the crate side, retag as a new patch version if
   it fails (released versions are never changed). When it is green, mark the PR ready; maintainers merge.
6. Check: in an empty directory, `alr get math_prime_util` then `alr build`.

Naming and size rules to respect: lowercase crate name, no network access during build, no vendored `reference/`
directory in the release archive (list it in `alire.toml` `[general] exclude`/use a `.gitattributes` export-ignore
**VERIFY** the exact key), keep the archive small.

Release plan: `0.1.0` after phase 2 (primality, sieve, factoring benchmarked) to claim the name and prove the
pipeline; `0.x` while the API moves; `1.0.0` when STATUS.md shows 428/428 and the API is frozen.

## 4. Toolchain isolation ("virtual environments")

- Alire is the environment manager: each crate has its own `alire/` directory, pinned dependencies in
  `alire.lock`, and a toolchain chosen per user with `alr toolchain --select`. Use `alr exec -- <cmd>` so every
  command runs with the crate's environment.
- Install through Alire (never system-wide): `gnat_native`, `gprbuild`, plus the crates `aunit` (unit tests),
  `gnatcov`/GNATcoverage and `gnatprove` (**VERIFY** crate names: `alr search gnatcov gnatprove gnatformat`).
- Pin the minimum supported compiler (the MSRV equivalent) in `alire.toml` `[[depends-on]] gnat = ">=13"` and have
  CI build with that oldest version as well as the newest.
- Perl is not needed: the oracle is the Rust port's committed fixtures. Only if a fixture family is missing, use
  the Rust repo's `tools/perl-env.sh` + `tools/gen_fixtures.pl` there, then copy the new `.tsv` here.

## 5. Crate layout

```
ricemath-mpu-ada/
  alire.toml  math_prime_util.gpr  config/ (Alire-generated, ignored)
  src/
    math_prime_util.ads                      root package: types (U64, U128), constants, Errors
    math_prime_util-int.ads/.adb             mulmod, montgomery, isqrt, iroot, ilog   (SPARK_Mode, proved)
    math_prime_util-sieve*.ads/.adb          segmented sieve, wheel, cache
    math_prime_util-primality*               MR, BPSW, Lucas, Frobenius, AKS
    math_prime_util-count*                   prime_count (LMO, Lehmer, Legendre phi), nth_prime, bounds
    math_prime_util-factor*                  trial, rho, p-1, SQUFOF, ECM, SIQS
    math_prime_util-arith* / families* / modular* / combinat* / digits* / rational* / vec* / iter* / random* / proving* / real* / bigint*
  tests/                                     separate Alire crate `tests/` (alr test), AUnit
    src/compat_<family>.adb                  one per MPU t/*.t family, reads tests/fixtures/<family>.tsv
    src/prop_<family>.adb                    seeded randomized property tests
    fixtures/                                copied from the Rust repo, one file per family
  bench/                                     timing harness (Ada.Real_Time), mirrors MPU bench/
  tools/                                     gate.sh, test.sh, status.py, cover.sh, prove.sh
  reference/mpu/                             vendored, read-only
  docs/                                      mutation-testing.md, upstream-findings.md
  PLAN.md STATUS.md CLAUDE.md AGENTS.md README.md CHANGELOG.md NOTICE LICENSE
```

Ada structural conventions: one package per file pair named by GNAT's krunch-free rule (`a-b-c.ads`; file
names are the lowercase unit names with `-` for children, set in the `.gpr` Naming package only if needed);
`Pure` / `Preelaborate` pragmas where legal; no globals except the sieve cache, guarded by a protected object so
the library is task-safe (MPU's pthread lock maps to a protected type).

## 6. Phases (same order as the Rust plan)

| # | Scope | MPU test files | Functions (approx) |
|---|---|---|---|
| 0 | Scaffold: Alire crate, tests crate, CI, gate script, coverage/prove wiring, fixtures copied, `tools/status.py`, GNATdoc, vendored reference | 01..04 | 0 |
| 1 | `util.c` int core, `mulmod.h`, `montmath.h`, `sieve.c`, `primality.c`, `lucas_seq.c`, `cache.c` | 10, 11-primes, 12, 15, 17, 18-*, 25 | ~80 |
| 2 | `factor.c`, `factor128.c`, totients, moebius, divisors, `rootmod.c`, `znlog.c`, `factmod.c` | 19-*, 20-*, 21, 26-modops, 26-rootmod, 50, 51 | ~90 |
| → | **publish 0.1.0** | | |
| 3 | prime counts, LMO, Lehmer, nth_prime, bounds | 13, 14 | ~25 |
| 4 | Families (twin, semi, almost, omega, ramanujan, lucky, powerful, powerfree, ...) | 11-*, 26-* | ~90 |
| 5 | Digits, rationals, combinatorics, partitions | 24, 26-*, 27 | ~80 |
| 6 | vec/set ops | 26-vec, 26-set* | ~60 |
| 7 | Iterators and `for*` family | 32-* | ~20 |
| 8 | CSPRNG, random primes | 16, 34, 35-* | ~25 |
| 9 | AKS, proving, real functions, bigint tier | 22, 23-*, 28, 29, 53, 70, 81 | ~20 + bigint |
| → | **publish 1.0.0** at 428/428 | | |

Each phase: port the C side by side, replay the fixtures, reach the gate, bench against the C, tick STATUS.md.
A phase is done when its MPU `t/` families all pass through the Ada compat tests.

## 7. Test strategy ("exceptionally good coverage")

Seven layers, all in `tools/gate.sh` and CI:

1. **Compat fixtures.** One AUnit test per MPU test family replays the Rust repo's `.tsv` oracle rows and
   compares exactly. Edge inputs: 0, 1, 2, 2^32±1, 2^63±1, 2^64-1, 128-bit edges, Carmichael numbers, strong
   pseudoprimes to the bases used, known hard factoring cases. Where MPU is wrong, assert the correct value, skip
   the row with a named comment, and list it in `docs/upstream-findings.md` (reuse the Rust repo's findings).
2. **Contracts as tests.** Every public subprogram carries `Pre`/`Post` (and `Type_Invariant` /
   `Dynamic_Predicate` for constrained types). Tests and CI build with `-gnata` so contracts run as assertions;
   the release build removes them (`-gnatp` only in the release profile, never in tests).
3. **Property tests.** Ada has no proptest: a small seeded generator in `tests/src/prop_support.ads` (fixed seed
   printed on failure, case count in the environment) drives the same laws as the Rust suite: `factor` multiplies
   back and every factor is prime; `prime_count(nth_prime(k)) = k`; `invmod` inverts; `sqrtmod` squares back;
   Dirichlet identities for moebius/phi; next/prev prime round-trip; native and 128-bit tiers agree.
4. **SPARK proof.** `Int` and `Modular` (mulmod, powmod, isqrt, ilog, gcd) are written in the SPARK subset
   with `SPARK_Mode => On`; `gnatprove --level=2` must prove absence of runtime errors (overflow, range, index,
   division by zero) with no unproved checks. This is the Ada answer to the Rust plan's Miri/unsafe audit and
   is the reason Ada is worth the port: it proves the 64/128-bit arithmetic. Expand to other packages when the
   code is already in the subset.
5. **Coverage gate.** GNATcoverage (`gnatcov`) with source instrumentation: statement ≥ 95% and decision ≥ 90%
   per package; the README carries the numbers. Exemptions need a written reason in the source
   (`pragma Annotate (Xcov, Exempt_On, "...")`). **VERIFY** the exact `gnatcov` command lines in phase 0 and
   record them in `tools/cover.sh`.
6. **Static checks and sanitizers.** Compile with `-gnatwa -gnatwe -gnaty` (all warnings, warnings are errors,
   style checks), `-fstack-check`, and run the suite once under `-fsanitize=address,undefined` where the GNAT
   runtime supports it. `gnatcheck` with a committed rules file; `gnatformat` (or `gnatpp`) must leave the tree
   unchanged (`--check`). **VERIFY** which formatter ships with the toolchain.
7. **Mutation testing.** No mature Ada mutation tool exists (**VERIFY** before assuming). Plan: a small script
   `tools/mutate.py` that applies operator swaps (`+`/`-`, `<`/`<=`, `and`/`or`, constants ±1) to one package at
   a time, rebuilds, runs that package's tests, and records survivors in `docs/mutation-testing.md` with the
   same triage as the Rust file. Run nightly on changed packages; not a merge gate.

Also: cross-implementation check against MPU's pure-Perl results (already inside the Rust fixtures), a doctest
equivalent (every public spec carries an example block that `tools/doc_examples.py` extracts into a test), and
a task-safety test (several Ada tasks hammering the sieve cache).

CI matrix (GitHub Actions, `alire-project/setup-alire` action **VERIFY**): `{oldest supported GNAT, newest}` ×
`{linux x86_64, macOS, windows}`; linux job adds gnatprove, gnatcov and sanitizers; nightly adds mutation and the
full benchmark. Push CI runs on `main` and `dev-*` and on pull requests, as in the Rust repo.

## 8. Performance strategy

Port the C algorithms as they are (LMO, SQUFOF/rho/ECM/SIQS, Montgomery mulmod, wheel sieve), faithful first,
Ada-idiom cleanup second, the benchmark deciding. `bench/` runs the same workloads as MPU's `bench/` and
`tools/bench_vs_perl.sh` compares with the XS build on the same box. Release profile: `-O2 -gnatn -gnatp`
(inlining, checks off) **only after** the checked build passes all tests; also run the full suite once with
checks on (`-gnato`) in CI. Ada tasks may be used for parallel prime counting later (a `Parallel` child package),
not before 1.0.0.

## 9. First work items (phase 0), in order

1. Install Alire and toolchain; verify every **VERIFY** item above and edit this plan with the answers.
2. `alr init --lib math_prime_util`; fill `alire.toml`; `.gpr` with `Debug`, `Release`, `Test` build modes.
3. Copy fixtures from the Rust repo (`tests/fixtures/*.tsv`) into `tests/fixtures/`; vendor `reference/mpu/`.
4. Write `tools/gate.sh` (format check, gnatcheck, build with warnings-as-errors, `alr test`, gnatprove,
   coverage thresholds, docs), `tools/test.sh`, `tools/status.py` (generates STATUS.md ticks).
5. CI workflow mirroring `.github/workflows/ci.yml` of the Rust repo.
6. First real code: `Math_Prime_Util.Int` (mulmod, isqrt, ilog) with SPARK proof, compat test, property test,
   and benchmark, as the pattern every later package copies.
