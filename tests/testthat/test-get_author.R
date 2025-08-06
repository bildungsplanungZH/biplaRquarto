test_that("returns a list with elements named user and org", {
    expect_equal(class(get_author()), "list")
    expect_named(get_author(), c("user", "org"))

})

test_that("element user has elements named family, given and email", {
    expect_equal(class(get_author()$user), "list")
    expect_contains(names(get_author()$user), c("family", "given", "email"))

})

test_that("element org has elements named dir and org1", {
    expect_equal(class(get_author()$org), "list")
    expect_contains(names(get_author()$org), c("dir", "org1"))

})

test_that("missing path returns error", {
    expect_error(get_author(NA))

})

test_that("missing .profile.yml returns error", {
    expect_error(get_author("path_to_nowhere"))

})
