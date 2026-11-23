Feature: Native totient, Moebius, and divisor arithmetic
  Scenario: Fixture compatibility and arithmetic identities
    Given the focused arithmetic runner has been built with contracts enabled
    When the arithmetic fixture and identity suite runs
    Then all arithmetic fixtures and boundary checks pass within one minute

  Scenario: Divisor arithmetic matches fixtures and exact integer laws
    Given the checked arithmetic test runner is built
    When the arithmetic compatibility suite runs
    Then all arithmetic fixtures, boundaries, and seeded divisor laws pass
