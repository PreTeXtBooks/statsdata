## Code to prepare `ghana_crashes` and `ghana_city_accidents_2011`: road traffic
## crashes in Ghana, as published by the National Road Safety Commission
##
## Real data, from Ghana's open data portal (data.gov.gh, publisher "Roads
## Sector"):
##   - "The Nature and Consequences of Road Traffic Crashes of Ghana": one CSV per
##     region (the ten regions before the 2019 split), crashes by type in 2001,
##     2005, 2010 and 2011. Licence on the dataset page: Creative Commons
##     Attribution. Modified 2019-05-13.
##   - "Road Accidents and Casualties in Ghana": accidents and casualties by
##     severity in five cities, 2011.
## data.gov.gh was unreachable when these were added (October 2026), so the
## files were downloaded from the Internet Archive's 2022 copies of
## https://data.gov.gh/sites/default/files/<file name>. The downloaded files are
## kept unchanged in data-raw/ghana_crashes/ and data-raw/ghana_city_accidents_2011.csv.
##
## ghana_crashes puts the ten regional files together, adding `region`. The
## columns are matched by position, not by name, because two files have
## mislabelled headers: Brong Ahafo's second column is headed "Crashes" though
## it holds the year, and one file spells "Crasshes". Values are as published
## (crash types keep their abbreviations, and "Rear End " its trailing space).
##
## ghana_city_accidents_2011 is the city file exactly as published, headers
## and all ("Danage", "Hospilized"): two tables, accidents and casualties,
## stacked in one, with blanks where a column does not apply.

files <- list.files("data-raw/ghana_crashes", pattern = "\\.csv$", full.names = TRUE)

read_region <- function(f) {
  d <- utils::read.csv(f, skip = 3, header = FALSE, stringsAsFactors = FALSE,
                       strip.white = FALSE, na.strings = "")
  d <- d[!is.na(d[[1]]) & d[[1]] != "", 1:7]
  names(d) <- c("crash_type", "year", "crashes", "fatal", "casualties", "killed", "injured")
  region <- sub("^The Nature and Consequences of Road Traffic Crashes (.*) Region\\.csv$",
                "\\1", basename(f))
  cbind(region = region, d)
}

ghana_crashes <- do.call(rbind, lapply(files, read_region))
num <- c("year", "crashes", "fatal", "casualties", "killed", "injured")
ghana_crashes[num] <- lapply(ghana_crashes[num], as.integer)
rownames(ghana_crashes) <- NULL
ghana_crashes <- tibble::as_tibble(ghana_crashes)

ghana_city_accidents_2011 <- utils::read.csv(
  "data-raw/ghana_city_accidents_2011.csv", check.names = FALSE,
  stringsAsFactors = FALSE
)
ghana_city_accidents_2011 <- tibble::as_tibble(ghana_city_accidents_2011)

usethis::use_data(ghana_crashes, ghana_city_accidents_2011, overwrite = TRUE)
