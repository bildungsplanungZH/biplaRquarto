# Informationen zu Autor:in und Organisation aus .profile.yml lesen

Informationen zu Autor:in und Organisation aus .profile.yml lesen

## Usage

``` r
get_author(path = Sys.getenv("R_USER"))
```

## Arguments

- path:

  Pfad zur Datei .profile.yml, default ist Sys.getenv("R_USER)

## Value

Liste mit Angaben zu Autor:in und Organisation

## Examples

``` r
if (FALSE) { # \dontrun{
get_author()
} # }
```
