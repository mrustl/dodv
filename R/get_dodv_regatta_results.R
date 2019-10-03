#' Get DODV regatta results
#'
#' @param url url to regatta results table provided by <https://segler-rangliste.de>
#' @importFrom stringr str_remove_all str_trim
#' @importFrom janitor clean_names
#' @importFrom dplyr mutate
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_node html_table html_text
#' @importFrom tibble tibble
#' @import RSelenium
#' @return table with regatta results
#' @export
#'
get_dodv_regatta_results <- function(url) {

  rs$navigate(url)
  Sys.sleep(2)
  html_content <- xml2::read_html(rs$getPageSource()[[1]]) 
  results <- html_content %>%  
    rvest::html_nodes("table") %>%  rvest::html_table(header = TRUE, fill  = TRUE)
  
  
regatta_master <-  tibble::tibble(
    regatta_name = html_content %>%  
    rvest::html_node(xpath = "//h3[@class='panel-title ng-binding']") %>% 
    rvest::html_text() %>% 
    stringr::str_trim(),
    regatta_club = html_content %>%  
      rvest::html_node(css = "body.container-fluid.deferred-bootstrap-loading:nth-child(2) div.row.ng-scope:nth-child(2) div.ng-scope div.ng-scope:nth-child(3) div.col-md-12.ng-scope:nth-child(4) div.panel.panel-default.col-lg-12.ng-scope div.panel-body table.table.table-bordered.table-condensed tbody:nth-child(1) tr:nth-child(1) > td.col-lg-1.ng-binding:nth-child(2)") %>% 
      rvest::html_text() %>% 
      stringr::str_trim(), 
    regatta_level = html_content %>%  
      rvest::html_node(xpath = "//td[@class='col-lg-1 ng-binding ng-scope']") %>% 
      rvest::html_text() %>% 
      stringr::str_trim(),
    regatta_web = html_content %>%  
      rvest::html_node(xpath = "//div[@class='panel-body']//tr[3]//td[1]") %>% 
      rvest::html_text() %>% 
      stringr::str_trim() %>% 
      ifelse(. == "", NA_character_, .), # or "." instead of ".data" ???
    regatta_cups = html_content %>%  
      rvest::html_node(xpath = "//td[@class='col-lg-1 angular-with-newlines ng-binding']") %>% 
      rvest::html_text() %>% 
      stringr::str_trim() %>%  
      ifelse(. == "", NA_character_, .), # or "." instead of ".data" ???
    regatta_boats = html_content %>%  
      rvest::html_node(xpath = "/html[1]/body[1]/div[2]/div[1]/div[3]/div[4]/div[1]/div[2]/table[1]/tbody[1]/tr[5]/td[1]") %>% 
      rvest::html_text() %>% 
      stringr::str_trim() %>%  
      as.integer(),
    regatta_date = html_content %>%  
      rvest::html_node(xpath = "/html[1]/body[1]/div[2]/div[1]/div[3]/div[4]/div[1]/div[2]/table[1]/tbody[1]/tr[2]/td[2]") %>% 
      rvest::html_text() %>% 
      stringr::str_trim()
    )
  
  
  results[[2]][-1,] %>% janitor::clean_names() %>%  
    dplyr::mutate(segel = stringr::str_remove_all(.data$segel, "\\s+?"))  
  
} 


#' Get DODV regatta overview
#'
#' @param url url to regatta results table provided by <https://segler-rangliste.de>
#' @importFrom xml2 read_html
#' @importFrom rvest html_table html_nodes
#' @importFrom janitor clean_names
#' @return table with regatta results
#' @export
#'
get_dodv_regatta_overview <- function(url) {
  
  rs$navigate(url)
  
  results <- xml2::read_html(rs$getPageSource()[[1]]) %>%  
    rvest::html_nodes("table") %>%  rvest::html_table(header = TRUE, fill  = TRUE)
  
  
  results[[2]][-1,] %>% janitor::clean_names() 
  
} 
