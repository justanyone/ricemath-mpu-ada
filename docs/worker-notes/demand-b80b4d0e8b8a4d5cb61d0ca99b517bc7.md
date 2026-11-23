Implement the six missing iterator APIs in the existing Iter package.
Read the plan, status, reference algorithms, and existing iterator tests first.
Extend fixture replay and add deterministic file-output and edge tests.
Run focused tests and the configured gate; record any environment limitations.
- 2026-11-23T22:28:23Z launcher: no commit for 60 s; 90 s elapsed. Files changed so far: docs/worker-notes/demand-b80b4d0e8b8a4d5cb61d0ca99b517bc7.md.
Read the existing iterator implementation and MPU sources; use lexical traversals, optional native prime results, and copied integer-list products. Perl identity/text/bigint fixture rows need named skip comments.
Added public APIs and implementations plus fixture replay, object-method checks, and file-output comparisons. Alire initially fails creating its temporary file under inaccessible /run/user/1000; trying a workspace runtime directory.
Workspace XDG_RUNTIME_DIR resolves Alire startup. First compile found an Ada reserved identifier in the composition port; renamed it. Focused tests have been launched and will be rerun after compiler fixes.
