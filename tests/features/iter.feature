Feature: Native MPU callback iterators
  Scenario Outline: Iterator compatibility and boundaries
    Given the checked Ada iterator runner is built
    When the iterator compatibility suite runs
    Then the iterator checks <names> pass within one minute

    Examples:
      | names                                           |
      | fixtures                                        |
      | control, properties                |
      | forcomp, forderange, formultiperm, forsetproduct |
      | object                                          |
      | print_primes                                    |
