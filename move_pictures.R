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
<<<<<<< HEAD
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
=======
    drop_date_as_posixct(uploads$client_modified) < (Sys.time() - 60*60*24*30*4)
  )

from_path <- uploads$path_display
to_path   <- 
  uploads$path_display %>% 
  str_replace(
    "/Kamera-Uploads/",
    paste0(
      "/Kamera-Saves/", 
      drop_date_year(uploads$client_modified),      
      drop_date_month(uploads$client_modified),
      "/"
    )
>>>>>>> 8d74ff3fe344325b3b507511e91cd0da453b845b
  )


# move files one-by-one
for(i in seq_along(from_path)){
  cat(i, "/", length(from_path), from_path[i], " -- ", to_path[i], "\n")
  drop_move(from_path = from_path[i], to_path = to_path[i])
}







