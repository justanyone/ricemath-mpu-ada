"""Given/When/Then bridge to the Ada fixture and arithmetic law tests."""
from pathlib import Path
import subprocess

from pytest_bdd import given, scenario, then, when


@scenario("features/modular_roots.feature", "Native fixtures and root laws pass")
def test_native_modular_roots():
    pass


# Justification: the Ada implementation requires its compiled contract-enabled runner.
@given("the modular root test runner has been built with contracts", target_fixture="runner")
def modular_runner():
    runner = Path(__file__).parent / "bin" / "modular_runner"
    assert runner.is_file(), "Build tests/math_prime_util_tests.gpr first"
    return runner


# Justification: reuse the AUnit fixture oracle rather than duplicate arithmetic in Python.
@when("the modular root compatibility suite runs", target_fixture="result")
def run_modular_suite(runner):
    return subprocess.run(
        ["nice", "-n", "10", str(runner.resolve())],
        cwd=Path(__file__).parent,
        capture_output=True,
        text=True,
        timeout=55,
        check=False,
    )


# Justification: require both a successful process and the expected six AUnit checks.
@then("all native fixtures and exhaustive root laws pass")
def check_modular_suite(result):
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Successful Tests:  6" in result.stdout
    assert "Failed Assertions: 0" in result.stdout
    assert "Unexpected Errors: 0" in result.stdout
