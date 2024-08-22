library(testthat)

# Test 1: has object
test_that("extractPathsDepthsAndValues handles a simple flat list", {
  list1 <- list(a = 1, b = 2)
  expected1 <- TRUE
  observed1 <- checkIfObjectExistsInNestedList(nestedList = list1, object = "a")
  expect_equal(observed1, expected1)
})

# Test 1: does not have object
test_that("extractPathsDepthsAndValues handles a simple flat list", {
  list1 <- list(a = 1, b = 2)
  expected1 <- TRUE
  observed1 <- !checkIfObjectExistsInNestedList(nestedList = list1, object = "x")
  expect_equal(observed1, expected1)
})
