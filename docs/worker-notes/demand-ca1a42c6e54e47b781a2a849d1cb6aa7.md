Review the existing folds implementation and post-check findings.
Reduce the implementation and test patch to the requested budgets using existing APIs.
Run focused tests and the declared gate; record actual validation limits.
Reused the existing Vec_Case registrar and generic fold; shared fixture input/output parsing to cut duplicate helpers without dropping reference cases.
Focused test build started. Simplified result conversion with an Ada aggregate and used the standard array sort to avoid a duplicate container copy.
The patch is down to three Ada files and 432 code lines; continuing to reduce duplicated helper logic. gnatcheck is absent from PATH and the Alire toolchain.
One focused build failed at link time on a vector iterator control symbol. Replaced that iterator with Element calls and removed the remaining nested suite wrapper.
Reduced the suite to the existing Vec_Case; retained oracle cases, native boundaries, snapshot and index checks. Removed the extra callback-order probe and compacted declaration spacing toward the line budget.
Corrected an edit that matched a forward declaration; restored the full oracle test bodies before further validation. Added the missing Canonical helper spec required by GNAT style.
The initial full run exposed reverse-window aggregate index semantics; mapped result indexes explicitly to restore reversed values. Restored all reference bodies from the unfiltered git source and restarted focused verification.
Kept the reverse-window helper as an explicit loop after GNAT rejected the replacement expression. Final code patch remains under 400 lines; full gate restarted on this version.
The final patch is 398 added Ada lines across three Ada files; required worker notes are separate. Waiting for the declared gate; no gnatcheck binary is installed on this host.
Development, release and test builds pass on the final source; no style diagnostics in the new library. Full suite is running; diff whitespace check passes.
The full gate suite is still executing after successful builds; waiting for its verdict without further source changes.
