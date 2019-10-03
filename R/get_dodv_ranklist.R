#' Helper function: DODV click on 500 button
#'
#' @param sleep_time time to wait after click in seconds (to enable site load)
#'
#' @return clicked button
#' @export
#'
click_more <- function(sleep_time) {
  is_available <- ifelse(xml2::read_html(rs$client$getPageSource()[[1]]) %>%  
                           rvest::html_node(xpath = "//span[contains(text(),'500')]") %>% 
                           rvest::html_text() %>%  is.na(), FALSE, TRUE)
  
  if(is_available) {
    get_500 <- rs$client$findElement(using = "xpath", value = "//span[contains(text(),'500')]")
    get_500$clickElement()
    Sys.sleep(sleep_time)
  }
}


#' Get DODV ranklist
#'
#' @param url url to a DODV ranklist (default: https://segler-rangliste.de/dodv/#/opti-a-ger)
#' @param sleep_time time to wait after click in seconds to enable site load (default: 2)
#' @param all_years should ranklists for all years scraped? (default: TRUE)
#' @param dbg show debug messages (default: TRUE)
#' @importFrom data.table rbindlist
#' @return tibble with ranklists 
#' @export
#'
get_dodv_ranklist <- function(url = "https://segler-rangliste.de/dodv/#/opti-a-ger", 
                              sleep_time = 2,
                              all_years = TRUE,
                              dbg = TRUE) {

if (dbg) message(sprintf("Getting ranklist from: %s", url))
rs$client$navigate(url)
Sys.sleep(time = sleep_time)
click_more(sleep_time)

dodv_ranks_html <- xml2::read_html(rs$client$getPageSource()[[1]])

my_opts <- rs$client$findElement(using = 'xpath', "//select")$selectTag()
my_opts$text

select_options <- rs$client$findElements(using = 'xpath', "//*/option[@value]")
if(all_years == FALSE) select_options <- select_options[1]
data.table::rbindlist(lapply(seq_along(select_options), function(year_id) {
  if (dbg) message(sprintf("Getting ranklist for year: %s", my_opts$text[year_id]))
  select_options[[year_id]]$clickElement()
  Sys.sleep(time = sleep_time)
  click_more(sleep_time) 
  dodv_ranks_html <- xml2::read_html(rs$client$getPageSource()[[1]])
  dodv_ranks_tbl1 <- dodv_ranks_html %>%  rvest::html_nodes("table") %>%  rvest::html_table(header = TRUE)
  
  tmp <- if(nrow(dodv_ranks_tbl1[[1]])>1) {
         dodv_ranks_tbl1[[1]][-1,]
  } else {
         dodv_ranks_tbl1[[1]]
  }
  dodv_ranks_tbl1_clean <- tmp %>% 
    janitor::clean_names()

  rank_period <- dodv_ranks_html %>% 
    rvest::html_node(xpath = "//div[@class='col-xs-12 col-sm-12 col-lg-12 ng-scope']//div//div[2]//div[1]") %>%  
    rvest::html_text() %>% 
    stringr::str_trim()

  rank_title <- dodv_ranks_html %>%  
    rvest::html_node(xpath = "//h3[@class='text-center ng-binding']") %>%  
    rvest::html_text()

  dodv_ranks_tbl1_clean$rank_title <- rank_title
  dodv_ranks_tbl1_clean$rank_period <- rank_period
  dodv_ranks_tbl1_clean
}))


}
