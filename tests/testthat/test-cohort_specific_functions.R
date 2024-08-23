library(testthat)

# Test 1: has object
test_that("stringPresentInCohortDefinitionText", {
  expected <- TRUE
  observed <- stringPresentInCohortDefinitionText(cohortDefinition = cohort14907, textToSearch = "gastrointestinal")
  expect_equal(observed, expected)
})

