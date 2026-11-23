"""BDD bridge reusing the bounded native runner from the ECM tests."""

from pathlib import Path

from pytest_bdd import given, parsers, scenarios, then, when
from test_bdd_ecm_factor import run_case

scenarios("features/iter.feature")


def iterator_runner():
    runner = Path(__file__).resolve().parent / "bin/iter_runner"
    assert runner.is_file(), "Build iter_runner.adb with the tests Alire project"
    return runner


def iterator_passes(iterator_run, names):
    result, elapsed = iterator_run
    assert result.returncode == 0, result.stdout + result.stderr
    for name in names.split(", "):
        assert f"OK Compat_Iter : {name}" in result.stdout, result.stdout
    for summary in ("Failed Assertions: 0", "Unexpected Errors: 0"):
        assert summary in result.stdout, result.stdout
    assert elapsed < 60


# Justification: locate the iterator harness; execution reuses the ECM helper.
given("the checked Ada iterator runner is built", target_fixture="runner")(
    iterator_runner
)
# Justification: the existing bounded subprocess helper also runs this AUnit suite.
when("the iterator compatibility suite runs", target_fixture="iterator_run")(run_case)
# Justification: one parameterized assertion proves each iterator scenario's outcome.
then(parsers.parse("the iterator checks {names} pass within one minute"))(
    iterator_passes
)
