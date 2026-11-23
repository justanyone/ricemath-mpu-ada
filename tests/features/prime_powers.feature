Feature: Native prime and perfect powers
  Scenario: Replay the power family oracle
    Given a built Ada power test runner
    When the power family fixtures are replayed
    Then all selected Ada assertions pass

  Scenario: Check power arithmetic laws
    Given a built Ada power test runner
    When the seeded power properties are checked
    Then all selected Ada assertions pass
