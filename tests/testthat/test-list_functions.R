# Load testthat library
library(testthat)

# Test cases for the checkIfObjectExistsInNestedList function
test_that("Object is directly in the list", {
  list1 <- list(a = 1, b = 2)
  expect_true(checkIfObjectExistsInNestedList(list1, "a"))
})

test_that("Object is in a nested list", {
  list2 <- list(a = list(x = 5), b = 2)
  expect_true(checkIfObjectExistsInNestedList(list2, "x"))
})

test_that("Object does not exist in the list", {
  list3 <- list(a = 1, b = 2)
  expect_false(checkIfObjectExistsInNestedList(list3, "x"))
})

test_that("Empty list returns false", {
  list4 <- list()
  expect_false(checkIfObjectExistsInNestedList(list4, "a"))
})

test_that("Complex nesting", {
  list5 <- list(a = list(b = list(c = list(d = 1))), x = 2)
  expect_true(checkIfObjectExistsInNestedList(list5, "d"))
  expect_false(checkIfObjectExistsInNestedList(list5, "z"))
})

test_that("Check with non-existent object in complex nested list", {
  list6 <- list(a = list(b = list(c = list(d = 1))), x = 2)
  expect_false(checkIfObjectExistsInNestedList(list6, "y"))
})

# Check behavior with non-list objects
test_that("Non-list input returns false", {
  expect_false(checkIfObjectExistsInNestedList(NA, "x"))
  expect_false(checkIfObjectExistsInNestedList("Hello", "Hello"))
  expect_false(checkIfObjectExistsInNestedList(123, "123"))
})
