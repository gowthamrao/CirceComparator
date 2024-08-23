library(testthat)

test_that("parseCohortDefinitionSpecifications", {
  observed <- parseCohortDefinitionSpecifications(cohortDefinition = cohort14907)
})

test_that("stringPresentInCohortDefinitionText", {
  expected <- TRUE
  observed <- stringPresentInCohortDefinitionText(cohortDefinition = cohort14907, textToSearch = "gastrointestinal")
  expect_equal(observed, expected)
})

test_that("readCollapseSettings", {
  observed <- readCollapseSettings(cohortDefinition = cohort14907)
  expect_equal(observed$collapseType, "ERA")
  expect_equal(observed$eraPad, "0")
})

test_that("readCohortExit", {
  observed <- readCohortExit(cohortDefinition = cohort14907)
  expect_equal(observed$surveillanceWindow, 0)
  expect_equal(observed$persistenceWindow, 30)
  expect_equal(observed$drugCodeSetId, 0)
})

test_that("readCensorWindow", {
  observed <- readCensorWindow(cohortDefinition = cohort14907)
})

test_that("hasInitialEventRestrictionAdditionalCriteria", {
  observed <- hasInitialEventRestrictionAdditionalCriteria(cohortDefinition = cohort14907)
  expect_equal(observed, FALSE)
})
