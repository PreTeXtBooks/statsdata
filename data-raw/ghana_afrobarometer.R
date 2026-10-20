## Code to prepare the Afrobarometer Ghana datasets:
##   ghana_news               both rounds (2022, 2024), one row per respondent,
##                            a few columns of interest
##   ghana_afro_people        2024, one row per respondent
##   ghana_afro_areas         2024, one row per area visited
##   ghana_afro_interviewers  2024, one row per interviewer
##
## Data: Afrobarometer Data, Ghana, Rounds 9 and 10, 2022 and 2024, available
## at http://www.afrobarometer.org. Afrobarometer data are protected by
## copyright; these extracts are redistributed here with Afrobarometer's
## permission (October 2026). Cite them as above.
##
## Afrobarometer interviews eight people in each sampled area (enumeration
## area). The released file has no area identifier, so `area_id` is
## reconstructed: respondents who share a district, urban/rural status, area
## weight (withinwt_ea) and every area-level observation (EA_*) are taken to be
## in the same area. That gives exactly 300 areas, 298 with eight respondents
## and one pair with seven and nine.

library(haven)
library(dplyr)

files <- c(
  "2022" = "https://www.afrobarometer.org/wp-content/uploads/2023/06/afrobarometer_release-dataset_gha_r9_en_2023-04-01.sav",
  "2024" = "https://www.afrobarometer.org/wp-content/uploads/2026/10/GHA_R10.Data_03Oct24.wtd_.final_.release_updated.13Feb25.sav"
)
read_round <- function(year) {
  path <- file.path(tempdir(), paste0("ghana_afrobarometer_", year, ".sav"))
  if (!file.exists(path)) {
    options(timeout = max(600, getOption("timeout")))
    ok <- try(download.file(files[[year]], path, mode = "wb"))
    if (inherits(ok, "try-error")) { unlink(path); stop("download failed: ", files[[year]]) }
  }
  read_sav(path)
}
to_number <- function(x) {
  x <- as.numeric(zap_labels(x))
  replace(x, x %in% c(-1, 998, 999), NA)
}
# The rounds word a few answers differently; use one wording for both.
same_labels <- function(x) {
  relabel <- c("Don't Know" = "Don't know", "Male" = "Man", "Female" = "Woman")
  old <- levels(x)
  levels(x) <- ifelse(old %in% names(relabel), relabel[old], old)
  x
}
title_case <- function(x) factor(tools::toTitleCase(tolower(as.character(x))))

# ghana_news: both rounds, columns matched up by hand -------------------------
# (Q101 is gender in 2024 but race in 2022.)
columns <- tribble(
  ~name,                 ~`2022`,       ~`2024`,
  "respondent",          "RESPNO",      "RESPNO",
  "region",              "REGION",      "REGION",
  "urban_rural",         "URBRUR",      "URBRUR",
  "age",                 "Q1",          "Q1",
  "gender",              "Q100",        "Q101",
  "education",           "Q94",         "Q96",
  "news_radio",          "Q74A",        "Q65A",
  "news_tv",             "Q74B",        "Q65B",
  "news_newspaper",      "Q74C",        "Q65C",
  "news_social_media",   "Q74E",        "Q65D",
  "news_internet_other", "Q74D",        "Q65E",
  "trust_social_media",  "Q37P_GHA",    "Q37P_GHA",
  "internet_use",        "Q90I",        "Q90J",
  "interviewer_age",     "Q112",        "Q109",
  "interviewer_gender",  "Q113",        "Q110",
  "weight",              "withinwt_hh", "withinwt_hh"
)
news_round <- function(year) {
  read_round(year) |>
    select(all_of(setNames(columns[[year]], columns$name))) |>
    mutate(across(c(age, interviewer_age, weight), to_number)) |>
    as_factor(only_labelled = TRUE) |>
    mutate(across(where(is.factor), same_labels), year = as.integer(year), .before = 1)
}
ghana_news <- bind_rows(news_round("2022"), news_round("2024")) |>
  mutate(id = paste(year, respondent, sep = "-"), region = title_case(region)) |>
  select(id, year, everything(), -respondent) |>
  tibble::as_tibble()

# 2024, split by level ----------------------------------------------------------
r10 <- read_round("2024")
area_cols <- c("LOCATION.LEVEL.1", "URBRUR", "withinwt_ea", grep("^EA_", names(r10), value = TRUE))
r10 <- r10 |>
  mutate(region_name = title_case(as_factor(REGION))) |>
  arrange(region_name, as.character(LOCATION.LEVEL.1), URBRUR, withinwt_ea) |>
  mutate(area_id = sprintf("A%03d", consecutive_id(across(all_of(c("REGION", area_cols))))))

ghana_afro_areas <- r10 |>
  distinct(area_id, .keep_all = TRUE) |>
  transmute(
    area_id,
    region = region_name,
    district = as.character(LOCATION.LEVEL.1),
    urban_rural = as_factor(URBRUR),
    electricity_grid = as_factor(EA_SVC_A),
    piped_water = as_factor(EA_SVC_B),
    sewage = as_factor(EA_SVC_C),
    mobile_service = as_factor(EA_SVC_D),
    borehole = as_factor(EA_SVC_E),
    post_office = as_factor(EA_FAC_A),
    school = as_factor(EA_FAC_B),
    police_station = as_factor(EA_FAC_C),
    health_clinic = as_factor(EA_FAC_D),
    market_stalls = as_factor(EA_FAC_E),
    bank = as_factor(EA_FAC_F),
    paid_transport = as_factor(EA_FAC_G),
    road_surface = as_factor(EA_ROAD_A),
    road_condition = as_factor(EA_ROAD_C),
    weight_area = as.numeric(withinwt_ea)
  )

ghana_afro_interviewers <- r10 |>
  distinct(Q108, .keep_all = TRUE) |>
  transmute(
    interviewer_id = as.character(Q108),
    age = to_number(Q109),
    gender = same_labels(as_factor(Q110)),
    education = droplevels(as_factor(Q114)),
    home_language = droplevels(as_factor(Q112))
  ) |>
  arrange(interviewer_id)

ghana_afro_people <- r10 |>
  transmute(
    respondent_id = as.character(RESPNO),
    area_id,
    interviewer_id = as.character(Q108),
    date = as.Date(DATEINTR),
    age = to_number(Q1),
    gender = as_factor(Q101),
    education = as_factor(Q96),
    news_radio = as_factor(Q65A),
    news_tv = as_factor(Q65B),
    news_newspaper = as_factor(Q65C),
    news_social_media = as_factor(Q65D),
    news_internet_other = as_factor(Q65E),
    trust_social_media = as_factor(Q37P_GHA),
    internet_use = as_factor(Q90J),
    weight = as.numeric(withinwt_hh)
  ) |>
  arrange(respondent_id)

usethis::use_data(ghana_news, ghana_afro_people, ghana_afro_areas,
                  ghana_afro_interviewers, overwrite = TRUE)
