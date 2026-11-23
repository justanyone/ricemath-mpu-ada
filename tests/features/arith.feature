Feature: Native totient and Moebius arithmetic
  Scenario: Fixture compatibility and arithmetic identities
    Given the focused arithmetic runner has been built with contracts enabled
    When the arithmetic fixture and identity suite runs
    Then all arithmetic fixtures and boundary checks pass within one minute
