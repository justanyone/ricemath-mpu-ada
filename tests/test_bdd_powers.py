"""BDD bridge to the checked Ada tests; build with `cd tests && alr build`."""

from pathlib import Path
import subprocess

from pytest_bdd import given, parsers, scenarios, then, when

scenarios("features/powers.feature")


# Justification: this is the first BDD bridge to the native Ada test executable.
@given("the compiled powers test runner", target_fixture="powers_runner")
def powers_runner():
    runner = Path(__file__).parent / "bin" / "powers_runner"
    assert runner.is_file(), "Build the tests crate with Alire first"
    return runner.resolve()


# Justification: fixture replay remains in Ada so BDD never invokes the oracle.
@when(parsers.parse('I replay the "{function}" fixture family'), target_fixture="result")
def replay_family(powers_runner, function):
    return run_selected(powers_runner, f"Compat_Families : {function}")


# Justification: expose the independent arithmetic and boundary assertions to BDD.
@when("I check the independent power family laws", target_fixture="result")
def check_laws(powers_runner):
    return run_selected(
        powers_runner, "Prop_Families seed 20261020 : powerful and powerfree laws"
    )


def run_selected(runner, selection):
    return subprocess.run(
        ["nice", "-n", "10", str(runner), selection],
        cwd=runner.parent.parent,
        capture_output=True,
        text=True,
        timeout=59,
        check=False,
    )


# Justification: AUnit's text runner reports failures without a failing exit code.
@then("the selected AUnit test passes within one minute")
def selected_test_passes(result):
    assert result.returncode == 0, result.stdout + result.stderr
    # AUnit's prefix filter also selects part_sum when selecting part.
    expected = 2 if "OK Compat_Families : powerfree_part (" in result.stdout else 1
    for summary in (
        f"Total Tests Run:   {expected}",
        f"Successful Tests:  {expected}",
        "Failed Assertions: 0",
        "Unexpected Errors: 0",
    ):
        assert summary in result.stdout, result.stdout


# Justification: compile and exercise the prime/perfect power regression paths.
@when(parsers.parse('I check the "{kind}" power regression'), target_fixture="result")
def check_power_regression(powers_runner, kind):
    return run_selected(powers_runner, f"Compat_Powers : {kind} laws")
