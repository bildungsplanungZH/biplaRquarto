# Öffnet die Datei .profile.yml im User-Verzeichnis (default) oder unter dem angegebenen Dateipfad

Öffnet die Datei .profile.yml im User-Verzeichnis (default) oder unter
dem angegebenen Dateipfad

## Usage

``` r
edit_author_profile(path = Sys.getenv("R_USER"))
```

## Arguments

- path:

  Dateipfad, wo .profile.yml liegt default ist Sys.getenv("R_USER")

## Value

invisible(path)

## Examples

``` r
if (FALSE) { # \dontrun{
edit_author_profile()
} # }
```
