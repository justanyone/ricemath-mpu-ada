Feature: Native bit position operations
  Positions are zero based and native integers have 64 bits.

  Scenario Outline: Exhaustive native positions and mixed bit boundaries
    Given the compiled bit position test runner
    When I check the "<operation>" bit position behavior
    Then the selected AUnit test passes within one minute

    Examples:
      | operation  |
      | bitset     |
      | bitclear   |
      | bitflip    |
      | bittest    |
      | bitscan0   |
      | bitscan1   |
      | mixed bits |
