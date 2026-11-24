"""BDD bridge to the checked native bit position compatibility tests."""

from pathlib import Path

from pytest_bdd import given, parsers, scenarios, when

from test_bdd_powers import run_selected, selected_test_passes  # noqa: F401

scenarios("features/bit_positions.feature")


# Justification: bit positions use the combined runner with their own suite filter.
@given("the compiled bit position test runner", target_fixture="bit_runner")
def bit_runner():
    runner = Path(__file__).parent / "bin" / "test_runner"
    assert runner.is_file(), "Build the tests crate with Alire first"
    return runner.resolve()


# Justification: select each native operation's exhaustive Ada boundary checks.
@when(
    parsers.parse('I check the "{operation}" bit position behavior'),
    target_fixture="result",
)
def check_bit_positions(bit_runner, operation):
    return run_selected(bit_runner, f"Compat_Bit_Positions : {operation}")
