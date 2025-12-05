* Neue Funktion `edit_author_profile()` zum interaktiven Bearbeiten der Profilangaben 
* biplaR-hmtl: 
  - Schriftgrösse in Abbildungen wird nur im Output angepasst, interaktiv nicht
* biplaR-revealjs:
  - Bugfix in Titelfolie (Logo und Spikel in Vorschau korrekt dargestellt)
  - default Hintergrund für Titelfolie im Profil hinterlegbar, Argument in set_author() hinzugefügt
  - Schriftgrösse in Abbildungen wird nur im Output angepasst, interaktiv nicht
* biplaR-pdf: 
  - latex-input-paths zur Verwendung mit TinyTeX
  - \pandocbounded für pandoc 3.2.1 definiert
  - Abkürzungsfunktionalität entfernt
* Vignette basierend auf Material vom R-Austausch hinzugefügt und Dokumentation ergänzt
* Testabdeckung verbessert

# biplaRquarto 1.1.0

* Name und Organisation werden automatisch in Vorlagen eingefügt, falls in `.profile.yml` hinterlegt:
    - mit `set_author()` können die Informationen hinterlegt werden, falls kein R-Profil der Bildungsplanung vorhanden ist. Ist ein Profile vorhanden, wird es nicht überschrieben.
    - mit `get_author()` werden die hinterlegten Information aufgerufen.
* Wird das Quarto-File in einem Unterordner erzeugt, werden die Pfade in den Vorlagen entsprechend angepasst.
* Klassifikation ist standardmässig "Intern", kann jedoch über das Argument `classification` angepasst werden. 
* Schriftgrösse in Abbildungen wird in `biplaR-html` und `biplaR-revealjs` neu im Setup-Chunk definiert (bugfix).
* Schriftintegration ohne include-in-header.
* Diverse kleine style-Anpassungen im Zusammenhang mit Observable Chunks.
* Automatisierte Tests hinzugefügt.
* Automatisiertes Styling und Linting eingerichtet.
* Vorbereitung für öffentliches Repository.

# biplaRquarto 1.0

* Package mit Quarto-Templates der Bildungsplanung, davon funktionierend:
    - `biplaR-html` für Berichte im HTML-Format
    - `biplaR-pdf` für Berichte im PDF-Format mit MikTeX
    - `biplaR-revealjs` für Präsentationen
* `get_names()` liefert die Namen der Vorlagen
* `use_quarto("Dateiname", "biplaR-<format>")` erstellt alle notwendigen Dateien im aktuellen Projekt

