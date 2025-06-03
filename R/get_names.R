#' Namen der verfügbaren Quarto-Vorlagen abrufen
#'
#' @returns character mit Namen der Vorlagen
#' @export
#'
#' @examples get_names()
get_names <- function() {
    path <- system.file("extdata/_extensions", package = "biplaRquarto")
    list.files(path)
}
