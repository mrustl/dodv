#' manage2sail: get regatta registrations
#'
#' @param url url (default: paste0("https://www.manage2sail.com/de-DE/event/", 
#' "5b69e6bf-d50a-4536-a203-54e90bd8320d#!/entries?classId=ba596ce5", 
#' "-2827-4b97-8fa4-568ca20659cb"))
#' @importFrom tibble tibble
#' @import RSelenium
#' @return tibble with registrations for regatta
#' @export
#'
manage2sail_registrations <- function(
  url = paste0("https://www.manage2sail.com/de-DE/event/",
               "5b69e6bf-d50a-4536-a203-54e90bd8320d#!/entries?classId=ba596ce5")) {
 # rs$open()
  rs$navigate(url)
  results_html <- rs$getPageSource()[[1]]
  
  x <- xml2::read_html(results_html)
  
  #results_html %>% XML::readHTMLTable()
  
  tbl_df <- tibble::tibble(segel = x %>%  rvest::html_nodes("td.td-sailnumber") %>% rvest::html_text() %>% stringr::str_replace_all("\\s+?", ""), 
                           boot = x %>%  rvest::html_nodes("td.td-ellipsis.ng-binding") %>% rvest::html_text() %>% magrittr::extract(seq_along(.data$segel)), 
                           skipper = x %>%  rvest::html_nodes("td.td-skiper") %>% rvest::html_text(),
                           crew = x %>%  rvest::html_nodes("td.td-ellipsis.wide-only") %>% rvest::html_text(),
                           verein = x %>%  rvest::html_nodes("td.td-ellipsis.medium-only") %>% rvest::html_text()
                           )  
  return(tbl_df)
}

#' manage2sail: get regatta results
#'
#' @param url url (default: paste0("http://manage2sail.com/de-DE/event/", 
#' "117e84c6-177e-4ed2-8432-434b3b362c7e#!/results?classId=437aac44-0937", 
#' "-4ade-b89f-95161274e6cb))
#' @importFrom rlang .data
#' @return tibble with registrations for regatta
#' @export
manage2sail_results <- function(
  url = paste0("http://manage2sail.com/de-DE/event/", 
               "117e84c6-177e-4ed2-8432-434b3b362c7e#!/results?classId=437aac44-0937", 
               "-4ade-b89f-95161274e6cb")) {
  #rs$open()
  rs$navigate(url)
  select_results <- rs$findElement(using = "xpath", value = "//li[@class='event-tab-results active']//a[contains(text(),'Ergebnisse')]")
  select_results$clickElement()
  select_regatta_button <- rs$findElement(using = "xpath", value = "//select[@class='selectRegatta ng-pristine ng-valid']")
  regatta_options <- select_regatta_button$selectTag()
  regatta_options$text
  select_options <- rs$findElements(using = 'xpath', "//*/option[@value]")
  select_options[[2]]$clickElement()
  
  results_html <- rs$getPageSource()[[1]]
  
  x <- xml2::read_html(results_html) %>% rvest::html_node(xpath = "//table[@class='table table-results table-hover']")
  rvest::html_table(x)

  
  tbl_df <- tibble::tibble(segel = x %>%  rvest::html_nodes("td.td-sailnumber") %>% rvest::html_text() %>% stringr::str_replace_all("\\s+?", ""), 
                           boot = x %>%  rvest::html_nodes("td.td-ellipsis.ng-binding") %>% rvest::html_text() %>% magrittr::extract(seq_along(.data$segel)), 
                           skipper = x %>%  rvest::html_nodes("td.td-skiper") %>% rvest::html_text(),
                           crew = x %>%  rvest::html_nodes("td.td-ellipsis.wide-only") %>% rvest::html_text(),
                           verein = x %>%  rvest::html_nodes("td.td-ellipsis.medium-only") %>% rvest::html_text()
  )  
  return(tbl_df)
}
