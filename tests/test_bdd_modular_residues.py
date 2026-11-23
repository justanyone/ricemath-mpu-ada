"""Reuse the modular fixture and law steps for residues, orders and CRT."""
from pytest_bdd import scenarios

from test_bdd_modular import (  # noqa: F401
    modular_runner,
    run_modular_suite,
    modular_suite_passes,
)

scenarios("features/modular_residues.feature")
