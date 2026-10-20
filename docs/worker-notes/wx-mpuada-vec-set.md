Vec/set port: inspect the existing API, fixture format, and MPU algorithms.
Implement native Ada vector and integer set operations with contracts.
Add compatibility and property coverage, then run the focused test and gate.
Keep the fixtures, generated status, dependencies, and build tools unchanged.
The checkout has only Int; Vec is new. Fixtures include bigint and string cases.
Start with exact signed set operations and stable vector helpers; no new crates.
