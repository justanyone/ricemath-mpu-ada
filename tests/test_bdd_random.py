"""BDD entry point for the native Ada random compatibility suite."""
from pathlib import Path
import subprocess
import re

from pytest_bdd import given, when, then, scenarios

scenarios("features/random.feature")
ROOT = Path(__file__).resolve().parent


# Justification: this repository's Ada suites require a prebuilt native runner.
@given("the random AUnit runner has been built", target_fixture="runner")
def random_runner():
    runner = ROOT / "bin" / "random_runner"
    assert runner.is_file(), "Build random_runner with the tests Alire project"
    return runner


# Justification: execute the existing AUnit fixture replay without duplicating it.
@when("the random compatibility suite runs with contracts enabled",
      target_fixture="result")
def run_random_suite(runner):
    return subprocess.run([str(runner)], cwd=ROOT, capture_output=True,
                          text=True, timeout=55, check=False)


# Justification: AUnit's text runner reports assertion failures in its summary.
@then("all native random fixture rows and boundary properties pass")
def random_suite_passes(result):
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Failed Assertions: 0" in result.stdout, result.stdout
    assert "Unexpected Errors: 0" in result.stdout, result.stdout
    assert re.search(r"Total Tests Run:\s+1\b", result.stdout), result.stdout
