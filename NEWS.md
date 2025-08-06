# biplaRquarto (development version)

* Name und Organisation werden automatisch in Vorlagen eigefügt, falls in `.profile.yml` hinterlegt (#18):
    - mit `set_author()` können die Informationen hinterlegt werden.
    - mit `get_author()` werden die hinterlegten Information aufgerufen.
* Schriftgrösse in Abbildungen wird in `biplaR-html` neu im Setup-Chunk definiert (#20).
* Automatisierte Tests hinzugefügt.

# biplaRquarto 1.0

* Package mit Quarto-Templates der Bildungsplanung, davon funktionierend:
    - `biplaR-html` für Berichte im HTML-Format
    - `biplaR-pdf` für Berichte im PDF-Format mit MikTeX
    - `biplaR-revealjs` für Präsentationen
* `get_names()` liefert die Namen der Vorlagen
* `use_quarto("Dateiname", "biplaR-<format>")` erstellt alle notwendigen Dateien im aktuellen Projekt

