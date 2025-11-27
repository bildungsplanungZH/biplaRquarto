#' Informationen zu Autor:in und Organisation aus .profile.yml lesen
#'
#' @param path Pfad zur Datei .profile.yml, default ist Sys.getenv("R_USER)
#'
#' @returns Liste mit Angaben zu Autor:in und Organisation
#' @export
#'
#' @examples \dontrun{
#' get_author()
#' }
get_author <- function(path = Sys.getenv("R_USER")) {
  if (!file.exists(file.path(path, ".profile.yml"))) {
    stop(
      "Keine Profilinformationen gefunden unter ",
      path, ".\nBitte mit set_author() einrichten."
    )
  }

  yml <- yaml::read_yaml(file.path(path, ".profile.yml"))
  author <- list(
    "user" = yml$r_user, "org" = yml$r_organisation,
    "bg_image" = yml$bg_image
  )
}
