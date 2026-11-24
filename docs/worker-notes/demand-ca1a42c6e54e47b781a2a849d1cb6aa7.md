I will inspect the existing folds implementation and the reported author checks.
I will keep the task scope and reduce changed files through existing test registration where possible.
I will run focused tests and the declared gate, then record any environment limitations.
Reduced the folds tests to a standalone suite function, removing the fourth new Ada file while retaining all cases.
Ada accessibility prevents a standalone function from registering local callbacks. Reused Compat_Vec with a nested Folds suite instead, retaining all tests and reducing new Ada files to two.
The Alire environment provides neither gnatcheck nor gnatformat; running the declared compiler/test gate and checking the relocated test layout directly.
Focused tests are still building; the relocated suite has no lines over 79 columns and git diff --check is clean.
