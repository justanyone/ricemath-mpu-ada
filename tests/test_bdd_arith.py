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
        check=False,
    )


# New step: AUnit's status and count make success an observable BDD outcome.
@then("all arithmetic fixtures, boundaries, and seeded divisor laws pass")
def arithmetic_passes(arith_result):
    output = arith_result.stdout + arith_result.stderr
    assert arith_result.returncode == 0, output
    assert "Total Tests Run:   3" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output
