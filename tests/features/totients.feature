Feature: Remaining native totient arithmetic
  Scenario: Totient fixtures and seeded arithmetic laws
    Given the checked totient test runner is built
    When the totient compatibility suite runs
    Then all eight totient fixture functions and seeded laws pass
