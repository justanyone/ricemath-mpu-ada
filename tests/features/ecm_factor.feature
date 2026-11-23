Feature: Native ECM factoring
  Scenario: Replay every committed native ECM fixture
    Given the checked Ada ECM test runner is built
    When the native ECM fixture test runs
    Then all 57 ECM fixture rows pass within one minute

  Scenario: Preserve factoring semantics at native boundaries
    Given the checked Ada ECM test runner is built
    When the native ECM boundary test runs
    Then the ECM boundary assertions pass within one minute
