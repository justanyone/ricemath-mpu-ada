"""Reuse the modular fixture and law steps for residues, orders and CRT."""

from pytest_bdd import scenarios

pytest_plugins = ["test_bdd_modular"]

scenarios("features/modular_residues.feature")
