# ricemath-mpu-ada

An Ada port of Perl's [Math::Prime::Util](https://metacpan.org/pod/Math::Prime::Util) (MPU) 0.75: primality tests,
sieves and prime counts, integer factoring, and the number-theory toolbox around them. Sibling of the Rust port,
[justanyone/math-prime-util](https://github.com/justanyone/math-prime-util).

Status: **planning (no code yet)**. See [PLAN.md](PLAN.md) for the design and phases, [STATUS.md](STATUS.md) for the
428-function checklist and the Alire publishing checklist, and [AGENTS.md](AGENTS.md) for the working rules.

## Goals

- **Full compatibility.** Same function names (in Ada_Case) and the same answers as MPU, checked against the
  committed oracle fixtures (279,306 rows recorded from MPU 0.75, shared with the Rust port).
- **Performance.** MPU's C algorithms ported as they are; within 1.5x of the C, 1.2x as the goal.
- **Exceptional test coverage.** Compat fixtures, contracts run as assertions, property tests, SPARK proof of the
  64/128-bit arithmetic (GNATprove), GNATcoverage gates (95% statement, 90% decision), sanitizer and static-check runs,
  mutation testing.
- **Easy to use from Ada.** Published on [Alire](https://alire.ada.dev) as `math_prime_util`
  (`alr with math_prime_util`) once phase 2 is done.

## Branches

`main` holds releases. Work lands on `dev-mpuada-NNN` branches through pull requests.

## License

`GPL-1.0-or-later OR Artistic-1.0-Perl`, the same terms as MPU and Perl. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
