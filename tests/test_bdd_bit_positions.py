"""BDD bridge to the checked native bit position compatibility tests."""

from pathlib import Path

from pytest_bdd import given, parsers, scenarios, then, when

from test_bdd_powers import run_selected, selected_test_passes

scenarios("features/bit_positions.feature")

# Justification: register the shared assertion step in this feature module.
then("the selected AUnit test passes within one minute")(selected_test_passes)


# Justification: reuse the existing filtered runner for the new suite.
@given("the compiled bit position test runner", target_fixture="bit_runner")
def bit_runner():
    runner = Path(__file__).parent / "bin" / "powers_runner"
    assert runner.is_file(), "Build the tests crate with Alire first"
    return runner.resolve()


# Justification: select each native operation's exhaustive Ada boundary checks.
@when(
    parsers.parse('I check the "{operation}" bit position behavior'),
    target_fixture="result",
)
def check_bit_positions(bit_runner, operation):
    return run_selected(bit_runner, f"Compat_Bit_Positions : {operation}")
