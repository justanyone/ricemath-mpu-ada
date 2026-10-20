Continuing MPUADA-STRINT: inspect existing digits and integer helpers.
Close bigint fixture gaps and compare string arithmetic with MPU strint.c.
Keep fixtures and generated status unchanged; validate with focused tests and gate.
Found native-tier skips; strint.c/h are absent, with equivalents in strops.c.
Digits is an Ada reserved word; retain the existing Digit_Operations unit.
Focused test blocked: Alire tries fetching an absent community index offline.
Adding a standard-library bigint child API to replay previously skipped rows.
