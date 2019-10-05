#' raceoffice: get regatta registrations
#'
#' @param url url (default: paste0("http://www.raceoffice.org/",
#' "entrylist.php?eid=11498618335c794171f0ae7"))
#' @importFrom tibble tibble
#' @importFrom janitor clean_names
#' @importFrom dplyr rename mutate
#' @return tibble with registrations for regatta
#' @export
#'
raceoffice_registrations <- function(
  url = paste0("http://www.raceoffice.org/", 
               "entrylist.php?eid=11498618335c794171f0ae7")) {
  
  tbl_raw <- xml2::read_html(url) %>% 
  rvest::html_table(fill = TRUE)

headers <- tbl_raw[[4]][1,-1]

tbl <- tbl_raw[[4]][-1,-1]
names(tbl) <-  headers

tbl_clean <- tbl %>% 
  janitor::clean_names() %>% 
  dplyr::rename(segel = .data$segel_nr, 
                nachname  = .data$nachname_stm, 
                vorname = .data$vorname_stm) %>%  
  dplyr::mutate(segel = sprintf("GER%s", .data$segel))

return(tbl_clean)
}
