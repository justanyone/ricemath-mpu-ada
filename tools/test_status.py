"""Unit tests for status.py."""

import tempfile
import unittest
import importlib.util
from pathlib import Path

SPEC = importlib.util.spec_from_file_location(
    "status", Path(__file__).with_name("status.py"))
status = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(status)


class StatusTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.source = self.root / "src"
        self.source.mkdir()
        self.status_file = self.root / "STATUS.md"

    def tearDown(self):
        self.temp.cleanup()

    def test_updates_matching_public_function_and_preserves_other_text(self):
        (self.source / "math_prime_util-demo.ads").write_text(
            "package Math_Prime_Util.Demo is\n"
            "   -- function Hidden is commented out\n"
            "   function Ada_Name return Boolean;\n"
            "end Math_Prime_Util.Demo;\n", encoding="utf-8")
        before = "Header tick: - [ ] `head` -> `Head`\n## Functions\n"
        before += "- [ ] `api` -> `ada_name`\n"
        before += "- [-] `skip` -> `Missing`\n"
        before += "- [ ] `missing` -> `Missing`\n"
        self.status_file.write_text(before, encoding="utf-8")

        self.assertTrue(status.regenerate(self.status_file, self.source))
        self.assertEqual(self.status_file.read_text(encoding="utf-8"),
                         before.replace("- [ ] `api`", "- [x] `api`"))

    def test_second_run_is_idempotent(self):
        (self.source / "demo.ads").write_text(
            "package Demo is function Present return Integer; end Demo;",
            encoding="utf-8")
        self.status_file.write_text(
            "## Functions\n- [ ] `present` -> `PRESENT`\n",
            encoding="utf-8")
        self.assertTrue(status.regenerate(self.status_file, self.source))
        self.assertFalse(status.regenerate(self.status_file, self.source))

    def test_missing_heading_fails_without_writing(self):
        self.status_file.write_text("unchanged\n", encoding="utf-8")
        with self.assertRaises(ValueError):
            status.regenerate(self.status_file, self.source)
        self.assertEqual(self.status_file.read_text(encoding="utf-8"),
                         "unchanged\n")


if __name__ == "__main__":
    unittest.main()
