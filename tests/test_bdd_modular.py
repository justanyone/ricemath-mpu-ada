"""BDD entry point for the native Ada modular compatibility suite."""

from pathlib import Path

from pytest_bdd import given, scenarios, then, when
from test_bdd_arith import run_runner
from test_bdd_random import random_suite_passes

scenarios("features/modular.feature")
ROOT = Path(__file__).resolve().parent


def modular_runner():
    runner = ROOT / "bin" / "modular_runner"
    assert runner.is_file(), "Build modular_runner with the tests Alire project"
    return runner


def modular_suite_passes(result):
    random_suite_passes(result, expected=23)


# Justification: reuse the checked native runner for each modular feature.
given("the modular AUnit runner has been built", target_fixture="arith_runner")(
    modular_runner
)
# Justification: share the bounded native execution used by arithmetic tests.
when("the modular compatibility suite runs with contracts enabled", target_fixture="result")(
    run_runner
)
# Justification: reuse AUnit summary validation with the modular test count.
then("all native modular fixture rows and boundary properties pass")(modular_suite_passes)
