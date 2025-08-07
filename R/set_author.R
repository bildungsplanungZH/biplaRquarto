#' Informationen zu Autor:in und Organisation in .profile.yml schreiben
#'
#' @param vorname Vorname
#' @param nachname Nachname
#' @param email Emailadresse
#' @param dir Direktion
#' @param org1 Organisationseinheit 1
#' @param org2 Organisationseinheit 2, default ist NA
#' @param path Pfad zum Schreiben der YAML-Datei,
#'   default ist Sys.getenv("R_USER")
#'
#' @returns list Liste mit Angaben zu Autor:in und Organisation
#' @export
#'
#' @examples \dontrun{
#' set_author(
#'   "Firstname", "Lastname", "first.last@zh.ch",
#'   "Lieblingsdirektion", "Bestes Amt"
#' )
#' }
set_author <- function(vorname, nachname, email, dir, org1, org2 = NA,
                       path = Sys.getenv("R_USER")) {
  assertthat::assert_that(dir.exists(path))
  # Liste mit relevanter Information zusammenstellen
  user_info <- list(
    "r_user" = list(
      "family" = nachname,
      "given" = vorname,
      "email" = email
    ),
    "r_organisation" = list(
      "dir" = dir,
      "org1" = org1,
      "org2" = org2
    )
  )

  # in YAML-Datei unter R_USER schreiben
  yaml::write_yaml(user_info,
    file.path(path, ".profile.yml"),
    fileEncoding = "UTF-8", indent = 4
  )
}
