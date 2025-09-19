test_that("error if filename is NULL", {
  expect_error(use_quarto(NULL))
})

test_that("directory _extensions and test.qmd created", {
  set_author("Testlauf", "Autorin", "testlauf.autorin@dir.zh.ch",
             "Direktion", "Amt", "Abteilung",
             path = test_path(), overwrite = TRUE
  )
  use_quarto(file.path(test_path(), "test"), author_path = test_path())
  expect_true(dir.exists("_extensions"))
  expect_true(file.exists(file.path(test_path(), "test.qmd")))

  unlink(file.path(test_path(), "test.qmd"))
  unlink("_extensions", recursive = TRUE)
})

test_that("arguments written to qmd", {
  set_author("Testlauf", "Autorin", "testlauf.autorin@dir.zh.ch",
               "Direktion", "Amt", "Abteilung",
               path = test_path(), overwrite = TRUE
    )
  use_quarto(file.path(test_path(), "test"), classification = "Geheim",
             author_path = test_path())

  expect_true(any(grepl(
    x = readLines(file.path(test_path(), "test.qmd")),
    pattern = "Geheim"
  )))

  unlink(file.path(test_path(), "test.qmd"))
  unlink("_extensions", recursive = TRUE)
  unlink(file.path(test_path(), ".profile.yml"))
})
