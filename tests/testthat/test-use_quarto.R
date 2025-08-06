test_that("error if filename is NULL", {
    expect_error(use_quarto(NULL))

})

test_that("dir _extensions and file report.qmd created in working directory", {

    use_quarto()

    expect_true(dir.exists("_extensions"))
    expect_true(dir.exists(file.path("_extensions", "biplaR-html")))
    expect_true(file.exists("report.qmd"))

    unlink("_extensions", recursive = T)
    unlink("report.qmd")

})

