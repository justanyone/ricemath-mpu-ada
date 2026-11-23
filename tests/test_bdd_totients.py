"""Run the native totient suite through the existing AUnit runner."""
from pathlib import Path
import subprocess

from pytest_bdd import given, scenarios, then, when

scenarios("features/totients.feature")
ROOT = Path(__file__).resolve().parent


# This family uses the focused checked AUnit runner.
@given("the checked totient test runner is built", target_fixture="totient_runner")
def totient_runner():
    runner = ROOT / "bin" / "totients_runner"
    assert runner.is_file(), "Build the tests crate with Alire first"
    return runner.resolve()


# A native suite run exercises the Ada implementation and fixture parser.
@when("the totient compatibility suite runs", target_fixture="totient_result")
def totient_result(totient_runner):
    return subprocess.run(
        ["nice", "-n", "10", str(totient_runner)],
        cwd=ROOT,
        capture_output=True,
        text=True,
        timeout=59,
        check=False,
    )


# The nine registered tests distinguish a passing suite from an empty filter.
@then("all eight totient fixture functions and seeded laws pass")
def totient_passed(totient_result):
    output = totient_result.stdout + totient_result.stderr
    assert totient_result.returncode == 0, output
    assert "Total Tests Run:   9" in output, output
    assert "Successful Tests:  9" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output
