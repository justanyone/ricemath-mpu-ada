Implement the u64 proving package and compatibility coverage for the requested functions.
Read PLAN.md and STATUS.md first, then inspect the oracle and existing arithmetic interfaces.
Preserve fixtures and generated STATUS.md; validate with focused tests and the project gate.
The Factor package is absent; ported the independent IMPL_V6 AKS path and native provable-prime shortcut, with both fixture families registered. Next: compile and test, then certificates.
Initial build failed because Alire used unwritable /run/user/1000; retrying with workspace obj/tmp. MPU native certificates use Small; BLS5 checking can validate supplied factors without the missing Factor package.
Setting XDG_RUNTIME_DIR fixed the Alire temporary-file failure; test build started. Added native Small certificate generation and single-block Small/BLS5 verification with explicit decimal overflow rejection.
Added certificate round trips at native boundaries and adversarial BLS5 cases; AKS polynomial-path coverage and formal proofs remain open. Running the checked suite next.
Certificate implementation compiled; the full suite is running and the declared gate has started. STATUS.md remains untouched. Single-block certificate support is intentionally documented; multi-block chains and additional n-1 formats remain for continuation.
