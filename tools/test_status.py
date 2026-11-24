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
        build = status.ROOT / "obj"
        build.mkdir(exist_ok=True)
        self.temp = tempfile.TemporaryDirectory(dir=build)
        self.root = Path(self.temp.name)
        self.source = self.root / "src"
        self.source.mkdir()
        self.status_file = self.root / "STATUS.md"

    def tearDown(self):
        self.temp.cleanup()

    def complete_list(self, text):
        """Pad small examples to the required 428 unique function rows."""
        count = sum(status.STATUS_ROW.match(line) is not None
                    for line in text.splitlines())
        return text + "".join(
            f"- [ ] `unused_{i}` -> `Unused_{i}`\n"
            for i in range(428 - count))

    def test_updates_matching_public_function_and_preserves_other_text(self):
        (self.source / "math_prime_util-demo.ads").write_text(
            "package Math_Prime_Util.Demo is\n"
            "   -- function Hidden is commented out\n"
            "   function Ada_Name return Boolean;\n"
            "end Math_Prime_Util.Demo;\n", encoding="utf-8")
        before = "Header tick: - [ ] `head` -> `Head`\n## Functions\n"
        before += "- [ ] `api` -> `ada_name`\n"
        before += "- [-] `skip` -> `Missing`\n"
        before += "- [ ] `missing` -> `Missing`\n\n \t\n"
        before = self.complete_list(before)
        self.status_file.write_text(before, encoding="utf-8")

        self.assertTrue(status.regenerate(self.status_file, self.source))
        self.assertEqual(self.status_file.read_text(encoding="utf-8"),
                         before.replace("- [ ] `api`", "- [x] `api`"))

    def test_second_run_is_idempotent(self):
        (self.source / "demo.ads").write_text(
            "package Demo is function Present return Integer; end Demo;",
            encoding="utf-8")
        self.status_file.write_text(
            self.complete_list("## Functions\n- [ ] `present` -> `PRESENT`\n"),
            encoding="utf-8")
        self.assertTrue(status.regenerate(self.status_file, self.source))
        self.assertFalse(status.regenerate(self.status_file, self.source))

    def test_wrong_function_count_fails_without_writing(self):
        for count in (0, 427, 429):
            with self.subTest(count=count):
                before = "## Functions\n" + "".join(
                    f"- [x] `api_{i}` -> `Api_{i}`\n"
                    for i in range(count))
                self.status_file.write_text(before, encoding="utf-8")
                with self.assertRaisesRegex(ValueError, "428 function rows"):
                    status.regenerate(self.status_file, self.source)
                self.assertEqual(self.status_file.read_text(encoding="utf-8"),
                                 before)

    def test_foreign_function_line_fails_without_writing(self):
        for foreign in ("KIT NOTE, NOT FILE CONTENT: shortened output",
                        "- [x] `permtonum` -> `Per", "## Unexpected"):
            with self.subTest(foreign=foreign):
                before = self.complete_list(
                    "## Functions\n- [x] `absent` -> `Absent`\n")
                before += foreign + "\n"
                self.status_file.write_text(before, encoding="utf-8")
                with self.assertRaisesRegex(ValueError, "invalid function row"):
                    status.regenerate(self.status_file, self.source)
                self.assertEqual(self.status_file.read_text(encoding="utf-8"),
                                 before)

    def test_missing_heading_fails_without_writing(self):
        self.status_file.write_text("unchanged\n", encoding="utf-8")
        with self.assertRaises(ValueError):
            status.regenerate(self.status_file, self.source)
        self.assertEqual(self.status_file.read_text(encoding="utf-8"),
                         "unchanged\n")


if __name__ == "__main__":
    unittest.main()
