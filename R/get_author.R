get_author <- function(path = Sys.getenv("R_USER")) {

    if (!file.exists(file.path(path, ".profile.yml"))){
        stop("Keine Profilinformationen gefunden unter ", path, ".\nDiese können mit set_author() hinzugefügt werden.")
    }

    yml <- yaml::read_yaml(file.path(Sys.getenv("R_USER"), ".profile.yml"))
    author <-  list("user" = yml$r_user, "org" = yml$r_organisation)

    return(author)
}

