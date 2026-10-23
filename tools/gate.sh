#!/bin/sh
# Merge gate: everything a head must pass before it merges into the dev branch.
# Library build in the development profile (style checks, contracts on, warnings),
# release build, tests build and run. Exit 0 = green; the first red step stops the run.
# Keep this file and .github/workflows/ci.yml in step (same steps, same switches).
export PATH="$HOME/.local/bin:$PATH"
cd "$(dirname "$0")/.." || exit 2
set -e
step() { echo "== gate: $*"; }
step build-development; nice -n 10 alr -n build --development
step build-release;     nice -n 10 alr -n build --release
step tests-build;       (cd tests && nice -n 10 alr -n build)
step tests-run;         (cd tests && ./bin/test_runner)
echo "== gate: green"
