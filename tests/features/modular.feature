Feature: Native modular helpers
  Scenario: Modular fixtures and independent boundary checks
    Given the modular AUnit runner has been built
    When the modular compatibility suite runs with contracts enabled
    Then all native modular fixture rows and boundary properties pass
