# Nutzung der Templates

``` r

library(biplaRquarto)
```

## Package installieren

`biplaRquarto` kann aus dem öffentlichen GitHub-Repository installiert
werden:

``` r

devtools::install_github("bildungsplanungZH/biplaRquarto",
  build_vignettes = TRUE
)
```

Das Argument `build_vignettes = TRUE` ist notwendig, damit die Vignetten
erstellt werden

## Namen und Organisation hinterlegen

Mit
[`set_author()`](https://bildungsplanungzh.github.io/biplaRquarto/reference/set_author.md)
können Namen und Organisation in einer Datei `.profile.yml` hinterlegt
werden. Diese liegt per Default unter `Sys.getenv("R_USER")`. Ist
bereits ein Profil vorhanden, wird dieses nur überschrieben, falls das
Argument `overwrite = TRUE` gesetzt wird.

``` r

set_author("Vorname", "Nachname", "Email", "Direktion", "Organisationseinheit")
```

Falls gewünscht, kann auch der Pfad zu einer Bilddatei im Profil
hinterlegt werden, welche per Default als Hintergrund für die Titelfolie
in Präsentationen verwendet werden soll. Dafür wird das Argument
`bg_image = "absoluter_Dateipfad"` genutzt.

``` r

set_author("Vorname", "Nachname", "Email", "Direktion", "Organisationseinheit",
  bg_image = "K:/Organisationseinheit/Hintergrund/Lieblingsbild.png"
)
```

[`get_author()`](https://bildungsplanungzh.github.io/biplaRquarto/reference/get_author.md)
liefert die hinterlegten Informationen zur Überprüfung.

``` r

get_author()
```

Sind die hinterlegten Informationen nicht mehr aktuell oder sollten
ergänzt werden, können sie mit
[`edit_author_profile()`](https://bildungsplanungzh.github.io/biplaRquarto/reference/edit_author_profile.md)
interaktiv bearbeitet werden. Damit die Anpassungen wirksam werden, muss
R anschliessend neu gestartet werden (mit Ctrl-Shift-F10).

``` r

edit_author_profile()
```

## Namen der verfügbaren Vorlagen anzeigen

Die Funktion
[`get_names()`](https://bildungsplanungzh.github.io/biplaRquarto/reference/get_names.md)
liefert die Namen der verfügbaren Vorlagen.

``` r

get_names()
#> [1] "biplaR-docx"     "biplaR-html"     "biplaR-pdf"      "biplaR-revealjs"
#> [5] "biplaR-typst"
```

## Quarto-Dokument gemäss Vorlage erstellen

Per Default wird mit `use_quarto` die Vorlage für HTML-Berichte mit der
Klassifikation “Intern” verwendet und eine Quarto-Datei auf der obersten
Ebene des aktuellen Projekts erzeugt.

``` r

use_quarto("dokumentation")
```

Man kann auch ein Dokument in einem Unterordner und/oder mit einer
anderen Klassifikationsstufe erzeugen.

``` r

use_quarto(
  file_name = "reporting/bericht", classification = "Vertraulich"
)
```

Für andere Output-Formate muss das Argument `ext_name` explizit gesetzt
werden:

``` r

use_quarto(file_name = "reporting/docx", ext_name = "biplaR-docx")

use_quarto(file_name = "reporting/pdf", ext_name = "biplaR-pdf")

use_quarto(
  file_name = "presentation/inputreferat",
  ext_name = "biplaR-revealjs",
  classification = "Öffentlich"
)
```
