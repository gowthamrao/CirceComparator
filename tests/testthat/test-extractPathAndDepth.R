library(testthat)

# Test 1: Simple flat list with no nesting
test_that("extractPathsAndDepths handles a simple flat list", {
  list1 <- list(a = 1, b = 2)
  expected1 <- list(a = 1, b = 1)
  observed1 <- extractPathsAndDepths(list1)
  expect_equal(observed1, expected1)
})

# Test 2: Single level nested list
test_that("extractPathsAndDepths handles a single level nested list", {
  list2 <- list(a = list(x = 5), b = 2)
  expected2 <- list("a$x" = 2, b = 1)
  observed2 <- extractPathsAndDepths(list2)
  expect_equal(observed2, expected2)
})

# Test 3: Nested list with repeated items
test_that("extractPathsAndDepths handles a nested list with repeated items",
          {
            list3 <- list(a = list(x = 5), b = list(y = list(x = 3)))
            expected3 <- list("a$x" = 2, "b$y$x" = 3)
            observed3 <- extractPathsAndDepths(list3)
            expect_equal(observed3, expected3)
          })

# Test 4: Multiple elements in nested lists
test_that("extractPathsAndDepths handles multiple elements in nested lists",
          {
            list4 <- list(a = list(x = 5, z = 7), b = list(y = list(x = 3, z = 4)))
            expected4 <- list(
              "a$x" = 2,
              "a$z" = 2,
              "b$y$x" = 3,
              "b$y$z" = 3
            )
            observed4 <- extractPathsAndDepths(list4)
            expect_equal(observed4, expected4)
          })

# Test 5: Deeply nested lists
test_that("extractPathsAndDepths handles deeply nested lists", {
  list5 <- list(a = list(b = list(c = list(d = list(
    x = 10
  )))))
  expected5 <- list("a$b$c$d$x" = 5)
  observed5 <- extractPathsAndDepths(list5)
  expect_equal(observed5, expected5)
})

# Test 6: List with different data types
test_that("extractPathsAndDepths handles lists with different data types", {
  list6 <- list(a = list(x = 5, y = "text"), b = list(y = list(x = 3.5)))
  expected6 <- list("a$x" = 2,
                    "a$y" = 2,
                    "b$y$x" = 3)
  observed6 <- extractPathsAndDepths(list6)
  expect_equal(observed6, expected6)
})

# Test 7: List with item filtering (simple case)
test_that("extractPathsAndDepths handles simple item filtering", {
  list7 <- list(a = list(x = 5, y = 2), b = 2)
  # Corrected expected result
  expected7 <- list("a$y" = 2)
  observed7 <- extractPathsAndDepths(list7, item = "y")
  expect_equal(observed7, expected7)
})

# Test 8: List with item filtering (complex case)
test_that("extractPathsAndDepths handles complex item filtering", {
  list8 <- list(a = list(x = 5, y = list(z = 9)), b = list(y = list(z = 4)))
  expected8 <- list("a$y$z" = 3, "b$y$z" = 3)
  observed8 <- extractPathsAndDepths(list8, item = "z")
  expect_equal(observed8, expected8)
})

# Test 9: Complex nested list with multiple matches for the filtered item
test_that("extractPathsAndDepths handles complex nested lists with multiple matches",
          {
            list9 <- list(a = list(b = list(c = list(
              x = 10, y = 11
            ))), d = list(y = 12))
            expected9 <- list("a$b$c$y" = 4, "d$y" = 2)
            observed9 <- extractPathsAndDepths(list9, item = "y")
            expect_equal(observed9, expected9)
          })


# Test 10: Complex nested list with mixed data types and item filtering
test_that(
  "extractPathsAndDepths handles complex nested lists with mixed data types and item filtering",
  {
    list10 <- list(a = list(x = 5, y = list(z = "hello", k = 3)), b = list(y = list(z = 4, k = list(w = 8))))
    expected10 <- list("a$y$z" = 3, "b$y$z" = 3)
    observed10 <- extractPathsAndDepths(list10, item = "z")
    expect_equal(observed10, expected10)
  }
)
