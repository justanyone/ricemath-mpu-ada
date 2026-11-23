"""BDD entry points for the Ada suites; build with Alire before pytest."""
from pathlib import Path
import subprocess

import pytest
from pytest_bdd import given, scenarios, then, when

scenarios("features/vec.feature")
ROOT = Path(__file__).resolve().parents[1]


# No shared BDD steps exist in this Ada project; this checks the build prerequisite.
@given("the checked Ada vector test runner is built")
def runner_built():
    assert (ROOT / "tests/bin/test_runner").is_file()


@pytest.fixture(scope="module")
def vec_result():
    return subprocess.run(
        ["nice", "-n", "10", str(ROOT / "tests/bin/test_runner"), "--vec"],
        cwd=ROOT,
        capture_output=True,
        text=True,
        timeout=55,
        check=True,
    ).stdout


# Invoke the existing AUnit tests rather than duplicate their fixture parser.
@when("the vector and set suites run", target_fixture="vec_output")
def run_vec(vec_result):
    return vec_result


# AUnit's legacy runner reports assertion failures in its summary, not its status.
@then("all native vector fixture cases pass")
def fixtures_pass(vec_output):
    assert "OK Compat_Vec : vec.tsv" in vec_output
    assert "Failed Assertions: 0" in vec_output
    assert "Unexpected Errors: 0" in vec_output


# Reuse the same bounded execution to verify all independent native property tests.
@then("callback, boundary, and seeded set laws pass")
def properties_pass(vec_output):
    for name in ("callbacks", "laws seed 0x5EED075", "boundaries"):
        assert f"OK Prop_Vec : {name}" in vec_output
    assert "Failed Assertions: 0" in vec_output
    assert "Unexpected Errors: 0" in vec_output
