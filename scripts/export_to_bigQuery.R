library(readr)
library(dplyr)

trip_data_clean <- trip_data_clean %>%
  mutate(across(where(is.character), ~ stringr::str_replace_all(., "[^\x20-\x7E]", "")))

write_csv(trip_data_clean, "C:/Users/Sephora/Desktop/cyclistic_data.csv.gz", na = "")

nrow(trip_data_clean)

library(readr)

# This will overwrite safely
write_csv(
  trip_data_clean,
  "C:/Users/Sephora/Desktop/cyclistic_data_v2.csv.gz",  
  na = ""
)
##IT WORKED