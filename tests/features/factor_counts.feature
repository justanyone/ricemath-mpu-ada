Feature: Native factor counts and predicates
  Scenario Outline: Replay each native function fixture
    Given the checked Ada factor counts runner is built
    When the factor fixture for "<function>" runs
    Then that native factor fixture test passes within one minute

    Examples:
      | function        |
      | factor_exp      |
      | prime_omega     |
      | prime_bigomega  |
      | prime_signature |
      | is_square_free  |
      | is_semiprime    |
      | is_almost_prime |
      | is_omega_prime  |
      | cheb_factor     |

  Scenario: Preserve decomposition laws and boundary conventions
    Given the checked Ada factor counts runner is built
    When the factor property tests run
    Then seeded factor laws and native boundary tests pass within one minute
