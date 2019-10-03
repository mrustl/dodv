#' raceoffice: get regatta registrations
#'
#' @param url url (default: paste0("https://www.manage2sail.com/de-DE/event/", 
#' "5b69e6bf-d50a-4536-a203-54e90bd8320d#!/entries?classId=ba596ce5-2827", 
#' "-4b97-8fa4-568ca20659cb"))
#' @importFrom tibble tibble
#' @importFrom janitor clean_names
#' @importFrom dplyr rename mutate
#' @return tibble with registrations for regatta
#' @export
#'
raceoffice_registrations <- function(
  url = paste0("https://www.manage2sail.com/de-DE/event/", 
               "5b69e6bf-d50a-4536-a203-54e90bd8320d#!/entries?classId=ba596ce5-2827", 
               "-4b97-8fa4-568ca20659cb")) {
  
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
