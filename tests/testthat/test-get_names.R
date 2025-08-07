test_that("returns character vector of length 5", {
  expect_vector(get_names(), ptype = character(), size = 5)
})
