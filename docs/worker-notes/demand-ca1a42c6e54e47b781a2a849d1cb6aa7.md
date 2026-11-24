Review the existing folds implementation and post-check findings.
Reduce the implementation and test patch to the requested budgets using existing APIs.
Run focused tests and the declared gate; record actual validation limits.
Reused the existing Vec_Case registrar and generic fold; shared fixture input/output parsing to cut duplicate helpers without dropping reference cases.
Focused test build started. Simplified result conversion with an Ada aggregate and used the standard array sort to avoid a duplicate container copy.
