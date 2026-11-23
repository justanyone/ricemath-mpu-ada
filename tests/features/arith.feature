Feature: Native divisor arithmetic
  Scenario: Divisor arithmetic matches fixtures and exact integer laws
    Given the checked arithmetic test runner is built
    When the arithmetic compatibility suite runs
    Then all arithmetic fixtures, boundaries, and seeded divisor laws pass
