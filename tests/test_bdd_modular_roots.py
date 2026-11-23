"""Reuse the modular runner and assertions for root fixtures and laws."""

from pytest_bdd import given, scenarios, then, when
from test_bdd_arith import run_runner
from test_bdd_modular import modular_runner, modular_suite_passes

scenarios("features/modular_roots.feature")

# Justification: roots use the same checked executable as the residue suite.
given("the modular root test runner has been built with contracts", target_fixture="arith_runner")(
    modular_runner
)
# Justification: share arithmetic's bounded native execution.
when("the modular root compatibility suite runs", target_fixture="result")(run_runner)
# Justification: the shared modular assertions include the root fixture tests.
then("all native fixtures and exhaustive root laws pass")(modular_suite_passes)
