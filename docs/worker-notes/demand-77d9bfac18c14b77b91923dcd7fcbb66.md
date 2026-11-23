Resolve the four Families merge conflicts while preserving both branches' public APIs and tests.
Read PLAN.md and STATUS.md first, then inspect each conflicting block and its surrounding implementation.
Run focused Families checks and available gate checks using the local Alire toolchain.
Leave resolved files on disk for the launcher; do not modify git metadata or generated STATUS.md.
Resolved the overlapping additions by retaining almost/omega and Ramanujan/twin/semiprime APIs and suites; kept both independent semiprime estimate bodies across the split conflict and removed duplicate declarations.
