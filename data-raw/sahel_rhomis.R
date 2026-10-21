## Code to store `sahel_rhomis` as a tibble.
##
## sahel_rhomis.csv is the dataset as published here. This script only reads
## the CSV and saves it as a tibble, so printing it shows a preview rather than
## all 1026 rows. Nothing is cleaned: the values are exactly those of the CSV.

sahel_rhomis <- read.csv("data-raw/sahel_rhomis.csv", stringsAsFactors = FALSE)
sahel_rhomis <- tibble::as_tibble(sahel_rhomis)

stopifnot(nrow(sahel_rhomis) == 1026, ncol(sahel_rhomis) == 30)

save(sahel_rhomis, file = "data/sahel_rhomis.rda", compress = "bzip2")
