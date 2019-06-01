#! /usr/bin/env Rscript

#### packages ==================================================================

library(rdrop2)
library(lubridate)
library(stringr)
library(dplyr)



#### helper function ===========================================================




#### doing-duty-to-do ==========================================================

# authenticate
drop_auth()


# gather info
uploads <- drop_dir("Kamera-Uploads")


# filter for 'old' folders
uploads <- 
  uploads %>% 
  filter(
    as_datetime(server_modified) < (Sys.time() - 60*60*24*30*4)
  )


# get current path 
from_path <- uploads$path_display


# generate new folder
new_folder <- 
  paste0(
    "/Kamera-Saves/", 
    year(as_datetime(uploads$server_modified)),      
    str_pad(month(as_datetime(uploads$server_modified)), width = 2, side = "left", pad = "0"),
    "/"
  )


# generate new path
to_path <- 
  str_replace(
    string      = uploads$path_display,
    pattern     = "/Kamera-Uploads/",
    replacement = new_folder
  )


# move files one-by-one
for(i in seq_along(from_path)){
  drop_move(from_path = from_path[i], to_path = to_path[i])
}







