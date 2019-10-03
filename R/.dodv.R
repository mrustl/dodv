
dodv_url <- function() {
  
  "https://segler-rangliste.de/dodv"
}


rs <- RSelenium::rsDriver(browser = "firefox", geckover = "0.25.0")



#' Get html
#'
#' @param url url (default: dodv_url())
#' @param rs connection object to selenium
#' @return html object
#' @export
#' @importFrom  RSelenium rsDriver remoteDriver
get_html <- function(url = dodv_url(), rs) {

rs$client$open()
rs$client$navigate(url)
#get_500 <- rs$client$findElement(using = "xpath", value = "//span[contains(text(),'500')]")
#get_500$clickElement()
page_source <- rs$client$getPageSource()[[1]]
rs$client$close()

return(page_source)
}

get_regions <- function() {
  
  get_html(rs = rs) %>% xml2::read_html(page_source) %>%  
  rvest::html_nodes("div.caption")
}
#' Get regions
#'
#' @param  
#'
#' @return
#' @export
#' @importFrom rvest html_nodes
#' @importFrom tibble tibble
get_categories <- function(region) {
  
  dat <-  region %>% 
    rvest::html_nodes("a") 
  
  tibble::tibble(name = dat %>% rvest::html_text() %>% stringr::str_trim(), 
                 url = sprintf("%s/%s", 
                               dodv_url(), 
                               dat %>% rvest::html_attr("href")))

}

`%>%` <- magrittr::`%>%`

regions <- get_regions()
  
regions_names <- regions %>% rvest::html_nodes("h6") %>% rvest::html_text()

regions_categories <- setNames(lapply(regions, get_categories), 
                               nm = regions_names) %>%  dplyr::bind_rows(.id = "region") 

regions_categories %>%  
  dplyr::filter(stringr::str_detect(url, "/regatta$", negate = TRUE))

regions_regattas <- regions_categories %>%  
  dplyr::filter(stringr::str_detect(url, "/regatta$"))

regions_regattas$url[1]

rs$client$open() 

opti_b <- get_dodv_ranklist("https://segler-rangliste.de/dodv/#/opti-b-b")

dodv_ranklists <- setNames(lapply(regions_categories$url[!grepl("/regatta$", regions_categories$url)], 
                                  get_dodv_ranklist),
                           regions_categories$url[!grepl("/regatta$", regions_categories$url)])

#readr::write_rds(dodv_ranklists, "dodv_ranklists.rds") 
dodv_ranklists <- readr::read_rds( "dodv_ranklists.rds") 

dodv_ranklists_df <- data.table::rbindlist(dodv_ranklists, idcol = "url")
DT::datatable(dodv_ranklists_df,filter = "top")

rs$client$navigate(regions_categories$url[1])
tmp <- rs$client$getPageSource()



rank_a_regattas <- get_html(url = regions_categories$url[2], rs = rs)

rank_a_regattas %>% 
  xml2::read_html() %>% 
  rvest::html_table()
