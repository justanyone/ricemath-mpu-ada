"""BDD bridge reusing the checked AUnit runner and status steps."""

from test_bdd_powers import (
    parsers, powers_runner, run_selected, scenarios, selected_test_passes, when,
)

scenarios("features/iter.feature")


# Justification: select iterator cases through the shared bounded AUnit runner.
@when(parsers.parse("the iterator check {name} runs"), target_fixture="result")
def run_iterator(powers_runner, name):
    return run_selected(powers_runner, f"Compat_Iter : {name}")
