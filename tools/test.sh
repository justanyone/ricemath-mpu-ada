#!/bin/sh
# Worker test command: `tools/test.sh [filter]...` (the factory's `mw-test` calls this).
# Builds the tests crate (tests/) with Alire and runs its AUnit runner; arguments go to the runner.
# An ssh or worker shell has no ~/.local/bin: put alr on PATH.
# Workers are offline: the maintainer runs `alr update` in tests/ on each host after an alire.toml change.
# Limit: 900 s. Prints the last 60 lines; the exit code is the runner's (or the build's).
export PATH="$HOME/.local/bin:$PATH"
cd "$(dirname "$0")/../tests" || exit 2
out=$(mktemp "${TMPDIR:-/tmp}/mpuada-test.XXXXXX") || exit 2
{ timeout 900 nice -n 10 alr -n build && ./bin/test_runner "$@"; } >"$out" 2>&1
rc=$?
tail -60 "$out"
rm -f "$out"
exit $rc
