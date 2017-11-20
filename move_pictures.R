#! /usr/bin/env Rscript

#### packages ==================================================================

library(rdrop2)
library(lubridate)
library(stringr)
library(dplyr)



#### helper function ===========================================================

source("functions/drop_as_posixct.R")



#### doing-duty-to-do ==========================================================

# authenticate
drop_auth()

# gather info
uploads <- drop_dir("Kamera-Uploads")

uploads <- 
  uploads %>% 
  filter(
    drop_date_as_posixct(uploads$client_modified) < (Sys.time() - 60*60*24*30*4)
  )

from_path <- uploads$path_display
to_path   <- 
  uploads$path_lower %>% 
  str_replace(
    "/Kamera-Uploads/",
    paste0(
      "/Kamera-Saves/", 
      drop_date_year(uploads$client_modified),      
      drop_date_month(uploads$client_modified),
      "/"
    )
  )


# move files one-by-one
for(i in seq_along(from_path)){
  drop_move(from_path = from_path[i], to_path = to_path[i])
}







