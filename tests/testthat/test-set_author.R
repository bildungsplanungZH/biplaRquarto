test_that("writes .profil.yml to path specified", {
  set_author("Rufname", "Nachname", "rufname.nachname@dir.zh.ch",
    "Lieblingsdirektion", "Bestes Amt", "Tolle Abteilung",
    path = test_path(), overwrite = TRUE
  )
  yml <- yaml::read_yaml(file.path(test_path(), ".profile.yml"))

  expect_equal(class(yml), "list")
  expect_named(yml, c("r_user", "r_organisation", "bg_image"))
  expect_named(yml$r_user, c("family", "given", "email"))
  expect_named(yml$r_organisation, c("dir", "org1", "org2"))

  expect_error(
    set_author("Rufname", "Nachname", "rufname.nachname@dir.zh.ch",
      "Lieblingsdirektion", "Bestes Amt", "Tolle Abteilung",
      path = test_path()
    ),
    regexp = "overwrite"
  )

  file.remove(file.path(test_path(), ".profile.yml"))
})
