"""Behavior bridge to the native AUnit arithmetic suite.

Build first from tests/: alr -n build. Run with pytest -p no:cacheprovider.
"""

from pathlib import Path
import subprocess

from pytest_bdd import given, scenarios, then, when

scenarios("features/arith.feature")
ROOT = Path(__file__).resolve().parent


def built_runner():
    runner = ROOT / "bin" / "arith_runner"
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
    assert "Total Tests Run:   10" in output, output
    assert "Successful Tests:  10" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output


# The native fixture suite needs its own runner rather than a Python copy.
@given(
    "the focused arithmetic runner has been built with contracts enabled",
    target_fixture="arith_runner",
)
def arith_runner_contracts():
    return built_runner()


# The divisor scenario uses the same prebuilt checked arithmetic runner.
@given(
    "the checked arithmetic test runner is built",
    target_fixture="arith_runner",
)
def arith_runner_checked():
    return built_runner()


# Run the same AUnit checks used by the project gate with a bounded duration.
@when(
    "the arithmetic fixture and identity suite runs",
    target_fixture="arith_run",
)
def arith_run(arith_runner):
    return run_runner(arith_runner)


# Execute the native fixture and property checks within one minute.
@when(
    "the arithmetic compatibility suite runs",
    target_fixture="arith_result",
)
def run_arith(arith_runner):
    return run_runner(arith_runner)


# AUnit status and counts make fixture failures and missing tests observable.
@then("all arithmetic fixtures and boundary checks pass within one minute")
def arithmetic_passes(arith_run):
    assert_arith_passed(arith_run)


# AUnit status and counts make divisor-law success an observable outcome.
@then("all arithmetic fixtures, boundaries, and seeded divisor laws pass")
def divisor_laws_pass(arith_result):
    assert_arith_passed(arith_result)
