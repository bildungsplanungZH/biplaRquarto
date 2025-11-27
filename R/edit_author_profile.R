#' Öffnet die Datei .profile.yml im User-Verzeichnis (default)
#' oder unter dem angegebenen Dateipfad
#'
#' @param path Dateipfad, wo .profile.yml liegt
#' default ist Sys.getenv("R_USER")
#' @returns invisible(path)
#' @export
#'
#' @examples \dontrun{
#' edit_author_profile()
#' }
edit_author_profile <- function(path = Sys.getenv("R_USER")) {
  assertthat::assert_that(file.exists(file.path(path, ".profile.yml")))

  utils::file.edit(file.path(path, ".profile.yml"))
  cli::cli_bullets(c("i" = "Bitte R neu starten (Ctrl-Shift-F10),
                     damit Anpassungen wirksam werden."))

  invisible(path)
}
