# Load testthat and other required libraries
library(testthat)
library(dplyr)
library(tidyr)

# Assume the checkIfObjectExistsInNestedList function is defined or loaded from the same package

# Simple tests for the getWhereAnObjectExistsInNestedList function
test_that("Object is directly in the list", {
  list1 <- list(a = 1, b = 2)
  result <- getWhereAnObjectExistsInNestedList(list1, "a")
  expected <- tibble(criteriaLocationa = 1)
  expect_equal(result, expected)
})

test_that("Object is in a nested list", {
  list2 <- list(a = list(x = 5), b = 2)
  result <- getWhereAnObjectExistsInNestedList(list2, "x")
  expected <- tibble(criteriaLocationx = 1)
  expect_equal(result, expected)
})

test_that("Object does not exist in the list", {
  list3 <- list(a = 1, b = 2)
  result <- getWhereAnObjectExistsInNestedList(list3, "x")
  expect_true(nrow(result) == 0 && ncol(result) == 0)
})

# Complex tests with multiple occurrences and deeper nesting
test_that("Multiple occurrences in different levels", {
  list4 <- list(a = list(x = 5), b = list(x = 10, c = list(x = 15)))
  result <- getWhereAnObjectExistsInNestedList(list4, "x")
  expected <- tibble(criteriaLocationx = 1)
  expect_equal(result, expected)
})

test_that("Non-list input returns empty dataframe", {
  expect_true(nrow(getWhereAnObjectExistsInNestedList(NA, "x")) == 0)
  expect_true(nrow(getWhereAnObjectExistsInNestedList("Hello", "x")) == 0)
  expect_true(nrow(getWhereAnObjectExistsInNestedList(123, "x")) == 0)
})

# Tests to check proper handling of unique and sorted names
test_that("Sorting and uniqueness of locations", {
  list5 <- list(
    a = list(x = 5),
    a = list(x = 5),
    c = list(x = 10)
  )
  result <- getWhereAnObjectExistsInNestedList(list5, "x")
  expected <- tibble(criteriaLocationx = 1)
  expect_equal(result, expected)
})
