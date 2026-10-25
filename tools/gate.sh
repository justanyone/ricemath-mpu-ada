#!/bin/sh
# Merge gate: everything a head must pass before it merges into the dev branch.
# Library build in the development profile (style checks, contracts on, warnings),
# release build, tests build and run. Exit 0 = green; the first red step stops the run.
# The tests step is red when the runner exits non-zero, or when its summary shows a
# failed test or no summary (tools/gate_verdict.sh).
# Keep this file and .github/workflows/ci.yml in step (same steps, same switches).
export PATH="$HOME/.local/bin:$PATH"
cd "$(dirname "$0")/.." || exit 2
set -e
step() { echo "== gate: $*"; }
. ./tools/gate_verdict.sh
step build-development; nice -n 10 alr -n build --development
step build-release;     nice -n 10 alr -n build --release
step tests-build;       (cd tests && nice -n 10 alr -n build)
step tests-run
out=$(mktemp "${TMPDIR:-/tmp}/mpuada-gate.XXXXXX") || exit 2
rc=0
(cd tests && ./bin/test_runner) >"$out" 2>&1 || rc=$?
cat "$out"
if [ "$rc" -ne 0 ]; then
  rm -f "$out"
  echo "== gate: red: test runner exit $rc"
  exit 1
fi
verdict=0
gate_verdict "$out" || verdict=$?
rm -f "$out"
[ "$verdict" -eq 0 ] || exit 1
echo "== gate: green"
