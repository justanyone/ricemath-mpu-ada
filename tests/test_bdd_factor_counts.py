"""Reuse the checked AUnit runner and acceptance checks for factor tests."""

from pytest_bdd import given, parsers, scenarios, then, when

from test_bdd_powers import powers_runner, run_selected, selected_test_passes

scenarios("features/factor_counts.feature")

# Reuse the existing checked runner locator for this Ada family.
given("the checked Ada factor counts runner is built",
      target_fixture="powers_runner")(powers_runner)


def run_factor(powers_runner, selection):
    return run_selected(powers_runner, selection)


# AUnit name filtering replaces the separate factor-only selection harness.
when(parsers.parse('the factor test "{selection}" runs'),
     target_fixture="result")(run_factor)
# Reuse AUnit status/count checks, including the subprocess time limit.
then("the selected AUnit test passes within one minute")(selected_test_passes)
