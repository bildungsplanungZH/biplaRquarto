# user R configurations template
#
# see https://github.com/bildungsmonitoringZH/biplaRconfig
#
# Author: Flavian Imlig <flavian.imlig@bi.zh.ch>
# Date: 16.04.2025
###############################################################################

# Startup function
.First <- function()
{
  # load profile information
  .profile <<- .get_profile()

  # set author
  options(devtools.desc.author = .profile$r_user)

  # get latest package version (even if it has to be compiled)
  options(install.packages.compile.from.source='newer')

  # set default packages
  options(defaultPackages = unique(c(getOption('defaultPackages'),
                                   c("devtools", "usethis", "testthat"))))

  # echo author
  message(sprintf('Profile for %s loaded.', .profile$r_user))
}

# get user r profile
.get_profile <- function()
{
  # get yaml informations
  yml_file <- file.path(Sys.getenv('R_USER'), '.profile.yml')

  profile_raw <- suppressWarnings(try(.read_profile_yml(yml_file), silent = TRUE))

  f_check <- function(.x) {
    if( is(.x, 'try-error') ) return(FALSE)
    if( !is(.x, 'list') ) return(FALSE)
    if( !all(c('r_user', 'r_settings') %in% names(.x)) ) return(FALSE)
    return(TRUE) }

  if( !f_check(profile_raw) ) {
    message(sprintf('%s(): Profil in %s nicht gefunden oder unvollständig!', as.character(match.call()[[1]]), yml_file))
    message("Mit `biplaRconfig::set_rprofile()` kann das Profil wieder hergestellt werden.")
    return(list()) }

  profile <- profile_raw

  # get r user
  profile_user <- suppressWarnings(try(.read_profile_person(profile_raw, nm_element = 'r_user')))

  f_check <- function(.x) {
    if( is(.x, 'try-error') ) return(FALSE)
    if( !is(.x, 'person') ) return(FALSE)
    return(TRUE) }

  if( f_check(profile_user) ) { profile$r_user <- profile_user } else { profile$r_user <- NULL }

  # get default packages
  defpacks <- suppressWarnings(try(.read_profile_list(profile_raw, nm_element = c('r_settings', 'defpacks'), sep = ', ')))

  f_check <- function(.x) {
    if( is(.x, 'try-error') ) return(FALSE)
    if( !is(.x, 'character') ) return(FALSE)
    return(TRUE) }

  if( f_check(defpacks) ) { profile$r_settings$defpacks <- defpacks } else { profile$r_settings$defpacks <- NULL }

  # add file location, return
  profile$profile_path <- yml_file

  return(profile)
}

# read profile information from yml file
.read_profile_yml <- function(yml_file)
{
  if( file.exists(yml_file) ) {
    yml_raw <- sub(' *$', '', sub('^ *', '', readLines(yml_file)))
    yml_tmp <- regmatches(yml_raw, regexpr('\\: *', yml_raw), invert = T)

    f_get <- function(.x, .idx) { .x[.idx] }

    yml_tbl <- data.frame('section' = '',
                          'var' = tolower(lapply(yml_tmp, f_get, .idx = 1L)),
                          'value' = as.character(lapply(yml_tmp, f_get, .idx = 2L)))

    idx_sec <- intersect(seq_along(yml_tbl$var), which(nchar(yml_tbl$value) < 1))

    f_get_idx_sec <- function(.x) { max(idx_sec[which(.x >= idx_sec)]) }
    yml_tbl$section <- yml_tbl$var[as.integer(lapply(seq_along(yml_tbl$var), f_get_idx_sec))]

    yml_list_raw <- split(yml_tbl[-idx_sec,], yml_tbl$section[-idx_sec])

    f_lgl <- function(.x) {
      .x_lgl <- as.logical(.x)
      if( is.na(.x_lgl) ) return(.x)
      return(.x_lgl) }

    f_tbl <- function(.tbl) { stats::setNames(lapply(as.list(.tbl$value), f_lgl), .tbl$var) }

    yml_list <- lapply(yml_list_raw, f_tbl)
    return(yml_list)
  }
  return(invisible(TRUE))
}

# generate person object
.read_profile_person <- function(profile_raw, nm_element = 'r_user')
{
  nms <- intersect(names(profile_raw[[nm_element]]), names(formals(utils::person)))
  args <- profile_raw[[nm_element]][nms]
  return(do.call(utils::person, args))
}

# read profile list
.read_profile_list <- function(profile_raw, nm_element = c('r_settings', 'defpacks'), sep = ', ')
{
  content <- profile_raw[[nm_element[1]]][[nm_element[2]]]
  list <- base::strsplit(content, sep)
  return(list[[1]])
}
