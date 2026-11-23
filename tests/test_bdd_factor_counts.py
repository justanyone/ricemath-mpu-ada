"""BDD acceptance adapter for the factor count and predicate AUnit tests."""
from pathlib import Path
import subprocess
import time

from pytest_bdd import given, parsers, scenarios, then, when

scenarios("features/factor_counts.feature")
FUNCTIONS = (
    "factor_exp", "prime_omega", "prime_bigomega", "prime_signature",
    "is_square_free", "is_semiprime", "is_almost_prime", "is_omega_prime",
    "cheb_factor",
)


# Existing runner steps target other Ada mains; this locates the factor harness.
@given("the checked Ada factor counts runner is built", target_fixture="runner")
def checked_factor_runner():
    runner = Path(__file__).resolve().parent / "bin/factor_counts_runner"
    assert runner.is_file(), "Build the tests Alire project first"
    return runner


def run_selected(runner, selected, names):
    started = time.monotonic()
    result = subprocess.run(
        ["nice", "-n", "10", str(runner), str(selected)],
        cwd=runner.parent.parent, capture_output=True, text=True,
        timeout=55, check=False,
    )
    return result, time.monotonic() - started, names


# Select one function per scenario to enforce the owner's per-test time limit.
@when(parsers.parse('the factor fixture for "{function}" runs'),
      target_fixture="factor_run")
def run_fixture(runner, function):
    return run_selected(runner, FUNCTIONS.index(function) + 1,
                        [f"OK Compat_Factor_Counts : {function}"])


# The property harness is shared with the normal Ada gate.
@when("the factor property tests run", target_fixture="factor_run")
def run_properties(runner):
    return run_selected(runner, 10, [
        "OK Prop_Factor seed 20261123 : factor laws",
        "OK Prop_Factor seed 20261123 : boundaries",
    ])


# Check named AUnit results because an empty selection can also exit cleanly.
@then("that native factor fixture test passes within one minute")
@then("seeded factor laws and native boundary tests pass within one minute")
def successful_tests(factor_run):
    result, elapsed, names = factor_run
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Failed Assertions: 0" in result.stdout, result.stdout
    assert "Unexpected Errors: 0" in result.stdout, result.stdout
    for name in names:
        assert name in result.stdout, result.stdout
    assert elapsed < 60
