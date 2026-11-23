"""BDD bridge reusing the checked AUnit runner helpers."""

from pathlib import Path

from pytest_bdd import given, parsers, scenarios, then, when
from test_bdd_powers import run_selected, selected_test_passes

scenarios("features/iter.feature")


def iterator_runner():
    runner = Path(__file__).resolve().parent / "bin/powers_runner"
    assert runner.is_file(), "Build the tests Alire project"
    return runner


def run_iterator(runner, name):
    return run_selected(runner, f"Compat_Iter : {name}")


# Justification: locate the iterator harness for the existing bounded runner.
given("the checked Ada iterator runner is built", target_fixture="runner")(
    iterator_runner
)
# Justification: select the iterator AUnit case using the shared runner helper.
when(parsers.parse("the iterator check {name} runs"), target_fixture="result")(
    run_iterator
)
# Justification: reuse the existing AUnit status and nonempty-selection assertions.
then("the selected AUnit test passes within one minute")(selected_test_passes)
