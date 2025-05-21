# Vorlagen für halbwegs CD-konforme Dokumente mit Quarto

11.04.2025  

Kontakt:  
Sarah Gerhard <sarah.gerhard@bi.zh>  
Res Marti <res.marti@bi.zh.ch>  
Flavian Imlig <flavian.imlig@bi.zh>  

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

* Package installieren oder mit `devtools::load_all("../biplaRquarto")` temporär laden,  
* mit der Funktion `get_names()` die Namen der verfügbaren Vorlagen abfragen,  
* mit der Funktion `use_quarto(filename = "Bericht", ext_name = "biplaR-html")` ein Quarto-Dokument mit dem entsprechenden Beigemüse erstellen.

### biplaR-pdf mit MikTeX nutzen

Die Vorlage biplaR-pdf funktioniert mit MikTeX. Mit TinyTeX wurde sie nicht getestet. MikTeX kann über das AFI-ServicePortal bestellt werden.

Nach der Installation muss der Pfad zum Verzeichnis `biplaR-pdf` in MikTeX zu den TEXMF-Wurzelverzeichnissen hinzugefügt werden:  
*Einstellungen -> Verzeichnisse -> hinzufügen via Plus-Zeichen*

Der Warnhinweis (kein TDS-konformes Wurzelverzeichnis) kann ignoriert werden


