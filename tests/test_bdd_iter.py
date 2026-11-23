"""BDD bridge reusing the checked AUnit runner and status steps."""

import pytest

bdd = pytest.importorskip("pytest_bdd", reason="BDD scenarios require pytest-bdd")
from test_bdd_powers import powers_runner, run_selected, selected_test_passes

bdd.scenarios("features/iter.feature")


# Justification: select iterator cases through the shared bounded AUnit runner.
@bdd.when(bdd.parsers.parse("the iterator check {name} runs"), target_fixture="result")
def run_iterator(powers_runner, name):
    return run_selected(powers_runner, f"Compat_Iter : {name}")
