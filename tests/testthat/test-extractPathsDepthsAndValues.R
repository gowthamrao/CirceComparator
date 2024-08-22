library(testthat)

# Test 1: Simple flat list with no nesting
test_that("extractPathsDepthsAndValues handles a simple flat list", {
  list1 <- list(a = 1, b = 2)
  expected1 <- data.frame(
    path = c("a", "b"),
    depth = c(1, 1),
    value = c(1, 2),
    stringsAsFactors = FALSE
  )
  observed1 <- extractPathsDepthsAndValues(list1)
  expect_equal(observed1, expected1)
})

# Test 2: Single level nested list
test_that("extractPathsDepthsAndValues handles a single level nested list", {
  list2 <- list(a = list(x = 5), b = 2)
  expected2 <- data.frame(
    path = c("a$x", "b"),
    depth = c(2, 1),
    value = c(5, 2),
    stringsAsFactors = FALSE
  )
  observed2 <- extractPathsDepthsAndValues(list2)
  expect_equal(observed2, expected2)
})

# Test 3: Nested list with repeated items
test_that("extractPathsDepthsAndValues handles a nested list with repeated items", {
  list3 <- list(a = list(x = 5), b = list(y = list(x = 3)))
  expected3 <- data.frame(
    path = c("a$x", "b$y$x"),
    depth = c(2, 3),
    value = c(5, 3),
    stringsAsFactors = FALSE
  )
  observed3 <- extractPathsDepthsAndValues(list3)
  expect_equal(observed3, expected3)
})

# Test 4: Multiple elements in nested lists
test_that("extractPathsDepthsAndValues handles multiple elements in nested lists", {
  list4 <- list(a = list(x = 5, z = 7), b = list(y = list(x = 3, z = 4)))
  expected4 <- data.frame(
    path = c("a$x", "a$z", "b$y$x", "b$y$z"),
    depth = c(2, 2, 3, 3),
    value = c(5, 7, 3, 4),
    stringsAsFactors = FALSE
  )
  observed4 <- extractPathsDepthsAndValues(list4)
  expect_equal(observed4, expected4)
})

# Test 5: Deeply nested lists
test_that("extractPathsDepthsAndValues handles deeply nested lists", {
  list5 <- list(a = list(b = list(c = list(d = list(
    x = 10
  )))))
  expected5 <- data.frame(
    path = "a$b$c$d$x",
    depth = 5,
    value = 10,
    stringsAsFactors = FALSE
  )
  observed5 <- extractPathsDepthsAndValues(list5)
  expect_equal(observed5, expected5)
})

# Test 6: List with different data types
test_that("extractPathsDepthsAndValues handles lists with different data types", {
  list6 <- list(a = list(x = 5, y = "text"), b = list(y = list(x = 3.5)))
  expected6 <- data.frame(
    path = c("a$x", "a$y", "b$y$x"),
    depth = c(2, 2, 3),
    value = c(5, "text", 3.5),
    stringsAsFactors = FALSE
  )
  observed6 <- extractPathsDepthsAndValues(list6)
  expect_equal(observed6, expected6)
})

# Test 7: List with item filtering (simple case)
test_that("extractPathsDepthsAndValues handles simple item filtering", {
  list7 <- list(a = list(x = 5, y = 2), b = 2)
  expected7 <- data.frame(
    path = "a$y",
    depth = 2,
    value = 2,
    stringsAsFactors = FALSE
  )
  observed7 <- extractPathsDepthsAndValues(list7, item = "y")
  expect_equal(observed7, expected7)
})

# Test 8: List with item filtering (complex case)
test_that("extractPathsDepthsAndValues handles complex item filtering", {
  list8 <- list(a = list(x = 5, y = list(z = 9)), b = list(y = list(z = 4)))
  expected8 <- data.frame(
    path = c("a$y$z", "b$y$z"),
    depth = c(3, 3),
    value = c(9, 4),
    stringsAsFactors = FALSE
  )
  observed8 <- extractPathsDepthsAndValues(list8, item = "z")
  expect_equal(observed8, expected8)
})

# Test 9: Complex nested list with multiple matches for the filtered item
test_that("extractPathsDepthsAndValues handles complex nested lists with multiple matches", {
  list9 <- list(a = list(b = list(c = list(
    x = 10, y = 11
  ))), d = list(y = 12))
  expected9 <- data.frame(
    path = c("a$b$c$y", "d$y"),
    depth = c(4, 2),
    value = c(11, 12),
    stringsAsFactors = FALSE
  )
  observed9 <- extractPathsDepthsAndValues(list9, item = "y")
  expect_equal(observed9, expected9)
})

# Test 10: Complex nested list with mixed data types and item filtering
test_that(
  "extractPathsDepthsAndValues handles complex nested lists with mixed data types and item filtering",
  {
    list10 <- list(a = list(x = 5, y = list(z = "hello", k = 3)), b = list(y = list(z = 4, k = list(w = 8))))
    expected10 <- data.frame(
      path = c("a$y$z", "b$y$z"),
      depth = c(3, 3),
      value = c("hello", 4),
      stringsAsFactors = FALSE
    )
    observed10 <- extractPathsDepthsAndValues(list10, item = "z")
    expect_equal(observed10, expected10)
  }
)

# Test 11: List with empty elements (no values)
test_that("extractPathsDepthsAndValues handles lists with empty elements", {
  list11 <- list(
    a = list(),
    b = list(x = 5),
    c = list(d = list())
  )
  expected11 <- data.frame(
    path = c("b$x"),
    depth = c(2),
    value = c(5),
    stringsAsFactors = FALSE
  )
  observed11 <- extractPathsDepthsAndValues(list11)
  expect_equal(observed11, expected11)
})

# Test 12: List with unnamed elements deep in the nested structure
test_that("extractPathsDepthsAndValues handles unnamed elements deep in the path", {
  list12 <- list(a = list(x = 5, list(y = 10)), b = list(z = list(list(w = 7))))
  expected12 <- data.frame(
    path = c("a$x", "a$_$y", "b$z$_$w"),
    depth = c(2, 3, 4),
    value = c(5, 10, 7),
    stringsAsFactors = FALSE
  )
  observed12 <- extractPathsDepthsAndValues(list12)
  expect_equal(observed12, expected12)
})
