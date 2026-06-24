# Quarto-Vorlage verwenden

Die Funktion erstellt ein Quarto-Dokument am mit `file_name` gewünschten
Ort. Wird nur der Dateiname mitgegeben, liegt das neue Dokument auf
oberster Ebene im Projekt. Wird ein Dateipfad genutzt, wird das Dokument
an diesem Ort erstellt, sofern der Pfad gültig ist.

## Usage

``` r
use_quarto(
  file_name = "report",
  ext_name = "biplaR-html",
  author_path = Sys.getenv("R_USER"),
  classification = "Intern",
  bg_image = "_extensions/biplaR-revealjs/images/panorama.png"
)
```

## Arguments

- file_name:

  Dateiname oder Dateipfad (ohne Erweiterung) der neuen Unterlage,
  default ist report

- ext_name:

  gewünschte Vorlage (biplaR-html, biplaR-revealjs, biplaR-pdf,
  biplaR-docx oder biplaR-typst)

- author_path:

  Dateipfad zu .profile.yml mit Name und Organisation, default ist
  Sys.getenv("R_USER)

- classification:

  Klassifikationsstufe (Öffentlich, Intern, Vertraulich oder Geheim),
  default ist Intern

- bg_image:

  Dateipfad zu gewünschtem Hintergrundbild für Titelfolie, default ist
  \_extensions/biplaR-revealjs/images/panorama.png

## Examples

``` r
if (FALSE) { # \dontrun{
use_quarto("bericht", "biplaR-html")
use_quarto(file_name = "reporting/bericht")
} # }
```
