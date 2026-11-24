Feature: Native powerful and powerfree numbers
  The Ada port replays MPU 0.75 fixtures without calling Perl.

  Scenario Outline: Replay a powerful or powerfree fixture family
    Given the compiled powers test runner
    When I replay the "<function>" fixture family
    Then the selected AUnit test passes within one minute

    Examples:
      | function           |
      | is_powerful        |
      | powerful_count     |
      | nth_powerful       |
      | sumpowerful        |
      | powerful_numbers   |
      | is_powerfree       |
      | powerfree_count    |
      | powerfree_sum      |
      | powerfree_part     |
      | powerfree_part_sum |
      | nth_powerfree      |
      | squarefree_kernel  |

  Scenario: Independent arithmetic laws and native boundaries
    Given the compiled powers test runner
    When I check the independent power family laws
    Then the selected AUnit test passes within one minute

  Scenario Outline: Prime and perfect power compilation regressions
    Given the compiled powers test runner
    When I check the "<kind>" power regression
    Then the selected AUnit test passes within one minute

    Examples:
      | kind    |
      | prime   |
      | perfect |
