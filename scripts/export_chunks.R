library(dplyr)
library(readr)

# Create chunk directory if needed
dir.create("data_chunks", showWarnings = FALSE)

# Split the data into ~1.4 million row chunks
chunks <- split(trip_data_clean, ceiling(seq_along(1:nrow(trip_data_clean)) / 1400000))

# Write each chunk as a separate CSV
for (i in seq_along(chunks)) {
  chunk_name <- paste0("data_chunks/cyclistic_chunk_", i, ".csv")
  write_csv(chunks[[i]], chunk_name, na = "")
}
#########error: chunks 2,3 are too small ^^^^

#updated code
chunks <- split(trip_data_clean, ceiling(seq_len(nrow(trip_data_clean)) / 1400000))

for (i in seq_along(chunks)) {
  filename <- paste0("data_chunks/cyclistic_chunk_", i, ".csv")
  write_csv(chunks[[i]], filename, na = "")
}

#produce even sized file chunks^^^^

warnings()

dir.create("data_chunks", showWarnings = FALSE)
write_csv(chunks[[1]], "C:/Users/Sephora/Desktop/cyclistic_chunk_1.csv", na = "")
gc()
dir.create("C:/Users/Sephora/Desktop/data_chunks", showWarnings = FALSE)
for (i in seq_along(chunks)) {
  filename <- paste0("C:/Users/Sephora/Desktop/data_chunks/cyclistic_chunk_", i, ".csv")
  write_csv(chunks[[i]], filename, na = "")
}

write_csv(trip_data_clean, "C:/Users/Sephora/Desktop/cyclistic_data.csv.gz", na = "")
