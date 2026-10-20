Review the existing Combinat port and its fixture tests.
Fix build failures first, then extend the named functions using MPU 0.75.
Run focused tests and the repository gate offline.
Keep incomplete work explicit; the launcher handles commits.
Focused tests blocked: Alire attempts to initialize its community index offline. Reviewing native algorithms next.
Read overflow conventions and factorial algorithms. Extending checked products and LCM before broader signed APIs.
Added descending/ascending signed factorials, prime-power LCM, Fubini, and power sums, with fixture dispatch.
Added algebraic quotient, signed duality, power-sum difference, and overflow boundary tests. Fubini supports 18, the last U64 result.
Both focused tests and gate stop at missing offline Alire index. Installed compiler binaries do exist; checking a workspace-local Alire configuration.
Workspace-local Alire settings avoid network, but tests cannot resolve AUnit and compiler without the preinstalled index. No tests reached compilation yet.
Copied installed toolchain into ignored obj/ to keep all Alire writes within the worktree. Attempting gate with isolated offline settings.
Local PATH enabled compilation. Fixed inherited Bell-row anonymous-array type error and new option equality visibility. Existing Int style diagnostics remain outside task paths.
Built a temporary local AUnit index under ignored obj/ using installed files; no dependency or build scripts changed.
Local index now resolves AUnit and GNAT. Compiler has started; checking the new fixture and property units.
The first compiled run reached all tests. Signed product fixtures exposed an overlarge-result parser failure; replaced conversion with checked magnitude parsing.
