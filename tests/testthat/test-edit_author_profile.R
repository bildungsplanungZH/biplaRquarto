test_that("returns error without profile", {
  expect_error(edit_author_profile(path = ""))
})

test_that("returns invisible(path) with existing profile and path", {
    expect_invisible(edit_author_profile(path = test_path()))
})

