Continuing the partial Count port; inspect existing implementations first.
Implement missing count bounds, approximations and Chebyshev APIs from MPU.
Extend compatibility and property tests, then run focused tests and gate.
Preserve fixtures and generated status; record remaining algorithm gaps honestly.
Inspected prior bounded Lucy implementation and MPU bounds; adding faithful analytic APIs before attempting larger algorithm changes.
The C source uses existing real.c Li/RiemannR routines for estimates; Ada Real is available. Large native estimates require extended precision to match fixtures exactly; keep this limitation visible.
