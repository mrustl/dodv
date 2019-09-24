pkg <- list(
  name = "dodv",
  title = "R package For Scraping and Analysing DODV rank lists",
  desc = paste0(
    "Scrape and analyse year ranks lists of German Opti-Dinghy Federation (DODV) ",
    " available at: <https://segler-rangliste.de/dodv>."
  )
)


kwb.pkgbuild::use_pkg_skeleton("dodv")

kwb.pkgbuild::use_pkg(
  pkg = pkg,
  copyright_holder = list(name = "Michael Rustler", start_year = NULL),
  user = "mrustl"
)

kwb.pkgbuild::use_autopkgdown("dodv", org = "mrustl")

