#' parse dropbox dates into POSIXct
#' @param x dates to be parsed
#' @export
drop_date_as_posixct <- function(x){
  time      <- substring(x, 12, 19)
  day       <- drop_date_day(x)
  year      <- drop_date_year(x)
  month     <- drop_date_month(x)
  date_time <-   paste0(year, "-", month, "-", day, " ", time)
  as.POSIXct(date_time, tz="UTC")
}

#' get year from dropbox dates
#' @param x dates to be parsed
drop_date_year <- function(x){
  substring(x, 1, 4)
}

#' get month from dropbox dates
#' @param x dates to be parsed
drop_date_month <- function(x){
  month <- 
    substring(x, 6,7) 
  month
}

#' get day from dropbox dates
#' @param x dates to be parsed
drop_date_day <- function(x){
  substring(x, 9,10)
}
