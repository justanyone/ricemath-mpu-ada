Continue the existing primality implementation and resolve the tests-only review.
Inspect the primality source and retained tests before choosing a minimal product correction.
Run focused tests and the declared gate; preserve fixture data and existing scope.
Inspection found the retained diff was tests-only; add MPU-compatible default base 2 to the three public base predicates and replay omitted-base fixture rows through those defaults.
Alire rejected --offline; use the declared build command with the existing pinned environment and no dependency changes.
Confirmed default-base behavior in reference/mpu/XS.xs:2465; product specs/bodies and fixture calls now expose it. Build attempts failed before compilation because Alire uses an unwritable runtime directory; checking a checkout-local runtime directory next.
