Feature: Native MPU callback iterators
  Scenario: Iterator fixture compatibility
    Given the checked Ada iterator runner is built
    When the iterator compatibility suite runs
    Then all native iterator fixture rows pass within one minute

  Scenario: Nested callback termination
    Given the checked Ada iterator runner is built
    When the iterator compatibility suite runs
    Then loop termination, callback exceptions, and native boundaries pass

  Scenario: Combinatorial iterator compatibility
    Given the checked Ada iterator runner is built
    When the iterator compatibility suite runs
    Then compositions, derangements, multisets, and products match fixtures

  Scenario: Prime iterator object operations
    Given the checked Ada iterator runner is built
    When the iterator compatibility suite runs
    Then prime object iteration and navigation pass

  Scenario: Printing inclusive prime ranges
    Given the checked Ada iterator runner is built
    When the iterator compatibility suite runs
    Then printed prime lines match the sieve
