"""BDD entry point for the native Ada random compatibility suite."""

import re

from pytest_bdd import given, scenarios, then, when
from test_bdd_arith import built_runner, run_runner

scenarios("features/random.feature")


def random_runner():
    return built_runner("random_runner")


def random_suite_passes(result, expected=1):
    assert result.returncode == 0, result.stdout + result.stderr
    assert "Failed Assertions: 0" in result.stdout, result.stdout
    assert "Unexpected Errors: 0" in result.stdout, result.stdout
    assert re.search(rf"Total Tests Run:\s+{expected}\b", result.stdout), result.stdout


# Justification: reuse the native executable lookup for the random suite.
given("the random AUnit runner has been built", target_fixture="arith_runner")(random_runner)
# Justification: share the bounded execution used by all native BDD bridges.
when("the random compatibility suite runs with contracts enabled", target_fixture="result")(
    run_runner
)
# Justification: the AUnit summary makes fixture failures observable.
then("all native random fixture rows and boundary properties pass")(random_suite_passes)
