# Vorlagen für halbwegs CD-konforme Dokumente mit Quarto

06.08.2025  

Kontakt:  
Sarah Gerhard <sarah.gerhard@bi.zh>  
Res Marti <res.marti@bi.zh.ch>  
Flavian Imlig <flavian.imlig@bi.zh>  

<!-- badges: start -->
[![R-CMD-check](https://github.com/bildungsplanungZH/biplaRquarto/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/bildungsplanungZH/biplaRquarto/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->


## Quarto-Vorlagen der Bildungsplanung

### Kurzbeschreibung

Das Package beinhaltet Vorlagen für das Erstellen von Berichten und Präsentationen mit Quarto, welche die Corporate Design-Vorgaben halbwegs respektieren. Bereits vorhanden sind:  

* Vorlage für HTML-Bericht (biplaR-html)  
* Vorlage für revealjs-Präsentation (biplaR-revealjs) 
* Vorlage für PDF-Bericht mit LaTeX (biplaR-pdf)  

Mittelfristig sollte auch Folgendes erstellt werden:

* Vorlage für Word-Dokumente (biplaR-docx)  
* Vorlage für PDF-Bericht mit typst (biplaR-typst)  

### Nutzung der Templates

* Package installieren mit `devtools::install_github("bildungsplanungZH/biplaRquarto", build_vignettes = TRUE)`,  
* mit der Funktion `get_names()` die Namen der verfügbaren Vorlagen abfragen,  
* (nur BP-Externe) mit `set_author()` eigenen Namen und Organisation hinterlegen
* mit der Funktion `use_quarto(file_name = "Bericht", ext_name = "biplaR-html")` ein Quarto-Dokument mit dem entsprechenden Beigemüse erstellen.


### Dokumentation

Aktuell enthält das Package zwei Vignetten zu folgenden Themen:

* Nutzung der Templates (`vignette("biplaRquarto")`)
* `biplaR-pdf` mit MikTeX (`vignette("biplaR-pdf")`)
