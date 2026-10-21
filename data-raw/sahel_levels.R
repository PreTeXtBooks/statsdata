## Code to prepare `sahel_households` and `sahel_crops` from `sahel_rhomis`
##
## sahel_rhomis holds two levels of data in one table: one row per household,
## with up to three crops in numbered columns. These two datasets split it
## into one table per level, linked by household_id, as in Chapter 2 of
## "An Introduction to Working with Data". Both are tibbles, so printing one
## shows a preview rather than every row. Nothing is cleaned: the values are
## exactly those in sahel_rhomis.

library(dplyr)
library(tidyr)

load("data/sahel_rhomis.rda")

# One row per household: every column that isn't about a particular crop
sahel_households <- sahel_rhomis %>%
  select(!matches("^crop_.*_\\d$")) %>%
  tibble::as_tibble()

# One row per crop that a household named. Households named up to three;
# the empty slots of those that named fewer are dropped.
sahel_crops <- sahel_rhomis %>%
  select(household_id, matches("^crop_.*_\\d$")) %>%
  pivot_longer(
    cols = matches("^crop_.*_\\d$"),
    names_to = c(".value", "crop_number"),
    names_pattern = "^(crop_.*)_(\\d)$"
  ) %>%
  filter(!is.na(crop_name)) %>%
  mutate(crop_number = as.integer(crop_number)) %>%
  tibble::as_tibble()

stopifnot(nrow(sahel_households) == 1026, ncol(sahel_households) == 15,
          nrow(sahel_crops) == 2390, ncol(sahel_crops) == 7)

write.csv(sahel_households, "data-raw/sahel_households.csv", row.names = FALSE)
write.csv(sahel_crops, "data-raw/sahel_crops.csv", row.names = FALSE)

save(sahel_households, file = "data/sahel_households.rda", compress = "bzip2")
save(sahel_crops, file = "data/sahel_crops.rda", compress = "bzip2")
