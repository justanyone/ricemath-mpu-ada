Feature: Native integer vectors and sets
  Scenario: Vector and set fixture compatibility
    Given the checked Ada vector test runner is built
    When the vector and set suites run
    Then all native vector fixture cases pass

  Scenario: Vector callback and boundary laws
    Given the checked Ada vector test runner is built
    When the vector and set suites run
    Then callback, boundary, and seeded set laws pass
