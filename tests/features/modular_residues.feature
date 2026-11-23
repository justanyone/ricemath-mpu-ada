Feature: Native residues, orders and Chinese remainders
  Scenario: Native residue fixtures and independent laws pass
    Given the modular AUnit runner has been built
    When the modular compatibility suite runs with contracts enabled
    Then all native modular fixture rows and boundary properties pass
