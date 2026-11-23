Feature: Native factor counts and predicates
  Scenario: Replay the nine native function fixtures
    Given the checked Ada factor counts runner is built
    When the factor counts acceptance suite runs
    Then all nine native factor fixture tests pass within one minute

  Scenario: Preserve decomposition laws and boundary conventions
    Given the checked Ada factor counts runner is built
    When the factor counts acceptance suite runs
    Then seeded factor laws and native boundary tests pass within one minute
