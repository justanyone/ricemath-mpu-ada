Feature: Native factor counts and predicates
  Scenario Outline: Replay each native function fixture
    Given the checked Ada factor counts runner is built
    When the factor test "Compat_Factor : <function>" runs
    Then the selected AUnit test passes within one minute

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

  Scenario Outline: Preserve decomposition laws and boundary conventions
    Given the checked Ada factor counts runner is built
    When the factor test "Prop_Factor seed 20261123 : <check>" runs
    Then the selected AUnit test passes within one minute

    Examples:
      | check       |
      | factor laws |
      | boundaries  |
