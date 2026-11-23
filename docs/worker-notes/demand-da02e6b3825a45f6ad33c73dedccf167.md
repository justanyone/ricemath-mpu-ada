Implement the almost-prime and omega-prime family APIs from MPU 0.75.
Read the plan, existing family support, fixtures, and C algorithms before editing.
Add deterministic fixture coverage and public contracts; preserve generated STATUS.md.
Run focused tests and the declared gate, recording any toolchain limitations.
Read C recursive construction and counting; factor package is absent, so use existing prime and integer primitives. Next implement exact lists/counts/nth and replay their fixtures.
Implemented exact recursive lists/counts/nth and narrow factor sieving. Alire needs XDG_RUNTIME_DIR redirected into obj/tmp on this host; checking compilation next.
