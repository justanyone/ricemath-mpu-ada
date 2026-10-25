#!/usr/bin/env python3
"""Update STATUS.md function ticks from Ada declarations in src/.

Run from any directory with ``python3 -I tools/status.py``.
"""

import re
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
STATUS = ROOT / "STATUS.md"
SOURCE = ROOT / "src"
FUNCTIONS_HEADING = "## Functions"
STATUS_ROW = re.compile(
    r"^(?P<prefix>- \[)(?P<tick>[ x-])(?P<middle>\] `[^`]+` -> `)"
    r"(?P<name>[^`]+)(?P<suffix>`.*)$"
)
DECLARATION = re.compile(
    r"\b(?:function|procedure)\s+([A-Za-z][A-Za-z0-9_]*)\b",
    re.IGNORECASE,
)


def public_subprograms(source: Path) -> set[str]:
    """Return names declared in Ada specs below source, ignoring comments."""
    names: set[str] = set()
    for spec in source.rglob("*.ads"):
        contents = spec.read_text(encoding="utf-8")
        contents = re.sub(r"--[^\n]*", "", contents)
        names.update(match.group(1).casefold()
                     for match in DECLARATION.finditer(contents))
    return names


def regenerate(status: Path = STATUS, source: Path = SOURCE) -> bool:
    """Update function ticks. Return True if the status file changed."""
    original = status.read_text(encoding="utf-8")
    lines = original.splitlines(keepends=True)
    declared = public_subprograms(source)
    if source.exists():
        declared = public_subprograms(source)
    else:
        declared = set()
    try:
        start = next(i for i, line in enumerate(lines)
                     if line.rstrip("\r\n") == FUNCTIONS_HEADING) + 1
    except StopIteration:
        raise ValueError(f"missing {FUNCTIONS_HEADING!r} heading") from None

    changed = False
    for index in range(start, len(lines)):
        line = lines[index]
        ending = "\n" if line.endswith("\n") else ""
        content = line[:-1] if ending else line
        if content.endswith("\r"):
            content, ending = content[:-1], "\r\n"
        match = STATUS_ROW.match(content)
        if match is None or match.group("tick") == "-":
            continue
        tick = "x" if match.group("name").casefold() in declared else " "
        if tick != match.group("tick"):
            lines[index] = (match.group("prefix") + tick
                            + match.group("middle") + match.group("name")
                            + match.group("suffix") + ending)
            changed = True
    if changed:
        status.write_text("".join(lines), encoding="utf-8")
    return changed


if __name__ == "__main__":
    regenerate()
