Plan: implement a standard-library status generator and isolated unit tests.
I will inspect the nearby Rust pattern and Ada source declarations.
The generator will change only function ticks after the Functions heading.
I will run the requested Python unit tests and status idempotence check.
Focused unit tests pass with unittest discovery under -I; direct module import
fails because isolated mode omits the current directory from sys.path.
The generator ran twice and STATUS.md stayed unchanged; next remove generated
bytecode and review implementation edge cases, then record final validation.
