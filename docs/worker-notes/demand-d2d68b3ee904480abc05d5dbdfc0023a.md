Implement the six block-taking Vec predicates as Ada generic subprograms.
Read the plan and existing vector conventions, then translate the XS semantics.
Add cited compatibility cases and deterministic laws in compat_vec.adb.
Run focused vector tests and the declared gate; record toolchain limits if any.
Read XS vecnone and aliases: callbacks short circuit in order; kept existing Big_Integer vector API and added six generic declarations/bodies with callback-free contracts.
Added separate AUnit tests for all six functions, cited upstream integer cases and reference-array exclusions, seeded complement/index laws, integer boundaries, and short-circuit call-order checks. Next run focused tests.
