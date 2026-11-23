Implement the six filtered iterator ranges in a new Iter.Ranges child.
Read the native iterator and upstream segment algorithms to preserve behavior.
Add fixture compatibility and Lastfor tests, then run focused tests and gate.
Keep the parent iterator spec and generated STATUS.md unchanged.
Read XS loop dispatch and factor-range sieve; added the public child spec without changing the parent.
Implemented segmented ranges and fixture replay, including explicit bigint skip lines and six Lastfor checks. Starting focused build/tests.
Focused test launch required obj creation and XDG_RUNTIME_DIR redirection because Alire defaults outside the writable checkout; build now running.
Focused build remains pending with no compiler output; checking Alire verbose diagnostics before further validation.
Implemented the dedicated MARKSEMI range sieve and moved square-free flags to heap-backed bounded storage; compiler/test diagnostics pending.
