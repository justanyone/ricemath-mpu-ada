"""Reuse the modular fixture and law steps for residues, orders and CRT."""
from pytest_bdd import given, scenarios, then, when
from test_bdd_arith import run_runner
from test_bdd_modular import modular_runner, modular_suite_passes

scenarios("features/modular_residues.feature")

# Justification: reuse the checked executable and steps without importing scenarios.
given("the modular AUnit runner has been built", target_fixture="arith_runner")(
    modular_runner
)
# Justification: reuse bounded native execution for the residue fixtures.
when("the modular compatibility suite runs with contracts enabled", target_fixture="result")(
    run_runner
)
# Justification: share the existing AUnit summary assertion.
then("all native modular fixture rows and boundary properties pass")(modular_suite_passes)
