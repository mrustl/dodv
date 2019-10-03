#' Calculate regatta factor
#'
#' @param points_median median DODV ranklist points of regatta participants
#'
#' @return calculated regatta factor
#' @export
#'
#' @examples 
#' calculate_regatta_factor(points_median = 60)
#' calculate_regatta_factor(points_median = 80)
#' calculate_regatta_factor(points_median = 100)
#' @references  \url{http://www.dodv.org/regatta/rangliste/erlaeuterung-der-neuen-ranglistenfaktoren-2/}
calculate_regatta_factor <- function(points_median) {

 1 + (points_median - 60)/ 88.88889

}