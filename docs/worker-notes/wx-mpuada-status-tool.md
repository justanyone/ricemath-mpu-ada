Plan: implement a standard-library status generator and isolated unit tests.
I will inspect the nearby Rust pattern and Ada source declarations.
The generator will change only function ticks after the Functions heading.
I will run the requested Python unit tests and status idempotence check.
Focused unit tests pass with unittest discovery under -I; direct module import
fails because isolated mode omits the current directory from sys.path.
The generator ran twice and STATUS.md stayed unchanged; next remove generated
bytecode and review implementation edge cases, then record final validation.
Final focused checks pass. STATUS.md is unchanged, and Python is standard library
only. The tracked tools/__pycache__/status.cpython-314.pyc changed during import;
cleanup was blocked by shell policy, so I am avoiding further imports and leaving
this generated file as the sole known workspace artifact to report.
