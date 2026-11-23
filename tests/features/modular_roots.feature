Feature: Native modular roots
  Scenario: Native fixtures and root laws pass
    Given the modular root test runner has been built with contracts
    When the modular root compatibility suite runs
    Then all native fixtures and exhaustive root laws pass
