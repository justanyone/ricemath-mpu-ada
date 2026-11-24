#!/bin/sh
# Verdict on the AUnit text summary of one runner output file (sourced by tools/gate.sh
# and tools/gate_verdict_check.sh). gate_verdict FILE: returns 0 only when the summary
# shows at least one test, every test passed, and no failed assertion or unexpected error.
# A file with no summary is red too: the runner did not finish.
gate_verdict() {
  total=$(sed -n 's/^Total Tests Run: *\([0-9][0-9]*\)$/\1/p' "$1" | tail -n 1)
  ok=$(sed -n 's/^Successful Tests: *\([0-9][0-9]*\)$/\1/p' "$1" | tail -n 1)
  asserts=$(sed -n 's/^Failed Assertions: *\([0-9][0-9]*\)$/\1/p' "$1" | tail -n 1)
  errs=$(sed -n 's/^Unexpected Errors: *\([0-9][0-9]*\)$/\1/p' "$1" | tail -n 1)
  if [ -z "$total" ] || [ -z "$ok" ] || [ -z "$asserts" ] || [ -z "$errs" ]; then
    echo "== gate: red: test runner printed no summary"
    return 1
  fi
  if [ "$total" -eq 0 ] || [ "$ok" -ne "$total" ] || [ "$asserts" -ne 0 ] || [ "$errs" -ne 0 ]; then
    echo "== gate: red: $ok of $total tests passed, $asserts failed assertions, $errs unexpected errors"
    return 1
  fi
  return 0
}
