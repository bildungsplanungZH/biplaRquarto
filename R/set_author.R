set_author <- function(vorname, nachname, email, org1, org2) {

    # Liste mit relevanter Information zusammenstellen
    user_info <- list("r_user" = list(
        "family" = nachname,
        "given" = vorname,
        "email" = email),
        "r_organisation" = list("name_de" = org1),
        "r_organisation" = list("name_de" = org2))

    # in YAML-Datei unter R_USER schreiben
    yaml::write_yaml(user_info, file.path(Sys.getenv("R_USER"), "profile.yml"), fileEncoding = "UTF-8", indent = 4)

}
