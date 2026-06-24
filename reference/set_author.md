# Informationen zu Autor:in und Organisation in .profile.yml schreiben

Informationen zu Autor:in und Organisation in .profile.yml schreiben

## Usage

``` r
set_author(
  vorname,
  nachname,
  email,
  dir,
  org1,
  org2 = NA,
  path = Sys.getenv("R_USER"),
  overwrite = FALSE,
  bg_image = NA
)
```

## Arguments

- vorname:

  Vorname

- nachname:

  Nachname

- email:

  Emailadresse

- dir:

  Direktion

- org1:

  Organisationseinheit 1

- org2:

  Organisationseinheit 2, default ist NA

- path:

  Pfad zum Schreiben der YAML-Datei, default ist Sys.getenv("R_USER")

- overwrite:

  boolean zur Angabe, ob ein existierendes profile.yml überschrieben
  werden soll (T) oder nicht, default ist FALSE

- bg_image:

  Pfad zu default Hintergrundbild in Präsentationen

## Value

list Liste mit Angaben zu Autor:in und Organisation

## Examples

``` r
if (FALSE) { # \dontrun{
set_author(
  "Firstname", "Lastname", "first.last@zh.ch",
  "Lieblingsdirektion", "Bestes Amt"
)
} # }
```
