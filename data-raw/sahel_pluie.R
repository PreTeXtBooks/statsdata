## Code to prepare data-raw/sahel_pluie.csv.
##
## The rainfall table sahel_rainfall as it might arrive from a francophone
## partner: French column names and place names with accents, saved in the
## Latin-1 (ISO-8859-1) encoding that older spreadsheet software still writes.
## It exists to practise reading a file that is not UTF-8. It is not a
## separate dataset: the values are those of sahel_rainfall, which is itself
## simulated for teaching.

x <- read.csv("data-raw/sahel_rainfall.csv", stringsAsFactors = FALSE)
x$site[x$site == "Segou"] <- "S\u00e9gou"
names(x) <- c("site", "ann\u00e9e", "pluie_mm", "jours_de_pluie")

write.csv(x, "data-raw/sahel_pluie.csv", row.names = FALSE, fileEncoding = "latin1")
