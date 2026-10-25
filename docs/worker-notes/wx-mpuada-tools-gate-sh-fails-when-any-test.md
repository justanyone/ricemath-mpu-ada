# wx-mpuada-tools-gate-sh-fails-when-any-test
- Goal: tools/gate.sh must fail (red, non-zero) when the test runner reports a failed test or prints no summary.
- Plan: capture runner output in tools/gate.sh, parse its summary, add a parse check script (tools/gate_check.sh) with fixtures of pass/fail/no-summary outputs.
- Step 1: ran tools/test.sh once: AUnit summary is "Total Tests Run:", "Successful Tests:", "Failed Assertions:", "Unexpected Errors:" (135/135 green on this base).
- Step 2: wrote tools/gate_verdict.sh (parses summary; red on missing summary, failed test, failed assertion, unexpected error) and tools/gate_verdict_check.sh (six sample cases). tools/gate.sh now captures runner output, goes red on non-zero runner exit, and calls gate_verdict.
- BLOCKER: every command that runs a script (sh, bash, direct path) was denied with "requires approval". Not run: tools/gate_verdict_check.sh, tools/gate.sh. Gate on base after the change is NOT verified. Next: run `tools/gate_verdict_check.sh` and `tools/gate.sh`, then check the base for failing tests.
- Also not done: tools/gate_verdict_check.sh and tools/gate_verdict.sh may lack the execute bit (created by Write); run via sh.
- ci.yml not changed; it may still run the tests step without the verdict check.
