#' Quarto-Vorlage in diesem Repository verwenden
#'
#' @param file_name Dateiname (ohne Erweiterung) der neuen Unterlage,
#'   default ist report
#' @param ext_name gewünschte Vorlage (biplaR-html, biplaR-revealjs,
#'   biplaR-pdf, biplaR-docx oder biplaR-typst)
#' @param author_path Dateipfad zu .profile.yml mit Name und Organisation,
#'   default ist Sys.getenv("R_USER)
#' @param bg_image Dateipfad zu gewünschtem Hintergrundbild für Titelfolie,
#'   default ist _extensions/ biplaR-revealjs/images/panorama.png
#' @returns NULL
#' @export
#'
#' @examples \dontrun{
#' use_quarto("bericht", "biplaR-html")
#' }
use_quarto <- function(file_name = "report", ext_name = "biplaR-html",
                       author_path = Sys.getenv("R_USER"),
                       bg_image = NA) {
  if (is.null(file_name)) {
    stop("You must provide a valid file_name")
  }

  # check for available extensions
  stopifnot("Extension not in package" = ext_name %in% get_names())

  # check for existing _extensions directory
  if (!file.exists("_extensions")) dir.create("_extensions")
  message("Created '_extensions' folder")

  # create folder
  if (!file.exists(paste0("_extensions/", ext_name))) {
    dir.create(paste0("_extensions/", ext_name))
  }

  # copy from internals
  file.copy(
    from = system.file(paste0("extdata/_extensions/", ext_name),
      package = "biplaRquarto"
    ),
    to = paste0("_extensions/"),
    overwrite = TRUE,
    recursive = TRUE,
    copy.mode = TRUE
  )

  # logic check to make sure extension files were moved
  n_files <- length(dir(paste0("_extensions/", ext_name)))

  if (n_files >= 2) {
    message(paste(
      ext_name,
      "was installed to _extensions folder
                  in the current working directory."
    ))
  } else {
    message("Extension appears not to have been created")
  }

  # create new qmd report based on skeleton
  file.copy(
    file.path("_extensions", ext_name, "template.qmd"),
    paste0(file_name, ".qmd", collapse = "")
  )

  # insert author and organisation information into skeleton
  author_info <- get_author(path = author_path)
  readLines(paste0(file_name, ".qmd", collapse = "")) |>
    gsub(
      pattern = "Vorname Nachname",
      replacement = paste(
        author_info$user$given,
        author_info$user$family
      ), x = _
    ) |>
    gsub(
      pattern = "vorname.nachname@bi.zh.ch",
      replacement = author_info$user$email, x = _
    ) |>
    gsub(
      pattern = "Organisationsname",
      replacement = paste0(author_info$org$org1), x = _
    ) |>
    gsub(
      pattern = "Direktion",
      replacement = author_info$org$dir, x = _
    ) |>
    writeLines(con = paste0(file_name, ".qmd"))

  if (!is.na(bg_image) & ext_name == "biplaR-revealjs") {
    if (!file.exists(bg_image)) {
      paste("Background image not found at", bg_image)
    }

    readLines(paste0(file_name, ".qmd", collapse = "")) |>
      gsub(
        pattern = "_extensions/biplaR-revealjs/images/panorama.png",
        replacement = bg_image, x = _
      ) |>
      writeLines(con = paste0(file_name, ".qmd"))
  }

  depth <- lengths(regmatches(file_name, gregexpr("\\/", file_name)))
  path_prefix <- paste0(rep("../", depth), collapse = "")

  if (depth > 0) {
    readLines(paste0(file_name, ".qmd", collapse = "")) |>
      gsub(
        pattern = "_extensions",
        replacement = paste0(path_prefix, "_extensions"), x = _
      ) |>
      writeLines(con = paste0(file_name, ".qmd"))

    if (ext_name %in% c("biplaR-html", "biplaR-revealjs")) {
      readLines(paste0("_extensions/", ext_name, "/partials/include-header.html")) |>
        gsub(
          pattern = "_extensions",
          replacement = paste0(path_prefix, "_extensions"), x = _
        ) |>
        writeLines(con = paste0("_extensions/", ext_name, "/partials/include-header.html"))

      if (ext_name == "biplaR-revealjs") {
        readLines(paste0("_extensions/", ext_name, "/partials/title-slide.html")) |>
          gsub(
            pattern = "_extensions",
            replacement = paste0(path_prefix, "_extensions"), x = _
          ) |>
          writeLines(con = paste0("_extensions/", ext_name, "/partials/title-slide.html"))
      }
    }
  }

  # open the new file in the editor
  utils::file.edit(paste0(file_name, ".qmd", collapse = ""))
}
