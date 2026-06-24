# Vorlagen für halbwegs CD-konforme Dokumente mit Quarto

15.06.2026

Kontakt:  
Sarah Gerhard <sarah.gerhard@bi.zh>  
Res Marti <res.marti@bi.zh.ch>

## Quarto-Vorlagen der Bildungsplanung

### Kurzbeschreibung

Das Package beinhaltet Vorlagen für das Erstellen von Berichten und
Präsentationen mit Quarto, welche die Corporate Design-Vorgaben halbwegs
respektieren. Bereits vorhanden sind:

- Vorlage für HTML-Bericht (biplaR-html)  
- Vorlage für revealjs-Präsentation (biplaR-revealjs)
- Vorlage für PDF-Bericht mit LaTeX (biplaR-pdf)

Mittelfristig sollte auch Folgendes erstellt werden:

- Vorlage für Word-Dokumente (biplaR-docx)  
- Vorlage für PDF-Bericht mit typst (biplaR-typst)

### Nutzung der Templates

- Package installieren mit
  `devtools::install_github("bildungsplanungZH/biplaRquarto", build_vignettes = TRUE)`,  
- mit der Funktion
  [`get_names()`](https://bildungsplanungzh.github.io/biplaRquarto/reference/get_names.md)
  die Namen der verfügbaren Vorlagen abfragen,  
- mit
  [`set_author()`](https://bildungsplanungzh.github.io/biplaRquarto/reference/set_author.md)
  eigenen Namen und Organisation hinterlegen (nur BP-Externe)
- mit der Funktion
  `use_quarto(file_name = "Bericht", ext_name = "biplaR-html")` ein
  Quarto-Dokument mit dem entsprechenden Beigemüse erstellen.

### Dokumentation

Aktuell enthält das Package zwei Vignetten zu folgenden Themen:

- Nutzung der Templates
  ([`vignette("biplaRquarto")`](https://bildungsplanungzh.github.io/biplaRquarto/articles/biplaRquarto.md))
- `biplaR-pdf` mit MikTeX
  ([`vignette("biplaR-pdf")`](https://bildungsplanungzh.github.io/biplaRquarto/articles/biplaR-pdf.md))
