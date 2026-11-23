Feature: Native random primes
  Scenario: Random fixtures and seeded boundary checks
    Given the random AUnit runner has been built
    When the random compatibility suite runs with contracts enabled
    Then all native random fixture rows and boundary properties pass
