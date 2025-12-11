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
#' @param overwrite boolean zur Angabe, ob ein existierendes profile.yml
#'   überschrieben werden soll (T) oder nicht, default ist FALSE
#' @param bg_image Pfad zu default Hintergrundbild in Präsentationen
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
                       path = Sys.getenv("R_USER"), overwrite = FALSE,
                       bg_image = NA) {
  assertthat::assert_that(dir.exists(path))

  if (file.exists(file.path(path, ".profile.yml")) && !overwrite) {
    stop(paste(
      "File profile.yml exists at location",
      path,
      "and will not be overwritten.
             To overwrite use set_author(overwrite = TRUE)."
    ))
  }

  if (!is.na(bg_image) && !file.exists(bg_image)) {
    stop(paste(
      "Background image at",
      bg_image,
      "doesn't exist. Please specify correct path."
    ))
  }

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
    ),
    "bg_image" = bg_image
  )

  # in YAML-Datei unter R_USER schreiben
  yaml::write_yaml(user_info,
    file.path(path, ".profile.yml"),
    fileEncoding = "UTF-8", indent = 4
  )
}
