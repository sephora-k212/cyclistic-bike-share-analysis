install.packages("readr")
library(readr)

write_csv(
  trip_data_clean,
  "C:/Users/Sephora/Desktop/cyclistic_data_v2.csv.gz",
  na = ""
)