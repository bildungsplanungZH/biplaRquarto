test_that("error if filename is NULL", {
    expect_error(use_quarto(NULL))

})

test_that("dir _extensions and file report.qmd created in working directory", {

    expect_true(dir.exists(file.path(test_path(), "_extensions")))
    expect_true(dir.exists(file.path(test_path(), "_extensions", "biplaR-html")))
    expect_true(file.exists("report.qmd"))

    unlink(file.path(test_path(), "_extensions"), recursive = T)
    unlink(file.path(test_path(), "report.qmd"))

})
