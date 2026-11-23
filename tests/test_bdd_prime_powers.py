"""BDD entry points for the Ada fixture and property assertions (offline)."""
from pathlib import Path
import subprocess

from pytest_bdd import given, when, then, scenarios

scenarios("features/prime_powers.feature")
ROOT = Path(__file__).resolve().parent


# The Ada runner is required to exercise contracts and the committed oracle.
@given("a built Ada power test runner", target_fixture="runner")
def runner():
    executable = ROOT / "bin" / "test_runner"
    assert executable.is_file(), "Build with: cd tests && alr build"
    return executable


# The existing Ada compat suite owns fixture parsing and row diagnostics.
@when("the power family fixtures are replayed", target_fixture="result")
def replay(runner):
    return subprocess.run([str(runner), "Compat_Families"],
                          cwd=ROOT, capture_output=True, text=True, timeout=55)


# The seeded Ada properties verify arithmetic independently of the oracle.
@when("the seeded power properties are checked", target_fixture="result")
def properties(runner):
    return subprocess.run([str(runner), "Prop_Families seed 20261020 : power laws"],
                          cwd=ROOT, capture_output=True, text=True, timeout=55)


# AUnit can return zero after failures, so its summary is also checked.
@then("all selected Ada assertions pass")
def passed(result):
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Failed Assertions: 0" in result.stdout, result.stdout
    assert "Unexpected Errors: 0" in result.stdout, result.stdout
    assert "Total Tests Run: 0" not in result.stdout, result.stdout
