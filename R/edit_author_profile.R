#' Öffnet die Datei .profile.yml im User-Verzeichnis (default)
#' oder unter dem angegebenen Dateipfad
#'
#' @returns invisible(path)
#' @export
#'
#' @examples \dontrun{
#' edit_author_profile()
#' }
edit_author_profile <- function(path = Sys.getenv("R_USER")) {

    assertthat::assert_that(file.exists(file.path(path, ".profile.yml")))

    utils::file.edit(file.path(path, ".profile.yml"))
    cli::cli_bullets(c("i" = "Restart R (Ctrl-Shift-F10) for changes to take effect."))

    invisible(path)
}

e <- edit_author_profile()
