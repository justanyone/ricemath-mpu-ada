# wx-mpuada-prime-counts (continue)
- Plan: finish count family (prime_count, nth_prime, LMO, phi, Chebyshev, sum_primes) on top of the committed partial work.
- Read current src/ state first, then add missing units, compat_count and prop_count tests, run tools/test.sh count, then gate.
- Scope this session: Prime_Count (Lucy/LMO-style, lmo.c), Legendre_Phi (legendre_phi.c), Nth_Prime (bisection on Prime_Count). Bounds Pre: X <= 10**10.
- Not in scope now: lower/upper/approx bounds, Chebyshev, prime_count tables, Lehmer, cache, 1e13 benchmark. Recorded as PARTIAL.
- Body written: Prime_Count (Lucy), Legendre_Phi, Nth_Prime. Next: compat_count rows for these 3, then tools/test.sh count.
