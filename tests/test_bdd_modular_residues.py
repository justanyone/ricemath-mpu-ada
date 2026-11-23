"""Reuse the modular fixture and law steps for residues, orders and CRT."""

from pytest_bdd import given, scenarios, then, when
from test_bdd_arith import run_runner
from test_bdd_modular import modular_runner, modular_suite_passes

scenarios("features/modular_residues.feature")

# Justification: residues use the checked modular executable.
given("the modular AUnit runner has been built", target_fixture="arith_runner")(
    modular_runner
)
# Justification: reuse arithmetic's bounded native execution for residue fixtures.
when("the modular compatibility suite runs with contracts enabled", target_fixture="result")(
    run_runner
)
# Justification: share modular fixture and law assertions across feature files.
then("all native modular fixture rows and boundary properties pass")(modular_suite_passes)
