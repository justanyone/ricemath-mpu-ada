"""Behavior bridge to the native AUnit arithmetic suite.

Build first from tests/: alr -n build. Run with pytest -p no:cacheprovider.
"""

import subprocess
from pathlib import Path

from pytest_bdd import given, scenarios, then, when

scenarios("features/arith.feature")
ROOT = Path(__file__).resolve().parent


def built_runner(name="arith_runner"):
    runner = ROOT / "bin" / name
    assert runner.is_file(), "Build with: cd tests && alr -n build"
    return runner.resolve()


def run_runner(arith_runner):
    return subprocess.run(
        ["nice", "-n", "10", str(arith_runner)],
        cwd=ROOT,
        capture_output=True,
        text=True,
        timeout=59,
        check=False,
    )


def assert_arith_passed(completed):
    output = completed.stdout + completed.stderr
    assert completed.returncode == 0, output
    assert "Total Tests Run:   12" in output, output
    assert "Successful Tests:  12" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output


# Justification: both arithmetic scenarios use the same checked executable.
for step in (
    "the focused arithmetic runner has been built with contracts enabled",
    "the checked arithmetic test runner is built",
):
    given(step, target_fixture="arith_runner")(built_runner)

# Justification: both scenarios execute the same bounded native suite.
for step in (
    "the arithmetic fixture and identity suite runs",
    "the arithmetic compatibility suite runs",
):
    when(step, target_fixture="completed")(run_runner)

# Justification: the shared summary checks prove both arithmetic scenarios.
for step in (
    "all arithmetic fixtures and boundary checks pass within one minute",
    "all arithmetic fixtures, boundaries, and seeded divisor laws pass",
):
    then(step)(assert_arith_passed)
