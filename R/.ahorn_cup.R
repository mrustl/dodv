library(dodv)


#rs <- RSelenium::rsDriver(browser = "firefox", geckover = "0.25.0")
rs <- RSelenium::remoteDriver(browserName = "chrome", port = 4444L)

dodv_ger_a <- get_dodv_ranklist("https://segler-rangliste.de/dodv/#/opti-a-ger", 
                                all_years = FALSE)


schwielochsee <- get_dodv_regatta_results("https://segler-rangliste.de/dodv/#/opti-a-em-wma/regatta/2019A062/info")
stanjek <- get_dodv_regatta_results("https://segler-rangliste.de/dodv/#/opti-a-year-ger/regatta/2019A026/info")
ahorn_cup_registrations <- raceoffice_registrations("http://www.raceoffice.org/entrylist.php?eid=16610475345d568670e4948")
ahorn_cup_results <- get_dodv_regatta_results("https://segler-rangliste.de/dodv/#/opti-a-ger/regatta/2019A064/info")  
herbst18 <- get_dodv_regatta_results("https://segler-rangliste.de/dodv/#/opti-a-ger/regatta/2018A132/info")
herbst19_registiations <- manage2sail_registrations("https://www.manage2sail.com/de-DE/event/5b69e6bf-d50a-4536-a203-54e90bd8320d#!/entries?classId=ba596ce5-2827-4b97-8fa4-568ca20659cb")

dplyr::inner_join(schwielochsee[,"segel", drop=FALSE], dodv_ger_a) %>% summary()
dplyr::inner_join(stanjek[,"segel", drop=FALSE], dodv_ger_a) %>% summary()
dplyr::inner_join(ahorn_cup_results[,"segel", drop=FALSE], dodv_ger_a) %>% summary()
dplyr::inner_join(herbst18[,"segel", drop=FALSE], dodv_ger_a) %>% summary()
dplyr::inner_join(herbst19_registiations[,"segel", drop=FALSE], dodv_ger_a) %>% summary()

calculate_regatta_factor(c(56, 82.69, 67.75))

