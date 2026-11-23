# Integer vectors and sets

`Math_Prime_Util.Vec` ports MPU 0.75 `sort.c: sort_iv_array`,
`sort_uv_array`, `sort_dedup_uv_array`; `xs_set.c: xs_set_op`,
`xs_set_relation`, `xs_is_sidon_set`, `xs_is_sumfree_set`; and the vector,
set update, extraction, and pair-sum entry points in `XS.xs`.
The Ada implementation replaces Perl arrays and `ds_iset.h` membership
storage with local arrays. It has no shared mutable state.

Integer values use the existing signed I128 type so mixed negative and
unsigned 64-bit inputs compare without wrapping. Arithmetic is checked;
overflow raises Constraint_Error. Empty extrema and absent search results
are discriminated optional values. Extracted indices are zero based and
negative indices count from the end; missing positions are undefined.
Masks use U128. List-returning operations return arrays starting at one.
Set update procedures take a capacity buffer and a used length, and reject
insufficient capacity before modifying the buffer. Set relation argument
order follows MPU: Set_Is_Subset(A,B) asks whether B is contained in A.

Callbacks are Ada generics. Pairwise and window callbacks can return zero
or multiple values; reduce and slide callbacks return scalar values.
Setbinop's Self flag selects the single-set triangular evaluation.
Vecsample takes randomness from a caller-supplied uniform Draw function;
it does not introduce library RNG state.

The compatibility test visits every vec.tsv row. Bigint_Input and
Bigint_Result comments identify skips beyond the native fixture tier or
I128 result range. Numeric outputs normalize decimal spelling; vecfreq
compares unordered key/count pairs because MPU returns a hash. Fixtures
are unchanged. Generic extraction maps letter fixtures to integer character
codes and back, exercising the same index/mask implementation.

`tests/features/vec.feature` names the BDD scenarios, backed by
`tests/test_bdd_vec.py`. After `cd tests && alr build`, the focused Ada
checks run with `nice -n 10 tests/bin/test_runner --vec` from the repository
root. The BDD wrapper requires pytest-bdd and bounds the focused run to 55
seconds. Prop_Vec covers callbacks, set identities with seed 0x5EED075,
non-one array bounds, native integer boundaries, and overflow.
