## Code to store `niger_oga` as a tibble.
##
## niger_oga.csv is the dataset as published here: the published Oga sheets
## (one per year, in different layouts) already put together, one row per
## trial. The code that did that is not in this repository. This script only
## reads the CSV and saves it as a tibble, so printing it shows a preview
## rather than all 810 rows.

niger_oga <- read.csv("data-raw/niger_oga.csv", stringsAsFactors = FALSE)
niger_oga <- tibble::as_tibble(niger_oga)

stopifnot(nrow(niger_oga) == 810, ncol(niger_oga) == 11)

save(niger_oga, file = "data/niger_oga.rda", compress = "bzip2")
