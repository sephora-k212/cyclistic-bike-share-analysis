install.packages(c("tidyverse", "janitor","fs","readr"))
library(tidyverse)
library(janitor)
library(fs) #file system functions

#this function sets my working directory to the main project folder
setwd("~/divvy-tripdata/Case_Study_Cyclistic")

#define path to raw zip files
raw_data_path <- "data_raw"

#get all .zip files
zip_files <- dir_ls(raw_data_path, glob = "*.zip")

#create a temp folder to unzip contents
temp_unzip_dir <- file.path(raw_data_path, "unzipped")
dir_create(temp_unzip_dir)

#unzip all files
walk(zip_files, ~ unzip(.x, exdir = temp_unzip_dir))

#get all .csv files inside unzipped folder
csv_files <- dir_ls(temp_unzip_dir, glob = "*.csv")

-------------------------------------------------------

#define a function to read each CSV neatly
read_trip_data <- function(file) {
      read_csv(file, show_col_types = FALSE) %>% 
        clean_names() #standardise column names
}

#read and combine all unzipped .csv files
trip_data <- map_dfr(csv_files, read_trip_data)

#view structure
glimpse(trip_data)
View(trip_data)

#save raw, combined dataset to data_cleaned folder
write_csv(trip_data, "data_cleaned/cyclistic_12_months_raw.csv")



















