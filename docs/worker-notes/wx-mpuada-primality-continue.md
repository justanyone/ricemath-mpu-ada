# wx-mpuada-primality continue notes

- Goal: finish the primality family: Perrin, Catalan, Frobenius variants, Chen, delicate, Mersenne, safe primes, Is_Prime fast path, validation.
- Random Miller-Rabin stays unimplemented (todo, STATUS stays [ ]); say so in the final message.
- Plan: read the current spec and body, add the missing functions in small edits, run tools/test.sh primality, then tools/gate.sh.
- Found: spec and body have Is_Prime, Is_Prob_Prime, Is_Bpsw_Prime, the Pseudoprime, Euler, Strong, Euler plumb, Lucas family, Safe prime, Mersenne. No code change yet in this session.
- Read C: Perrin in primality.c (calc_perrin_sig, is_perrin_pseudoprime, needs the _perrindata and _perrinmask tables); Catalan in util.c:2392 (needs factorint); Chen in almost_primes.c:1005 (needs is_semiprime and MAX_CHEN_PRIME); Delicate in util.c:3143.
- Blocked: src has no factoring or semiprime package, so Catalan and Chen cannot be ported as MPU does. Did not add a local substitute, because that would change the method.
- Not done: Perrin, Catalan, Frobenius (plain, Underwood, Khashin), Chen, Delicate, miller_rabin_random (todo, random module absent), the Is_Prime fast path, and the validation review.
- Last line: no code written; the next session needs a factoring package before Catalan and Chen.
