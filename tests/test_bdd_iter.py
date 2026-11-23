"""BDD entry point; build tests/bin/iter_runner with the tests Alire project."""
from pathlib import Path
import subprocess
import time

import pytest
from pytest_bdd import given, scenarios, then, when

scenarios("features/iter.feature")


# A shared runner avoids rebuilding or rerunning the Ada suite per scenario.
@pytest.fixture(scope="module")
def iterator_result():
    root = Path(__file__).resolve().parents[1]
    started = time.monotonic()
    result = subprocess.run(
        ["nice", "-n", "10", str(root / "tests/bin/iter_runner")],
        cwd=root, capture_output=True, text=True, timeout=55, check=True,
    )
    return result.stdout, time.monotonic() - started


# No existing BDD steps exist; this step identifies the compiled Ada harness.
@given("the checked Ada iterator runner is built")
def checked_runner():
    runner = Path(__file__).resolve().parent / "bin/iter_runner"
    assert runner.is_file(), "Build iter_runner.adb in the tests Alire project"


# This step shares the same checked Ada execution between both scenarios.
@when("the iterator compatibility suite runs", target_fixture="iterator_run")
def run_iterators(iterator_result):
    return iterator_result


# Fixture replay is the observable compatibility outcome of this scenario.
@then("all native iterator fixture rows pass within one minute")
def fixture_compatibility(iterator_run):
    output, elapsed = iterator_run
    assert "OK Compat_Iter : fixtures" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output
    assert elapsed < 60


# The control test covers nested contexts, exceptions, and U64 exhaustion.
@then("loop termination, callback exceptions, and native boundaries pass")
def callback_control(iterator_run):
    output, _ = iterator_run
    assert "OK Compat_Iter : control" in output, output
    assert "Failed Assertions: 0" in output, output
    assert "Unexpected Errors: 0" in output, output
