"""BDD acceptance adapter for the checked AUnit ECM tests."""
from pathlib import Path
import subprocess
import time

from pytest_bdd import given, scenarios, then, when

scenarios("features/ecm_factor.feature")


# No existing BDD steps exist in this Ada repository; locate its checked runner.
@given("the checked Ada ECM test runner is built", target_fixture="ecm_runner")
def ecm_runner():
    runner = Path(__file__).resolve().parent / "bin" / "test_runner"
    assert runner.is_file(), "Build tests with Alire before running acceptance tests"
    return runner


def run_case(runner, name):
    start = time.monotonic()
    result = subprocess.run(
        [str(runner), "-n", f"Compat_Factor : ecm_factor {name}"],
        cwd=runner.parent.parent,
        capture_output=True,
        text=True,
        timeout=59,
        check=False,
    )
    return result, time.monotonic() - start


# The fixture replay lives in AUnit so the normal Ada gate exercises it too.
@when("the native ECM fixture test runs", target_fixture="ecm_result")
def fixture_run(ecm_runner):
    return run_case(ecm_runner, "fixtures")


# Boundary assertions reuse the same checked implementation and gate test.
@when("the native ECM boundary test runs", target_fixture="ecm_result")
def boundary_run(ecm_runner):
    return run_case(ecm_runner, "edges")


# AUnit's exit status alone does not establish that a selected test ran.
@then("all 57 ECM fixture rows pass within one minute")
@then("the ECM boundary assertions pass within one minute")
def successful_case(ecm_result):
    result, elapsed = ecm_result
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Total Tests Run:   1" in result.stdout, result.stdout
    assert "Successful Tests:  1" in result.stdout, result.stdout
    assert "Failed Assertions: 0" in result.stdout, result.stdout
    assert "Unexpected Errors: 0" in result.stdout, result.stdout
    assert elapsed < 60
