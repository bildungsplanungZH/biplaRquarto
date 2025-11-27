test_that("error if filename is NULL", {
  expect_error(use_quarto(NULL))
})

test_that("error if classification is not valid value", {
    expect_error(use_quarto("test", classification = "Blabla"))
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

test_that("reveal using custom background works", {
  set_author("Testlauf", "Autorin", "testlauf.autorin@dir.zh.ch",
    "Direktion", "Amt", "Abteilung",
    path = test_path(), overwrite = TRUE
  )
  use_quarto(file.path(test_path(), "test_reveal"),
    ext_name = "biplaR-revealjs",
    author_path = test_path(),
    bg_image = "_extensions/biplaR-revealjs/images/panorama.png"
  )

  expect_true(any(grepl(
    x = readLines(file.path(test_path(), "test_reveal.qmd")),
    pattern = "panorama.png"
  )))

  unlink(file.path(test_path(), "test.qmd"))
  unlink("_extensions", recursive = TRUE)
  unlink(file.path(test_path(), ".profile.yml"))
})


test_that("reveal using personal background works", {
    set_author("Testlauf", "Autorin", "testlauf.autorin@dir.zh.ch",
               "Direktion", "Amt", "Abteilung",
               path = test_path(), overwrite = TRUE,
               bg_image = "_extensions/biplaR-revealjs/images/panorama.png"
    )
    use_quarto(file.path(test_path(), "test_reveal"),
               ext_name = "biplaR-revealjs",
               author_path = test_path()
    )

    expect_true(any(grepl(
        x = readLines(file.path(test_path(), "test_reveal.qmd")),
        pattern = "panorama.png"
    )))

    unlink(file.path(test_path(), "test.qmd"))
    unlink("_extensions", recursive = TRUE)
    unlink(file.path(test_path(), ".profile.yml"))
})

test_that("reveal using invalid background generates message", {
    set_author("Testlauf", "Autorin", "testlauf.autorin@dir.zh.ch",
               "Direktion", "Amt", "Abteilung",
               path = test_path(), overwrite = TRUE)
    expect_message(use_quarto(file.path(test_path(), "test_reveal"),
               ext_name = "biplaR-revealjs",
               author_path = test_path(),
               bg_image = "blabla"
    ))

    unlink(file.path(test_path(), "test_reveal.qmd"))
    unlink("_extensions", recursive = TRUE)
    unlink(file.path(test_path(), ".profile.yml"))
})
