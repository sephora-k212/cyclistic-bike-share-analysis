library(tidyverse)
library(janitor)
library(lubridate) #functions to work with date-times & time-spans

trip_data_clean <- trip_data

#Inspect data structure
#
glimpse(trip_data_clean) #get a glimpse of every column in dataframe
summary(trip_data_clean) #quickly summarise the values in df
View(trip_data_clean, 'Trip Data') #invoke a spreadsheet-style data viewer, titled Trip Data

#Remove duplicates
#
trip_data_clean < - trip_data_clean %>% distinct() #only selects unique/distinct rows from df

nrow(trip_data) - nrow(trip_data_clean) #checks how many duplicates were removed (no duplicates)

#Convert date times
#
trip_data_clean <- trip_data_clean %>% 
      mutate(
        started_at = ymd_hms(started_at),
        ended_at = ymd_hms(ended_at)
        
      ) # converts all rows in both columns in case there are any characters (guarantees datetimes)

#Create 'ride_length' col to calculate time differences
#
trip_data_clean <- trip_data_clean %>% 
      mutate(
        ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")) # calculate the time difference between two dates or date times
      )

summary(trip_data_clean$ride_length) #view summarised df, specifically, ride_length column

#Remove bad data
#
trip_data_clean <- trip_data_clean %>% 
      filter(
        ride_length > 1,
        ride_length <= 1400
      ) #remove negative or 0 duration rides and ride durations longer than 24 hours

#Create useful time-related fields
#
trip_data_clean <- trip_data_clean %>% 
      mutate(
        day_of_week = wday(started_at, label = TRUE),
        month = month(started_at, label = TRUE),
        hour = hour(started_at)
      ) #new tables will help with pulling insights from dataset

#Exporting the cleaned dataset
#
write_csv(trip_data_clean, 
          "C:/Users/Sephora/Documents/divvy-tripdata/Case_Study_Cyclistic/
          data_cleaned/cyclistic_12_months_clean.csv")

##Export issue - solution: Fix it with a safer write method
install.packages("vroom")
library(vroom)

vroom_write(trip_data_clean, "C:/Users/Sephora/Documents/divvy-tripdata/
            Case_Study_Cyclistic/data_cleaned/cyclistic_12_months_clean.csv")

dir.create("data_cleaned", showWarnings = FALSE)
vroom_write(trip_data_clean, "data_cleaned/cyclistic_12_months_clean.csv")
getwd()
#
#manually sets path
setwd("C:/Users/Sephora/Documents/divvy-tripdata/Case_Study_Cyclistic")

test_import <- read_csv("data_cleaned/cyclistic_12_months_clean.csv")
nrow(test_import)

#save the cleaned dataset as .RDS file
saveRDS(trip_data_clean, "data_cleaned/trip_data_clean_full.rds")
dir.create("data_cleaned", showWarnings = FALSE)
writeLines("test", "data_cleaned/test.txt")

##checks directory
getwd()

saveRDS(trip_data_clean, "C:/Users/Sephora/Desktop/trip_data_clean_full.rds")

gc()

nrow(trip_data_clean)