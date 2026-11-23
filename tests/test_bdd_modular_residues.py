"""Reuse the modular fixture and law steps for residues, orders and CRT."""
from pytest_bdd import scenarios
from test_bdd_modular import *  # noqa: F403 -- reuse registered modular steps

scenarios("features/modular_residues.feature")
