# wx-mpuada-tools-gate-sh-fails-when-any-test
- Goal: tools/gate.sh must fail (red, non-zero) when the test runner reports a failed test or prints no summary.
- Plan: capture runner output in tools/gate.sh, parse its summary, add a parse check script (tools/gate_check.sh) with fixtures of pass/fail/no-summary outputs.
- Step 1: run tools/test.sh once to see the real AUnit summary text.
