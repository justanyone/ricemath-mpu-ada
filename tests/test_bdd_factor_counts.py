"""BDD acceptance adapter for the factor count and predicate AUnit tests."""
from pathlib import Path
import subprocess
import time

import pytest
from pytest_bdd import given, scenarios, then, when

scenarios("features/factor_counts.feature")


@pytest.fixture(scope="module")
def factor_counts_result():
    root = Path(__file__).resolve().parent
    started = time.monotonic()
    result = subprocess.run(
        ["nice", "-n", "10", str(root / "bin/factor_counts_runner")],
        cwd=root, capture_output=True, text=True, timeout=55, check=False,
    )
    return result, time.monotonic() - started


# Existing runner steps target other Ada mains; this locates the factor harness.
@given("the checked Ada factor counts runner is built")
def checked_factor_runner():
    runner = Path(__file__).resolve().parent / "bin/factor_counts_runner"
    assert runner.is_file(), "Build the tests Alire project first"


# Share a single checked Ada execution, following the iterator adapter pattern.
@when("the factor counts acceptance suite runs", target_fixture="factor_run")
def run_factor_counts(factor_counts_result):
    return factor_counts_result


def assert_success(factor_run):
    result, elapsed = factor_run
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Failed Assertions: 0" in result.stdout, result.stdout
    assert "Unexpected Errors: 0" in result.stdout, result.stdout
    assert elapsed < 60
    return result.stdout


# These nine names prove each new public API is exercised against its fixtures.
@then("all nine native factor fixture tests pass within one minute")
def fixture_tests(factor_run):
    output = assert_success(factor_run)
    for name in (
        "factor_exp", "prime_omega", "prime_bigomega", "prime_signature",
        "is_square_free", "is_semiprime", "is_almost_prime", "is_omega_prime",
        "cheb_factor",
    ):
        assert f"OK Compat_Factor_Counts : {name}" in output, output


# The same AUnit properties run in the normal gate and this acceptance harness.
@then("seeded factor laws and native boundary tests pass within one minute")
def factor_laws(factor_run):
    output = assert_success(factor_run)
    assert "OK Prop_Factor seed 20261123 : factor laws" in output, output
    assert "OK Prop_Factor seed 20261123 : boundaries" in output, output
