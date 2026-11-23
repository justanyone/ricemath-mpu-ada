"""Reuse the checked AUnit runner and acceptance checks for factor tests."""

from test_bdd_powers import (
    given, parsers, scenarios, then, when,
    powers_runner, run_selected, selected_test_passes,
)

scenarios("features/factor_counts.feature")

# Reuse the existing checked runner locator for this Ada family.
given("the checked Ada factor counts runner is built",
      target_fixture="runner")(powers_runner)


# AUnit name filtering replaces the separate factor-only selection harness.
when(parsers.parse('the factor test "{selection}" runs'),
     target_fixture="result")(run_selected)
# Reuse AUnit status/count checks, including the subprocess time limit.
then("the selected AUnit test passes within one minute")(selected_test_passes)
