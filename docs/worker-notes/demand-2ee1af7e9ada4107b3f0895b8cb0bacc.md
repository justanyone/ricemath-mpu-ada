Implement the six filtered iterator ranges in a new Iter.Ranges child.
Read the native iterator and upstream segment algorithms to preserve behavior.
Add fixture compatibility and Lastfor tests, then run focused tests and gate.
Keep the parent iterator spec and generated STATUS.md unchanged.
Read XS loop dispatch and factor-range sieve; added the public child spec without changing the parent.
Implemented segmented ranges and fixture replay, including explicit bigint skip lines and six Lastfor checks. Starting focused build/tests.
Focused test launch required obj creation and XDG_RUNTIME_DIR redirection because Alire defaults outside the writable checkout; build now running.
Focused build remains pending with no compiler output; checking Alire verbose diagnostics before further validation.
Implemented the dedicated MARKSEMI range sieve and moved square-free flags to heap-backed bounded storage; compiler/test diagnostics pending.
Development library build succeeded. Fixed fixture diagnostic typo, segment-end odd-composite handling, and added XS almost-prime power-of-two reduction.
Corrected vector initialization and reran the focused suite; retaining upstream segmented algorithms and all native boundary rows.
Gate development build passed; release build is running. Added empty/reversed ranges, K=63 reduction, and a factor-segment boundary test.
Square-free integer loop now visits one before allocation, matching XS Lastfor behavior; waiting for focused results and gate.
Gate release and tests builds passed. Native square-free U64 fixture is still running and may conflict with the owner one-minute test limit; checking isolated execution controls.
The stock AUnit runner also starts tests for --help, indicating CLI filter arguments are ignored. Added a dedicated focused runner to measure this package independently.
Stopped duplicate unfiltered test jobs. Corrected focused-runner source path after the first gprbuild attempt reported it missing.
Focused runner compilation is active; gate is still in the full existing test suite. No parent spec, fixtures, tools, or generated STATUS changes.
Dedicated package runner built successfully and is running with a 60-second timeout. Line-length and git whitespace checks passed.
Full gate tests and bounded focused run remain active; no additional implementation changes while collecting results.
Awaiting the focused timeout verdict before deciding whether the exact upstream square-free sieve meets the owner runtime guardrail.
Focused suite timed out at 60.02 seconds. Added named-routine selection to the dedicated runner to isolate runtime instead of weakening fixture coverage.
Replaced controlled-vector operations inside the prime segment sieve with a fixed odd-slot array, retaining segmented Eratosthenes and prime-square marking to reduce runtime without per-value square-free tests.
Rebuilding optimized square-free sieve and running the selected edge test. Stopped the earlier gate run because it used the pre-optimization library.
