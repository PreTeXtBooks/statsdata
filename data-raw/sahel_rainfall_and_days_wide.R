## Code to prepare data-raw/sahel_rainfall_and_days_wide.csv.
##
## The two wide rainfall files (sahel_rainfall_wide.csv and
## sahel_rainy_days_wide.csv) in one: one row per site, and for every fifth year
## two columns whose names hold both the year and the variable, such as
## 1950_rainfall_mm and 1950_rainy_days. It is how data from several variables
## often arrive when the spreadsheet has one row per place, and it is untidy
## in the way that "Reshaping data" explains. The values are those of
## sahel_rainfall, which is simulated; see data-raw/sahel_rainfall.R.

library(dplyr)
library(tidyr)

load("data/sahel_rainfall.rda")

x <- sahel_rainfall |>
  filter(year %in% seq(1950, 2020, by = 5)) |>
  mutate(site = as.character(site)) |>
  pivot_longer(c(rainfall_mm, rainy_days)) |>
  mutate(name = paste(year, name, sep = "_")) |>
  select(site, name, value) |>
  pivot_wider()

stopifnot(nrow(x) == 3, ncol(x) == 1 + 2 * 15)
readr::write_csv(x, "data-raw/sahel_rainfall_and_days_wide.csv")
