Resolve the four Families merge conflicts while preserving both branches' public APIs and tests.
Read PLAN.md and STATUS.md first, then inspect each conflicting block and its surrounding implementation.
Run focused Families checks and available gate checks using the local Alire toolchain.
Leave resolved files on disk for the launcher; do not modify git metadata or generated STATUS.md.
Resolved the overlapping additions by retaining almost/omega and Ramanujan/twin/semiprime APIs and suites; kept both independent semiprime estimate bodies across the split conflict and removed duplicate declarations.
Alire initially could not use its runtime directory; retrying with XDG_RUNTIME_DIR under obj works. Development and focused runner builds are in progress; removed the shared vector rename duplicate.
Development library build passed. The first direct focused build lacked generated test configuration; running alr build in tests generated it, and the focused runner is now compiling with contracts enabled.
