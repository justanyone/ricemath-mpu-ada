#!/bin/sh
# Checks tools/gate_verdict.sh on sample runner outputs: a green summary must pass,
# and a failed test, a failed assertion, an unexpected error or a missing summary must not.
# Run: tools/gate_verdict_check.sh. Exit 0 = all cases as expected.
cd "$(dirname "$0")" || exit 2
. ./gate_verdict.sh
dir=$(mktemp -d "${TMPDIR:-/tmp}/gate-verdict.XXXXXX") || exit 2
summary() {
  printf 'Total Tests Run:   %s\nSuccessful Tests:  %s\nFailed Assertions: %s\nUnexpected Errors: %s\n' "$1" "$2" "$3" "$4"
}
summary 135 135 0 0 >"$dir/green"
summary 135 132 3 0 >"$dir/failed"
summary 135 134 0 1 >"$dir/error"
summary 135 135 1 0 >"$dir/assert"
printf 'OK Compat_Int : x\nRunning...\n' >"$dir/nosummary"
: >"$dir/empty"
fail=0
expect() {
  want=$1
  file=$2
  if gate_verdict "$file" >/dev/null; then got=0; else got=1; fi
  if [ "$got" -ne "$want" ]; then
    echo "FAIL: $file: want $want, got $got"
    fail=1
  fi
}
expect 0 "$dir/green"
expect 1 "$dir/failed"
expect 1 "$dir/error"
expect 1 "$dir/assert"
expect 1 "$dir/nosummary"
expect 1 "$dir/empty"
rm -rf "$dir"
if [ "$fail" -ne 0 ]; then
  echo "== gate verdict check: red"
  exit 1
fi
echo "== gate verdict check: green"
