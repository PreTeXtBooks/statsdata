## Code to prepare the wide-format rainfall files used to practise importing and
## tidying data (ModernDive Sahel edition, "Data Importing and Tidy Data").
##
## sahel_rainfall is tidy: one row per site and year. These files hold the same
## simulated rainfall the way a spreadsheet often arrives: one row per site, one
## column per year, here every fifth year from 1950 to 2020. Nothing here is
## new data. The values are exactly those of sahel_rainfall, so they are just
## as simulated; see data-raw/sahel_rainfall.R.

library(dplyr)
library(tidyr)

load("data/sahel_rainfall.rda")

wide <- function(variable) {
  sahel_rainfall %>%
    filter(year %in% seq(1950, 2020, by = 5)) %>%
    select(site, year, all_of(variable)) %>%
    mutate(site = as.character(site)) %>%
    pivot_wider(names_from = year, values_from = all_of(variable))
}

rainfall_wide <- wide("rainfall_mm")
rainy_days_wide <- wide("rainy_days")

stopifnot(nrow(rainfall_wide) == 3, ncol(rainfall_wide) == 16,
          nrow(rainy_days_wide) == 3, ncol(rainy_days_wide) == 16)

readr::write_csv(rainfall_wide, "data-raw/sahel_rainfall_wide.csv")
readr::write_csv(rainy_days_wide, "data-raw/sahel_rainy_days_wide.csv")
writexl::write_xlsx(rainfall_wide, "data-raw/sahel_rainfall_wide.xlsx")
