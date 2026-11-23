<<<<<<< HEAD
"""Behavior bridge to the native AUnit arithmetic suite.

Build first from tests/: alr exec -- gprbuild -P math_prime_util_tests.gpr
arith_runner.adb -o ../obj/arith_runner. Run with pytest -p no:cacheprovider.
"""

from pathlib import Path
import subprocess

from pytest_bdd import given, when, then, scenarios

scenarios("features/arith.feature")


# The native fixture suite needs its own runner rather than a Python arithmetic copy.
@given("the focused arithmetic runner has been built with contracts enabled",
       target_fixture="arith_runner")
def arith_runner():
    runner = Path(__file__).parent / "obj" / "arith_runner"
    assert runner.is_file(), "Build the focused Ada arithmetic runner first"
    return runner.resolve()


# Run the same AUnit checks used by the project gate with a bounded duration.
@when("the arithmetic fixture and identity suite runs", target_fixture="arith_run")
def arith_run(arith_runner):
    return subprocess.run(
        ["nice", "-n", "10", str(arith_runner)],
        cwd=Path(__file__).parent,
        capture_output=True,
        text=True,
        timeout=59,
=======
"""BDD entry point for the Ada arithmetic acceptance suite (build first)."""
from pathlib import Path
import subprocess

from pytest_bdd import given, scenario, then, when


@scenario(
    "features/arith.feature",
    "Divisor arithmetic matches fixtures and exact integer laws",
)
def test_divisor_arithmetic():
    pass


# New step: this repository has no existing BDD steps for Ada executables.
@given(
    "the checked arithmetic test runner is built", target_fixture="arith_runner"
)
def arith_runner():
    runner = Path(__file__).parent / "bin" / "arith_runner"
    assert runner.is_file(), "Build with: cd tests && alr -n build"
    return runner.resolve()


# New step: execute the native fixture and property checks within one minute.
@when("the arithmetic compatibility suite runs", target_fixture="arith_result")
def run_arith(arith_runner):
    return subprocess.run(
        [str(arith_runner)],
        cwd=Path(__file__).parent,
        capture_output=True,
        text=True,
        timeout=55,
>>>>>>> origin/dev-mpuada-001
        check=False,
    )


<<<<<<< HEAD
# AUnit status and counts make fixture failures and missing tests observable.
@then("all arithmetic fixtures and boundary checks pass within one minute")
def arithmetic_passes(arith_run):
    assert arith_run.returncode == 0, arith_run.stdout + arith_run.stderr
    assert "Total Tests Run:   7" in arith_run.stdout
    assert "Successful Tests:  7" in arith_run.stdout
=======
# New step: AUnit's status and count make success an observable BDD outcome.
@then("all arithmetic fixtures, boundaries, and seeded divisor laws pass")
def arithmetic_passes(arith_result):
    output = arith_result.stdout + arith_result.stderr
    assert arith_result.returncode == 0, output
    assert "Total Tests Run:   3" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output
>>>>>>> origin/dev-mpuada-001
