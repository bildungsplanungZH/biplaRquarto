test_that("error if filename is NULL", {
  expect_error(use_quarto(NULL))
})

test_that("directory _extensions and test.qmd created", {
  use_quarto(file.path(test_path(), "test"))
  expect_true(dir.exists("_extensions"))
  expect_true(file.exists(file.path(test_path(), "test.qmd")))

  unlink(file.path(test_path(), "test.qmd"))
  unlink("_extensions", recursive = TRUE)
})

test_that("arguments written to qmd", {
  use_quarto(file.path(test_path(), "test"), classification = "Geheim")

  expect_true(any(grepl(
    x = readLines(file.path(test_path(), "test.qmd")),
    pattern = "Geheim"
  )))

  unlink(file.path(test_path(), "test.qmd"))
  unlink("_extensions", recursive = TRUE)
})
