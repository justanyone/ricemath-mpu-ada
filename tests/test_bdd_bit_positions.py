"""BDD bridge to the checked native bit position compatibility tests."""

from pytest_bdd import given, parsers, scenarios, then, when
from test_bdd_powers import powers_runner, run_selected, selected_test_passes

scenarios("features/bit_positions.feature")

# Justification: share executable lookup with the existing filtered AUnit runner.
given("the compiled bit position test runner", target_fixture="bit_runner")(
    powers_runner
)
# Justification: register the shared assertion step in this feature module.
then("the selected AUnit test passes within one minute")(selected_test_passes)


def check_bit_positions(bit_runner, operation):
    return run_selected(bit_runner, f"Compat_Bit_Positions : {operation}")


# Justification: select each native operation's exhaustive Ada boundary checks.
when(
    parsers.parse('I check the "{operation}" bit position behavior'),
    target_fixture="result",
)(check_bit_positions)
