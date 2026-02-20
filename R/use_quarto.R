#' Quarto-Vorlage verwenden
#'
#' Die Funktion erstellt ein Quarto-Dokument am mit `file_name` gewünschten
#' Ort. Wird nur der Dateiname mitgegeben, liegt das neue Dokument auf oberster
#' Ebene im Projekt. Wird ein Dateipfad genutzt, wird das Dokument an diesem
#' Ort erstellt, sofern der Pfad gültig ist.
#'
#' @param file_name Dateiname oder Dateipfad (ohne Erweiterung) der neuen
#' Unterlage, default ist report
#' @param ext_name gewünschte Vorlage (biplaR-html, biplaR-revealjs,
#'   biplaR-pdf, biplaR-docx oder biplaR-typst)
#' @param author_path Dateipfad zu .profile.yml mit Name und Organisation,
#'   default ist Sys.getenv("R_USER)
#' @param classification Klassifikationsstufe (Öffentlich, Intern,
#'   Vertraulich oder Geheim), default ist Intern
#' @param bg_image Dateipfad zu gewünschtem Hintergrundbild für Titelfolie,
#'   default ist _extensions/biplaR-revealjs/images/panorama.png
#' @returns NULL
#' @export
#'
#' @examples \dontrun{
#' use_quarto("bericht", "biplaR-html")
#' use_quarto(file_name = "reporting/bericht")
#' }
use_quarto <- function(file_name = "report", ext_name = "biplaR-html",
                       author_path = Sys.getenv("R_USER"),
                       classification = "Intern",
                       bg_image =
                         "_extensions/biplaR-revealjs/images/panorama.png") {
  if (is.null(file_name)) {
    stop("You must provide a valid file_name")
  }

  if (!classification %in% c(
    "\u00D6ffentlich", "Intern", "Vertraulich",
    "Geheim"
  )) {
    stop("Argument classification must be one of the following:
         \u00D6ffentlich, Intern, Vertraulich, Geheim")
  }

  if (ext_name == "biplaR-revealjs" &&
    bg_image != "_extensions/biplaR-revealjs/images/panorama.png") {
    if (!file.exists(bg_image)) {
      stop("Background image not found at ", bg_image)
    }
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

  if (n_files >= 1) {
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
    gsub(
      pattern = "Intern",
      replacement = classification, x = _
    ) |>
    writeLines(con = paste0(file_name, ".qmd"))

  if (ext_name == "biplaR-revealjs" &&
    bg_image != "_extensions/biplaR-revealjs/images/panorama.png") {
    readLines(paste0(file_name, ".qmd", collapse = "")) |>
      gsub(
        pattern = "_extensions/biplaR-revealjs/images/panorama.png",
        replacement = bg_image, x = _
      ) |>
      writeLines(con = paste0(file_name, ".qmd"))
  } else if (ext_name == "biplaR-revealjs" && !is.na(author_info$bg_image)) {
    readLines(paste0(file_name, ".qmd", collapse = "")) |>
      gsub(
        pattern = "_extensions/biplaR-revealjs/images/panorama.png",
        replacement = author_info$bg_image, x = _
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

    if (ext_name %in% c("biplaR-revealjs")) {
      readLines(paste0(
        "_extensions/", ext_name,
        "/partials/title-slide.html"
      )) |>
        gsub(
          pattern = "_extensions",
          replacement = paste0(path_prefix, "_extensions"), x = _
        ) |>
        writeLines(con = paste0(
          "_extensions/", ext_name,
          "/partials/title-slide.html"
        ))
    }
  }

  # open the new file in the editor
  utils::file.edit(paste0(file_name, ".qmd", collapse = ""))
}
