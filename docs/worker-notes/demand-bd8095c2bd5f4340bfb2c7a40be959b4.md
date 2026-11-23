I will port the Goldbach routines and the requested small prime-family predicates from the vendored MPU reference.
I will first check the prerequisite primality implementation and existing fixture test architecture.
I will add a standalone Goldbach package, public predicate APIs, and fixture coverage within the task scope.
I will run focused tests and the declared project gate if the local toolchain permits.
Inspection found Goldbach implemented inside Families and its fixture replay already wired. I am checking task-listed functions against reference and status before extracting the package.
Extracted Goldbach declarations and algorithms into their own child package. I am switching fixture replay to that API and will compile/run the family compatibility suite next.
