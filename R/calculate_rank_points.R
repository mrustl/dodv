#' Calculate DODV rank points
#'
#' @param rank total rank of a boat in a regatta
#' @param number_of_boats number of boast at least one time reaching the 
#' finish line
#' @param regatta_factor DODV quality factor of regatta. Varies between 
#' 1.0 and 1.45 (for DODV German Opti A championchip)
#'
#' @return DODV rank points
#' @export
#'
#' @examples
#' calculate_rank_points(10, 70, 1.2)
#' calculate_rank_points(3, 30, 1.0)
#' @references \href{http://www.dodv.org/regatta/rangliste/ranglisten-regelung/}
#' 
calculate_rank_points <- function(rank, number_of_boats, regatta_factor) {
  
  100 * regatta_factor * (1 + number_of_boats - rank) / number_of_boats
  
}
