Feature: Native MPU callback iterators
  Scenario Outline: Iterator compatibility and boundaries
    Given the compiled powers test runner
    When the iterator check <name> runs
    Then the selected AUnit test passes within one minute

    Examples:
      | name          |
      | fixtures      |
      | control       |
      | properties    |
      | forcomp       |
      | forderange    |
      | formultiperm  |
      | forsetproduct |
      | object        |
      | print_primes  |
